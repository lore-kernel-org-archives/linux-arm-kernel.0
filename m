From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Sep 2015 13:07:02 +0100
Subject: [PATCH v7 1/2] usb: make xhci platform driver use 64 bit or 32
 bit DMA
In-Reply-To: <55E591E9.60008@linux.intel.com>
References: <1522889.9kdnRk8vHo@wuerfel>
 <69e6f5bf693d02fba001d02047453bed0519499d.1440098398.git.dhdang@apm.com>
 <CADaLNDnPaeHcMjywsuQ4oiUpWsNpStshdKVtW=tuUorrcQkZ=g@mail.gmail.com>
 <55E591E9.60008@linux.intel.com>
Message-ID: <20150901120702.GK21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 01, 2015 at 02:54:17PM +0300, Mathias Nyman wrote:
> On 31.08.2015 21:58, Duc Dang wrote:
> >On Thu, Aug 20, 2015 at 12:38 PM, Duc Dang <dhdang@apm.com> wrote:
> >>The xhci platform driver needs to work on systems that
> >>either only support 64-bit DMA or only support 32-bit DMA.
> >>Attempt to set a coherent dma mask for 64-bit DMA, and
> >>attempt again with 32-bit DMA if that fails.
> >>
> >>[dhdang: regenerate the patch over 4.2-rc5 and address new comments]
> >>Signed-off-by: Mark Langsdorf <mlangsdo@redhat.com>
> >>Tested-by: Mark Salter <msalter@redhat.com>
> >>Signed-off-by: Duc Dang <dhdang@apm.com>
> >>
> >>---
> >>Changes from v6:
> >>         -Add WARN_ON if dma_mask is NULL
> >>         -Use dma_coerce_mask_and_coherent to assign
> >>         dma_mask and coherent_dma_mask
> >>
> >>Changes from v5:
> >>         -Change comment
> >>         -Assign dma_mask to coherent_dma_mask if dma_mask is NULL
> >>         to make sure dma_set_mask_and_coherent does not fail prematurely.
> >>
> >>Changes from v4:
> >>         -None
> >>
> >>Changes from v3:
> >>         -Re-generate the patch over 4.2-rc5
> >>         -No code change.
> >>
> >>Changes from v2:
> >>         -None
> >>
> >>Changes from v1:
> >>         -Consolidated to use dma_set_mask_and_coherent
> >>         -Got rid of the check against sizeof(dma_addr_t)
> >>
> >>  drivers/usb/host/xhci-plat.c | 21 +++++++++++++--------
> >>  1 file changed, 13 insertions(+), 8 deletions(-)
> >>
> >>diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> >>index 890ad9d..e4c7f9d 100644
> >>--- a/drivers/usb/host/xhci-plat.c
> >>+++ b/drivers/usb/host/xhci-plat.c
> >>@@ -93,14 +93,19 @@ static int xhci_plat_probe(struct platform_device *pdev)
> >>         if (irq < 0)
> >>                 return -ENODEV;
> >>
> >>-       /* Initialize dma_mask and coherent_dma_mask to 32-bits */
> >>-       ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
> >>-       if (ret)
> >>-               return ret;
> >>-       if (!pdev->dev.dma_mask)
> >>-               pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
> >>-       else
> >>-               dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
> >>+       /* Throw a waring if broken platform code didn't initialize dma_mask */
> >>+       WARN_ON(!pdev->dev.dma_mask);
> >>+       /*
> >>+        * Try setting dma_mask and coherent_dma_mask to 64 bits,
> >>+        * then try 32 bits
> >>+        */
> >>+       ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> >>+       if (ret) {
> >>+               ret = dma_coerce_mask_and_coherent(&pdev->dev,
> >>+                                                  DMA_BIT_MASK(32));
> >>+               if (ret)
> >>+                       return ret;
> >>+       }

This isn't very good.  If dev.dma_mask is already set,
dma_coerce_mask_and_coherent() will always overwrite it.  There's also
no need to call it twice.  This, imho, is much better:

	/* Try to set a 64-bit DMA mask first */
	if (WARN_ON(!pdev->dev.dma_mask)) {
		/* Eek, platform didn't initialise the streaming DMA mask */
		ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
	} else {
		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
	}

	/* If that failed, fall back to a 32-bit DMA mask */
	if (ret) {
		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
		if (ret)
			return ret;
	}

since it preserves the dev.dma_mask pointer if it was properly setup

Really, drivers shouldn't be messing around with that pointer - especially
if it's already been correctly setup.  A platform may require separate
streaming and coherent masks, and we should respect that.

(The whole dma_mask being a pointer thing is a left-over from the PCI
layer which has never been cleaned up through fear of breaking something.)

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
