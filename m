From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 27 May 2013 10:58:28 -0400 (EDT)
Subject: [RFC V7 PATCH 3/3] USB: OHCI: make ohci-pci a separate driver
In-Reply-To: <1369657550-24101-4-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1305271056390.21231-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 May 2013, Manjunath Goudar wrote:

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
> 
> V2:
>   - few specific content of pci related code in ohci_pci_start function has been moved to ohci_pci_reset
>     and rest of the generic code is written in ohci_start of ohci-hcd.c file.
> V3:
>  - ohci_restart() has been called in ohci_pci_reset() function for to reset the ohci pci.
> 
> V4:
>  -sb800_prefetch() moved to ohci-q.c,because its only related to ohci-pci.
>  -no longer _creating_ CONFIG_USB_OHCI_PCI,creating CONFIG_USB_OHCI_HCD_PCI.
>  -overrides renamed with pci_override,its giving proper meaning.
> 
> V5:
>  -sb800_prefetch() moved to pci-quirks.c,because its only related to pci.
> 
> V6:
>  -sb800_prefetch() function has been moved to pci-quirks.c made as separate patch in 2/3.
>  -Most of the generic ohci pci changes moved in 2/3 patch,now this is complete  ohci-pci separation patch.
> 
> V7:
>  -Unrelated include file has been removed from ohci.h file.

One tiny mistake still remains...

> @@ -242,94 +249,24 @@ static int ohci_pci_reset (struct usb_hcd *hcd)
>  			ret = quirk(hcd);
>  		}
>  	}
> -	if (ret == 0) {
> -		ohci_hcd_init (ohci);
> -		return ohci_init (ohci);
> -	}

...

> +	if (ret == 0)
> +		ohci_setup(hcd);

This should say

		ret = ohci_setup(hcd);

so that errors in ohci_setup() won't be ignored.

> +	/*
> +	* After ohci setup RWC may not be set for add-in PCI cards.
> +	* This transfers PCI PM wakeup capabilities.
> +	*/
> +	if (device_can_wakeup(&pdev->dev))
> +		ohci->hc_control |= OHCI_CTRL_RWC;
>  	return ret;
>  }

Alan Stern
