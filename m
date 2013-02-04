From: Barry.Song@csr.com (Barry Song)
Date: Mon, 4 Feb 2013 17:53:34 +0800
Subject: [PATCH] pinctrl: sirf: replace of_gpio_simple_xlate by sirf specific
 of_xlate
Message-ID: <1359971614-18681-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

the default of_gpio_simple_xlate() will make us fail while getting gpios
bigger than 32 by of_get_named_gpio() or related APIs.
this patch adds a specific of_xlate callback for sirf gpio_chip and fix
the problem.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/pinctrl/pinctrl-sirf.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-sirf.c b/drivers/pinctrl/pinctrl-sirf.c
index fc76f28..7051874 100644
--- a/drivers/pinctrl/pinctrl-sirf.c
+++ b/drivers/pinctrl/pinctrl-sirf.c
@@ -1246,6 +1246,22 @@ static void __iomem *sirfsoc_rsc_of_iomap(void)
 	return of_iomap(np, 0);
 }
 
+static int sirfsoc_gpio_of_xlate(struct gpio_chip *gc,
+       const struct of_phandle_args *gpiospec,
+       u32 *flags)
+{
+       if (gpiospec->args[0] > SIRFSOC_GPIO_NO_OF_BANKS * SIRFSOC_GPIO_BANK_SIZE)
+               return -EINVAL;
+
+       if (gc != &sgpio_bank[gpiospec->args[0] / SIRFSOC_GPIO_BANK_SIZE].chip.gc)
+               return -EINVAL;
+
+       if (flags)
+               *flags = gpiospec->args[1];
+
+       return gpiospec->args[0] % SIRFSOC_GPIO_BANK_SIZE;
+}
+
 static int sirfsoc_pinmux_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -1747,6 +1763,8 @@ static int sirfsoc_gpio_probe(struct device_node *np)
 		bank->chip.gc.ngpio = SIRFSOC_GPIO_BANK_SIZE;
 		bank->chip.gc.label = kstrdup(np->full_name, GFP_KERNEL);
 		bank->chip.gc.of_node = np;
+		bank->chip.gc.of_xlate = sirfsoc_gpio_of_xlate;
+		bank->chip.gc.of_gpio_n_cells = 2;
 		bank->chip.regs = regs;
 		bank->id = i;
 		bank->is_marco = is_marco;
-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
