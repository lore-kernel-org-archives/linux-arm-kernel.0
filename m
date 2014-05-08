From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  8 May 2014 16:56:29 +0200
Subject: [PATCH] remoteproc: da8xx: don't select CMA on no-MMU
In-Reply-To: <1399560990-1402858-1-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
Message-ID: <1399560990-1402858-18-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can only use CMA on systems that have an MMU, because of
the requirement to use memory migration. NOMMU systems are
rather constrained to start with, but it seems reasonable
to assume that DMA allocations can still succeed in the
constrained case for remoteproc on NOMMU, so this patch
changes the da8xx implementation to not rely on CMA when
the MMU is disabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Robert Tivy <rtivy@ti.com>
---
 drivers/remoteproc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index ce1743d..5e343ba 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -44,7 +44,7 @@ config STE_MODEM_RPROC
 config DA8XX_REMOTEPROC
 	tristate "DA8xx/OMAP-L13x remoteproc support"
 	depends on ARCH_DAVINCI_DA8XX
-	select CMA
+	select CMA if MMU
 	select REMOTEPROC
 	select RPMSG
 	help
-- 
1.8.3.2
