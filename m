From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Mon, 28 Sep 2015 16:10:17 +0200
Subject: [PATCH linux-next 0/4] mtd: spi-nor: fix Quad SPI memory support
In-Reply-To: <cover.1442590224.git.cyrille.pitchen@atmel.com>
References: <cover.1442590224.git.cyrille.pitchen@atmel.com>
Message-ID: <56094A49.7000304@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

are there other works in progress to enhance the QSPI support inside the
spi-nor framework?
Do you have any suggestion about what should be done and how to do it?
Is there any discussion on this topic? If so, I would be interested in taking
part of it so I could synchronize my work with other developers' efforts.

Brian, Mark, Marek, with this series I've removed the Atmel QSPI controller
driver to focus only on the common spi-nor framework. I will send a dedicated
series later for the Atmel QSPI controller once we all agree on an update of
the framework API to add support to other QSPI memory manufacturers such as
Micron or Macronix.

Currently, it looks like the spi-nor framework only works with Spansion
memories. For instance, without the patches of this series, I can't use the
Micron n25q128a13 embedded on sama5d2 xplained boards.
So I hope we will find a way to make it work!

Best Regards,

Cyrille

Le 18/09/2015 17:49, Cyrille Pitchen a ?crit :
> Hi all,
> 
> this series of patches fixes the QSPI support mostly for Micron and
> Macronix memories. There are also some updates for Spansion memories.
> There are also many comments to explain the implementation choices based
> on the datasheets from memory manufacturers.
> 
> The series was backported to a at91-4.1 kernel then tested on a sama5d2
> xplained board, which embeds a at25df321a memory on a SPI controller and
> a Micron n25q128a13 QSPI memory on the new Atmel QSPI controller.
> 
> The at25 memory was used to check non regression on the m25p80 driver
> whereas the Micron memory was used to test the fixes of the spi-nor
> framework. The driver for the Atmel QSPI controller will be sent in a
> dedicated series.
> 
> Best Regards,
> 
> Cyrille
> 
> Cyrille Pitchen (4):
>   mtd: spi-nor: remove unused read_xfer/write_xfer hooks
>   mtd: spi-nor: properly detect the memory when it boots in Quad or Dual
>     mode
>   mtd: spi-nor: fix Quad SPI mode support for Spansion, Micron and
>     Macronix
>   mtd: m25p80: add support of dual and quad spi protocols to all
>     commands
> 
>  drivers/mtd/devices/m25p80.c  | 254 ++++++++++---
>  drivers/mtd/spi-nor/spi-nor.c | 811 ++++++++++++++++++++++++++++++++++++------
>  include/linux/mtd/spi-nor.h   |  69 ++--
>  3 files changed, 954 insertions(+), 180 deletions(-)
> 
