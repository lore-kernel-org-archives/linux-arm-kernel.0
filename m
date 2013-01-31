From: manishv.b@ti.com (Vishwanathrao Badarkhe, Manish)
Date: Thu, 31 Jan 2013 14:53:41 +0530
Subject: [PATCH RFC] davinci: poll for sleep completion in resume routine.
Message-ID: <1359624221-5378-1-git-send-email-manishv.b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per OMAP-L138 TRM, Software must poll for
SLEEPCOMPLETE bit until it is set to 1 before clearing
SLEEPENABLE bit in DEEPSLEEP register in resume routine.
Modifications are as per datasheet:
http://www.ti.com/lit/ug/spruh77a/spruh77a.pdf
See sections 10.10.2.2 and 11.5.21 for more detailed
explanation.

Tested on da850-evm.

Signed-off-by: Vishwanathrao Badarkhe, Manish <manishv.b@ti.com>
---
:100644 100644 d4e9316... 976f096... M	arch/arm/mach-davinci/sleep.S
 arch/arm/mach-davinci/sleep.S |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/sleep.S b/arch/arm/mach-davinci/sleep.S
index d4e9316..976f096 100644
--- a/arch/arm/mach-davinci/sleep.S
+++ b/arch/arm/mach-davinci/sleep.S
@@ -35,6 +35,7 @@
 #define PLL_LOCK_CYCLES		(PLL_LOCK_TIME * 25)
 
 #define DEEPSLEEP_SLEEPENABLE_BIT	BIT(31)
+#define DEEPSLEEP_SLEEPCOMPLETE_BIT 	BIT(30)
 
 	.text
 /*
@@ -110,6 +111,13 @@ ENTRY(davinci_cpu_suspend)
 
 	/* Wake up from sleep */
 
+	/* wait for sleep complete */
+sleep_complete:
+	ldr 	ip, [r4]
+	and 	ip, ip, #DEEPSLEEP_SLEEPCOMPLETE_BIT
+	cmp 	ip, #DEEPSLEEP_SLEEPCOMPLETE_BIT
+	bne 	sleep_complete
+
 	/* Clear sleep enable */
 	ldr	ip, [r4]
 	bic	ip, ip, #DEEPSLEEP_SLEEPENABLE_BIT
-- 
1.7.4.1
