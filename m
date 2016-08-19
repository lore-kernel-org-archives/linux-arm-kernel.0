From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Sat, 20 Aug 2016 01:10:15 +0300
Subject: [PATCH 3/3] gpio: mxc: add generic gpio request/free callbacks to
 pinctrl
In-Reply-To: <1471644615-10320-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1471644615-10320-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <1471644615-10320-4-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a GPIO controller description in board DTB contains information
about mappings between GPIOs and pads under IOMUX control use it to
request and free GPIOs with respect to pinctrl/pinmux subsystems.

One of immediate positive functional changes is inability to
request non-existing GPIOs, i.e. if there is no pad such. Also
pinctrl/pinmux may now properly account pads occupied by requested
GPIOs.

The change has no effect, if "gpio-ranges" property is not found
including the case if a board has no DTB firmware.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
 drivers/gpio/gpio-mxc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 1f0deb7d3380..342f34f90bbd 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -458,6 +458,11 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 	if (err)
 		goto out_bgio;
 
+	if (of_property_read_bool(np, "gpio-ranges")) {
+		port->gc.request = gpiochip_generic_request;
+		port->gc.free = gpiochip_generic_free;
+	}
+
 	port->gc.to_irq = mxc_gpio_to_irq;
 	port->gc.base = (pdev->id < 0) ? of_alias_get_id(np, "gpio") * 32 :
 					     pdev->id * 32;
-- 
2.8.1
