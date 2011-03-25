From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Fri, 25 Mar 2011 16:36:02 +0100
Subject: [ PATCH V2  0/7] add the GPMI controller driver for IMX23/IMX28
In-Reply-To: <1301048581-21321-1-git-send-email-b32955@freescale.com>
References: <1301048581-21321-1-git-send-email-b32955@freescale.com>
Message-ID: <19852.46690.924051.229009@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Huang Shijie writes:
> The general-purpose media interface(GPMI) controller is a flexible interface
> to up to several NAND flashs.
> 
> The Bose Ray-Choudhury Hocquenghem(BCH) module is a hardware ECC accelerator.
> 
> With the help of BCH, the GPMI controller can choose to do the hardware ECC or
> not.
> 
> This driver is based the Shawn Guo's DMA patches for IMX23/IMX28,
> please refer to :
> 	http://git.infradead.org/users/vkoul/slave-dma.git/commit/a580b8c5429a624d120cd603e1498bf676e2b4da
> 
> v1 --> v2:
> 	[0] merge the common files into the gpmi-nfc-main.c
> 	[1] change the code to get the clock.
> 	[2] remove the timing in the nand_device_info{}
> 	[3] fix DMA errors
> 	[4] add the nand_device_info.[ch] to generic code
> 	[5] use the chip->onfi_version for the ONFI nand
> 	[6] useless init
> 	[7] others
> 
> Huang Shijie (7):
>   ARM: add GPMI support for imx23/imx28
>   dmaengine: change the flags of request_irq()
>   MTD : add the database for the NANDs
>   MTD : add the common code for GPMI controller driver
>   MTD : add GPMI support for imx23
>   MTD : add GPMI support for imx28
>   MTD : add GPMI driver in the config and Makefile
> 
>  arch/arm/mach-mxs/Kconfig                       |    2 +
>  arch/arm/mach-mxs/clock-mx23.c                  |    3 +
>  arch/arm/mach-mxs/clock-mx28.c                  |    3 +
>  arch/arm/mach-mxs/devices-mx23.h                |    3 +
>  arch/arm/mach-mxs/devices-mx28.h                |    3 +
>  arch/arm/mach-mxs/devices/Kconfig               |    3 +
>  arch/arm/mach-mxs/devices/Makefile              |    1 +
>  arch/arm/mach-mxs/devices/platform-gpmi.c       |  140 ++
>  arch/arm/mach-mxs/include/mach/devices-common.h |    4 +
>  arch/arm/mach-mxs/include/mach/gpmi-nfc.h       |   62 +
>  arch/arm/mach-mxs/mach-mx23evk.c                |   37 +
>  arch/arm/mach-mxs/mach-mx28evk.c                |   37 +
>  drivers/dma/mxs-dma.c                           |    2 +-
>  drivers/mtd/nand/Kconfig                        |   10 +
>  drivers/mtd/nand/Makefile                       |    1 +
>  drivers/mtd/nand/gpmi-nfc/Makefile              |    7 +

>  drivers/mtd/nand/gpmi-nfc/bch-regs-imx23.h      |  342 ++++
>  drivers/mtd/nand/gpmi-nfc/bch-regs-imx28.h      |  342 ++++
>
Those two files are identical except for the file name included in the
comment.
If a new SoC with differences in the register layout pops up, that
should be handled by using namespace prefixes for the definitions
rather than by adding new files.

>  drivers/mtd/nand/gpmi-nfc/gpmi-regs-imx23.h     |  381 ++++
>  drivers/mtd/nand/gpmi-nfc/gpmi-regs-imx28.h     |  370 ++++
>
These files differ only in a few definitions. They should be combined
into one file and the differences sorted out using appropriate
namespace prefixes like:
|#define MX23_BP_GPMI_CTRL0_LOCK_CS	22
|#define MX23_BM_GPMI_CTRL0_LOCK_CS	(1 << MX23_BP_GPMI_CTRL0_LOCK_CS)
|#define BP_GPMI_CTRL0_CS		20
|#define MX23_BM_GPMI_CTRL0_CS		(3 << BP_GPMI_CTRL0_CS)
|#define MX28_BM_GPMI_CTRL0_CS		(7 << BP_GPMI_CTRL0_CS)

The code could either use if clauses checking the platform_id to
decide which definition to use, or use hooked functions and initialize
the function pointers depending on the platform_id.

Also, I prefer notations like '(1 << 22)' over '0x00400000' for bit
masks, because that makes it easier to match the definition with the
bit numbers given in the documentation.

Further the 'RSVD' entries should be removed from the register
definitions (even if they are generated from the XML).

>  drivers/mtd/nand/gpmi-nfc/hal-imx23.c           |  555 +++++
>  drivers/mtd/nand/gpmi-nfc/hal-imx28.c           |  503 +++++
>
These files are more or less identical. The code should be moved to
the main file and the differences sorted out using the platform_ids.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
