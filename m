From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 25 Jun 2015 10:29:19 +0200
Subject: [PATCH] gpio: zynq: Fix problem with unbalanced pm_runtime_enable
Message-ID: <b4b2bb2d7747f8c9223fb50fd2868f77a7c7f63a.1435220957.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing pm_runtime_disabled to remove().

Error log:
root at zynqmp:~# modprobe gpio_zynq
root at zynqmp:~# lsmod
    Not tainted
gpio_zynq 7086 0 - Live 0xffffffbffc00a000
root at zynqmp:~# rmmod gpio_zynq
root at zynqmp:~# lsmod
    Not tainted
root at zynqmp:~# modprobe gpio_zynq
[  246.924438] zynq-gpio ff0a0000.gpio: Unbalanced pm_runtime_enable!
root at zynqmp:~# rmmod gpio_zynq
root at zynqmp:~# lsmod
    Not tainted

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/gpio/gpio-zynq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 2e87c4b8da26..a78882389836 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -757,6 +757,7 @@ static int zynq_gpio_remove(struct platform_device *pdev)
 	gpiochip_remove(&gpio->chip);
 	clk_disable_unprepare(gpio->clk);
 	device_set_wakeup_capable(&pdev->dev, 0);
+	pm_runtime_disable(&pdev->dev);
 	return 0;
 }
 
-- 
2.3.5
