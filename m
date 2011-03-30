From: gerg@snapgear.com (Greg Ungerer)
Date: Wed, 30 Mar 2011 15:00:26 +1000
Subject: arm non-mmu 2.6.39-rc1 and loadable modules
Message-ID: <201103300500.p2U50Qve010921@goober.internal.moreton.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi All,

With 2.6.39-rc1 you can cleanly compile for non-mmu targets if you
do not have kernel modules enabled. But if you do you will get:

  arch/arm/kernel/built-in.o: In function `module_finalize':
  io.c:(.text+0x3840): undefined reference to `fixup_smp'

fixup_smp() is only defined in arch/arm/kernel/head.S, and that is
only used for MMU enabled kernels.A Now the most simple fix is
something like:

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index fee7c36..7080e68 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -339,9 +339,11 @@ int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *
        if (s)
                fixup_pv_table((void *)s->sh_addr, s->sh_size);
 #endif
+#ifdef CONFIG_MMU
        s = find_mod_section(hdr, sechdrs, ".alt.smp.init");
        if (s && !is_smp())
                fixup_smp((void *)s->sh_addr, s->sh_size);
+#endif
        return 0;
 }

But I am wondering is the ".alt.smp.init" section something we should
be dealing with no matter whether we are running with MMU enabled or not?
Do we need a fixup_smp() for the non-MMU case as well?

Regards
Greg
