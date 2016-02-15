From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 15 Feb 2016 10:19:04 +0100
Subject: [PATCH] iio: health/afe4404: mark suspend/resume functions
 __maybe_unused
Message-ID: <1455527958-2647084-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added afe4404 driver implements suspend/resume using the
SIMPLE_DEV_PM_OPS() macro, which leaves out references to the actual
functions when CONFIG_PM is disabled, causing a harmless warning:

health/afe4404.c:509:12: error: 'afe4404_suspend' defined but not used
health/afe4404.c:530:12: error: 'afe4404_resume' defined but not used

This marks the functions as __maybe_unused so we don't get those
warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 87aec56e27ef ("iio: health: Add driver for the TI AFE4404 heart monitor")
---
 drivers/iio/health/afe4404.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index 0759268f37e0..5096a4643784 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -477,7 +477,7 @@ static const struct of_device_id afe4404_of_match[] = {
 MODULE_DEVICE_TABLE(of, afe4404_of_match);
 #endif
 
-static int afe4404_suspend(struct device *dev)
+static int __maybe_unused afe4404_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct afe4404_data *afe = iio_priv(indio_dev);
@@ -498,7 +498,7 @@ static int afe4404_suspend(struct device *dev)
 	return 0;
 }
 
-static int afe4404_resume(struct device *dev)
+static int __maybe_unused afe4404_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct afe4404_data *afe = iio_priv(indio_dev);
-- 
2.7.0
