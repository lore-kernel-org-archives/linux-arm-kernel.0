From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 5 Aug 2012 14:01:27 +0800
Subject: [PATCH 3/4] gpio/mxs: specify gpio base for device tree probe
In-Reply-To: <1344146488-9496-1-git-send-email-shawn.guo@linaro.org>
References: <1344146488-9496-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1344146488-9496-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, unlike the non-DT probe where the gpio base is specified
with pdev->id, the DT probe uses the base dynamically allocated by
gpio core, which uses a completely different numbering scheme.  This
causes two issues to user space applications which access sysfs entry
/sys/class/gpio/gpioN.

* It breaks the compatibility with user space applications between
  non-DT and DT kernels.

* It's not intuitive and sometimes hard for users to map the Linux
  gpio number to the actual hardware pin.

Use alias to identify the gpio port/bank, and then the gpio base
can be specified with port id to solve above issues.  If alias is not
defined in device tree, the base number dynamically allocated by gpio
core will be used.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/gpio/gpio-mxs.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index 39e4956..09687ce 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -290,7 +290,8 @@ static int __devinit mxs_gpio_probe(struct platform_device *pdev)
 		return err;
 
 	port->bgc.gc.to_irq = mxs_gpio_to_irq;
-	port->bgc.gc.base = port->id * 32;
+	port->bgc.gc.base = (pdev->id < 0) ? of_alias_get_id(np, "gpio") * 32 :
+					     pdev->id * 32;
 
 	err = gpiochip_add(&port->bgc.gc);
 	if (err) {
-- 
1.7.5.4
