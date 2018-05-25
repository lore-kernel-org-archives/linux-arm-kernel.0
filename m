From: drjones@redhat.com (Andrew Jones)
Date: Fri, 25 May 2018 18:09:09 +0200
Subject: [PATCH] arm64: vgic-v2: Fix proxying of cpuif access
In-Reply-To: <20180429140507.60bfe2dc@why.wild-wind.fr.eu.org>
References: <20180427145102.5645-1-marc.zyngier@arm.com>
 <20180429123432.GA7512@C02W217FHV2R.local>
 <20180429140507.60bfe2dc@why.wild-wind.fr.eu.org>
Message-ID: <20180525160909.uykqxtxkjfzc7aqg@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 29, 2018 at 02:05:07PM +0100, Marc Zyngier wrote:
> On Sun, 29 Apr 2018 14:34:32 +0200
> Christoffer Dall <christoffer.dall@arm.com> wrote:
> 
> > On Fri, Apr 27, 2018 at 03:51:02PM +0100, Marc Zyngier wrote:
> > > Proxying the cpuif accesses at EL2 makes use of vcpu_data_guest_to_host
> > > and co, which check the endianness, which call into vcpu_read_sys_reg...
> > > which isn't mapped at EL2 (it was inlined before, and got moved OoL
> > > with the VHE optimizations).  
> > 
> > I thought we relied on static inline functions to always be inlined, but
> > apparently not?  Does this mean we have potential other bugs looming
> > depending on the mood of the compiler, or was there something special
> > that went wrong here?
> 
> We do rely on that behaviour. And that was the case until you moved
> vcpu_read_sys_reg() to be entirely out of line (see d47533dab9f5).
> 
> At that point, kvm_vcpu_is_be() becomes a death trap.
> 
> We missed it for two reasons:
> - It was only indirectly called, making it quite hard to notice the
>   potential breakage
> - Nobody gives a damn about 64k pages, specially on something like Juno
> 
> What we'd need is a way to find cross-section calls (text -> hyp-text
> should allowed, but not the reverse). We already have similar things in
> the kernel, it is probably only a matter of reusing the infrastructure
> for our own purpose.
>

Hi all,

While debugging a series backported to the RHEL kernel, I was suspicious
of the problem being an issue like this (a hyp-text to non-hyp-mapped
reference), so I went ahead an implemented the cross-section reference
checking as Marc suggested. I've attached the patch. I don't really
like it though because of all the special casing necessary to kill
false alarms - making it too hacky. Also, the need to inline some
functions just to match their symbol names is pretty lame. Anyway,
maybe it can be helpful, at least as inspiration.

Running it on latest master doesn't produce anything. Running it
without b220244d4179 ("arm64: vgic-v2: Fix proxying of cpuif access")
gives

.hyp.text:__vgic_v2_perform_cpuif_access references .text:vcpu_read_sys_reg

so I guess it works.

Unfortunately it didn't help me with my downstream debug...

drew
-------------- next part --------------
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index bffece27b5c1..7a6364e8312f 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -200,6 +200,7 @@ ENDPROC(\label)
 	invalid_vector	el2h_fiq_invalid
 	invalid_vector	el1_fiq_invalid
 
+hyp_entry_literal_pool:
 	.ltorg
 
 	.align 11
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index d9645236e474..16f063af3bd9 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -86,7 +86,7 @@ static void __hyp_text __deactivate_traps_common(void)
 	write_sysreg(0, pmuserenr_el0);
 }
 
-static void activate_traps_vhe(struct kvm_vcpu *vcpu)
+static noinline void activate_traps_vhe(struct kvm_vcpu *vcpu)
 {
 	u64 val;
 
@@ -125,7 +125,7 @@ static void __hyp_text __activate_traps(struct kvm_vcpu *vcpu)
 		__activate_traps_nvhe(vcpu);
 }
 
-static void deactivate_traps_vhe(void)
+static noinline void deactivate_traps_vhe(void)
 {
 	extern char vectors[];	/* kernel exception vectors */
 	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
@@ -529,8 +529,8 @@ static void __hyp_text __hyp_call_panic_nvhe(u64 spsr, u64 elr, u64 par,
 		       read_sysreg(hpfar_el2), par, vcpu);
 }
 
