From: gbean@codeaurora.org (Gregory Bean)
Date: Wed, 29 Sep 2010 13:46:45 -0700
Subject: [PATCH 1/2] msm: qsd8x50: enable ethernet.
Message-ID: <1285793206-5717-1-git-send-email-gbean@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configure the smc91x ethernet chip on the qsd8x50 SURF.

Signed-off-by: Gregory Bean <gbean@codeaurora.org>
---
 arch/arm/mach-msm/board-qsd8x50.c |   39 +++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/board-qsd8x50.c
index fb0fe67..9e4cf24 100644
--- a/arch/arm/mach-msm/board-qsd8x50.c
+++ b/arch/arm/mach-msm/board-qsd8x50.c
@@ -35,6 +35,45 @@
 
 extern struct sys_timer msm_timer;
 
+static const resource_size_t qsd8x50_surf_smc91x_base __initdata = 0x70000300;
+static const unsigned        qsd8x50_surf_smc91x_gpio __initdata = 156;
+
+/* Leave smc91x resources empty here, as we'll fill them in
+ * at run-time: they vary from board to board, and the true
+ * configuration won't be known until boot.
+ */
+static struct resource smc91x_resources[] __initdata = {
+	[0] = {
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device smc91x_device __initdata = {
+	.name           = "smc91x",
+	.id             = 0,
+	.num_resources  = ARRAY_SIZE(smc91x_resources),
+	.resource       = smc91x_resources,
+};
+
+static int __init msm_init_smc91x(void)
+{
+	if (machine_is_qsd8x50_surf()) {
+		smc91x_resources[0].start = qsd8x50_surf_smc91x_base;
+		smc91x_resources[0].end   = qsd8x50_surf_smc91x_base + 0xff;
+		smc91x_resources[1].start =
+			gpio_to_irq(qsd8x50_surf_smc91x_gpio);
+		smc91x_resources[1].end   =
+			gpio_to_irq(qsd8x50_surf_smc91x_gpio);
+		platform_device_register(&smc91x_device);
+	}
+
+	return 0;
+}
+module_init(msm_init_smc91x);
+
 static struct platform_device *devices[] __initdata = {
 	&msm_device_uart3,
 };
-- 
1.7.0.4

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
