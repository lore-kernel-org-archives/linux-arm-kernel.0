From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri,  8 Jul 2016 22:09:06 +0200
Subject: [PATCH 2/3] usb: phy: generic: cope with initial state
In-Reply-To: <1468008547-10925-1-git-send-email-robert.jarzmik@free.fr>
References: <1468008547-10925-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1468008547-10925-2-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the gpio based case, the status of the phy is known at start by
reading the VBus gpio.

Actually, this is a fix, as this initial state, when not set up,
prevents a gadget to answer to the enumeration phase, as there is no
notification in this case (the VBus is already high when kernel boots)
so no interrupt is triggered, and the flow is :
 - gadget initializes
 - gadget gets its phy-generic with a xxx_get_phy_xxx() call type
 - gadget does a "set_peripheral()" call type
   => here if the otg->state is correctly filled, the proper vbus
   handling will be called, and the gadget will be aware it should
   answer enumeration and go forth

Without this fix, the USB cable must be removed and replugged for any
gadget relying on phy-generic and its gpio vbus handling to work.

The problem was seen on a pxa27x architecture based board on a
devicetree build.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/usb/phy/phy-generic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
index 980c9dee09eb..41b8aff9b925 100644
--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -322,6 +322,8 @@ static int usb_phy_generic_probe(struct platform_device *pdev)
 				gpiod_to_irq(nop->gpiod_vbus), err);
 			return err;
 		}
+		nop->phy.otg->state = gpiod_get_value(nop->gpiod_vbus) ?
+			OTG_STATE_B_PERIPHERAL : OTG_STATE_B_IDLE;
 	}
 
 	nop->phy.init		= usb_gen_phy_init;
-- 
2.1.4
