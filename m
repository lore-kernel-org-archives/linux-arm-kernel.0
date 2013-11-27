From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 26 Nov 2013 20:32:53 -0800
Subject: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <1385447575-23773-1-git-send-email-b32955@freescale.com>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
Message-ID: <20131127043253.GA9468@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Lee Jones, others

I'd like to keep a similar CC list for the various conversations going
on about SPI NOR frameworks.

On Tue, Nov 26, 2013 at 02:32:51PM +0800, Huang Shijie wrote:
> 1.) Why add a new framework for SPI NOR?
>   The SPI-NOR controller such as Freescale's Quadspi controller is working
>   in a different way from the SPI bus. It should knows the NOR commands to
>   find the right LUT sequence. Unfortunately, the current code can not meet
>   this requirement.
> 
> 2.) How does this patch set do?
>    This patch set adds a new spi-nor layer.
>    Before this patch, the layer is like:
> 
>                    MTD
>          ------------------------
>                   m25p80
>          ------------------------
> 	       spi bus driver
>          ------------------------
> 	        SPI NOR chip
> 
>    After this patch, the layer is like:
>                    MTD
>          ------------------------
>                   spi-nor
>          ------------------------
>                   m25p80
>          ------------------------
> 	       spi bus driver
>          ------------------------
> 	       SPI NOR chip
> 
>   With the spi-nor controller driver(Freescale Quadspi), it looks like:
>                    MTD
>          ------------------------
>                   spi-nor
>          ------------------------
>                 fsl-quadspi
>          ------------------------
> 	       SPI NOR chip
> 
> 3.) more details
>    This patch set adds a new data structrue spi_nor{}, clones most the common
>   code to spi-nor.c. Make the m25p80.c use the new APIs.
> 
> 4.) TODO list:
>    3.1) add the new spi_nor_device{} for the spi-nor controller's device.
>    3.2) add the Freescale Quadspi driver.
> 
> 	       
> Huang Shijie (4):
>   mtd: spi-nor: move the SPI NOR commands to a new header file
>   mtd: spi-nor: add a new data structrue spi_nor{}
>   mtd: spi-nor: add the framework for SPI NOR
>   mtd: m25p80: use the new spi-nor APIs
> 
>  drivers/mtd/Kconfig           |    2 +
>  drivers/mtd/Makefile          |    1 +
>  drivers/mtd/devices/Kconfig   |    2 +-
>  drivers/mtd/devices/m25p80.c  | 1249 +++--------------------------------------
>  drivers/mtd/spi-nor/Kconfig   |    6 +
>  drivers/mtd/spi-nor/Makefile  |    1 +
>  drivers/mtd/spi-nor/spi-nor.c | 1057 ++++++++++++++++++++++++++++++++++
>  include/linux/mtd/spi-nor.h   |  101 ++++
>  8 files changed, 1239 insertions(+), 1180 deletions(-)
>  create mode 100644 drivers/mtd/spi-nor/Kconfig
>  create mode 100644 drivers/mtd/spi-nor/Makefile
>  create mode 100644 drivers/mtd/spi-nor/spi-nor.c
>  create mode 100644 include/linux/mtd/spi-nor.h
> 
