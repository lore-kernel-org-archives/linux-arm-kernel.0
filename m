From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 1 Jul 2015 07:07:49 +0200
Subject: [PATCH v2 3/4] spi: mediatek: Add spi bus for Mediatek MT8173
In-Reply-To: <CAGS+omD3anZyJST90QVoJ5N-OPsdYYj3_Fq0rJSXADt84EL6yg@mail.gmail.com>
References: <1435583070-9600-1-git-send-email-leilk.liu@mediatek.com>
 <1435583070-9600-4-git-send-email-leilk.liu@mediatek.com>
 <CAGS+omD3anZyJST90QVoJ5N-OPsdYYj3_Fq0rJSXADt84EL6yg@mail.gmail.com>
Message-ID: <20150701050749.GV18611@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 01, 2015 at 12:06:02PM +0800, Daniel Kurtz wrote:
> Hi Leilk,
> 
> Please see comments inline...
> 
> On Mon, Jun 29, 2015 at 9:04 PM, Leilk Liu <leilk.liu@mediatek.com> wrote:
> > This patch adds basic spi bus for MT8173.
> >
> > Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> > Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> > ---
> >  drivers/spi/Kconfig      |   9 +
> >  drivers/spi/Makefile     |   1 +
> >  drivers/spi/spi-mt65xx.c | 656 +++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 666 insertions(+)
> >  create mode 100644 drivers/spi/spi-mt65xx.c
> >
> > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> > index 198f96b..06f9514 100644
> > --- a/drivers/spi/Kconfig
> > +++ b/drivers/spi/Kconfig
> > @@ -324,6 +324,15 @@ config SPI_MESON_SPIFC
> >           This enables master mode support for the SPIFC (SPI flash
> >           controller) available in Amlogic Meson SoCs.
> >
> > +config SPI_MT65XX
> > +       tristate "MediaTek SPI controller"
> > +       depends on ARCH_MEDIATEK || COMPILE_TEST
> > +       help
> > +         This selects the MediaTek(R) SPI bus driver.
> > +         If you want to use MediaTek(R) SPI interface,
> > +         say Y or M here.If you are not sure, say N.
> > +         SPI drivers for Mediatek mt65XX series ARM SoCs.
> > +
> >  config SPI_OC_TINY
> >         tristate "OpenCores tiny SPI"
> >         depends on GPIOLIB
> > diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> > index d8cbf65..ab332ef 100644
> > --- a/drivers/spi/Makefile
> > +++ b/drivers/spi/Makefile
> > @@ -48,6 +48,7 @@ obj-$(CONFIG_SPI_MESON_SPIFC)         += spi-meson-spifc.o
> >  obj-$(CONFIG_SPI_MPC512x_PSC)          += spi-mpc512x-psc.o
> >  obj-$(CONFIG_SPI_MPC52xx_PSC)          += spi-mpc52xx-psc.o
> >  obj-$(CONFIG_SPI_MPC52xx)              += spi-mpc52xx.o
> > +obj-$(CONFIG_SPI_MT65XX)                += spi-mt65xx.o
> >  obj-$(CONFIG_SPI_MXS)                  += spi-mxs.o
> >  obj-$(CONFIG_SPI_NUC900)               += spi-nuc900.o
> >  obj-$(CONFIG_SPI_OC_TINY)              += spi-oc-tiny.o
> > diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> > new file mode 100644
> > index 0000000..6cb54587
> > --- /dev/null
> > +++ b/drivers/spi/spi-mt65xx.c
> > @@ -0,0 +1,656 @@
> > +/*
> > + * Copyright (c) 2015 MediaTek Inc.
> > + * Author: Leilk Liu <leilk.liu@mediatek.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/device.h>
> > +#include <linux/ioport.h>
> > +#include <linux/errno.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/workqueue.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irqreturn.h>
> > +#include <linux/types.h>
> > +#include <linux/delay.h>
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/sched.h>
> > +#include <linux/of.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_gpio.h>
> > +#include <linux/kernel.h>
> > +#include <linux/gpio.h>
> > +#include <linux/module.h>
> > +#include <linux/pm_runtime.h>
> 
> It would be nicer if you can alphabetize these headers.
> 
> > +
> > +#define SPI_CFG0_REG                      0x0000
> > +#define SPI_CFG1_REG                      0x0004
> > +#define SPI_TX_SRC_REG                    0x0008
> > +#define SPI_RX_DST_REG                    0x000c
> > +#define SPI_CMD_REG                       0x0018
> > +#define SPI_STATUS0_REG                   0x001c
> > +#define SPI_PAD_SEL_REG                   0x0024
> > +
> > +#define SPI_CFG0_SCK_HIGH_OFFSET          0
> > +#define SPI_CFG0_SCK_LOW_OFFSET           8
> > +#define SPI_CFG0_CS_HOLD_OFFSET           16
> > +#define SPI_CFG0_CS_SETUP_OFFSET          24
> > +
> > +#define SPI_CFG0_SCK_HIGH_MASK            0xff
> > +#define SPI_CFG0_SCK_LOW_MASK             0xff00
> > +#define SPI_CFG0_CS_HOLD_MASK             0xff0000
> > +#define SPI_CFG0_CS_SETUP_MASK            0xff000000
> > +
> > +#define SPI_CFG1_CS_IDLE_OFFSET           0
> > +#define SPI_CFG1_PACKET_LOOP_OFFSET       8
> > +#define SPI_CFG1_PACKET_LENGTH_OFFSET     16
> > +#define SPI_CFG1_GET_TICK_DLY_OFFSET      30
> > +
> > +#define SPI_CFG1_CS_IDLE_MASK             0xff
> > +#define SPI_CFG1_PACKET_LOOP_MASK         0xff00
> > +#define SPI_CFG1_PACKET_LENGTH_MASK       0x3ff0000
> > +#define SPI_CFG1_GET_TICK_DLY_MASK        0xc0000000
> > +
> > +#define SPI_CMD_ACT_OFFSET                0
> > +#define SPI_CMD_RESUME_OFFSET             1
> > +#define SPI_CMD_RST_OFFSET                2
> > +#define SPI_CMD_PAUSE_EN_OFFSET           4
> > +#define SPI_CMD_DEASSERT_OFFSET           5
> > +#define SPI_CMD_CPHA_OFFSET               8
> > +#define SPI_CMD_CPOL_OFFSET               9
> > +#define SPI_CMD_RX_DMA_OFFSET             10
> > +#define SPI_CMD_TX_DMA_OFFSET             11
> > +#define SPI_CMD_TXMSBF_OFFSET             12
> > +#define SPI_CMD_RXMSBF_OFFSET             13
> > +#define SPI_CMD_RX_ENDIAN_OFFSET          14
> > +#define SPI_CMD_TX_ENDIAN_OFFSET          15
> > +#define SPI_CMD_FINISH_IE_OFFSET          16
> > +#define SPI_CMD_PAUSE_IE_OFFSET           17
> > +
> > +#define SPI_CMD_RST_MASK                  0x4
> > +#define SPI_CMD_PAUSE_EN_MASK             0x10
> > +#define SPI_CMD_DEASSERT_MASK             0x20
> > +#define SPI_CMD_CPHA_MASK                 0x100
> > +#define SPI_CMD_CPOL_MASK                 0x200
> > +#define SPI_CMD_RX_DMA_MASK               0x400
> > +#define SPI_CMD_TX_DMA_MASK               0x800
> > +#define SPI_CMD_TXMSBF_MASK               0x1000
> > +#define SPI_CMD_RXMSBF_MASK               0x2000
> > +#define SPI_CMD_RX_ENDIAN_MASK            0x4000
> > +#define SPI_CMD_TX_ENDIAN_MASK            0x8000
> > +#define SPI_CMD_FINISH_IE_MASK            0x10000
> 
> Use the BIT() macro do define these bit masks.
> In fact, for these 1-bit fields, just use the MASK rather than "(1 <<
> *_OFFSET)" when setting/clearing the bits in code.
> 
> > +
> > +#define COMPAT_MT6589                  (0x1 << 0)
> > +#define COMPAT_MT8135                  (0x1 << 1)
> > +#define COMPAT_MT8173                  (0x1 << 2)
> 
> Rather than define per-platform "COMPAT" flags, I think it would be
> better to define these as a set of quirks.
> Individual platforms would then specify a mask indicating which quirks
> they support.
> 
> In this case, there are only two, and both are present on mt8173, but
> not on the other 2 listed parts:
>   MTK_SPI_QUIRK_PAD_SELECT
>   MTK_SPI_QUIRK_MUST_TX  /* Must explicitly send dummy Tx bytes to do
> Rx only transfer */
> 
> For MTK_SPI_QUIRK_MUST_TX, I think it just means that we must set the
> SPI_MASTER_MUST_TX flag when registering the spi_master?
> 
> > +
> > +#define MT8173_MAX_PAD_SEL 3
> 
> I'm not exactly sure how to deal with PAD_SEL either:
> 
> The MT8173 SPI device supports four SPI ports.
> Each port has the full complement of 4 signals (nSS, CLK, MISO, MOSI).
> However, only one can be selected at a time via the "PAD_SEL" register.
> In addition, the SPI function for the SPI port pins must be enabled
> for the corresponding GPIOs via pinctl.
> If the nSS pin has its SPI function selected, it will be controlled
> automatically by SPI hardware.
> 
> Relying on hardware control of the SPI nSS pin seems quite limiting -
> it means each SPI port can only control a single slave device.
> I would think that allowing any GPIO to act as nSS would be much more
> flexible, since then each SPI port could truly be a multi-slave bus.
> I also believe the standard linux SPI infrastructure has support for
> using GPIOs in this way.
> How is this handled for other platforms (using built-in nSS versus
> using GPIOs as nSS)?

Often Hardware has its own idea when to enable/disable the chipselect.
Some Freescale hardware just raises the chipselect when it's out of data
which means that delays in the software causes arbitrary CS toggles.
With GPIOs as chipselects there are less possibilities to get it wrong.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
