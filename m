From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 19 Sep 2016 04:37:27 +0300
Subject: [PATCH 15/19] ARM: imx legacy: scb9328: move peripheral
 initialization to .init_late
In-Reply-To: <1474248988-10626-1-git-send-email-vz@mleia.com>
References: <1474248988-10626-1-git-send-email-vz@mleia.com>
Message-ID: <1474249051-10718-15-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change moves some of peripheral registrations and initializations
(all peripherals dependent on GPIOs) from .init_machine to .init_late
level, this allows to safely shift the shared GPIO controller driver
initialization level after init level of i.MX IOMUXC driver.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-imx/mach-scb9328.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-scb9328.c b/arch/arm/mach-imx/mach-scb9328.c
index 1f6bc3f..8023769 100644
--- a/arch/arm/mach-imx/mach-scb9328.c
+++ b/arch/arm/mach-imx/mach-scb9328.c
@@ -119,8 +119,12 @@ static void __init scb9328_init(void)
 			ARRAY_SIZE(mxc_uart1_pins), "UART1");
 
 	imx1_add_imx_uart0(&uart_pdata);
+}
 
+static void __init scb9328_late_init(void)
+{
 	printk(KERN_INFO"Scb9328: Adding devices\n");
+
 	dm9000x_resources[2].start = gpio_to_irq(IMX_GPIO_NR(3, 3));
 	dm9000x_resources[2].end = gpio_to_irq(IMX_GPIO_NR(3, 3));
 	platform_add_devices(devices, ARRAY_SIZE(devices));
@@ -138,6 +142,7 @@ MACHINE_START(SCB9328, "Synertronixx scb9328")
 	.init_early = imx1_init_early,
 	.init_irq = mx1_init_irq,
 	.init_time	= scb9328_timer_init,
-	.init_machine = scb9328_init,
+	.init_machine	= scb9328_init,
+	.init_late	= scb9328_late_init,
 	.restart	= mxc_restart,
 MACHINE_END
-- 
2.8.1
