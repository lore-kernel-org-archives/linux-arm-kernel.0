From: alexanders83@web.de (Alexander Stein)
Date: Fri, 11 Apr 2014 16:24:09 +0200
Subject: [PATCH] gpio/at91: free GPIO after configuring as input
Message-ID: <1397226249-3922-1-git-send-email-alexanders83@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the GPIO stays requested a device driver can't request it again.
e.g. Without this patch the ads7846 driver returns the following error:
ads7846 spi32766.3: failed to request/setup pendown GPIO15: -16
ads7846: probe of spi32766.3 failed with error -16

/sys/kernel/debug/gpio shows this:
GPIOs 0-31, platform/fffff200.gpio, fffff200.gpio:
[/ahb/apb/pinctrl at fffff200/gpio at fffff200] GPIOfffff200.gpio15: [gpio] set

Signed-off-by: Alexander Stein <alexanders83@web.de>
---
I'm aware that it makes sense this GPIO is/stays requested, but either the
pinctl or device driver have to be adjusted as both can't request this GPIO.
I think the latter shouldn't change.

 drivers/pinctrl/pinctrl-at91.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index d990e33..63176f2 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1493,6 +1493,8 @@ static int at91_gpio_irq_domain_xlate(struct irq_domain *d,
 	if (ret)
 		return ret;
 
+	gpio_free(pin);
+
 	return 0;
 }
 
-- 
1.9.2
