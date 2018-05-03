From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 3 May 2018 21:38:38 +0200
Subject: Droid 4: very confusing config around OHCI_OMAP3_HCD
In-Reply-To: <20180503192838.GY98604@atomide.com>
References: <20180503192510.GB32572@amd> <20180503192838.GY98604@atomide.com>
Message-ID: <20180503193837.GC32572@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2018-05-03 12:28:38, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180503 19:27]:
> > Hi!
> > 
> > For power management experiments, I tried
> > 
> > CONFIG_USB_OHCI_HCD=y
> > CONFIG_USB_OHCI_HCD_OMAP3=m
> > CONFIG_USB_OHCI_HCD_PLATFORM=y
> > 
> > and could not find resulting .ko.
> > 
> > Help text says:
> > 
> > CONFIG_USB_OHCI_HCD_OMAP3:
> > 
> > This option is deprecated now and the driver was removed, use
> > USB_OHCI_HCD_PLATFORM instead.
> > 
> > Enables support for the on-chip OHCI controller on
> > OMAP3 and later chips.
> > 
> > Which may partly explain it. But if the option no longer does
> > anything, why keep it? Certainly second part is confusing if option is
> > NOP...
> 
> Yeah it's ohci-platform now, I think we decided to keep the old one
> around to avoid breaking people's .config files for booting rather
> than silently fail.

Ok, what about this? (Should I do the same for the other drivers?)
Or at least put (DEPRECATED) as other drivers do?

Situation is quite confusing if you already have PLATFORM=y. OMAP=m
can be selected, but nothing happens.

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 5d958da..67c151a 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -455,7 +455,7 @@ config USB_OHCI_HCD_AT91
           Atmel chips.
 
 config USB_OHCI_HCD_OMAP3
-	tristate "OHCI support for OMAP3 and later chips"
+	tristate "dummy option for backwards compatibility"
 	depends on (ARCH_OMAP3 || ARCH_OMAP4 || SOC_OMAP5)
 	select USB_OHCI_HCD_PLATFORM
 	default y
@@ -463,9 +463,6 @@ config USB_OHCI_HCD_OMAP3
 	  This option is deprecated now and the driver was removed, use
 	  USB_OHCI_HCD_PLATFORM instead.
 
-	  Enables support for the on-chip OHCI controller on
-	  OMAP3 and later chips.
-
 config USB_OHCI_HCD_DAVINCI
 	tristate "OHCI support for TI DaVinci DA8xx"
 	depends on ARCH_DAVINCI_DA8XX

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180503/9205ad12/attachment.sig>
