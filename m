From: thomas@m3y3r.de (Thomas Meyer)
Date: Thu, 17 Nov 2011 23:43:40 +0100
Subject: [PATCH] ARM: LPC32XX: Use kmemdup rather than duplicating its
 implementation
Message-ID: <1321569820.1624.267.camel@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The semantic patch that makes this change is available
in scripts/coccinelle/api/memdup.cocci.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/arch/arm/mach-lpc32xx/pm.c b/arch/arm/mach-lpc32xx/pm.c
--- a/arch/arm/mach-lpc32xx/pm.c 2011-11-07 19:37:19.236182427 +0100
+++ b/arch/arm/mach-lpc32xx/pm.c 2011-11-08 11:03:32.769642874 +0100
@@ -87,7 +87,8 @@ static int lpc32xx_pm_enter(suspend_stat
 	void *iram_swap_area;
 
 	/* Allocate some space for temporary IRAM storage */
-	iram_swap_area = kmalloc(lpc32xx_sys_suspend_sz, GFP_KERNEL);
+	iram_swap_area = kmemdup((void *)TEMP_IRAM_AREA,
+				 lpc32xx_sys_suspend_sz, GFP_KERNEL);
 	if (!iram_swap_area) {
 		printk(KERN_ERR
 		       "PM Suspend: cannot allocate memory to save portion "
@@ -95,10 +96,6 @@ static int lpc32xx_pm_enter(suspend_stat
 		return -ENOMEM;
 	}
 
-	/* Backup a small area of IRAM used for the suspend code */
-	memcpy(iram_swap_area, (void *) TEMP_IRAM_AREA,
-		lpc32xx_sys_suspend_sz);
-
 	/*
 	 * Copy code to suspend system into IRAM. The suspend code
 	 * needs to run from IRAM as DRAM may no longer be available
