From: toddpoynor@google.com (Todd Poynor)
Date: Tue, 22 Feb 2011 19:55:25 -0800
Subject: [RFC] ARM: Cortex-A9: Enable dynamic clock gating
Message-ID: <1298433325-16810-1-git-send-email-toddpoynor@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable dynamic high level clock gating for Cortex-A9 CPUs, as
described in 2.3.3 "Dynamic high level clock gating" of the
Cortex-A9 TRM.  This may cut the clock of the integer core,
system control block, and Data Engine in certain conditions.

Add ARM errata 720791 to avoid corrupting the Jazelle
instruction stream on earlier Cortex-A9 revisions.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
Can anyone advise whether this feature should be selectively
enabled (or otherwise modified) due to secured register access,
introduced latencies observed, etc.?

This has been tested on a few Tegra 2 boards without problems
observed thus far, and some preliminary testing indicates it
may result in fairly significant power savings.  Any additional
testing greatly appreciated.

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 166efa2..632ec97 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1202,6 +1202,16 @@ config ARM_ERRATA_753970
 	  This has the same effect as the cache sync operation: store buffer
 	  drain and waiting for all buffers empty.
 
+config ARM_ERRATA_720791
+	bool "ARM errata: Dynamic high-level clock gating corrupts the Jazelle instruction stream"
+	depends on CPU_V7
+	help
+	  This option enables the workaround for the 720791 Cortex-A9
+	  (r1p0..r1p2) erratum.  The Jazelle instruction stream may be
+	  corrupted when dynamic high-level clock gating is enabled.
+	  This workaround disables gating the Core clock when the Instruction
+	  side is waiting for a Page Table Walk answer or linefill completion.
+
 endmenu
 
 source "arch/arm/common/Kconfig"
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 8e33562..aa1733a 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -241,6 +241,16 @@ __v7_setup:
 2:	ldr	r10, =0x00000c09		@ Cortex-A9 primary part number
 	teq	r0, r10
 	bne	3f
+	cmp	r6, #0x10			@ power ctrl reg added r1p0
+	mrcge	p15, 0, r10, c15, c0, 0		@ read power control register
+	orrge	r10, r10, #1			@ enable dynamic clock gating
+	mcrge	p15, 0, r10, c15, c0, 0		@ write power control register
+#ifdef CONFIG_ARM_ERRATA_720791
+	teq	r5, #0x00100000			@ only present in r1p*
+	mrceq	p15, 0, r10, c15, c0, 2		@ read "chicken power ctrl" reg
+	orreq	r10, r10, #0x30			@ disable core clk gate on
+	mcreq	p15, 0, r10, c15, c0, 2		@ instr-side waits
+#endif
 #ifdef CONFIG_ARM_ERRATA_742230
 	cmp	r6, #0x22			@ only present up to r2p2
 	mrcle	p15, 0, r10, c15, c0, 1		@ read diagnostic register
-- 
1.7.3.1
