From: b-cousson@ti.com (Benoit Cousson)
Date: Wed, 24 Aug 2011 15:09:07 +0200
Subject: [RFC PATCH 01/10] OMAP2+: l3-noc: Add support for device-tree
In-Reply-To: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
Message-ID: <1314191356-10963-2-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device-tree support for the l3-noc driver.

Use platform_driver_register to defer the probing at device init
time.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap_l3_noc.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_l3_noc.c b/arch/arm/mach-omap2/omap_l3_noc.c
index 7b9f190..4630703 100644
--- a/arch/arm/mach-omap2/omap_l3_noc.c
+++ b/arch/arm/mach-omap2/omap_l3_noc.c
@@ -228,16 +228,28 @@ static int __exit omap4_l3_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#if defined(CONFIG_OF)
+static const struct of_device_id l3_noc_match[] = {
+	{.compatible = "arteris,noc", },
+	{},
+}
+MODULE_DEVICE_TABLE(of, l3_noc_match);
+#else
+#define l3_noc_match NULL
+#endif
+
 static struct platform_driver omap4_l3_driver = {
+	.probe		= omap4_l3_probe,
 	.remove		= __exit_p(omap4_l3_remove),
 	.driver		= {
-	.name		= "omap_l3_noc",
+		.name		= "omap_l3_noc",
+		.of_match_table = l3_noc_match,
 	},
 };
 
 static int __init omap4_l3_init(void)
 {
-	return platform_driver_probe(&omap4_l3_driver, omap4_l3_probe);
+	return platform_driver_register(&omap4_l3_driver);
 }
 postcore_initcall_sync(omap4_l3_init);
 
-- 
1.7.0.4
