From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Apr 2016 16:29:59 +0100
Subject: [PATCH] ARM: mach-imx: sdhci-esdhc-imx: initialize DMA mask
In-Reply-To: <570CC6F2.4090301@intel.com>
References: <1460362846-2906-1-git-send-email-akurz@blala.de>
 <20160411083510.GN10108@pengutronix.de>
 <570B780E.7090801@intel.com>
 <alpine.DEB.2.00.1604111803080.6072@blala.de>
 <570C902E.7090607@intel.com>
 <20160412084048.GM19428@n2100.arm.linux.org.uk>
 <570CC6F2.4090301@intel.com>
Message-ID: <20160412152959.GN19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2016 at 12:59:14PM +0300, Adrian Hunter wrote:
> On 12/04/16 11:40, Russell King - ARM Linux wrote:
> > What do you mean "doesn't need a dma_mask" ?  DMA _always_ requires a
> > DMA mask.  The DMA mask defines how many address bits are capable of
> > being used on the bus.
> > 
> > If there's no DMA mask, then there's no usable address bits, and so
> > the device is not DMA capable.  Hence, dma_set_mask_and_coherent()
> > will fail because its not possible to negotiate a non-zero number of
> > address bits.
> > 
> 
> The point is, now we valid dma_set_mask_and_coherent(), DMA will stop
> working for any other SDHCI device that hasn't allocated dev.dma_mask.  Is
> that OK?

Two latent bugs.

1) Any device that doesn't have dma_mask allocated isn't capable of
   streaming DMA, but may be capable of coherent DMA - a device which
   is capable _should_ have a defaulted dma_mask setup.

2) Drivers must always use the dma_set_mask*() family of functions
   if they intend to use DMA.

Requirement (2) is nothing new, and predates MMC as a whole, so it's
a long-standing latent bug.


-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
