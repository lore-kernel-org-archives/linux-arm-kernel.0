From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 02 Aug 2013 21:28:48 +0200
Subject: [PATCH v4] dmaengine: Add MOXA ART DMA engine driver
In-Reply-To: <CACmBeS1vT6HyhN=Q4Y9izR0F1Es818iU0fQ5-U8LxijRKe=+8w@mail.gmail.com>
References: <1374055584-15746-1-git-send-email-jonas.jensen@gmail.com>
 <201307291835.21151.arnd@arndb.de>
 <CACmBeS1vT6HyhN=Q4Y9izR0F1Es818iU0fQ5-U8LxijRKe=+8w@mail.gmail.com>
Message-ID: <1957393.zQhGBaWaVi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 August 2013 14:28:28 Jonas Jensen wrote:
> 
> On 29 July 2013 18:35, Arnd Bergmann <arnd@arndb.de> wrote:
> > You must not override the "dest_req_no" and "dest_req_no" in moxart_slave_config
> > since they are already set by the ->xlate() function and the driver calling
> > slave_config generally has no knowledge of what the slave id is.
> 
> MMC now has a device tree node:
> 
> mmc: mmc at 98e00000 {
> compatible = "moxa,moxart-mmc";
> reg = <0x98e00000 0x5C>;
> interrupts = <5 0>;
> clocks = <&coreclk>;
> dmas = <&dma 0>,
>             <&dma 1>;
> dma-names = "tx", "rx";
> };
> 
> .. where the driver requests channel 0-1 and sets cfg.slave_id =
> APB_DMA_SD_REQ_NO for both.
> 
> Perhaps this is not how slave_id is intended to be used?
> 
> Maybe it would be more appropriate to have two DMA cells?
> 
> APB_DMA_SD_REQ_NO can then be moved from driver code to DT.

In most drivers, you can use any channel with any request line number
and let the dmaengine driver pick a channel while you pass just the
request line (slave id) in a single cell in DT. If this does not
work, using two cells is the best approach here.

Removing APB_DMA_SD_REQ_NO from the driver code is definitely the
right approach, since that number is not something specific to the
device, but to the way it is connected to the DMA engine, which
belongs into DT.

	Arnd
