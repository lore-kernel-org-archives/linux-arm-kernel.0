From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 23 May 2013 10:37:51 -0400 (EDT)
Subject: [RFC V6 PATCH 3/3] USB: OHCI: make ohci-pci a separate driver
In-Reply-To: <1369307506-4458-4-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1305231034110.925-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 May 2013, Manjunath Goudar wrote:

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

This patch has a lot of extra stuff in it.  It looks like you forgot to
undo a bunch of things from the previous version, things that are no
longer needed.

As I said before, you really need to proofread your patches before
emailing them.  Don't rely on other people to find your mistakes.

Also, you left out one thing that should still be here.  What happened 
to the part about changing

#if	!defined(PCI_DRIVER) &&		\

to

#if	!ENABLED(CONFIG_USB_OHCI_HCD_PCI) &&	\

?

Alan Stern
