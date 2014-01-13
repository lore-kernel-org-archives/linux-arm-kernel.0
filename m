From: balbi@ti.com (Felipe Balbi)
Date: Mon, 13 Jan 2014 12:03:57 -0600
Subject: [PATCH] arm: omap1: fix build when !CONFIG_OMAP_32K_TIMER
Message-ID: <1389636237-2998-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_OMAP_32K_TIMER isn't enabled, we will
try to use enable_dyn_sleep which wasn't defined
anywhere.

In order to fix the problem, we always define
enable_dyn_sleep as 0 when !CONFIG_OMAP_32K_TIMER.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap1/pm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 40a1ae3..dbee729 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -71,7 +71,11 @@ static unsigned int mpui7xx_sleep_save[MPUI7XX_SLEEP_SAVE_SIZE];
 static unsigned int mpui1510_sleep_save[MPUI1510_SLEEP_SAVE_SIZE];
 static unsigned int mpui1610_sleep_save[MPUI1610_SLEEP_SAVE_SIZE];
 
-#ifdef CONFIG_OMAP_32K_TIMER
+#ifndef CONFIG_OMAP_32K_TIMER
+
+static unsigned short enable_dyn_sleep = 0;
+
+#else
 
 static unsigned short enable_dyn_sleep = 1;
 
-- 
1.8.5.2
