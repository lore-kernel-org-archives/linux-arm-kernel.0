From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 17 Jun 2015 16:10:02 +0200 (CEST)
Subject: [PATCH 1/9] irq: add irq_set_chained_handler_and_data()
In-Reply-To: <E1Z4yzs-0002Rw-4B@rmk-PC.arm.linux.org.uk>
References: <E1Z4yzs-0002Rw-4B@rmk-PC.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.11.1506171609390.4107@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Jun 2015, Russell King wrote:

> Driver authors seem to get the ordering of irq_set_chained_handler()
> and irq_set_handler_data() wrong - ordering the former before the
> latter.  This opens a race window where, if there is an interrupt
> pending, the handler will be called between these two calls,
> potentially resulting in an oops.
> 
> Provide a single interface to set both of these together, especially
> as that's commonly what is required.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> It probably makes sense to convert everything over to this new
> registration function, and kill all users of irq_set_chained_handler()
> to prevent this problem recurring.  Thoughts?

Yes. Classic coccinelle problem. Here is the semantic patch:

@@
expression E1, E2, E3;
@@
-irq_set_chained_handler(E1, E3);
...
-irq_set_handler_data(E1, E2);
+irq_set_chained_handler_and_data(E1, E3, E2);

This finds and corrects all instances which get it wrong:

arch:
 arm/common/locomo.c                   |    3 +--
 arm/common/sa1111.c                   |    3 +--
 arm/mach-gemini/gpio.c                |    4 ++--
 avr32/mach-at32ap/extint.c            |    3 +--
 m68k/mac/psc.c                        |   12 ++++--------
 mips/ath25/ar2315.c                   |    4 ++--
 mips/ath25/ar5312.c                   |    4 ++--
 mips/pci/pci-ar2315.c                 |    4 ++--
 mips/ralink/irq.c                     |    3 +--
 sh/intc/core.c                        |    5 +++--

drivers:
 dma/ipu/ipu_irq.c                     |    6 ++----
 gpio/gpio-bcm-kona.c                  |    5 +++--
 gpio/gpio-davinci.c                   |   10 ++--------
 gpio/gpio-dwapb.c                     |    4 ++--
 gpio/gpio-msic.c                      |    3 +--
 gpio/gpio-mxc.c                       |   10 +++++-----
 gpio/gpio-mxs.c                       |    4 ++--
 gpio/gpio-tegra.c                     |    4 ++--
 gpu/ipu-v3/ipu-common.c               |   13 +++++--------
 irqchip/irq-keystone.c                |    4 ++--
 irqchip/spear-shirq.c                 |    3 +--
 mfd/pm8921-core.c                     |    6 ++----
 mfd/t7l66xb.c                         |    3 +--
 mfd/tc6393xb.c                        |    3 +--
 pci/host/pci-keystone.c               |    7 +++----
 pinctrl/mediatek/pinctrl-mtk-common.c |    3 +--
 pinctrl/pinctrl-adi2.c                |    4 ++--
 pinctrl/pinctrl-st.c                  |    4 ++--
 pinctrl/samsung/pinctrl-exynos.c      |    4 ++--
 pinctrl/samsung/pinctrl-s3c24xx.c     |    3 +--
 pinctrl/samsung/pinctrl-s3c64xx.c     |    8 ++++----
 pinctrl/sunxi/pinctrl-sunxi.c         |    6 +++---
 spmi/spmi-pmic-arb.c                  |    6 ++----
 33 files changed, 70 insertions(+), 98 deletions(-)

If we revert the search pattern we get the ones which got it right:

@@
expression E1, E2, E3;
@@
-irq_set_handler_data(E1, E2);
...
-irq_set_chained_handler(E1, E3);
+irq_set_chained_handler_and_data(E1, E3, E2);

That handles another bunch and leaves us with 135 instances of
irq_set_chained_handler() which do not set handler data. So its
trivial to change them to

 irq_set_chained_handler_and_data(irq, handler, NULL);

and then remove irq_set_chained_handler()

If thats ok for you, then i apply the lot you sent and run the cocci
scripts right at rc1. I have another set of transformations in that
area pending.

Thanks,

	tglx
