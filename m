From: ffainelli@freebox.fr (Florian Fainelli)
Date: Wed, 30 Mar 2011 11:23:59 +0200
Subject: [PATCH V3 3/6] MTD : add the database for the NANDs
In-Reply-To: <4D92F277.7060607@freescale.com>
References: <1301474413-28821-1-git-send-email-b32955@freescale.com>
	<201103301046.04357.ffainelli@freebox.fr>
	<4D92F277.7060607@freescale.com>
Message-ID: <201103301123.59329.ffainelli@freebox.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Huang,

On Wednesday 30 March 2011 11:05:59 Huang Shijie wrote:
> Hi Florian:
> 
> thanks for a so quick reply. :)
> 
> > Hello Huang,
> > 
> > On Wednesday 30 March 2011 10:40:10 Huang Shijie wrote:
> >> This is a new database for the NANDs which is searched by the id_bytes.
> > 
> > drivers/mtd//nand/nand_base.c will be able to detect all of your chips
> > listed below based on the ids present in drivers/mtd/nand/nand_ids.c
> 
> yes.
> 
> But I will use the new database to replace the old one.
> 
> I will  submit new patches to modify the generic code if my driver is
> accepted.

I think you can start right away submitting patches to modify generic code, 
this can either be a premilinary patch series to the GPMI driver, or in the 
same patch series as the GPMI driver.

> 
> > If you have new chips to support in the future, you should add them in
> > drivers/mtd/nand/nand_ids.c and not keep this file.
> 
> The data structure  nand_flash_dev{} does not contain enough information.
> So I want to the nand_device_info{} to replace it in future.

Ok, you should have written that in the patch description, otherwise it is 
misleading and I though you just duplicated code without knowing what the 
existing code could do.

