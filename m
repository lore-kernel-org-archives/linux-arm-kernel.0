From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 Jul 2014 13:42:10 +0200
Subject: [PATCH] spi/pxa2xx-pci: Enable DMA binding through device name
In-Reply-To: <1406196111-22861-1-git-send-email-hock.leong.kweh@intel.com>
References: <1406196111-22861-1-git-send-email-hock.leong.kweh@intel.com>
Message-ID: <10365151.12bEvS9Gvj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 July 2014 18:01:51 Kweh Hock Leong wrote:
> From: "Chew, Chiau Ee" <chiau.ee.chew@intel.com>
> 
> Intel LPSS Baytrail supports two DMA controllers and SPI is only
> using one of the DMA controller. During DMA channel request,
> we need to ensure the requested Tx and Rx channels are from the correct
> DMA controller. Thus, we add extra checking in filter callback funtion
> by matching against the DMA controller device name.
> 
> Signed-off-by: Chew, Chiau Ee <chiau.ee.chew@intel.com>
> Signed-off-by: Kweh, Hock Leong <hock.leong.kweh@intel.com>

I'm confused. Doesn't  Bay Trail use ACPI to do the DMA
engine configuration? That should set find the right device/chan_id/slave_id
combination without any interaction, through the use of dma_request_slave_channel.

On a related note, there seems to be a bug in this driver, which
attempts to set the slave_id through dmaengine_slave_config(), which
is wrong in both cases, ACPI and filter functions.

	Arnd
