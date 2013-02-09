From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Sat,  9 Feb 2013 21:44:28 +0100
Subject: [PATCH RFC 4/7] ARM: OMAP: gpmc-smsc911x: pass a dev node to platform
 registration
In-Reply-To: <1360442671-15216-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1360442671-15216-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1360442671-15216-5-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The smsc911x driver needs the GPMC smsc911x associated device
node to set the OMAP mux pins using the pinctrl framework.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/mach-omap2/gpmc-smsc911x.c |    5 ++++-
 arch/arm/mach-omap2/gpmc-smsc911x.h |    1 +
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
index 59a2ee4..9f3b0a5 100644
--- a/arch/arm/mach-omap2/gpmc-smsc911x.c
+++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
@@ -83,7 +83,8 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *gpmc_cfg)
 
 	pdev = platform_device_register_resndata(NULL, "smsc911x", gpmc_cfg->id,
 		 gpmc_smsc911x_resources, ARRAY_SIZE(gpmc_smsc911x_resources),
-		 &gpmc_smsc911x_config, sizeof(gpmc_smsc911x_config), NULL);
+		 &gpmc_smsc911x_config, sizeof(gpmc_smsc911x_config),
+		 gpmc_cfg->of_node);
 	if (!pdev) {
 		pr_err("Unable to register platform device\n");
 		gpio_free(gpmc_cfg->gpio_reset);
@@ -107,6 +108,8 @@ int gpmc_smsc911x_init_dt(struct device_node *node)
 	if (WARN_ON(!node))
 		return -ENODEV;
 
+	gpmc_cfg.of_node = node;
+
 	if (of_property_read_u32(node, "gpmc,cs", &gpmc_cfg.cs)) {
 		pr_err("Unable to get GPMC smsc911x chip select\n");
 		return -EINVAL;
diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.h b/arch/arm/mach-omap2/gpmc-smsc911x.h
index bbcb8bc..32a7df0 100644
--- a/arch/arm/mach-omap2/gpmc-smsc911x.h
+++ b/arch/arm/mach-omap2/gpmc-smsc911x.h
@@ -19,6 +19,7 @@ struct omap_smsc911x_platform_data {
 	int	gpio_irq;
 	int	gpio_reset;
 	u32	flags;
+	struct device_node *of_node;
 };
 
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
-- 
1.7.7.6
