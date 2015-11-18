From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 18 Nov 2015 11:17:50 +0800
Subject: [PATCH] USB: USB_OTG does not depend on PM
In-Reply-To: <5647698.81XCu85L5D@wuerfel>
References: <7521777.8ZmnT3AlIC@wuerfel> <874mgkjoh2.fsf@saruman.tx.rr.com>
 <5647698.81XCu85L5D@wuerfel>
Message-ID: <20151118031748.GA4228@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 11:00:18PM +0100, Arnd Bergmann wrote:
> On Tuesday 17 November 2015 15:38:33 Felipe Balbi wrote:
> > 
> > Arnd Bergmann <arnd@arndb.de> writes:
> > > USB_OTG initially depended on USB_SUSPEND, which was later turned into
> > > PM_RUNTIME and finally into PM. I don't know at what point the dependency
> > > became unnecessary but it appears to work fine without CONFIG_PM now.
> > >
> > > However, we get lots of warnings in randconfig kernels like:
> > >
> > > warning: (USB_OTG_FSM && FSL_USB2_OTG && USB_MV_OTG) selects USB_OTG which has unmet direct dependencies (USB_SUPPORT && USB && PM)
> > >
> > > whenever CONFIG_PM is disabled and something else selects USB_OTG.
> > > Let's just drop the dependency to avoid the warnings.
> > >
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > > I keep seeing this one in my ARM randconfig test
> > 
> > and how did you test this ? Did you make sure you're not breaking HNP ?
> > For HNP to happen we depend on a bus_suspend and bus_suspend is only
> > available on CONFIG_PM, unless that has changed.
> > 
> > Seems like you've only compile tested this patch, is that correct ?
> 
> Yes, I compile-tested only and inspected the code briefly without finding
> anything that contradicted this. It seems I missed the important part
> as you say, so we should instead add 'depends on PM' for the other
> symbols.
> 
> 	Arnd

Hi Arnd, would you kindly try if below patch can fix your problem

>From 3a6918dae038aadc200dcf0263f4440acc2353d4 Mon Sep 17 00:00:00 2001
From: Peter Chen <peter.chen@freescale.com>
Date: Wed, 18 Nov 2015 11:06:34 +0800
Subject: [PATCH 1/1] usb: kconfig: fix warning of select USB_OTG

When choose randconfig for kernel build, it reports below warning:
"warning: (USB_OTG_FSM && FSL_USB2_OTG && USB_MV_OTG) selects USB_OTG
which has unmet direct dependencies (USB_SUPPORT && USB && PM)"

In fact, USB_OTG is visual symbol and depends on PM, so the driver
needs to depend on it to reduce dependency problem.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Cc: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/core/Kconfig | 3 +--
 drivers/usb/phy/Kconfig  | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
index a99c89e..dd28010 100644
--- a/drivers/usb/core/Kconfig
+++ b/drivers/usb/core/Kconfig
@@ -77,8 +77,7 @@ config USB_OTG_BLACKLIST_HUB
 
 config USB_OTG_FSM
 	tristate "USB 2.0 OTG FSM implementation"
-	depends on USB
-	select USB_OTG
+	depends on USB && USB_OTG
 	select USB_PHY
 	help
 	  Implements OTG Finite State Machine as specified in On-The-Go
diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 1731324..22e8ecb 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -21,7 +21,6 @@ config AB8500_USB
 config FSL_USB2_OTG
 	bool "Freescale USB OTG Transceiver Driver"
 	depends on USB_EHCI_FSL && USB_FSL_USB2 && USB_OTG_FSM && PM
-	select USB_OTG
 	select USB_PHY
 	help
 	  Enable this to support Freescale USB OTG transceiver.
@@ -168,8 +167,7 @@ config USB_QCOM_8X16_PHY
 
 config USB_MV_OTG
 	tristate "Marvell USB OTG support"
-	depends on USB_EHCI_MV && USB_MV_UDC && PM
-	select USB_OTG
+	depends on USB_EHCI_MV && USB_MV_UDC && PM && USB_OTG
 	select USB_PHY
 	help
 	  Say Y here if you want to build Marvell USB OTG transciever
-- 
1.9.1

-- 

Best Regards,
Peter Chen
