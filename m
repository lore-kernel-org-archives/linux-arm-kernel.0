From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 28 Oct 2016 19:20:33 +0200
Subject: pinctrl: mediatek: build failure if CONFIG_IRQ_DOMAIN is not set
Message-ID: <1477675233.2167.11.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

0) A rather spartan build, on x86_64, which did include
drivers/pinctrl/mediatek/pinctrl-mtk-common.o failed like this:

drivers/pinctrl/mediatek/pinctrl-mtk-common.c: In function ?mtk_gpio_to_irq?:
drivers/pinctrl/mediatek/pinctrl-mtk-common.c:838:8: error: implicit declaration of function ?irq_find_mapping? [-Werror=implicit-function-declaration]
  irq = irq_find_mapping(pctl->domain, pin->eint.eintnum);
        ^~~~~~~~~~~~~~~~
drivers/pinctrl/mediatek/pinctrl-mtk-common.c: In function ?mtk_pctrl_init?:
drivers/pinctrl/mediatek/pinctrl-mtk-common.c:1474:17: error: implicit declaration of function ?irq_domain_add_linear? [-Werror=implicit-function-declaration]
  pctl->domain = irq_domain_add_linear(np,
                 ^~~~~~~~~~~~~~~~~~~~~
drivers/pinctrl/mediatek/pinctrl-mtk-common.c:1475:27: error: ?irq_domain_simple_ops? undeclared (first use in this function)
   pctl->devdata->ap_num, &irq_domain_simple_ops, NULL);
                           ^~~~~~~~~~~~~~~~~~~~~
drivers/pinctrl/mediatek/pinctrl-mtk-common.c:1475:27: note: each undeclared identifier is reported only once for each function it appears in
drivers/pinctrl/mediatek/pinctrl-mtk-common.c:1484:14: error: implicit declaration of function ?irq_create_mapping? [-Werror=implicit-function-declaration]
   int virq = irq_create_mapping(pctl->domain, i);
              ^~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
make[3]: *** [drivers/pinctrl/mediatek/pinctrl-mtk-common.o] Error 1
make[2]: *** [drivers/pinctrl/mediatek] Error 2
make[1]: *** [drivers/pinctrl] Error 2
make: *** [drivers] Error 2

1) That build had CONFIG_COMPILE_TEST set (obviously) but
CONFIG_IRQ_DOMAIN not set.

2) This quick hack fixes that for me:

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 419ea4d5964d..066087156dcc 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -7,6 +7,7 @@ config PINCTRL_MTK
        select GENERIC_PINCONF
        select GPIOLIB
        select OF_GPIO
+       select IRQ_DOMAIN
 
 # For ARMv7 SoCs
 config PINCTRL_MT2701

3) Would you like me to submit a proper (but lightly tested) patch or
do you prefer to fix this yourself?

Thanks,


Paul Bolle
