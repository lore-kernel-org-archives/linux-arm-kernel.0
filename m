From: ffainelli@freebox.fr (Florian Fainelli)
Date: Thu, 24 Mar 2011 14:50:50 +0100
Subject: [PATCH 3/7] add the database for the NANDs
In-Reply-To: <4D8AAC1C.2070709@freescale.com>
References: <1300240521-4344-1-git-send-email-b32955@freescale.com>
	<201103231629.46958.ffainelli@freebox.fr>
	<4D8AAC1C.2070709@freescale.com>
Message-ID: <201103241450.50967.ffainelli@freebox.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Huang,

On Thursday 24 March 2011 03:27:40 Huang Shijie wrote:
> Hi Florian:
>      thanks a lot for your review.
> 
> > Hello Huang,
> > 
> > On Wednesday 16 March 2011 02:55:17 Huang Shijie wrote:
> >> This is a database for the NANDs which is now supported by imx23 and
> >> imx28.
> >> 
> >> Signed-off-by: Huang Shijie<b32955@freescale.com>
> >> ---
> >> 
> >>   drivers/mtd/nand/gpmi-nfc/nand_device_info.c |  181
> >> 
> >> ++++++++++++++++++++++++++ drivers/mtd/nand/gpmi-nfc/nand_device_info.h
> >> | 145 +++++++++++++++++++++ 2 files changed, 326 insertions(+), 0
> >> deletions(-)
> >> 
> >>   create mode 100644 drivers/mtd/nand/gpmi-nfc/nand_device_info.c
> >>   create mode 100644 drivers/mtd/nand/gpmi-nfc/nand_device_info.h
> >> 
> >> diff --git a/drivers/mtd/nand/gpmi-nfc/nand_device_info.c
> >> b/drivers/mtd/nand/gpmi-nfc/nand_device_info.c new file mode 100644
> >> index 0000000..aa0813a
> >> --- /dev/null
> >> +++ b/drivers/mtd/nand/gpmi-nfc/nand_device_info.c
> >> @@ -0,0 +1,181 @@
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
> >> +
> >> +#include<asm/sizes.h>
> >> +#include<linux/mtd/nand.h>
> >> +
> >> +#include "nand_device_info.h"
> >> +
> >> +static struct nand_device_info samsung_nand[] __initdata = {
> >> +	{
> >> +		.id	= { 0xec, 0xd3, 0x14, 0x25, 0x64, 0xec, 0xd3, 0x14 },
> >> +		.desc	= "K9G8G08U0M, K9HAG08U1M",
> >> +		.attr	= ATTR(MLC, 1LL * SZ_1G, 128, 2 * SZ_1K + 64, 4, 512),
> >> +		.timing	= TIMING(20, 15, 20, 6, -1, -1, -1),
> >> +	}, {
> >> +		.id	= { 0xec, 0xd7, 0xd5, 0x29, 0x38, 0x41, 0xec, 0xd7 },
> >> +		.desc	= "K9LBG08U0D",
> >> +		.attr	= ATTR(MLC, 4LL * SZ_1G, 128, 4 * SZ_1K + 218, 8, 512),
> >> +		.timing	= TIMING(20, 10, 25, 6, 20, 5, 15),
> >> +	}, {
> >> +		.id	= { 0xec, 0xd5, 0x14, 0xb6, 0x74, 0xec, 0xd5, 0x14 },
> >> +		.desc	= "K9GAG08U0M",
> >> +		.attr	= ATTR(MLC, 2LL * SZ_1G, 128, 4 * SZ_1K + 218, 4, 512),
> >> +		.timing	= TIMING(15, 10, 20, 6, -1, -1, -1),
> >> +	}, {
> >> +		/* end of the table. */
> >> +		.id	= { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
> >> +	},
> >> +};
> > 
> > Such information should be set in platform code, because it is specific
> > to your controller and most likely to a particular board design.
> 
> I prefer to place it here.
> 
>   If I move the code to arch/arm/mach-mxs, it will make the arch/ much
> bigger.
> I have nearly 50 different nands information by hand, I will add it
> gradually in later patches.

This certainly makes the code bigger, but this is also the place where the 
code belongs. Also, if you mark your structures with __initdata, such memory 
can be freed later by the kernel, so I would rather go into that direction.

> 
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
> >> +	unsigned    page_data_size_in_bytes;
> >> +	unsigned    page_oob_size_in_bytes;
> >> +	struct nand_attr *attr		=&info->attr;
> >> +	struct nand_timing *timing	=&info->timing;
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
> >> +	page_data_size_in_bytes =
> >> (1<<(fls(attr->page_total_size_in_bytes)-1)); +	page_oob_size_in_bytes 
> >> = attr->page_total_size_in_bytes -
> >> +					page_data_size_in_bytes;
> >> +
> >> +	/* Print the infomation. */
> >> +	printk(KERN_INFO "--------------------------------------\n");
> >> +	printk(KERN_INFO "	NAND device infomation (RAW)\n");
> >> +	printk(KERN_INFO "--------------------------------------\n");
> >> +	printk(KERN_INFO "Manufacturer      : %s (0x%02x)\n", mfr_name,
> >> +							info->id[0]);
> >> +	printk(KERN_INFO "Device Code       : 0x%02x\n", info->id[1]);
> >> +	printk(KERN_INFO "Cell Technology   : %s\n", cell_technology_name);
> >> +	printk(KERN_INFO "Chip Size         : %llu %s\n", chip_size,
> >> +							chip_size_units);
> >> +	printk(KERN_INFO "Pages per Block   : %u\n",
> >> attr->block_size_in_pages); +	printk(KERN_INFO "Page Geometry     :
> >> %u+%u\n", page_data_size_in_bytes, +							
page_oob_size_in_bytes);
> >> +	printk(KERN_INFO "ECC Strength      : %u bits\n",
> >> +						attr->ecc_strength_in_bits);
> >> +	printk(KERN_INFO "ECC Size          : %u B\n",
> >> attr->ecc_size_in_bytes); +	printk(KERN_INFO "Data Setup Time   : %u
> >> ns\n",
> >> +						timing->data_setup_in_ns);
> >> +	printk(KERN_INFO "Data Hold Time    : %u ns\n",
> >> +						timing->data_hold_in_ns);
> >> +	printk(KERN_INFO "Address Setup Time: %u ns\n",
> >> +						timing->address_setup_in_ns);
> >> +	printk(KERN_INFO "GPMI Sample Delay : %u ns\n",
> >> +					timing->gpmi_sample_delay_in_ns);
> >> +	printk(KERN_INFO "tREA              : %d ns\n",
> >> +						(timing->tREA_in_ns>= 0 ?
> >> +						timing->tREA_in_ns : -1));
> >> +	printk(KERN_INFO "tRLOH             : %d ns\n",
> >> +						(timing->tRLOH_in_ns>= 0 ?
> >> +						timing->tRLOH_in_ns : -1));
> >> +	printk(KERN_INFO "tRHOH             : %d ns\n",
> >> +						(timing->tRHOH_in_ns>= 0 ?
> >> +						timing->tRHOH_in_ns : -1));
> >> +	printk(KERN_INFO "Description       : %s\n", info->desc);
> >> +}
> > 
> > What is the purpose of printing all these informations? If it is for
> > debugging purposes, use dev_dbg().
> 
> I do not treat this as debugging information.
> I print it out for showing the detail of a NAND.

