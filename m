From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Thu, 24 Jul 2014 17:06:20 +0300
Subject: [PATCH] spi/pxa2xx-pci: Enable DMA binding through device name
In-Reply-To: <10365151.12bEvS9Gvj@wuerfel>
References: <1406196111-22861-1-git-send-email-hock.leong.kweh@intel.com>
 <10365151.12bEvS9Gvj@wuerfel>
Message-ID: <20140724140620.GP1857@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 01:42:10PM +0200, Arnd Bergmann wrote:
> On Thursday 24 July 2014 18:01:51 Kweh Hock Leong wrote:
> > From: "Chew, Chiau Ee" <chiau.ee.chew@intel.com>
> > 
> > Intel LPSS Baytrail supports two DMA controllers and SPI is only
> > using one of the DMA controller. During DMA channel request,
> > we need to ensure the requested Tx and Rx channels are from the correct
> > DMA controller. Thus, we add extra checking in filter callback funtion
> > by matching against the DMA controller device name.
> > 
> > Signed-off-by: Chew, Chiau Ee <chiau.ee.chew@intel.com>
> > Signed-off-by: Kweh, Hock Leong <hock.leong.kweh@intel.com>
> 
> I'm confused. Doesn't  Bay Trail use ACPI to do the DMA
> engine configuration? That should set find the right device/chan_id/slave_id
> combination without any interaction, through the use of dma_request_slave_channel.

It is also possible that the corresponding Baytrail system doesn't have
ACPI enabled BIOS in which case it dma_request_slave_channel() doesn't
help here.

> On a related note, there seems to be a bug in this driver, which
> attempts to set the slave_id through dmaengine_slave_config(), which
> is wrong in both cases, ACPI and filter functions.

Good point. We will fix this, thanks.
