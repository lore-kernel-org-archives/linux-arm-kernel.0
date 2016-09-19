From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 19 Sep 2016 04:37:26 +0300
Subject: [PATCH 14/19] ARM: imx legacy: apf9328: move peripheral
 initialization to .init_late
In-Reply-To: <1474248988-10626-1-git-send-email-vz@mleia.com>
References: <1474248988-10626-1-git-send-email-vz@mleia.com>
Message-ID: <1474249051-10718-14-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change moves some of peripheral registrations and initializations
(all peripherals dependent on GPIOs) from .init_machine to .init_late
level, this allows to safely shift the shared GPIO controller driver
initialization level after init level of i.MX IOMUXC driver.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-imx/mach-apf9328.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-apf9328.c b/arch/arm/mach-imx/mach-apf9328.c
index ebbb5ab..3f3ab7f 100644
--- a/arch/arm/mach-imx/mach-apf9328.c
+++ b/arch/arm/mach-imx/mach-apf9328.c
@@ -126,7 +126,10 @@ static void __init apf9328_init(void)
 	imx1_add_imx_uart1(&uart1_pdata);
 
 	imx1_add_imx_i2c(&apf9328_i2c_data);
+}
 
+static void __init apf9328_late_init(void)
+{
 	dm9000_resources[2].start = gpio_to_irq(IMX_GPIO_NR(2, 14));
 	dm9000_resources[2].end = gpio_to_irq(IMX_GPIO_NR(2, 14));
 	platform_add_devices(devices, ARRAY_SIZE(devices));
@@ -143,6 +146,7 @@ MACHINE_START(APF9328, "Armadeus APF9328")
 	.init_early   = imx1_init_early,
 	.init_irq     = mx1_init_irq,
 	.init_time	= apf9328_timer_init,
-	.init_machine = apf9328_init,
+	.init_machine	= apf9328_init,
+	.init_late	= apf9328_late_init,
 	.restart	= mxc_restart,
 MACHINE_END
-- 
2.8.1