This is not required, if you need informations about your nand chip, you'd 
better use an user-space tool such as nanddump.

> 
> >> +
> >> +static struct nand_device_info * __init
> >> +search_table(struct nand_device_info *table, const uint8_t id[])
> >> +{
> >> +	struct nand_device_info *info = table;
> >> +
> >> +	while (ID_GET_MFR_CODE(info->id)) {
> >> +		int i;
> >> +
> >> +		/* match all the ids. Is it too strict? */
> >> +		for (i = 0; i<  ID_BYTES; i++)
> >> +			if (info->id[i] != id[i])
> >> +				break;
> >> +
> >> +		/* found it */
> >> +		if (i == ID_BYTES) {
> >> +			nand_device_print_info(info);
> >> +			return info;
> >> +		}
> >> +
> >> +		info++;
> >> +	}
> >> +	return NULL;
> >> +}
> >> +
> >> +struct nand_device_mfr_info {
> >> +	uint8_t                  id;
> >> +	struct nand_device_info  *table;
> >> +};
> >> +
> >> +static struct nand_device_mfr_info  nand_device_mfr_directory[]
> >> __initdata = { +	{ NAND_MFR_SAMSUNG, samsung_nand },
> >> +	{ 0, NULL },
> >> +};
> >> +
> >> +struct nand_device_info * __init nand_device_get_info(const uint8_t
> >> id[]) +{
> >> +	uint8_t mfr_id = ID_GET_MFR_CODE(id);
> >> +	unsigned i;
> >> +
> >> +	for (i = 0; nand_device_mfr_directory[i].id; i++) {
> >> +		if (nand_device_mfr_directory[i].id == mfr_id) {
> >> +			struct nand_device_info  *table;
> >> +
> >> +			table = nand_device_mfr_directory[i].table;
> >> +			return search_table(table, id);
> >> +		}
> >> +	}
> >> +	return NULL;
> >> +}
> >> diff --git a/drivers/mtd/nand/gpmi-nfc/nand_device_info.h
> >> b/drivers/mtd/nand/gpmi-nfc/nand_device_info.h new file mode 100644
> >> index 0000000..e606705
> >> --- /dev/null
> >> +++ b/drivers/mtd/nand/gpmi-nfc/nand_device_info.h
> >> @@ -0,0 +1,145 @@
> >> +/*
> >> + * Copyright 2009-2010 Freescale Semiconductor, Inc. All Rights
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
> >> +#ifndef __DRIVERS_NAND_DEVICE_INFO_H
> >> +#define __DRIVERS_NAND_DEVICE_INFO_H
> >> +
> >> +enum nand_device_cell_technology {
> >> +	SLC = 0,
> >> +	MLC = 1,
> >> +};
> >> +
> >> +/**
> >> + *
> >> + *
> >> + * @cell_technology:           The storage cell technology.
> >> + * @chip_size_in_bytes:        The total size of the storage behind a
> >> single + *                             chip select, in bytes. Notice
> >> that this is *not* + *                             necessarily the
> >> total size of the storage in a + *                            
> >> *package*, which may contain several chips. + * @block_size_in_pages:  
> >>     The number of pages in a block.
> >> + * @page_total_size_in_bytes:  The total size of a page, in bytes,
> >> including + *                             both the data and the OOB.
> >> + * @ecc_strength_in_bits:      The strength of the ECC called for by
> >> the + *                             manufacturer, in number of
> >> correctable bits. + * @ecc_size_in_bytes:         The size of the data
> >> block over which the + *                             manufacturer calls
> >> for the given ECC algorithm + *                             and
> >> strength.
> >> + * @is_ddr_ok:                 Is this nand an ONFI nand or a TOGGLE
> >> nand ? + */
> >> +struct nand_attr {
> >> +	/* Technology */
> >> +	enum nand_device_cell_technology  cell_technology;
> >> +
> >> +	/* Geometry */
> >> +	uint64_t	chip_size_in_bytes;
> >> +	uint32_t	block_size_in_pages;
> >> +	uint32_t	page_total_size_in_bytes;
> >> +
> >> +	/* ECC */
> >> +	uint16_t	ecc_size_in_bytes;
> >> +	uint16_t	ecc_strength_in_bits;
> >> +
> >> +	/* Does the nand support DDR? (ONFI or TOGGLE) */
> >> +	bool		is_ddr_ok;
> >> +};
> > 
> > The generic NAND code already supports reading a NAND chip ONFI page, and
> > will return the supported ONFI page, you can get all of these parameters
> > from it, no need to have this duplicated in your driver.
> 
> Yes.  But the generic code dose not support the TOGGLE nand now.
> 
> But I think you are right, maybe I should remove the code now.