-static void __hyp_call_panic_vhe(u64 spsr, u64 elr, u64 par,
-				 struct kvm_cpu_context *host_ctxt)
+static noinline void __hyp_call_panic_vhe(u64 spsr, u64 elr, u64 par,
+					  struct kvm_cpu_context *host_ctxt)
 {
 	struct kvm_vcpu *vcpu;
 	vcpu = host_ctxt->__hyp_running_vcpu;
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 4ff08a0ef5d3..6ba0617df985 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -964,6 +964,7 @@ enum mismatch {
 	ANY_EXIT_TO_ANY_INIT,
 	EXPORT_TO_INIT_EXIT,
 	EXTABLE_TO_NON_TEXT,
+	HYP_TEXT_TO_NON_HYP,
 };
 
 /**
@@ -1003,6 +1004,11 @@ static void extable_mismatch_handler(const char *modname, struct elf_info *elf,
 				     Elf_Rela *r, Elf_Sym *sym,
 				     const char *fromsec);
 
+static void hyp_mismatch_handler(const char *modname, struct elf_info *elf,
+				 const struct sectioncheck* const mismatch,
+				 Elf_Rela *r, Elf_Sym *sym,
+				 const char *fromsec);
+
 static const struct sectioncheck sectioncheck[] = {
 /* Do not reference init/exit code/data from
  * normal code and data
@@ -1090,7 +1096,15 @@ static void extable_mismatch_handler(const char *modname, struct elf_info *elf,
 	.good_tosec = {ALL_TEXT_SECTIONS , NULL},
 	.mismatch = EXTABLE_TO_NON_TEXT,
 	.handler = extable_mismatch_handler,
-}
+},
+{
+	.fromsec = { ".hyp.text", NULL },
+	.good_tosec = { ".hyp.text", ".hyp.idmap.text",
+			".rodata", ".data..ro_after_init",
+			".bss", NULL },
+	.mismatch = HYP_TEXT_TO_NON_HYP,
+	.handler = hyp_mismatch_handler,
+},
 };
 
 static const struct sectioncheck *section_mismatch(
@@ -1525,6 +1539,10 @@ static void report_sec_mismatch(const char *modname,
 		fatal("There's a special handler for this mismatch type, "
 		      "we should never get here.");
 		break;
+	case HYP_TEXT_TO_NON_HYP:
+		fatal("There's a special handler for this mismatch type, "
+		      "we should never get here.");
+		break;
 	}
 	fprintf(stderr, "\n");
 }
@@ -1681,6 +1699,46 @@ static void extable_mismatch_handler(const char* modname, struct elf_info *elf,
 	}
 }
 
+static void hyp_mismatch_handler(const char *modname, struct elf_info *elf,
+				 const struct sectioncheck* const mismatch,
+				 Elf_Rela *r, Elf_Sym *sym,
+				 const char *fromsec)
+{
+	Elf_Sym *from = find_elf_symbol2(elf, r->r_offset, fromsec);
+	Elf_Sym *to = find_elf_symbol(elf, r->r_addend, sym);
+	const char *fromsym = sym_name(elf, from);
+	const char *tosec = sec_name(elf, get_secindex(elf, sym));
+	const char *tosym = sym_name(elf, to);
+	char *s;
+
+	switch (mismatch->mismatch) {
+	case HYP_TEXT_TO_NON_HYP:
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
+		if (!is_valid_name(elf, from) || !is_valid_name(elf, to)) {
+			/*
+			 * Skip unknown symbols to reduce false alarms,
+			 * of course at the risk of missing something...
+			 */
+			return;
+		}
+		if (strcmp(tosym, "kvm_arm_hyp_stack_page") == 0 ||
+		    strcmp(tosym, "kvm_host_cpu_state") == 0)
+			return;
+		if (strcmp(fromsym, "hyp_entry_literal_pool") == 0)
+			return;
+		if ((s = strstr(tosym, "_vhe")) &&
+		    (strlen(s) == 4 || s[4] == '.'))
+			return;
+		fprintf(stderr,
+			".hyp.text:%s references %s:%s\n\n",
+			fromsym, tosec, tosym);
+#endif
+		break;
+	default:
+		break;
+	}
+}
+
 static void check_section_mismatch(const char *modname, struct elf_info *elf,
 				   Elf_Rela *r, Elf_Sym *sym, const char *fromsec)
 {
