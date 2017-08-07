From: michal.simek@xilinx.com (Michal Simek)
Date: Mon,  7 Aug 2017 13:01:56 +0200
Subject: [PATCH 3/8] gpio: zynq: Shift zynq_gpio_init() to subsys_initcall
 level
In-Reply-To: <cover.1502103715.git.michal.simek@xilinx.com>
References: <cover.1502103715.git.michal.simek@xilinx.com>
Message-ID: <a05cc4f104097bef71ed381229aa8c746717ebce.1502103715.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nava kishore Manne <nava.manne@xilinx.com>

In general situation on-SoC GPIO controller drivers should be probed
after pinctrl/pinmux controller driver, because on-SoC GPIOs utilize a
pin/pad as a resource provided and controlled by pinctrl subsystem.

  GPIO must come after pinctrl as gpios may need to mux pins....etc

Looking at Xilinx SoC series pinctrl drivers, zynq*_pinctrl_init()
functions are called at arch_initcall init levels,
so the change of initcall level for gpio-zynq driver from
postcore_initcall to subsys_initcall level is sufficient. Also note
that the most of GPIO controller drivers settled at subsys_initcall
level.

If pinctrl subsystem manages pads with GPIO functions, the change is
needed to avoid unwanted driver probe deferrals during kernel boot.

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/gpio/gpio-zynq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 5198fa6e016a..bcf11f0ef5c3 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -929,7 +929,7 @@ static int __init zynq_gpio_init(void)
 {
 	return platform_driver_register(&zynq_gpio_driver);
 }
-postcore_initcall(zynq_gpio_init);
+subsys_initcall(zynq_gpio_init);
 
 static void __exit zynq_gpio_exit(void)
 {
-- 
1.9.1
