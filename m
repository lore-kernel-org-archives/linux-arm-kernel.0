From: girish.shivananjappa@linaro.org (Girish K S)
Date: Tue,  4 Oct 2011 16:08:04 +0530
Subject: [PATCH] arm: mm: Fix infinite looping issue
Message-ID: <1317724684-29115-1-git-send-email-girish.shivananjappa@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the problem of infinite looping while booting.

The bne instruction expects the z flag to be set to break the loop.
The (mov r1, r1, lsr #1) doesn't behave in the expected way. If
replaced with the movs instruction then the execution will exit
the loop.

Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
---
 arch/arm/mm/proc-arm740.S |    4 ++--
 arch/arm/mm/proc-arm940.S |    4 ++--
 arch/arm/mm/proc-arm946.S |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/proc-arm740.S b/arch/arm/mm/proc-arm740.S
index 4506be3..9284f10 100644
--- a/arch/arm/mm/proc-arm740.S
+++ b/arch/arm/mm/proc-arm740.S
@@ -77,7 +77,7 @@ __arm740_setup:
 	ldr	r1, =(CONFIG_DRAM_SIZE >> 12)	@ size of RAM (must be >= 4KB)
 	mov	r2, #10				@ 11 is the minimum (4KB)
 1:	add	r2, r2, #1			@ area size *= 2
-	mov	r1, r1, lsr #1
+	movs	r1, r1, lsr #1			@ set zero bit if r1=0
 	bne	1b				@ count not zero r-shift
 	orr	r0, r0, r2, lsl #1		@ the area register value
 	orr	r0, r0, #1			@ set enable bit
@@ -87,7 +87,7 @@ __arm740_setup:
 	ldr	r1, =(CONFIG_FLASH_SIZE >> 12)	@ size of FLASH (must be >= 4KB)
 	mov	r2, #10				@ 11 is the minimum (4KB)
 1:	add	r2, r2, #1			@ area size *= 2
-	mov	r1, r1, lsr #1
+	movs	r1, r1, lsr #1			@ set zero bit if r1=0
 	bne	1b				@ count not zero r-shift
 	orr	r0, r0, r2, lsl #1		@ the area register value
 	orr	r0, r0, #1			@ set enable bit
diff --git a/arch/arm/mm/proc-arm940.S b/arch/arm/mm/proc-arm940.S
index ac750d5..e639034 100644
--- a/arch/arm/mm/proc-arm940.S
+++ b/arch/arm/mm/proc-arm940.S
@@ -296,7 +296,7 @@ __arm940_setup:
 	ldr	r1, =(CONFIG_DRAM_SIZE >> 12)	@ size of RAM (must be >= 4KB)
 	mov	r2, #10				@ 11 is the minimum (4KB)
 1:	add	r2, r2, #1			@ area size *= 2
-	mov	r1, r1, lsr #1
+	movs	r1, r1, lsr #1			@ set zero bit if r1=0
 	bne	1b				@ count not zero r-shift
 	orr	r0, r0, r2, lsl #1		@ the area register value
 	orr	r0, r0, #1			@ set enable bit
@@ -307,7 +307,7 @@ __arm940_setup:
 	ldr	r1, =(CONFIG_FLASH_SIZE >> 12)	@ size of FLASH (must be >= 4KB)
 	mov	r2, #10				@ 11 is the minimum (4KB)
 1:	add	r2, r2, #1			@ area size *= 2
-	mov	r1, r1, lsr #1
+	movs	r1, r1, lsr #1			@ set zero bit if r1=0
 	bne	1b				@ count not zero r-shift
 	orr	r0, r0, r2, lsl #1		@ the area register value
 	orr	r0, r0, #1			@ set enable bit
diff --git a/arch/arm/mm/proc-arm946.S b/arch/arm/mm/proc-arm946.S
index 683af3a..731388a 100644
--- a/arch/arm/mm/proc-arm946.S
+++ b/arch/arm/mm/proc-arm946.S
@@ -341,7 +341,7 @@ __arm946_setup:
 	ldr	r1, =(CONFIG_DRAM_SIZE >> 12)	@ size of RAM (must be >= 4KB)
 	mov	r2, #10				@ 11 is the minimum (4KB)
 1:	add	r2, r2, #1			@ area size *= 2
-	mov	r1, r1, lsr #1
+	movs	r1, r1, lsr #1			@ set zero bit if r1=0
 	bne	1b				@ count not zero r-shift
 	orr	r0, r0, r2, lsl #1		@ the region register value
 	orr	r0, r0, #1			@ set enable bit
@@ -351,7 +351,7 @@ __arm946_setup:
 	ldr	r1, =(CONFIG_FLASH_SIZE >> 12)	@ size of FLASH (must be >= 4KB)
 	mov	r2, #10				@ 11 is the minimum (4KB)
 1:	add	r2, r2, #1			@ area size *= 2
-	mov	r1, r1, lsr #1
+	movs	r1, r1, lsr #1			@ set zero bit if r1=0
 	bne	1b				@ count not zero r-shift
 	orr	r0, r0, r2, lsl #1		@ the region register value
 	orr	r0, r0, #1			@ set enable bit
-- 
1.7.1
