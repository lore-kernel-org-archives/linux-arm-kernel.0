From: tixy@yxit.co.uk (Tixy)
Date: Thu, 21 Apr 2011 18:29:26 +0100
Subject: [PATCH] ARM: kprobes: Fix error in conditional instruction checking
In-Reply-To: <1302085032-30415-2-git-send-email-tixy@yxit.co.uk>
References: <1302085032-30415-2-git-send-email-tixy@yxit.co.uk>
Message-ID: <1303406966-28219-1-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

The patch titled "ARM: kprobes: Fix probing of conditionally executed
instructions" contains errors in the condition code checking functions
__check_gt() and __check_lt(). These return the incorrect results if the
Q flag is set because this is xored with the Z flag in the first
expression. The fix is to use an intermediate temporary variable.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-decode.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index 894e139..15eeff6 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -1587,16 +1587,16 @@ static unsigned long __kprobes __check_lt(unsigned long cpsr)
 
 static unsigned long __kprobes __check_gt(unsigned long cpsr)
 {
-	cpsr ^= (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
-	cpsr |= (cpsr << 1); /* PSR_N_BIT |= PSR_Z_BIT */
-	return (~cpsr) & PSR_N_BIT;
+	unsigned long temp = cpsr ^ (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
+	temp |= (cpsr << 1);			 /* PSR_N_BIT |= PSR_Z_BIT */
+	return (~temp) & PSR_N_BIT;
 }
 
 static unsigned long __kprobes __check_le(unsigned long cpsr)
 {
-	cpsr ^= (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
-	cpsr |= (cpsr << 1); /* PSR_N_BIT |= PSR_Z_BIT */
-	return cpsr & PSR_N_BIT;
+	unsigned long temp = cpsr ^ (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
+	temp |= (cpsr << 1);			 /* PSR_N_BIT |= PSR_Z_BIT */
+	return temp & PSR_N_BIT;
 }
 
 static unsigned long __kprobes __check_al(unsigned long cpsr)
-- 
1.7.2.5
