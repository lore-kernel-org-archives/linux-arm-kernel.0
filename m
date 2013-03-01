From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 1 Mar 2013 11:22:48 -0600
Subject: [PATCH 2/2] gpio/omap: warn if bank is not enabled on setting irq type
In-Reply-To: <1362158568-1624-1-git-send-email-jon-hunter@ti.com>
References: <1362158568-1624-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1362158568-1624-3-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For OMAP devices, if a gpio is being used as an interrupt source but has
not been requested by calling gpio_request(), a call to request_irq()
may cause the kernel hang because the gpio bank may be disabled and
hence the register access will fail. To prevent such hangs, test for
this case and warn if this is detected.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 drivers/gpio/gpio-omap.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index c3598d1..0d30c7a 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -427,6 +427,9 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
 	int retval;
 	unsigned long flags;
 
+	if (WARN_ON(!bank->mod_usage))
+		return -EINVAL;
+
 #ifdef CONFIG_ARCH_OMAP1
 	if (d->irq > IH_MPUIO_BASE)
 		gpio = OMAP_MPUIO(d->irq - IH_MPUIO_BASE);
-- 
1.7.10.4
