From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Tue, 22 Mar 2011 13:46:07 +0100
Subject: [PATCH 5/7] add GPMI support for imx28
In-Reply-To: <1300239773-4222-6-git-send-email-b32955@freescale.com>
References: <1300239773-4222-1-git-send-email-b32955@freescale.com>
	<1300239773-4222-6-git-send-email-b32955@freescale.com>
Message-ID: <19848.39439.380861.195051@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

some general comments:
- Why are you not using the existing nand_ids but inventing your own
  database?

- What is the purpose of the 'rom_helpers'? To me it looks like they
  are doing something that should be done in the mtd partition
  handlers, not in the flash chip driver.


Huang Shijie writes:
> These files contain the code to implement the GPMI in the imx28.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  drivers/mtd/nand/gpmi-nfc/bch-regs-imx28.h  |  557 +++++++++++++++++++++++++++
>  drivers/mtd/nand/gpmi-nfc/gpmi-regs-imx28.h |  421 ++++++++++++++++++++
>  drivers/mtd/nand/gpmi-nfc/hal-imx28.c       |  503 ++++++++++++++++++++++++
>  drivers/mtd/nand/gpmi-nfc/rom-imx28.c       |   66 ++++
>  4 files changed, 1547 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/mtd/nand/gpmi-nfc/bch-regs-imx28.h
>  create mode 100644 drivers/mtd/nand/gpmi-nfc/gpmi-regs-imx28.h
>  create mode 100644 drivers/mtd/nand/gpmi-nfc/hal-imx28.c
>  create mode 100644 drivers/mtd/nand/gpmi-nfc/rom-imx28.c
> 
> diff --git a/drivers/mtd/nand/gpmi-nfc/bch-regs-imx28.h b/drivers/mtd/nand/gpmi-nfc/bch-regs-imx28.h
> new file mode 100644
> index 0000000..692db08
> --- /dev/null
> +++ b/drivers/mtd/nand/gpmi-nfc/bch-regs-imx28.h
> @@ -0,0 +1,557 @@
> +/*
> + * Freescale GPMI NFC NAND Flash Driver
> + *
> + * Copyright 2008-2010 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
> + *
> + * Xml Revision: 2.5
> + * Template revision: 26195
> + */
> +
> +#ifndef __GPMI_NFC_BCH_REGS_H
> +#define __GPMI_NFC_BCH_REGS_H
> +
> +/*============================================================================*/
> +
> +#define HW_BCH_CTRL	(0x00000000)
> +#define HW_BCH_CTRL_SET	(0x00000004)
> +#define HW_BCH_CTRL_CLR	(0x00000008)
> +#define HW_BCH_CTRL_TOG	(0x0000000c)
>
No need for parens around bare numbers.

> +#define BM_BCH_CTRL_SFTRST	0x80000000
> +#define BV_BCH_CTRL_SFTRST__RUN   0x0
> +#define BV_BCH_CTRL_SFTRST__RESET 0x1
> +#define BM_BCH_CTRL_CLKGATE	0x40000000
> +#define BV_BCH_CTRL_CLKGATE__RUN     0x0
> +#define BV_BCH_CTRL_CLKGATE__NO_CLKS 0x1
> +#define BP_BCH_CTRL_RSVD5	23
> +#define BM_BCH_CTRL_RSVD5	0x3F800000
> +#define BF_BCH_CTRL_RSVD5(v)  \
> +		(((v) << 23) & BM_BCH_CTRL_RSVD5)
> +#define BM_BCH_CTRL_DEBUGSYNDROME	0x00400000
> +#define BP_BCH_CTRL_RSVD4	20
> +#define BM_BCH_CTRL_RSVD4	0x00300000
> +#define BF_BCH_CTRL_RSVD4(v)  \
> +		(((v) << 20) & BM_BCH_CTRL_RSVD4)
> +#define BP_BCH_CTRL_M2M_LAYOUT	18
> +#define BM_BCH_CTRL_M2M_LAYOUT	0x000C0000
> +#define BF_BCH_CTRL_M2M_LAYOUT(v)  \
> +		(((v) << 18) & BM_BCH_CTRL_M2M_LAYOUT)
> +#define BM_BCH_CTRL_M2M_ENCODE	0x00020000
> +#define BM_BCH_CTRL_M2M_ENABLE	0x00010000
> +#define BP_BCH_CTRL_RSVD3	11
> +#define BM_BCH_CTRL_RSVD3	0x0000F800
> +#define BF_BCH_CTRL_RSVD3(v)  \
> +		(((v) << 11) & BM_BCH_CTRL_RSVD3)
> +#define BM_BCH_CTRL_DEBUG_STALL_IRQ_EN	0x00000400
> +#define BM_BCH_CTRL_RSVD2	0x00000200
> +#define BM_BCH_CTRL_COMPLETE_IRQ_EN	0x00000100
> +#define BP_BCH_CTRL_RSVD1	4
> +#define BM_BCH_CTRL_RSVD1	0x000000F0
> +#define BF_BCH_CTRL_RSVD1(v)  \
> +		(((v) << 4) & BM_BCH_CTRL_RSVD1)
> +#define BM_BCH_CTRL_BM_ERROR_IRQ	0x00000008
> +#define BM_BCH_CTRL_DEBUG_STALL_IRQ	0x00000004
> +#define BM_BCH_CTRL_RSVD0	0x00000002
> +#define BM_BCH_CTRL_COMPLETE_IRQ	0x00000001
> +
[...]
Messed up indentation. Also, use TAB instead of spaces for indentation.

