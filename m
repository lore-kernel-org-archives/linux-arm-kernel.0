From: arnd@arndb.de (Arnd Bergmann)
Date: Sun,  2 Oct 2011 16:45:41 +0200
Subject: [PATCH 11/30] ARM: omap2/n8x0: work around modular omap mmc
In-Reply-To: <1317566760-25681-1-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Message-ID: <1317566760-25681-12-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the omap driver is built as a module for n8x0,
n8x0_mmc_set_power_menelaus cannot call into the driver:

arch/arm/mach-omap2/board-n8x0.c:374: undefined reference to `omap_mmc_notify_cover_event'

As a workaround, do not provide that device in this case. This needs
to be fixed properly, e.g. by converting n8x0 to be probed through the
device tree and moving that code into the driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/board-n8x0.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index e11f0c5..403325d 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -193,8 +193,9 @@ static struct omap_onenand_platform_data board_onenand_data[] = {
 };
 #endif
 
-#if defined(CONFIG_MENELAUS) &&						\
-	(defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE))
+#if defined(CONFIG_MENELAUS) && defined(CONFIG_MMC_OMAP)
+/* || defined(CONFIG_MMC_OMAP_MODULE)) */
+/* FIXME: cannot call omap_mmc_notify_cover_event for ONFIG_MMC_OMAP_MODULE */
 
 /*
  * On both N800 and N810, only the first of the two MMC controllers is in use.
-- 
1.7.5.4
