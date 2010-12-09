From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  9 Dec 2010 11:33:46 -0800
Subject: [PATCH 13/11] OMAP2+: GPIO: ensure bank wakeups are enabled by default
In-Reply-To: <1290689318-10191-1-git-send-email-charu@ti.com>
References: <1290689318-10191-1-git-send-email-charu@ti.com>
Message-ID: <1291923226-10112-1-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As part of the GPIO conversion to platform_device/platform_driver,
commit 2fae7fbed072705d91e09ed393b2e580b2d895fc (OMAP: GPIO: prepare
for platform driver) removed hard-coded per-bank SYSCONFIG register
values in favor of using omap_hwmod to manage the SYSCONFIG register.

In the previous code, bank-level wakeups were enabled by default using
the SYSCONFIG.ENAWAKEUP bit, but omap_hwmod does not enable wakeups by
default.  Thus the above commit effectively disabled GPIO bank wakeups.

This patch enables GPIO bank level wakeups by default to preserve
previous functionality.

Longer term, per-bank wakeup functionality should be controlled by the
driver and enabled only when there are wakeup-enabled GPIOs in the
bank.

Tested on 36xx/Zoom3 where serial console (QUART) uses GPIO IRQ.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Applies to Tony's devel-gpio branch.

 arch/arm/mach-omap2/gpio.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 413de18..05a123f 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -75,6 +75,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		return -EINVAL;
 	}
 
+	omap_hwmod_enable_wakeup(oh);
 	od = omap_device_build(name, id - 1, oh, pdata,
 				sizeof(*pdata),	omap_gpio_latency,
 				ARRAY_SIZE(omap_gpio_latency),
-- 
1.7.2.1
