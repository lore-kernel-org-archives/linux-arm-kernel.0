From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Tue, 18 Aug 2015 16:45:44 +0000
Subject: [PATCH V2] Watchdog: Fix parent of watchdog_devices
In-Reply-To: <9fcc2a2cc8273f461baa13c6c9992f3ca56b508a.1439915117.git.panand@redhat.com>
References: <9fcc2a2cc8273f461baa13c6c9992f3ca56b508a.1439915117.git.panand@redhat.com>
Message-ID: <BN3PR0101MB1057C3FE09F00EEC55D2C9B1D0780@BN3PR0101MB1057.prod.exchangelabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, August 18, 2015 9:34 AM, Pratyush Anand wrote:
> 
> /sys/class/watchdog/watchdogn/device/modalias can help to identify the
> driver/module for a given watchdog node. However, many wdt devices does not set
> its parent and so, we do not see an entry for device in sysfs for such devices.
>
> This patch fixes parent of watchdog_device so that
> /sys/class/watchdog/watchdogn/device is populated.
>
> Exceptions: booke, diag288, mpc8xxx, octeon, softdog and w83627hf -- They do not
> have any parent. Not sure, how we can we identify driver for these devices.
>
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> ---
[snip]

drivers/watchdog/ep93xx_wdt.c       | 1 +

[snip]

diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.c
index 7a2cc7191c58..0a4d7cc05d54 100644
--- a/drivers/watchdog/ep93xx_wdt.c
+++ b/drivers/watchdog/ep93xx_wdt.c
@@ -132,6 +132,7 @@ static int ep93xx_wdt_probe(struct platform_device *pdev)
 	val = readl(mmio_base + EP93XX_WATCHDOG);
 	ep93xx_wdt_wdd.bootstatus = (val & 0x01) ? WDIOF_CARDRESET : 0;
 	ep93xx_wdt_wdd.timeout = timeout;
+	ep93xx_wdt_wdd.parent = &pdev->dev;
 
 	watchdog_set_nowayout(&ep93xx_wdt_wdd, nowayout);

For ep93xx_wdt.c, use whichever tag you prefer:

Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Thanks,
Hartley
