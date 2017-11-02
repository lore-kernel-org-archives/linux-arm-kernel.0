From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed,  1 Nov 2017 18:04:07 -0700
Subject: [PATCH 11/12] hwrng: bcm2835-rng: Enable BCM2835 RNG to work on
 BCM63xx platforms
In-Reply-To: <20171102010408.27736-1-f.fainelli@gmail.com>
References: <20171102010408.27736-1-f.fainelli@gmail.com>
Message-ID: <20171102010408.27736-12-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have now incorporated all necessary functionality for the BCM63xx
platforms to successfully migrate over bcm2835-rng, so add the final
bits: Kconfig selection and proper platform_device device type matching
to keep the same platform device name for registration to work.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/char/hw_random/Kconfig       |  7 ++++---
 drivers/char/hw_random/bcm2835-rng.c | 11 ++++++++++-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 95a031e9eced..d0689cc8c7fc 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -87,12 +87,13 @@ config HW_RANDOM_BCM63XX
 	  If unusure, say Y.
 
 config HW_RANDOM_BCM2835
-	tristate "Broadcom BCM2835 Random Number Generator support"
-	depends on ARCH_BCM2835 || ARCH_BCM_NSP || ARCH_BCM_5301X
+	tristate "Broadcom BCM2835/BCM63xx Random Number Generator support"
+	depends on ARCH_BCM2835 || ARCH_BCM_NSP || ARCH_BCM_5301X || \
+		   ARCH_BCM_63XX || BCM63XX || BMIPS_GENERIC
 	default HW_RANDOM
 	---help---
 	  This driver provides kernel-side support for the Random Number
-	  Generator hardware found on the Broadcom BCM2835 SoCs.
+	  Generator hardware found on the Broadcom BCM2835 and BCM63xx SoCs.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called bcm2835-rng
diff --git a/drivers/char/hw_random/bcm2835-rng.c b/drivers/char/hw_random/bcm2835-rng.c
index 650e0033c273..d9ffe14f312b 100644
--- a/drivers/char/hw_random/bcm2835-rng.c
+++ b/drivers/char/hw_random/bcm2835-rng.c
@@ -131,6 +131,7 @@ static const struct of_device_id bcm2835_rng_of_match[] = {
 	{ .compatible = "brcm,bcm2835-rng"},
 	{ .compatible = "brcm,bcm-nsp-rng", .data = &nsp_rng_of_data },
 	{ .compatible = "brcm,bcm5301x-rng", .data = &nsp_rng_of_data },
+	{ .compatible = "brcm,bcm6368-rng"},
 	{},
 };
 
@@ -164,7 +165,7 @@ static int bcm2835_rng_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->clk))
 		priv->clk = NULL;
 
-	priv->rng.name = "bcm2835-rng";
+	priv->rng.name = pdev->id_entry->name;
 	priv->rng.init = bcm2835_rng_init;
 	priv->rng.read = bcm2835_rng_read;
 	priv->rng.cleanup = bcm2835_rng_cleanup;
@@ -190,12 +191,20 @@ static int bcm2835_rng_probe(struct platform_device *pdev)
 
 MODULE_DEVICE_TABLE(of, bcm2835_rng_of_match);
 
+static struct platform_device_id bcm2835_rng_devtype[] = {
+	{ .name = "bcm2835-rng" },
+	{ .name = "bcm63xx-rng" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, bcm2835_rng_devtype);
+
 static struct platform_driver bcm2835_rng_driver = {
 	.driver = {
 		.name = "bcm2835-rng",
 		.of_match_table = bcm2835_rng_of_match,
 	},
 	.probe		= bcm2835_rng_probe,
+	.id_table	= bcm2835_rng_devtype,
 };
 module_platform_driver(bcm2835_rng_driver);
 
-- 
2.9.3
