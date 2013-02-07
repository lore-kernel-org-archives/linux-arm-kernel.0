From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 7 Feb 2013 14:18:05 +0100
Subject: [PATCH 0/2] ARM: dts: Add DT bindings for OMAP SDMA
In-Reply-To: <1360184596-1603-1-git-send-email-jon-hunter@ti.com>
References: <1360184596-1603-1-git-send-email-jon-hunter@ti.com>
Message-ID: <5113A98D.1000209@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On 02/06/2013 10:03 PM, Jon Hunter wrote:
> Adds device-tree bindings from SDMA on OMAP2+ devices. DMA client
> bindings are also added for devices that have SPI and MMC bindings
> populated. Client binding data is based upon existing HWMOD data for
> OMAP and has been checked against OMAP documentation.
> 
> Testing includes ...
> 1. Boot tested on OMAP3430 Beagle board, OMAP4430 Panda board and
>    OMAP4460 Panda board with and without device-tree present.
> 2. Testing of MMC1 with SD card on OMAP3430 Beagle board, OMAP4430
>    Panda board and OMAP4460 Panda board with and without device-tree
>    present.

I looked briefly around in the mentioned code and I wonder how this is going
to work with audio (ASoC).
When we boot with DT it looks like we are _not_ creating the DMA resources for
the device as it is done for the IRQ and IO/MEM. So this means that we can not
use get_resource*() for DMA anymore when we move to DT.
This might be OK for (OMAP)mmc, (OMAP)spi, etc. But in audio we have a common
library used by all platforms to deal with the dmaengine.
I don't think we can switch to use dma_request_slave_channel_compat() in
soc-dmaengine-pcm.c. We need to pass the dma channel number to the lib from
the ASoC platform drivers. Or we need to synchronize the order of the dmas and
the dma-names around all SOCs in existence?

Has anyone thought about this?

CC-ing Mark Brown and Lars-Peter Clausen they might already know the answer to
this.

> 
> Testing branch available here [1].
> 
> Series is based upon v3.8-rc6 on top of the following ...
> - Vinod's topic/dmaengine_dt branch [2]
> - Matt Porter's series "DMA Engine support for AM33XX" [3]
> - Matt Porter's series "omap_hsmmc DT DMA Client support" [4]
> - Sourav Poddar's series "add omap mcspi device tree data" [5]
> 
> [1] https://github.com/jonhunter/linux/commits/dev-dt-dma
> [2] http://git.infradead.org/users/vkoul/slave-dma.git/shortlog/refs/heads/topic/dmaengine_dt
> [3] http://permalink.gmane.org/gmane.linux.kernel.spi.devel/12508
> [4] http://permalink.gmane.org/gmane.linux.ports.arm.omap/93165
> [5] http://permalink.gmane.org/gmane.linux.kernel/1435002
> 
> Jon Hunter (2):
>   ARM: dts: OMAP2+: Add SDMA controller bindings and nodes
>   dmaengine: OMAP: Register SDMA controller with Device Tree DMA driver
> 
>  .../devicetree/bindings/dma/omap-sdma.txt          |   44 ++++++++++++++++++++
>  arch/arm/boot/dts/omap2.dtsi                       |   12 ++++++
>  arch/arm/boot/dts/omap3.dtsi                       |   40 ++++++++++++++++++
>  arch/arm/boot/dts/omap4.dtsi                       |   41 ++++++++++++++++++
>  arch/arm/boot/dts/omap5.dtsi                       |   41 ++++++++++++++++++
>  drivers/dma/omap-dma.c                             |   31 +++++++++++++-
>  6 files changed, 208 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/omap-sdma.txt
> 


-- 
P?ter
