From: dianders@chromium.org (Douglas Anderson)
Date: Fri, 26 Feb 2016 11:20:59 -0800
Subject: [PATCH] ARM: errata: Workaround errata A12 818325/852422 A17 852423
Message-ID: <1456514459-12176-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are several similar errata on Cortex A12 and A17 that all have the
same workaround: setting bit[12] of the Feature Register.  Technically
the list of errata are:

- A12 818325: Execution of an UNPREDICTABLE STR or STM instruction might
  deadlock.  Fixed in r0p1.
- A12 852422: Execution of a sequence of instructions might lead to
  either a data corruption or a CPU deadlock.  Not fixed in any A12s
  yet.
- A17 852423: Execution of a sequence of instructions might lead to
  either a data corruption or a CPU deadlock.  Not fixed in any A17s
  yet.

Since A12 got renamed to A17 it seems likely that there won't be any
future Cortex-A12 cores, so we'll enable for all Cortex-A12.

For Cortex-A17 I believe that all known revisions are affected and that
all knows revisions means <= r1p2.  Presumably if a new A17 was released
it would have this problem fixed.

Note that in <https://patchwork.kernel.org/patch/4735341/> folks
previously expressed opposition to this change because:
A) It was thought to only apply to r0p0 and there were no known r0p0
   boards supported in mainline.
B) It was argued that such a workaround beloned in firmware.

Now that this same fix solves other errata on real boards (like rk3288)
point A) is addressed.

Point B) is impossible to address on boards like rk3288.  On rk3288 the
firmware doesn't stay resident in RAM and isn't involved at all in the
suspend/resume process nor in the SMP bringup process.  That means that
the most the firmware could do would be to set the bit on "core 0" and
this bit would be lost at suspend/resume time.  It is true that we could
write a "generic" solution that saved the boot-time "core 0" value of
this register and applied it at SMP bringup / resume time.  However,
since this register (described as the "Feature Register" in errata)
appears to be undocumented (as far as I can tell) and is only modified
for these errata, that "generic" solution seems questionably cleaner.
The generic solution also won't fix existing users that haven't happened
to do a FW update.

Note that in ARM64 presumably PSCI will be universal and fixes like this
will end up in ATF.  Hopefully we are nearing the end of this style of
errata workaround.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Huang Tao <huangtao@rock-chips.com>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---
Note that I have only tested this on Rockchip rk3288 (A12).  It seemed
like a good idea to apply this to A17 as well but it would be nice to
get some testing.  Also: if all A17 boards use PSCI and the firmware
has a fix for this then we can remove the A17 erratum from this patch.

 arch/arm/Kconfig      | 26 ++++++++++++++++++++++++++
 arch/arm/mm/proc-v7.S | 27 +++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 98de149b7715..40a6c15e7595 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1165,6 +1165,32 @@ config ARM_ERRATA_773022
 	  loop buffer may deliver incorrect instructions. This
 	  workaround disables the loop buffer to avoid the erratum.
 
+config ARM_ERRATA_818325_852422
+	bool "ARM errata: A12: some seqs of opposed cond code instrs => deadlock or corruption"
+	depends on CPU_V7
+	help
+	  This option enables the workaround for:
+	  - Cortex-A12 818325: Execution of an UNPREDICTABLE STR or STM
+	    instruction might deadlock.  Fixed in r0p1.
+	  - Cortex-A12 852422: Execution of a sequence of instructions might
+	    lead to either a data corruption or a CPU deadlock.  Not fixed in
+	    any Cortex-A12 cores yet.
+	  This workaround for all both errata involves setting bit[12] of the
+	  Feature Register. This bit disables an optimisation applied to a
+	  sequence of 2 instructions that use opposing condition codes.
+
+config ARM_ERRATA_852423
+	bool "ARM errata: A17: some seqs of opposed cond code instrs => deadlock or corruption"
+	depends on CPU_V7
+	help
+	  This option enables the workaround for:
+	  - Cortex-A17 852423: Execution of a sequence of instructions might
+	    lead to either a data corruption or a CPU deadlock.  Not fixed in
+	    any Cortex-A17 cores yet.
+	  This is identical to Cortex-A12 erratum 852422.  It is a separate
+	  config option from the A12 erratum due to the way errata are checked
+	  for and handled.
+
 endmenu
 
 source "arch/arm/common/Kconfig"
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 0f8963a7e7d9..96d2972d4d93 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -353,6 +353,23 @@ __ca9_errata:
 #endif
 	b	__errata_finish
 
+__ca12_errata:
+#ifdef CONFIG_ARM_ERRATA_818325_852422
+	mrc	p15, 0, r10, c15, c0, 1		@ read diagnostic register
+	orr	r10, r10, #1 << 12		@ set bit #12
+	mcr	p15, 0, r10, c15, c0, 1		@ write diagnostic register
+#endif
+	b	__errata_finish
+
+__ca17_errata:
+#ifdef CONFIG_ARM_ERRATA_852423
+	cmp	r6, #0x12			@ only present up to r1p2
+	mrcle	p15, 0, r10, c15, c0, 1		@ read diagnostic register
+	orrle	r10, r10, #1 << 12		@ set bit #12
+	mcrle	p15, 0, r10, c15, c0, 1		@ write diagnostic register
+#endif
+	b	__errata_finish
+
 __ca15_errata:
 #ifdef CONFIG_ARM_ERRATA_773022
 	cmp	r6, #0x4			@ only present up to r0p4
@@ -443,6 +460,16 @@ __v7_setup_cont:
 	teq	r0, r10
 	beq	__ca9_errata
 
+	/* Cortex-A12 Errata */
+	ldr	r10, =0x00000c0d		@ Cortex-A12 primary part number
+	teq	r0, r10
+	beq	__ca12_errata
+
+	/* Cortex-A17 Errata */
+	ldr	r10, =0x00000c0e		@ Cortex-A17 primary part number
+	teq	r0, r10
+	beq	__ca17_errata
+
 	/* Cortex-A15 Errata */
 	ldr	r10, =0x00000c0f		@ Cortex-A15 primary part number
 	teq	r0, r10
-- 
2.7.0.rc3.207.g0ac5344
