From: angus.clark@st.com (Angus Clark)
Date: Tue, 26 Nov 2013 12:57:39 +0000
Subject: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <1385447575-23773-1-git-send-email-b32955@freescale.com>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
Message-ID: <52949AC3.6070008@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Huang Shijie,

I have not gone through your proposal in detail yet, but I just wanted to say I
fully support the motivation behind an update to the way Serial Flash is handled
in the kernel.  Looking at the various drivers supporting Serial Flash, it is
obvious that the current framework is not adequate.  Some have chosen to
implement standalone drivers, in driver/mtd/devices, duplicating much of
m25p80.c, while others have attempted to squeeze dedicated Serial Flash
Controllers within the generic SPI framework, often requiring fragile heuristics
to re-create the semantics of m25p80 which are lost over the SPI framework.

I will try to go through the patches in the next couple of days -- I have many
pending tasks at present!

Cheers,

Angus


On 11/26/2013 06:32 AM, Huang Shijie wrote:
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
