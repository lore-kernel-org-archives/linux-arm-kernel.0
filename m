From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Jan 2014 20:36:35 +0000
Subject: [PATCH] arm64: Add pdev_archdata for dmamask
In-Reply-To: <1390854331.23180.22.camel@localhost.localdomain>
References: <y> <1390845177-2626-1-git-send-email-lauraa@codeaurora.org>
 <20140127181836.GH26766@pengutronix.de>
 <1390854331.23180.22.camel@localhost.localdomain>
Message-ID: <20140127203635.GA15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 09:25:31PM +0100, Yann Droneaud wrote:
> ARM, even AAAAARGH64 [1], doesn't need a special treatement regarding
> the infamous dma_mask pointer. So perhaps my solution is better.
> 
> This solution (adding dma_mask in pdev_archdata) is already in use in
> powerpc architecture. See arch/powerpc/kernel/setup-common.c
> 
> The advantage of this solution is that it makes a dma_mask placeholder
> available to statically allocated platform_device struct, while mine
> only address the problem for platform_device struct allocated with
> platform_device_alloc().

As I've already said in this thread, the basic problem comes from DT's
platform device creation.  It's the responsibility of the device creator
to set the dma_mask pointer appropriately, and DT doesn't do that.  So,
DT needs to be fixed rather than everyone introducing their own
workarounds for this.

> I'm also considering using dma_set_mask_and_coherent() in
> platform_device_register_full() and drivers using
> platform_device_alloc().

As the one who introduced dma_set_mask_and_coherent, consider this a
strong NAK on that.  The reason is dma_set_mask_and_coherent() is
for drivers to set their requirements, not for the bus requirements
to be set in the first place.

It also means that drivers which need no DMA support are subjected to
DMA restrictions (in that dma_set_mask_and_coherent can error out if
the platform can't support the DMA mask.)

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