> diff --git a/drivers/mtd/nand/gpmi-nfc/gpmi-regs-imx28.h b/drivers/mtd/nand/gpmi-nfc/gpmi-regs-imx28.h
> new file mode 100644
> index 0000000..dcb3b7d
> --- /dev/null
> +++ b/drivers/mtd/nand/gpmi-nfc/gpmi-regs-imx28.h
> @@ -0,0 +1,421 @@
> +/*
> + * Freescale GPMI NFC NAND Flash Driver
> + *
> + * Copyright 2008-2010 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
> + *
> + * Xml Revision: 2.2
> + * Template revision: 26195
> + */
> +
> +#ifndef __GPMI_NFC_GPMI_REGS_H
> +#define __GPMI_NFC_GPMI_REGS_H
> +
> +/*============================================================================*/
> +
> +#define HW_GPMI_CTRL0	(0x00000000)
> +#define HW_GPMI_CTRL0_SET	(0x00000004)
> +#define HW_GPMI_CTRL0_CLR	(0x00000008)
> +#define HW_GPMI_CTRL0_TOG	(0x0000000c)
> +
> +#define BM_GPMI_CTRL0_SFTRST	0x80000000
> +#define BV_GPMI_CTRL0_SFTRST__RUN   0x0
> +#define BV_GPMI_CTRL0_SFTRST__RESET 0x1
> +#define BM_GPMI_CTRL0_CLKGATE	0x40000000
> +#define BV_GPMI_CTRL0_CLKGATE__RUN     0x0
> +#define BV_GPMI_CTRL0_CLKGATE__NO_CLKS 0x1
> +#define BM_GPMI_CTRL0_RUN	0x20000000
> +#define BV_GPMI_CTRL0_RUN__IDLE 0x0
> +#define BV_GPMI_CTRL0_RUN__BUSY 0x1
> +#define BM_GPMI_CTRL0_DEV_IRQ_EN	0x10000000
> +#define BM_GPMI_CTRL0_LOCK_CS	0x08000000
> +#define BV_GPMI_CTRL0_LOCK_CS__DISABLED 0x0
> +#define BV_GPMI_CTRL0_LOCK_CS__ENABLED  0x1
> +#define BM_GPMI_CTRL0_UDMA	0x04000000
> +#define BV_GPMI_CTRL0_UDMA__DISABLED 0x0
> +#define BV_GPMI_CTRL0_UDMA__ENABLED  0x1
> +#define BP_GPMI_CTRL0_COMMAND_MODE	24
> +#define BM_GPMI_CTRL0_COMMAND_MODE	0x03000000
> +#define BF_GPMI_CTRL0_COMMAND_MODE(v)  \
> +		(((v) << 24) & BM_GPMI_CTRL0_COMMAND_MODE)
> +#define BV_GPMI_CTRL0_COMMAND_MODE__WRITE            0x0
> +#define BV_GPMI_CTRL0_COMMAND_MODE__READ             0x1
> +#define BV_GPMI_CTRL0_COMMAND_MODE__READ_AND_COMPARE 0x2
> +#define BV_GPMI_CTRL0_COMMAND_MODE__WAIT_FOR_READY   0x3
> +#define BM_GPMI_CTRL0_WORD_LENGTH	0x00800000
> +#define BV_GPMI_CTRL0_WORD_LENGTH__16_BIT 0x0
> +#define BV_GPMI_CTRL0_WORD_LENGTH__8_BIT  0x1
> +#define BP_GPMI_CTRL0_CS	20
> +#define BM_GPMI_CTRL0_CS	0x00700000
> +#define BF_GPMI_CTRL0_CS(v)  \
> +		(((v) << 20) & BM_GPMI_CTRL0_CS)
> +#define BP_GPMI_CTRL0_ADDRESS	17
> +#define BM_GPMI_CTRL0_ADDRESS	0x000E0000
> +#define BF_GPMI_CTRL0_ADDRESS(v)  \
> +		(((v) << 17) & BM_GPMI_CTRL0_ADDRESS)
> +#define BV_GPMI_CTRL0_ADDRESS__NAND_DATA 0x0
> +#define BV_GPMI_CTRL0_ADDRESS__NAND_CLE  0x1
> +#define BV_GPMI_CTRL0_ADDRESS__NAND_ALE  0x2
> +#define BM_GPMI_CTRL0_ADDRESS_INCREMENT	0x00010000
> +#define BV_GPMI_CTRL0_ADDRESS_INCREMENT__DISABLED 0x0
> +#define BV_GPMI_CTRL0_ADDRESS_INCREMENT__ENABLED  0x1
> +#define BP_GPMI_CTRL0_XFER_COUNT	0
> +#define BM_GPMI_CTRL0_XFER_COUNT	0x0000FFFF
> +#define BF_GPMI_CTRL0_XFER_COUNT(v)  \
> +		(((v) << 0) & BM_GPMI_CTRL0_XFER_COUNT)
>
same as above.

