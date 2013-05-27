From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 27 May 2013 22:38:08 +0200
Subject: [RFC V7 PATCH 3/3] USB: OHCI: make ohci-pci a separate driver
In-Reply-To: <1369657550-24101-4-git-send-email-manjunath.goudar@linaro.org>
References: <1365746856-7772-2-git-send-email-manjunath.goudar@linaro.org>
 <1369657550-24101-1-git-send-email-manjunath.goudar@linaro.org>
 <1369657550-24101-4-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <201305272238.08984.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 27 May 2013, Manjunath Goudar wrote:
> This patch splits the PCI portion of ohci-hcd out into its
> own separate driver module, called ohci-pci.
> 
> The major point of difficulty lies in ohci-pci's many vendor- and
> device-specific workarounds.  Some of them have to be applied before
> calling ohci_start() some after, which necessitates a fair amount of
> code motion.  The other platform drivers require much smaller changes.
> 
> The complete sb800_prefetch() function moved to ohci-q.c,because its
> only related to ohci-pci driver.

I just gave this a little test run in qemu and on my server.

> @@ -446,7 +446,7 @@ config USB_OHCI_HCD_PPC_OF
>         default USB_OHCI_HCD_PPC_OF_BE || USB_OHCI_HCD_PPC_OF_LE
>  
>  config USB_OHCI_HCD_PCI
> -       bool "OHCI support for PCI-bus USB controllers"
> +       tristate "OHCI support for PCI-bus USB controllers"
>         depends on PCI && (STB03xxx || PPC_MPC52xx || USB_OHCI_HCD_PPC_OF)
>         default y
>         select USB_OHCI_LITTLE_ENDIAN

There is a preexisting bug in this symbol: USB_OHCI_HCD_PCI was previously
unused, and has a bogus 'depends' line, which causes it to not be selectable
on anything but PPC.

You have to change this to only 'depends on PCI'.

>  	}
> -	if (ret == 0) {
> -		ohci_hcd_init (ohci);
> -		return ohci_init (ohci);
> -	}
> -	return ret;
> -}

I found that the call to ohci_hcd_init() that is removed here is not getting
added in any other place, which caused a NULL pointer dereference the first
time we actually try to use the driver.

Adding the call back into the new ohci_setup function makes it work again.

Please fold the patch below into your patch, unless Alan discovers something
wrong with it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index f948e8f..eef6dc5 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -454,7 +454,7 @@ config USB_OHCI_HCD_PPC_OF
 
 config USB_OHCI_HCD_PCI
 	tristate "OHCI support for PCI-bus USB controllers"
-	depends on PCI && (STB03xxx || PPC_MPC52xx || USB_OHCI_HCD_PPC_OF)
+	depends on PCI
 	default y
 	select USB_OHCI_CORE
 	select USB_OHCI_LITTLE_ENDIAN
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 3da8c3a..5601139 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -763,6 +763,8 @@ int ohci_setup(struct usb_hcd *hcd)
 {
 	struct ohci_hcd		*ohci = hcd_to_ohci(hcd);
 
+	ohci_hcd_init(ohci);
+
 	return ohci_init(ohci);
 }
 EXPORT_SYMBOL_GPL(ohci_setup);
diff --git a/drivers/usb/host/ohci-pci.c b/drivers/usb/host/ohci-pci.c
index ea088c1..3133354 100644
--- a/drivers/usb/host/ohci-pci.c
+++ b/drivers/usb/host/ohci-pci.c
@@ -250,7 +250,7 @@ static int ohci_pci_reset (struct usb_hcd *hcd)
 		}
 	}
 	if (ret == 0)
-		ohci_setup(hcd);
+		ret = ohci_setup(hcd);
 	/*
 	* After ohci setup RWC may not be set for add-in PCI cards.
 	* This transfers PCI PM wakeup capabilities.
