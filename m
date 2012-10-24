From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Oct 2012 21:18:01 +0200
Subject: [PATCH] [RFC] pinctrl: mvebu: reset pins to an UNKNOWN state on
 startup
Message-ID: <1351106281-31288-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Note: this patch is a *RFC*, it is not intended for merging, only to
get a discussion started. The code is horrible, makes terrible
assumptions and so on.

On many platforms, most of the pinmux initialization is done in the
bootloader, and therefore persists when we boot the Linux kernel. This
prevents us from making sure that the pinmux configuration in the
board device trees is correct.

One idea to make sure our device trees are correct in terms of
pinmuxing is to set the state of each pin to an unavailable function
during the initialization of the pinctrl driver. This way, only pins
that are explicitly configured through proper device tree attributes
will actually be functional.

Remaining questions to solve:

 * Is this useful?

 * How to figure out what function number is a good function number to
   set all pins to at startup? It could be passed by the SoC-specific
   pinctrl drivers.

 * Maybe some pins should be excluded for this, especially if the
   console serial port pins are muxed. On Armada XP, it's not the
   case: UART0 RX/UART0 TX pins are not part of MPPs, so we can clear
   all pins. But on other mvebu platforms, it may be the case.

 * If this sounds like an interesting thing, should we keep it only at
   the mvebu driver level, or make it something more generically
   available in the pinctrl subsystem?

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pinctrl/pinctrl-mvebu.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-mvebu.c b/drivers/pinctrl/pinctrl-mvebu.c
index 8e6266c..32a9cbe 100644
--- a/drivers/pinctrl/pinctrl-mvebu.c
+++ b/drivers/pinctrl/pinctrl-mvebu.c
@@ -739,6 +739,9 @@ int __devinit mvebu_pinctrl_probe(struct platform_device *pdev)
 
 	dev_info(&pdev->dev, "registered pinctrl driver\n");
 
+	for (n = 0; n < pctl->num_groups; n++)
+		mvebu_pinconf_group_set(pctl->pctldev, n, 7);
+
 	/* register gpio ranges */
 	for (n = 0; n < soc->ngpioranges; n++)
 		pinctrl_add_gpio_range(pctl->pctldev, &soc->gpioranges[n]);
-- 
1.7.9.5