> diff --git a/drivers/mtd/nand/gpmi-nfc/hal-imx28.c b/drivers/mtd/nand/gpmi-nfc/hal-imx28.c
> new file mode 100644
> index 0000000..ff87d7f
> --- /dev/null
> +++ b/drivers/mtd/nand/gpmi-nfc/hal-imx28.c
> @@ -0,0 +1,503 @@
> +/*
> + * Freescale GPMI NFC NAND Flash Driver
> + *
> + * Copyright (C) 2011 Freescale Semiconductor, Inc.
> + * Copyright (C) 2008 Embedded Alley Solutions, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +#include "gpmi-nfc.h"
> +#include "gpmi-regs-imx28.h"
> +#include "bch-regs-imx28.h"
> +
[...]
> +static int send_command(struct gpmi_nfc_data *this)
> +{
> +	struct dma_chan *channel = get_dma_chan(this);
> +	struct mil *mil	= &this->mil;
> +	struct dma_async_tx_descriptor *desc;
> +	struct scatterlist *sgl;
> +	u32 pio[3];
> +
> +	/* [1] send out the PIO words */
> +	pio[0] = BF_GPMI_CTRL0_COMMAND_MODE(BV_GPMI_CTRL0_COMMAND_MODE__WRITE)
> +		| BM_GPMI_CTRL0_WORD_LENGTH
> +		| BF_GPMI_CTRL0_CS(mil->current_chip)
> +		| BF_GPMI_CTRL0_ADDRESS(BV_GPMI_CTRL0_ADDRESS__NAND_CLE)
> +		| BM_GPMI_CTRL0_ADDRESS_INCREMENT
> +		| BF_GPMI_CTRL0_XFER_COUNT(mil->command_length);
> +	pio[1] = pio[2] = 0;
> +	desc = channel->device->device_prep_slave_sg(channel,
> +					(struct scatterlist *)pio,
> +					ARRAY_SIZE(pio), DMA_NONE, 0);
> +	if (!desc) {
> +		log("step 1 error");
> +		return -1;
> +	}
> +
> +	/* [2] send out the COMMAND + ADDRESS string stored in @buffer */
> +	sgl = &mil->cmd_sgl;
> +
> +	dma_map_sg(this->dev, sgl, 1, DMA_TO_DEVICE);
> +	sgl->length = mil->command_length;
>
this has to be done _before_ dma_map_sg(). With CONFIG_DMA_API_DEBUG
enabled you would get:
|gpmi-nfc gpmi-nfc: DMA-API: device driver frees DMA memory with different size [device address=0x0000000046e10000] [map size=4096 bytes] [unmap size=1 bytes]


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