> 
> > I still do not understand why this would be needed, is it because the
> > generic code does not provide enough informations for your driver?
> 
> yes.
> 
> IMHO, the generic code is somehow trapped in a wrong way. :(
> Paring the id bytes is not sufficient to get all the information you
> need which is faced by me.
> 
> What's more, I think the paring code is ugly, see the
> nand_get_flash_type().
> 
> Why not create a new database which contains all the necessary
> information for a nand, and can be easy
> find by the id bytes as the keyword?

The idea is to hardcode as little information as possible, and let the rest be 
detected at runtime when possible. I think this it the right approach, because 
it is more future proof.

> 
> I wish David and Artem give some advice about this.

I would also like them to jump into this discussion.

> 
> >> Signed-off-by: Huang Shijie<b32955@freescale.com>
> >> ---
> >> 
> >>   drivers/mtd/nand/nand_device_info.c |  157
> >> 
> >> +++++++++++++++++++++++++++++++++++ drivers/mtd/nand/nand_device_info.h
> >> |
> >> 
> >>   88 +++++++++++++++++++
> >>   2 files changed, 245 insertions(+), 0 deletions(-)
> >>   create mode 100644 drivers/mtd/nand/nand_device_info.c
> >>   create mode 100644 drivers/mtd/nand/nand_device_info.h
> >> 
> >> diff --git a/drivers/mtd/nand/nand_device_info.c
> >> b/drivers/mtd/nand/nand_device_info.c new file mode 100644
> >> index 0000000..757ed89
> >> --- /dev/null
> >> +++ b/drivers/mtd/nand/nand_device_info.c
> >> @@ -0,0 +1,157 @@
> >> +/*
> >> + * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights
> >> Reserved. + */
> >> +
> >> +/*
> >> + * The code contained herein is licensed under the GNU General Public
> >> + * License. You may obtain a copy of the GNU General Public License
> >> + * Version 2 or later at the following locations:
> >> + *
> >> + * http://www.opensource.org/licenses/gpl-license.html
> >> + * http://www.gnu.org/copyleft/gpl.html
> >> + */
> >> +#include<asm/sizes.h>
> >> +#include<linux/mtd/nand.h>
> >> +
> >> +#include "nand_device_info.h"
> >> +
> >> +static const struct nand_device_info samsung_nand[] = {
> >> +	{
> >> +		.id	= { 0xec, 0xd3, 0x14, 0x25, 0x64, 0xec, 0xd3, 0x14 },
> >> +		.id_len	= 8,
> >> +		.desc	= "K9G8G08U0M, K9HAG08U1M",
> >> +		.attr	= ATTR(MLC, NAND_BUSWIDTH_8, 1LL * SZ_1G, 128,
> >> +				2 * SZ_1K + 64, 8, 512),
> >> +	}, {
> >> +		.id	= { 0xec, 0xd7, 0xd5, 0x29, 0x38, 0x41, 0xec, 0xd7 },
> >> +		.id_len	= 8,
> >> +		.desc	= "K9LBG08U0D",
> >> +		.attr	= ATTR(MLC, NAND_BUSWIDTH_8, 4LL * SZ_1G, 128,
> >> +				4 * SZ_1K + 218, 16, 512),
> >> +	}, {
> >> +		.id	= { 0xec, 0xd5, 0x14, 0xb6, 0x74, 0xec, 0xd5, 0x14 },
> >> +		.id_len	= 8,
> >> +		.desc	= "K9GAG08U0M",
> >> +		.attr	= ATTR(MLC, NAND_BUSWIDTH_8, 2LL * SZ_1G, 128,
> >> +				4 * SZ_1K + 218, 16, 512),
> >> +	}, {
> >> +		/* end of the table. */
> >> +		.id	= { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
> >> +	},
> >> +};
> >> +
> >> +/* macro to get the id bytes */
> >> +#define ID_GET_MFR_CODE(id)  ((id)[0])
> >> +
> >> +void nand_device_print_info(struct nand_device_info *info)
> >> +{
> >> +	unsigned    i;
> >> +	const char  *mfr_name;
> >> +	const char  *cell_technology_name;
> >> +	uint64_t    chip_size;
> >> +	const char  *chip_size_units;
> >> +	unsigned    page_size;
> >> +	unsigned    oob_size;
> >> +	struct nand_attr *attr		=&info->attr;
> >> +
> >> +	/* Prepare the manufacturer name. */
> >> +	mfr_name = "Unknown";
> >> +	for (i = 0; nand_manuf_ids[i].id; i++) {
> >> +		if (nand_manuf_ids[i].id == ID_GET_MFR_CODE(info->id)) {
> >> +			mfr_name = nand_manuf_ids[i].name;
> >> +			break;
> >> +		}
> >> +	}
> >> +
> >> +	/* Prepare the name of the cell technology. */
> >> +	switch (attr->cell_technology) {
> >> +	case SLC:
> >> +		cell_technology_name = "SLC";
> >> +		break;
> >> +	case MLC:
> >> +		cell_technology_name = "MLC";
> >> +		break;
> >> +	default:
> >> +		cell_technology_name = "Unknown";
> >> +		break;
> >> +	}
> >> +
> >> +	/* Prepare the chip size. */
> >> +	if ((attr->chip_size_in_bytes>= SZ_1G)&&
> >> +					!(attr->chip_size_in_bytes % SZ_1G)) {
> >> +		chip_size       = attr->chip_size_in_bytes / ((uint64_t) 
SZ_1G);
> >> +		chip_size_units = "GiB";
> >> +	} else if ((attr->chip_size_in_bytes>= SZ_1M)&&
> >> +					!(attr->chip_size_in_bytes % SZ_1M)) {
> >> +		chip_size       = attr->chip_size_in_bytes / ((uint64_t) 
SZ_1M);
> >> +		chip_size_units = "MiB";
> >> +	} else {
> >> +		chip_size       = attr->chip_size_in_bytes;
> >> +		chip_size_units = "B";
> >> +	}
> >> +
> >> +	/* Prepare the page geometry. */
> >> +	page_size = (1<<  (fls(attr->page_total_size_in_bytes) - 1));
> >> +	oob_size  = attr->page_total_size_in_bytes - page_size;
> >> +
> >> +	/* Print the infomation. */
> >> +	pr_info("--------------------------------------\n");
> >> +	pr_info("	NAND device infomation (RAW)\n");
> >> +	pr_info("--------------------------------------\n");
> >> +	pr_info("Manufacturer      : %s (0x%02x)\n", mfr_name, info->id[0]);
> >> +	pr_info("Device Code       : 0x%02x\n", info->id[1]);
> >> +	pr_info("Cell Technology   : %s\n", cell_technology_name);
> >> +	pr_info("Chip Size         : %llu %s\n", chip_size, 
chip_size_units);
> >> +	pr_info("Pages per Block   : %u\n", attr->block_size_in_pages);
> >> +	pr_info("Page Geometry     : %u+%u\n", page_size, oob_size);
> >> +	pr_info("ECC Strength      : %u bits\n", attr-
>ecc_strength_in_bits);
> >> +	pr_info("ECC Size          : %u B\n", attr->ecc_size_in_bytes);
> >> +	pr_info("Description       : %s\n", info->desc);
> >> +}
> >> +
> >> +static struct nand_device_info * __init
> >> +search_table(const struct nand_device_info *table, const uint8_t id[])
> >> +{
> >> +	struct nand_device_info *info = (struct nand_device_info *)table;
> >> +
> >> +	while (ID_GET_MFR_CODE(info->id)) {
> >> +		int i;
> >> +
> >> +		/* match all the valid id bytes. Is it too strict? */
> >> +		for (i = 0; i<  info->id_len; i++)
> >> +			if (info->id[i] != id[i])
> >> +				break;
> >> +
> >> +		/* found it */
> >> +		if (i == info->id_len)
> >> +			return info;
> >> +		info++;
> >> +	}
> >> +	return NULL;
> >> +}
> >> +
> >> +struct nand_device_mfr_info {
> >> +	uint8_t                  id;
> >> +	const struct nand_device_info  *table;
> >> +};
> >> +
> >> +static const struct nand_device_mfr_info  nand_device_mfr_directory[] =
> >> { +	{ NAND_MFR_SAMSUNG, samsung_nand },
> >> +	{ 0, NULL },
> >> +};
> >> +
> >> +struct nand_device_info *nand_device_get_info(const uint8_t id[])
> >> +{
> >> +	uint8_t mfr_id = ID_GET_MFR_CODE(id);
> >> +	unsigned i;
> >> +
> >> +	for (i = 0; nand_device_mfr_directory[i].id; i++) {
> >> +		if (nand_device_mfr_directory[i].id == mfr_id) {
> >> +			const struct nand_device_info  *table;
> >> +
> >> +			table = nand_device_mfr_directory[i].table;
> >> +			return search_table(table, id);
> >> +		}
> >> +	}
> >> +	return NULL;
> >> +}
> >> diff --git a/drivers/mtd/nand/nand_device_info.h
> >> b/drivers/mtd/nand/nand_device_info.h new file mode 100644
> >> index 0000000..15f688d
> >> --- /dev/null
> >> +++ b/drivers/mtd/nand/nand_device_info.h
> >> @@ -0,0 +1,88 @@
> >> +/*
> >> + * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
> >> + */
> >> +
> >> +/*
> >> + * The code contained herein is licensed under the GNU General Public
> >> + * License. You may obtain a copy of the GNU General Public License
> >> + * Version 2 or later at the following locations:
> >> + *
> >> + * http://www.opensource.org/licenses/gpl-license.html
> >> + * http://www.gnu.org/copyleft/gpl.html
> >> + */
> >> +#ifndef __DRIVERS_NAND_DEVICE_INFO_H
> >> +#define __DRIVERS_NAND_DEVICE_INFO_H
> >> +
> >> +enum nand_device_cell_technology {
> >> +	SLC = 0,
> >> +	MLC = 1,
> >> +};
> >> +
> >> +/**
> >> + * @cell_technology:		The storage cell technology.
> >> + * @busw:			The bus width of the NAND.
> >> + * @chip_size_in_bytes:		The total size of the storage behind a 
single
> >> + *				chip select, in bytes. Notice that this is *not*
> >> + *				necessarily the total size of the storage in a
> >> + *				*package*, which may contain several chips.
> >> + * @block_size_in_pages:	The number of pages in a block.
> >> + * @page_total_size_in_bytes:	The total size of a page, in bytes,
> >> including + *				both the data and the OOB.
> >> + * @ecc_strength_in_bits:	The strength of the ECC called for by the
> >> + *				manufacturer, in number of correctable bits.
> >> + * @ecc_size_in_bytes:		The size of the data block over which the
> >> + *				manufacturer calls for the given ECC algorithm
> >> + *				and strength.
> >> + */
> >> +struct nand_attr {
> >> +	/* Technology */
> >> +	enum nand_device_cell_technology  cell_technology;
> >> +
> >> +	/* bus width */
> >> +#define NAND_BUSWIDTH_8	0
> >> +	uint32_t	busw;
> >> +
> >> +	/* Geometry */
> >> +	uint64_t	chip_size_in_bytes;
> >> +	uint32_t	block_size_in_pages;
> >> +	uint32_t	page_total_size_in_bytes;
> >> +
> >> +	/* ECC */
> >> +	uint16_t	ecc_strength_in_bits;
> >> +	uint16_t	ecc_size_in_bytes;
> >> +};
> >> +
> >> +#define ID_BYTES	(8)
> >> +/*
> >> + * struct nand_device_info - Information about a single NAND Flash
> >> device. + *
> >> + * This structure contains all the *essential* information about a NAND
> >> Flash + * device, derived from the device's data sheet.
> >> + */
> >> +struct nand_device_info {
> >> +	/* id */
> >> +	uint8_t			id[ID_BYTES];
> >> +	unsigned int		id_len;
> >> +
> >> +	/* Description */
> >> +	const char		*desc;
> >> +
> >> +	/* attribute*/
> >> +	struct nand_attr	attr;
> >> +};
> >> +
> >> +/* macro for the NAND attribute */
> >> +#define ATTR(_a, _b, _c, _d, _e, _f, _g)		\
> >> +	{						\
> >> +		.cell_technology		= (_a),	\
> >> +		.busw				= (_b),	\
> >> +		.chip_size_in_bytes		= (_c),	\
> >> +		.block_size_in_pages		= (_d),	\
> >> +		.page_total_size_in_bytes	= (_e),	\
> >> +		.ecc_strength_in_bits		= (_f),	\
> >> +		.ecc_size_in_bytes		= (_g),	\
> >> +	}
> >> +
> >> +struct nand_device_info *nand_device_get_info(const uint8_t
> >> id_bytes[]); +void nand_device_print_info(struct nand_device_info
> >> *info);
> >> +#endif
> 
> Best Regards
> Huang Shijie
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
