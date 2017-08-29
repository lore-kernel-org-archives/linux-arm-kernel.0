From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 29 Aug 2017 11:03:39 -0700
Subject: [PATCH] ARM: brcmstb: Add appropriate ARM_BE8() macros for swapping
Message-ID: <1504029821-38267-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building a big-endian kernel for ARCH_BRCMSTB revealed that we would not
be correctly polling for the right bit in the busyuart macro, turns out
there are a few transformations needed to work with big-endian kernels.
First we need to swap the value we read from SUN_TOP_CTRL to properly
compare it against our local tables. Then, just like 8250.S we need to
swap the value before storing it, and conversely swap it after a load.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/include/debug/brcmstb.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/include/debug/brcmstb.S b/arch/arm/include/debug/brcmstb.S
index 52aaed2b936f..c826f15d2f80 100644
--- a/arch/arm/include/debug/brcmstb.S
+++ b/arch/arm/include/debug/brcmstb.S
@@ -58,6 +58,7 @@
 		/* Check SUN_TOP_CTRL base */
 		ldr	\rp, =SUN_TOP_CTRL_BASE	@ load SUN_TOP_CTRL PA
 		ldr	\rv, [\rp, #0]		@ get register contents
+ARM_BE8(	rev	\rv, \rv )
 		and	\rv, \rv, #0xffffff00	@ strip revision bits [7:0]
 
 		/* Chip specific detection starts here */
@@ -98,11 +99,13 @@
 		.endm
 
 		.macro	store, rd, rx:vararg
+ARM_BE8(	rev	\rd, \rd )
 		str	\rd, \rx
 		.endm
 
 		.macro	load, rd, rx:vararg
 		ldr	\rd, \rx
+ARM_BE8(	rev	\rd, \rd )
 		.endm
 
 		.macro	senduart,rd,rx
-- 
1.9.1
