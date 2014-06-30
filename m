From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 30 Jun 2014 14:49:39 -0700
Subject: [PATCH] ARM: debug: msm: Support big-endian CPUs
Message-ID: <1404164979-17068-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the CPU is in big-endian mode these macros will access the
hardware incorrectly. Reverse thins as necessary to fix this.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/include/debug/msm.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/include/debug/msm.S b/arch/arm/include/debug/msm.S
index 9ef57612811d..e55a9426b496 100644
--- a/arch/arm/include/debug/msm.S
+++ b/arch/arm/include/debug/msm.S
@@ -23,6 +23,7 @@
 	.endm
 
 	.macro	senduart, rd, rx
+ARM_BE8(rev	\rd, \rd )
 #ifdef CONFIG_DEBUG_QCOM_UARTDM
 	@ Write the 1 character to UARTDM_TF
 	str	\rd, [\rx, #0x70]
@@ -35,24 +36,29 @@
 #ifdef CONFIG_DEBUG_QCOM_UARTDM
 	@ check for TX_EMT in UARTDM_SR
 	ldr	\rd, [\rx, #0x08]
+ARM_BE8(rev     \rd, \rd )
 	tst	\rd, #0x08
 	bne	1002f
 	@ wait for TXREADY in UARTDM_ISR
 1001:	ldr	\rd, [\rx, #0x14]
+ARM_BE8(rev     \rd, \rd )
 	tst	\rd, #0x80
 	beq 	1001b
 1002:
 	@ Clear TX_READY by writing to the UARTDM_CR register
 	mov	\rd, #0x300
+ARM_BE8(rev     \rd, \rd )
 	str	\rd, [\rx, #0x10]
 	@ Write 0x1 to NCF register
 	mov 	\rd, #0x1
+ARM_BE8(rev     \rd, \rd )
 	str	\rd, [\rx, #0x40]
 	@ UARTDM reg. Read to induce delay
 	ldr	\rd, [\rx, #0x08]
 #else
 	@ wait for TX_READY
 1001:	ldr	\rd, [\rx, #0x08]
+ARM_BE8(rev     \rd, \rd )
 	tst	\rd, #0x04
 	beq	1001b
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
