From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 19 Nov 2014 17:07:56 +0100
Subject: [PATCH RESEND 2/4] hwrng: atmel: add DT support
In-Reply-To: <1416413278-10197-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1416413278-10197-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1416413278-10197-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT support.

Make the driver depend on CONFIG_OF as at91sam9g45 was the only SoC making
use of the TRNG block and this SoC is now fully migrated to DT.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/char/hw_random/Kconfig     | 2 +-
 drivers/char/hw_random/atmel-rng.c | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 836b061..a0f5500 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -64,7 +64,7 @@ config HW_RANDOM_AMD
 
 config HW_RANDOM_ATMEL
 	tristate "Atmel Random Number Generator support"
-	depends on ARCH_AT91 && HAVE_CLK
+	depends on ARCH_AT91 && HAVE_CLK && OF
 	default HW_RANDOM
 	---help---
 	  This driver provides kernel-side support for the Random Number
diff --git a/drivers/char/hw_random/atmel-rng.c b/drivers/char/hw_random/atmel-rng.c
index 644ec48..0bb0b21 100644
--- a/drivers/char/hw_random/atmel-rng.c
+++ b/drivers/char/hw_random/atmel-rng.c
@@ -123,6 +123,12 @@ static const struct dev_pm_ops atmel_trng_pm_ops = {
 };
 #endif /* CONFIG_PM */
 
+static const struct of_device_id atmel_trng_dt_ids[] = {
+	{ .compatible = "atmel,at91sam9g45-trng" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, atmel_trng_dt_ids);
+
 static struct platform_driver atmel_trng_driver = {
 	.probe		= atmel_trng_probe,
 	.remove		= atmel_trng_remove,
@@ -132,6 +138,7 @@ static struct platform_driver atmel_trng_driver = {
 #ifdef CONFIG_PM
 		.pm	= &atmel_trng_pm_ops,
 #endif /* CONFIG_PM */
+		.of_match_table = atmel_trng_dt_ids,
 	},
 };
 
-- 
1.9.1
