From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Jul 2017 12:41:39 +0100
Subject: [BUG] v4.12 breaks pxa25x
In-Reply-To: <87o9s7qw64.fsf@belgarion.home>
References: <87inirsgzk.fsf@belgarion.home>
 <20170717081518.GI31807@n2100.armlinux.org.uk>
 <87eftfrs0e.fsf@belgarion.home> <87o9s7qw64.fsf@belgarion.home>
Message-ID: <20170726114139.GN31807@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 01:23:15PM +0200, Robert Jarzmik wrote:
> Robert Jarzmik <robert.jarzmik@free.fr> writes:
> > Sure, it like this :
> > c06f22c8 D user_pmd_table
> > c06f22cc d __warned.19178
> > c06f22cd d clean_addr
> >
> > And I have no idea how to link that __warned.19178 with the WARN_xxx() statement ...
> >
> > This bisection I made points me to :
> > # first bad commit: [799c43415442414b1032580c47684cb709dfed6d] kbuild: thin archives make default for all archs
> >
> > Reverting this commit makes my kernel boot again.
> 
> Hi Russell,
> 
> I think I know where this is comming from.
>   - in file: ~/mio_linux/kernel/include/asm-generic/vmlinux.lds.h:206
>   - the definition of DATA_DATA looks like :
>     (*.data .data.[0-9a-zA-Z_]*)
>     ...
>     *(.data.unlikely)
>     ...
> 
> This doesn't look good to me, as .data.unlikely fullfills the first wildcard,
> and the linker is allowed to mix .data and .data.unlikely symbols to its
> pleasure, while .data.unlikely symbols (at least in my case) are not 4 bytes
> multiples.

Obviously, the mixing of .data.unlikely with the normal .data sections
is undesirable - that looks like it's come from commit b67067f1176d
("kbuild: allow archs to select link dead code/data elimination") dated
2016, which according to git describe --contains was merged in v4.9-rc1.
So it's unlikely to be directly caused by this, although this commit is
implicated.

I wonder if Nick realised this side effect (that .data.unlikely is no
longer grouped together) - maybe we need to rename .data.unlikely?
(Adding Nick and Michal).

Anyway, I think this patch may resolve the problem you're seeing as well
- this should mark the .data sections in the ELF objects as requiring a
32-bit alignment - if you check with objdump -h, you should see the
"Algn" column for the .data section change from "2**0" to "2**2", which
should cause the linker to apply the appropriate alignment to the files
.data section.

We will have to ensure that all new .data statements have an appropriate
.align directive after them if the data requires alignment.

 arch/arm/kernel/entry-armv.S | 2 ++
 arch/arm/kernel/head.S       | 2 ++
 arch/arm/kernel/hyp-stub.S   | 1 +
 arch/arm/kernel/iwmmxt.S     | 1 +
 arch/arm/kernel/sleep.S      | 1 +
 arch/arm/mm/cache-v4wb.S     | 1 +
 arch/arm/mm/proc-xscale.S    | 1 +
 7 files changed, 9 insertions(+)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index f2d2f9398adb..10ad44f3886a 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -721,6 +721,7 @@ ENDPROC(__und_usr)
  */
 
 	.pushsection .data
+	.align	2
 ENTRY(fp_enter)
 	.word	no_fp
 	.popsection
@@ -1026,6 +1027,7 @@ ENDPROC(vector_\name)
 	W(b)	vector_fiq
 
 	.data
+	.align	2
 
 	.globl	cr_alignment
 cr_alignment:
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 04286fd9e09c..6b1148cafffd 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -556,6 +556,7 @@ ENDPROC(__fixup_smp)
 	.word	__smpalt_end
 
 	.pushsection .data
+	.align	2
 	.globl	smp_on_up
 smp_on_up:
 	ALT_SMP(.long	1)
@@ -716,6 +717,7 @@ ENTRY(fixup_pv_table)
 ENDPROC(fixup_pv_table)
 
 	.data
+	.align	2
 	.globl	__pv_phys_pfn_offset
 	.type	__pv_phys_pfn_offset, %object
 __pv_phys_pfn_offset:
diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index ec7e7377d423..60146e32619a 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -31,6 +31,7 @@
  * zeroing of .bss would clobber it.
  */
 .data
+	.align	2
 ENTRY(__boot_cpu_mode)
 	.long	0
 .text
diff --git a/arch/arm/kernel/iwmmxt.S b/arch/arm/kernel/iwmmxt.S
index 49fadbda8c63..81cd4d43b3ec 100644
--- a/arch/arm/kernel/iwmmxt.S
+++ b/arch/arm/kernel/iwmmxt.S
@@ -367,6 +367,7 @@ ENTRY(iwmmxt_task_release)
 ENDPROC(iwmmxt_task_release)
 
 	.data
+	.align	2
 concan_owner:
 	.word	0
 
diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index 0f6c1000582c..9f08d214d05a 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -171,6 +171,7 @@ ENDPROC(cpu_resume_arm)
 	.long	mpidr_hash - .			@ mpidr_hash struct offset
 
 	.data
+	.align	2
 	.type	sleep_save_sp, #object
 ENTRY(sleep_save_sp)
 	.space	SLEEP_SAVE_SP_SZ		@ struct sleep_save_sp
diff --git a/arch/arm/mm/cache-v4wb.S b/arch/arm/mm/cache-v4wb.S
index 2522f8c8fbb1..a5084ec70c6e 100644
--- a/arch/arm/mm/cache-v4wb.S
+++ b/arch/arm/mm/cache-v4wb.S
@@ -47,6 +47,7 @@
 #define CACHE_DLIMIT	(CACHE_DSIZE * 4)
 
 	.data
+	.align	2
 flush_base:
 	.long	FLUSH_BASE
 	.text
diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index b6bbfdb6dfdc..3d75b7972fd1 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -104,6 +104,7 @@
 	.endm
 
 	.data
+	.align	2
 clean_addr:	.word	CLEAN_ADDR
 
 	.text


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
