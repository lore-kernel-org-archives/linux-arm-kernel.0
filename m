From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Thu, 22 Oct 2015 13:30:20 +0200
Subject: [PATCH] pinctrl-zynq: Initialize early
Message-ID: <1445513420-23527-1-git-send-email-mike.looijmans@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Supplying pinmux configuration for e.g. gpio pins leads to deferred
probes because the pinctrl device is probed much later than gpio.
Move the init call to a much earlier stage so it probes before the
devices that may need it.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/pinctrl/pinctrl-zynq.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-zynq.c b/drivers/pinctrl/pinctrl-zynq.c
index fd4602d..36984f1 100644
--- a/drivers/pinctrl/pinctrl-zynq.c
+++ b/drivers/pinctrl/pinctrl-zynq.c
@@ -1173,7 +1173,17 @@ static struct platform_driver zynq_pinctrl_driver = {
 	.remove = zynq_pinctrl_remove,
 };
 
-module_platform_driver(zynq_pinctrl_driver);
+static int __init zynq_pinctrl_init(void)
+{
+	return platform_driver_register(&zynq_pinctrl_driver);
+}
+arch_initcall(zynq_pinctrl_init);
+
+static void __exit zynq_pinctrl_exit(void)
+{
+	platform_driver_unregister(&zynq_pinctrl_driver);
+}
+module_exit(zynq_pinctrl_exit);
 
 MODULE_AUTHOR("S??ren Brinkmann <soren.brinkmann@xilinx.com>");
 MODULE_DESCRIPTION("Xilinx Zynq pinctrl driver");
-- 
1.9.1
