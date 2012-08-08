From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  8 Aug 2012 16:47:28 +0200
Subject: [PATCH 11/11] pm/drivers: fix use of SIMPLE_DEV_PM_OPS
In-Reply-To: <1344437248-20560-1-git-send-email-arnd@arndb.de>
References: <1344437248-20560-1-git-send-email-arnd@arndb.de>
Message-ID: <1344437248-20560-12-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A few drivers use a construct like

 #ifdef CONFIG_PM
 static int foo_suspend(struct device *pdev)
 {
    ...
 }
 static int foo_resume struct device *pdev)
 {
    ...
 }
 #endif
 static SIMPLE_DEV_PM_OPS(foo_pm, foo_suspend, foo_resume);

which leaves the two functions unused if CONFIG_PM is enabled
but CONFIG_PM_SLEEP is disabled. I found this while building
all defconfig files on ARM. It's not clear to me if this is
the right solution, but at least it makes the code consistent
again.

Without this patch, building omap1_defconfig results in:

drivers/char/hw_random/omap-rng.c:165:12: warning: 'omap_rng_suspend' defined but not used [-Wunused-function]
drivers/char/hw_random/omap-rng.c:171:12: warning: 'omap_rng_resume' defined but not used [-Wunused-function]
sound/drivers/dummy.c:1068:12: warning: 'snd_dummy_suspend' defined but not used [-Wunused-function]
sound/drivers/dummy.c:1078:12: warning: 'snd_dummy_resume' defined but not used [-Wunused-function]

and building tegra_defconfig results in:

drivers/i2c/busses/i2c-tegra.c:716:12: warning: 'tegra_i2c_suspend' defined but not used [-Wunused-function]
drivers/i2c/busses/i2c-tegra.c:727:12: warning: 'tegra_i2c_resume' defined but not used [-Wunused-function]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/char/hw_random/omap-rng.c |    2 +-
 drivers/i2c/busses/i2c-tegra.c    |    2 +-
 sound/drivers/dummy.c             |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/omap-rng.c b/drivers/char/hw_random/omap-rng.c
index d706bd0e..4fbdceb 100644
--- a/drivers/char/hw_random/omap-rng.c
+++ b/drivers/char/hw_random/omap-rng.c
@@ -160,7 +160,7 @@ static int __exit omap_rng_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 
 static int omap_rng_suspend(struct device *dev)
 {
diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 66eb53f..9a08c57 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -712,7 +712,7 @@ static int __devexit tegra_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int tegra_i2c_suspend(struct device *dev)
 {
 	struct tegra_i2c_dev *i2c_dev = dev_get_drvdata(dev);
diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index f7d3bfc..54bb664 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -1064,7 +1064,7 @@ static int __devexit snd_dummy_remove(struct platform_device *devptr)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int snd_dummy_suspend(struct device *pdev)
 {
 	struct snd_card *card = dev_get_drvdata(pdev);
-- 
1.7.10
