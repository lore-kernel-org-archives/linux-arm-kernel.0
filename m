From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 30 Jul 2017 22:38:48 +0300
Subject: [PATCH] pinctrl: sirf: atlas7: fix of_irq_get() error check
Message-ID: <20170730193855.099325987@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_irq_get() may return  any negative error number as well as 0 on failure,
while the driver only checks for -EPROBE_DEFER, blithely continuing with
the call to gpiochip_set_chained_irqchip() -- that function expects the
parent IRQ as *unsigned int*, so would probably do nothing  when a large
IRQ number resulting from a conversion of a negative error number is passed
to it, however passing 0 would probably work but the driver won't receive
valid GPIO bank interrupts.

Check for 'ret <= 0' instead and return -ENXIO from the driver's probe iff
of_irq_get() returned 0.

Fixes: f9367793293d ("pinctrl: sirf: add sirf atlas7 pinctrl and gpio support")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'fixes' branch of Linus W.'s 'linux-pinctrl.git' repo.

 drivers/pinctrl/sirf/pinctrl-atlas7.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-pinctrl/drivers/pinctrl/sirf/pinctrl-atlas7.c
===================================================================
--- linux-pinctrl.orig/drivers/pinctrl/sirf/pinctrl-atlas7.c
+++ linux-pinctrl/drivers/pinctrl/sirf/pinctrl-atlas7.c
@@ -6081,9 +6081,11 @@ static int atlas7_gpio_probe(struct plat
 
 		/* Get interrupt number from DTS */
 		ret = of_irq_get(np, idx);
-		if (ret == -EPROBE_DEFER) {
+		if (ret <= 0) {
 			dev_err(&pdev->dev,
 				"Unable to find IRQ number. ret=%d\n", ret);
+			if (!ret)
+				ret = -ENXIO;
 			goto failed;
 		}
 		bank->irq = ret;