I think so, and while using generic code, take advantage of that rework to 
introduce TOGGLE support in a generic manner.

> 
> >> +
> >> +/**
> >> + * This structure contains the fundamental timing attributes for NAND.
> >> + *
> >> + * @data_setup_in_ns:         The data setup time, in nanoseconds.
> >> Usually the + *                            maximum of tDS and tWP. A
> >> negative value + *                            indicates this
> >> characteristic isn't known. + * @data_hold_in_ns:          The data
> >> hold time, in nanoseconds. Usually the + *                           
> >> maximum of tDH, tWH and tREH. A negative value + *                     
> >>       indicates this
> >> characteristic isn't known. + * @address_setup_in_ns:      The address
> >> setup time, in nanoseconds. Usually + *                            the
> >> maximum of tCLS, tCS and tALS. A negative + *
> >> value indicates this characteristic isn't known. + *
> >> @gpmi_sample_delay_in_ns:  A GPMI-specific timing parameter. A negative
> >> value + *                            indicates this characteristic isn't
> >> known. + * @tREA_in_ns:               tREA, in nanoseconds, from the
> >> data sheet. A + *                            negative value indicates
> >> this characteristic isn't + *                            known.
> >> + * @tRLOH_in_ns:              tRLOH, in nanoseconds, from the data
> >> sheet. A + *                            negative value indicates this
> >> characteristic isn't + *                            known.
> >> + * @tRHOH_in_ns:              tRHOH, in nanoseconds, from the data
> >> sheet. A + *                            negative value indicates this
> >> characteristic isn't + *                            known.
> >> + */
> >> +struct nand_timing {
> >> +	int8_t  data_setup_in_ns;
> >> +	int8_t  data_hold_in_ns;
> >> +	int8_t  address_setup_in_ns;
> >> +	int8_t  gpmi_sample_delay_in_ns;
> >> +	int8_t  tREA_in_ns;
> >> +	int8_t  tRLOH_in_ns;
> >> +	int8_t  tRHOH_in_ns;
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
> >> +
> >> +	/* Description */
> >> +	const char		*desc;
> >> +
> >> +	/* attribute*/
> >> +	struct nand_attr	attr;
> >> +
> >> +	/* timing */
> >> +	struct nand_timing	timing;
> >> +};
> >> +
> >> +/* macro for the NAND attribute */
> >> +#define ATTR(_a, _b, _c, _d, _e, _f)			\
> >> +	{						\
> >> +		.cell_technology          = (_a),	\
> >> +		.chip_size_in_bytes       = (_b),	\
> >> +		.block_size_in_pages      = (_c),	\
> >> +		.page_total_size_in_bytes = (_d),	\
> >> +		.ecc_strength_in_bits     = (_e),	\
> >> +		.ecc_size_in_bytes        = (_f),	\
> >> +	}
> >> +
> >> +/* macro for the NAND timing */
> >> +#define TIMING(_a, _b, _c, _d, _e, _f, _h)		\
> >> +	{						\
> >> +		.data_setup_in_ns         = (_a),	\
> >> +		.data_hold_in_ns          = (_b),	\
> >> +		.address_setup_in_ns      = (_c),	\
> >> +		.gpmi_sample_delay_in_ns  = (_d),	\
> >> +		.tREA_in_ns               = (_e),	\
> >> +		.tRLOH_in_ns              = (_f),	\
> >> +		.tRHOH_in_ns              = (_h),	\
> >> +	}
> >> +
> >> +struct nand_device_info *nand_device_get_info(const uint8_t
> >> id_bytes[]); +void nand_device_print_info(struct nand_device_info
> >> *info);
> >> +
> >> +/*
> >> + * Check the NAND whether it supports the DDR mode.
> >> + * Only the ONFI nand and TOGGLE nand support the DDR now.
> >> + */
> >> +static inline bool is_ddr_nand(struct nand_device_info *info)
> >> +{
> >> +	return info->attr.is_ddr_ok;
> >> +}
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
