From: b32955@freescale.com (Huang Shijie)
Date: Wed, 23 Mar 2011 11:41:25 +0800
Subject: [PATCH 2/7] add the common code for GPMI driver
In-Reply-To: <19848.38860.624803.339369@ipc1.ka-ro>
References: <1300239773-4222-1-git-send-email-b32955@freescale.com>	<1300239773-4222-3-git-send-email-b32955@freescale.com>
	<19848.38860.624803.339369@ipc1.ka-ro>
Message-ID: <4D896BE5.7030208@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi:

>> +
>> +static int acquire_register_block(struct gpmi_nfc_data *this,
>> +			const char *resource_name, void **reg_block_base)
>> +{
>> +	struct platform_device  *pdev = this->pdev;
>> +	struct resource         *r;
>> +	void                    *p;
>> +
>> +	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, resource_name);
>> +	if (!r) {
>> +		log("Can't get resource information for '%s'", resource_name);
>> +		return -ENXIO;
>> +	}
>> +
>> +	/* remap the register block */
>> +	p = ioremap(r->start, r->end - r->start + 1);
>                                ^^^^^^^^^^^^^^^^^^^^^
> resource_size(r)
>
thanks.

>
>> +static int acquire_interrupt(struct gpmi_nfc_data *this,
>> +			const char *resource_name,
>> +			irq_handler_t interrupt_handler, int *lno, int *hno)
>> +{
>> +	struct platform_device  *pdev = this->pdev;
>> +	struct resource         *r;
>> +	int                     err = 0;
>>
> Useless initialization.
>
ok.
>> +	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ, resource_name);
>> +	if (!r) {
>> +		log("Can't get resource information for '%s'", resource_name);
>> +		return -ENXIO;
>> +	}
>> +
>> +	BUG_ON(r->start != r->end);
>> +	err = request_irq(r->start, interrupt_handler, 0, resource_name, this);
>> +	if (err) {
>> +		log("Can't own %s", resource_name);
>> +		return -EIO;
>>
> Promote the error code from request_irq().
>
thanks.
>> +	}
>> +
>> +	*lno = r->start;
>> +	*hno = r->end;
>> +	return 0;
>> +}
>> +
>> +static void release_interrupt(struct gpmi_nfc_data *this,
>> +			int low_interrupt_number, int high_interrupt_number)
>> +{
>> +	int i;
>> +	for (i = low_interrupt_number; i<= high_interrupt_number; i++)
>> +		free_irq(i, this);
>> +}
>> +
>>
>> +
>> +static void release_dma_channels(struct gpmi_nfc_data *this)
>> +{
>> +	unsigned int   i;
>> +	for (i = 0; i<= DMA_CHANS; i++)
>>
> Obiwan error! should be 'i<  DMA_CHANS'
>
  thanks a lot!
>> +		if (this->dma_chans[i]) {
>> +			dma_release_channel(this->dma_chans[i]);
>> +			this->dma_chans[i] = NULL;
>> +		}
>> +}
>> +
>>
>> +static inline int acquire_clock(struct gpmi_nfc_data *this,
>> +			const char *clock_name, struct clk **clock)
>> +{
>> +	struct clk *c;
>> +
>> +	c = clk_get(this->dev, clock_name);
>> +	if (IS_ERR(c)) {
>> +		log("Can't own clock %s", clock_name);
>> +		return PTR_ERR(c);
>> +	}
>> +	*clock = c;
>> +	return 0;
>> +}
>> +
>> +static void release_clock(struct gpmi_nfc_data *this, struct clk *clock)
>> +{
>> +	clk_disable(clock);
>>
> Unbalanced clk_disable().
thanks.
>> +	clk_put(clock);
>> +}
>> +
>> +static int acquire_resources(struct gpmi_nfc_data *this)
>> +{
>> +	struct gpmi_nfc_platform_data  *pdata     =  this->pdata;
>> +	struct resources               *resources =&this->resources;
>> +	int                            error      = 0;
>>
> Useless initialization.
ok.
>> +
>> +	/* Attempt to acquire our clock. */
>> +	error = acquire_clock(this, pdata->clock_name,&resources->clock);
>>
> Abuse of the clock API. Don't pass clock names via platform_data.
>
thanks, I will change it in next version.
>> +static int set_up_nfc_hal(struct gpmi_nfc_data *this)
>> +{
>> +	struct gpmi_nfc_platform_data  *pdata = this->pdata;
>> +	struct nfc_hal                 *nfc;
>> +	int                            error = 0;
>>
> Useless initialization.
>
>> +	/*
>> +	 * This structure contains the "safe" GPMI timing that should succeed
>> +	 * with any NAND Flash device
>> +	 * (although, with less-than-optimal performance).
>> +	 */
>> +	static struct nand_timing  safe_timing = {
>> +		.data_setup_in_ns        = 80,
>> +		.data_hold_in_ns         = 60,
>> +		.address_setup_in_ns     = 25,
>> +		.gpmi_sample_delay_in_ns =  6,
>> +		.tREA_in_ns              = -1,
>> +		.tRLOH_in_ns             = -1,
>> +		.tRHOH_in_ns             = -1,
>> +	};
>> +
>> +	switch (pdata->chip_version) {
>> +	case CHIP_VERSION_IMX23:
>> +		nfc =&gpmi_nfc_hal_imx23;
>> +		break;
>> +	case CHIP_VERSION_IMX28:
>> +		nfc =&gpmi_nfc_hal_imx28;
>> +		break;
>> +	default:
>> +		log("Unkown NFC version %u", pdata->chip_version);
>> +		return -ENXIO;
>> +	}
>>
> Use platform_ids to distinguish between HW variants.
>
ok.
>> +
>> +	this->nfc = nfc;
>> +
>> +	/* Initialize the NFC HAL. */
>> +	error = nfc->init(this);
>> +	if (error)
>> +		return error;
>> +
>> +	/* Set up safe timing. */
>> +	nfc->set_timing(this,&safe_timing);
>> +	return 0;
>> +}
>> +
>> +static int set_up_boot_rom_helper(struct gpmi_nfc_data *this)
>> +{
>> +	struct gpmi_nfc_platform_data  *pdata = this->pdata;
>> +	struct boot_rom_helper         *rom;
>> +
>> +	switch (pdata->chip_version) {
>> +	case CHIP_VERSION_IMX23:
>> +		rom =&gpmi_nfc_boot_rom_imx23;
>> +		break;
>> +	case CHIP_VERSION_IMX28:
>> +		rom =&gpmi_nfc_boot_rom_imx28;
>> +		break;
>> +	default:
>> +		log("Unkown NFC version %u", pdata->chip_version);
>> +		return -ENXIO;
>> +	}
>> +
>> +	pr_info("Boot ROM: Version %u, %s\n", rom->version, rom->description);
>> +	this->rom = rom;
>> +	return 0;
>> +}
>> +
>> +/* Creates/Removes sysfs files for this device.*/
>> +static void manage_sysfs_files(struct gpmi_nfc_data *this, int create)
>> +{
>> +	struct device            *dev = this->dev;
>> +	int                      error;
>> +	unsigned int             i;
>> +	struct device_attribute  **attr;
>> +
>> +	for (i = 0, attr = device_attributes;
>> +			i<  ARRAY_SIZE(device_attributes); i++, attr++) {
>> +
>> +		if (create) {
>> +			error = device_create_file(dev, *attr);
>> +			if (error) {
>> +				while (--attr>= device_attributes)
>> +					device_remove_file(dev, *attr);
>> +				return;
>> +			}
>> +		} else {
>> +			device_remove_file(dev, *attr);
>> +		}
>> +	}
>> +}
>> +
>> +static int gpmi_nfc_probe(struct platform_device *pdev)
>> +{
>> +	struct gpmi_nfc_platform_data  *pdata = pdev->dev.platform_data;
>> +	struct gpmi_nfc_data           *this  = 0;
>> +	int                            error  = 0;
>>
> Useless initialization (NB: pointers are initialized with 'NULL' not
> '0').
>
thanks.

I have already changed a lot, but i missed this one.
>> +/* This structure represents this driver to the platform management system. */
>> +static struct platform_driver gpmi_nfc_driver = {
>> +	.driver = {
>> +		.name = GPMI_NFC_DRIVER_NAME,
>> +	},
>> +	.probe   = gpmi_nfc_probe,
>> +	.remove  = __exit_p(gpmi_nfc_remove),
>> +	.suspend = gpmi_nfc_suspend,
>> +	.resume  = gpmi_nfc_resume,
>> +};
>> +
>> +static int __init gpmi_nfc_init(void)
>> +{
>> +	printk(KERN_INFO "GPMI NFC driver registered. (IMX)\n");
>> +	if (platform_driver_register(&gpmi_nfc_driver) != 0) {
>> +		pr_err("i.MX GPMI NFC driver registration failed\n");
>> +		return -ENODEV;
>>
> Promote the error code from platform_driver_register().
>
ok
>> +	}
>> +	return 0;
>> +}
>> +
>> +static void __exit gpmi_nfc_exit(void)
>> +{
>> +	platform_driver_unregister(&gpmi_nfc_driver);
>> +}
>> +
>> +module_init(gpmi_nfc_init);
>> +module_exit(gpmi_nfc_exit);
>> +
>> +MODULE_AUTHOR("Freescale Semiconductor, Inc.");
>> +MODULE_DESCRIPTION("i.MX GPMI NAND Flash Controller Driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/mtd/nand/gpmi-nfc/gpmi-nfc.h b/drivers/mtd/nand/gpmi-nfc/gpmi-nfc.h
>> new file mode 100644
>> index 0000000..b5a2d77
>> --- /dev/null
>> +++ b/drivers/mtd/nand/gpmi-nfc/gpmi-nfc.h
>> @@ -0,0 +1,520 @@
>> +/*
>> + * Freescale GPMI NFC NAND Flash Driver
>> + *
>> + * Copyright (C) 2010-2011 Freescale Semiconductor, Inc.
>> + * Copyright (C) 2008 Embedded Alley Solutions, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along
>> + * with this program; if not, write to the Free Software Foundation, Inc.,
>> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> + */
>> +
>> +#ifndef __DRIVERS_MTD_NAND_GPMI_NFC_H
>> +#define __DRIVERS_MTD_NAND_GPMI_NFC_H
>> +
>> +/* Linux header files. */
>> +#include<linux/err.h>
>> +#include<linux/init.h>
>> +#include<linux/module.h>
>> +#include<linux/io.h>
>> +#include<linux/interrupt.h>
>> +#include<linux/clk.h>
>> +#include<linux/delay.h>
>> +#include<linux/platform_device.h>
>> +#include<linux/dma-mapping.h>
>> +#include<linux/mtd/mtd.h>
>> +#include<linux/mtd/nand.h>
>> +#include<linux/mtd/partitions.h>
>> +#include<linux/mtd/concat.h>
>> +#include<linux/dmaengine.h>
>> +#include<asm/sizes.h>
>> +
>> +/* Platform header files. */
>> +#include<mach/mxs.h>
>> +#include<mach/common.h>
>> +#include<mach/dma.h>
>> +#include<mach/gpmi-nfc.h>
>> +#include<mach/system.h>
>> +#include<mach/clock.h>
>> +
>> +/* Driver header files. */
>> +#include "nand_device_info.h"
>> +
>> +/*
>> + *------------------------------------------------------------------------------
>> + * Fundamental Data Structures
>> + *------------------------------------------------------------------------------
>> + */
>> +
>> +/**
>> + * struct resources - The collection of resources the driver needs.
>> + *
>> + * @gpmi_regs:         A pointer to the GPMI registers.
>> + * @bch_regs:          A pointer to the BCH registers.
>> + * @bch_interrupt:     The BCH interrupt number.
>> + * @dma_low_channel:   The low  DMA channel.
>> + * @dma_high_channel:  The high DMA channel.
>> + * @clock:             A pointer to the struct clk for the NFC's clock.
>> + */
>> +struct resources {
>> +	void          *gpmi_regs;
>> +	void          *bch_regs;
>> +	unsigned int  bch_low_interrupt;
>> +	unsigned int  bch_high_interrupt;
>> +	unsigned int  dma_low_channel;
>> +	unsigned int  dma_high_channel;
>> +	struct clk    *clock;
>> +};
>> +
>> +/**
>> + * struct mil - State for the MTD Interface Layer.
>> + *
>> + * @nand:                    The NAND Flash MTD data structure that represents
>> + *                           the NAND Flash medium.
>> + * @mtd:                     The MTD data structure that represents the NAND
>> + *                           Flash medium.
>> + * @oob_layout:              A structure that describes how bytes are laid out
>> + *                           in the OOB.
>> + * @general_use_mtd:         A pointer to an MTD we export for general use.
>> + *                           This *may* simply be a pointer to the mtd field, if
>> + *                           we've been instructed NOT to protect the boot
>> + *                           areas.
>> + * @partitions:              A pointer to a set of partitions applied to the
>> + *                           general use MTD.
>> + * @partition_count:         The number of partitions.
>> + * @current_chip:            The chip currently selected by the NAND Fash MTD
>> + *                           code. A negative value indicates that no chip is
>> + *                           selected.
>> + * @command_length:          The length of the command that appears in the
>> + *                           command buffer (see cmd_virt, below).
>> + * @ignore_bad_block_marks:  Indicates we are ignoring bad block marks.
>> + * @saved_bbt:               A saved pointer to the in-memory NAND Flash MTD bad
>> + *                           block table. See show_device_ignorebad() for more
>> + *                           details.
>> + * @marking_a_bad_block:     Indicates the caller is marking a bad block. See
>> + *                           mil_ecc_write_oob() for details.
>> + * @hooked_block_markbad:    A pointer to the block_markbad() function we
>> + *                           we "hooked." See mil_ecc_write_oob() for details.
>> + * @upper_buf:               The buffer passed from upper layer.
>> + * @upper_len:               The buffer len passed from upper layer.
>> + * @direct_dma_map_ok:       Is the direct DMA map is good for the upper_buf?
>> + * @cmd_sgl/cmd_buffer:      For NAND command.
>> + * @data_sgl/data_buffer_dma:For NAND DATA ops.
>> + * @page_buffer_virt:        A pointer to a DMA-coherent buffer we use for
>> + *                           reading and writing pages. This buffer includes
>> + *                           space for both the payload data and the auxiliary
>> + *                           data (including status bytes, but not syndrome
>> + *                           bytes).
>> + * @page_buffer_phys:        The physical address for the page_buffer_virt
>> + *                           buffer.
>> + * @page_buffer_size:        The size of the page buffer.
>> + * @payload_virt:            A pointer to a location in the page buffer used
>> + *                           for payload bytes. The size of this buffer is
>> + *                           determined by struct nfc_geometry.
>> + * @payload_phys:            The physical address for payload_virt.
>> + * @auxiliary_virt:          A pointer to a location in the page buffer used
>> + *                           for auxiliary bytes. The size of this buffer is
>> + *                           determined by struct nfc_geometry.
>> + * @auxiliary_phys:          The physical address for auxiliary_virt.
>> + */
>> +struct mil {
>> +	/* MTD Data Structures */
>> +	struct nand_chip       nand;
>> +	struct mtd_info        mtd;
>> +	struct nand_ecclayout  oob_layout;
>> +
>> +	/* Partitioning and Boot Area Protection */
>> +	struct mtd_info        *general_use_mtd;
>> +	struct mtd_partition   *partitions;
>> +	unsigned int           partition_count;
>> +
>> +	/* General-use Variables */
>> +	int                    current_chip;
>> +	unsigned int           command_length;
>> +	int                    ignore_bad_block_marks;
>> +	void                   *saved_bbt;
>> +
>> +	/* MTD Function Pointer Hooks */
>> +	int                    marking_a_bad_block;
>> +	int                    (*hooked_block_markbad)(struct mtd_info *mtd,
>> +					loff_t ofs);
>> +
>> +	/* from upper layer */
>> +	uint8_t			*upper_buf;
>> +	int			upper_len;
>> +
>> +	/* DMA */
>> +	bool			direct_dma_map_ok;
>> +
>> +	struct scatterlist	cmd_sgl;
>> +	char			*cmd_buffer;
>> +
>> +	struct scatterlist	data_sgl;
>> +	char			*data_buffer_dma;
>> +
>> +	void                   *page_buffer_virt;
>> +	dma_addr_t             page_buffer_phys;
>> +	unsigned int           page_buffer_size;
>> +
>> +	void                   *payload_virt;
>> +	dma_addr_t             payload_phys;
>> +
>> +	void                   *auxiliary_virt;
>> +	dma_addr_t             auxiliary_phys;
>> +};
>>
> IMO this struct should be removed and the members integrated into the
> struct gpmi_nfc_data.
>
>> +
>> +/**
>> + * struct nfc_geometry - NFC geometry description.
>> + *
>> + * This structure describes the NFC's view of the medium geometry.
>> + *
>> + * @ecc_algorithm:            The human-readable name of the ECC algorithm
>> + *                            (e.g., "Reed-Solomon" or "BCH").
>> + * @ecc_strength:             A number that describes the strength of the ECC
>> + *                            algorithm.
>> + * @page_size_in_bytes:       The size, in bytes, of a physical page, including
>> + *                            both data and OOB.
>> + * @metadata_size_in_bytes:   The size, in bytes, of the metadata.
>> + * @ecc_chunk_size_in_bytes:  The size, in bytes, of a single ECC chunk. Note
>> + *                            the first chunk in the page includes both data and
>> + *                            metadata, so it's a bit larger than this value.
>> + * @ecc_chunk_count:          The number of ECC chunks in the page,
>> + * @payload_size_in_bytes:    The size, in bytes, of the payload buffer.
>> + * @auxiliary_size_in_bytes:  The size, in bytes, of the auxiliary buffer.
>> + * @auxiliary_status_offset:  The offset into the auxiliary buffer at which
>> + *                            the ECC status appears.
>> + * @block_mark_byte_offset:   The byte offset in the ECC-based page view at
>> + *                            which the underlying physical block mark appears.
>> + * @block_mark_bit_offset:    The bit offset into the ECC-based page view at
>> + *                            which the underlying physical block mark appears.
>> + */
>> +struct nfc_geometry {
>> +	char          *ecc_algorithm;
>> +	unsigned int  ecc_strength;
>> +	unsigned int  page_size_in_bytes;
>> +	unsigned int  metadata_size_in_bytes;
>> +	unsigned int  ecc_chunk_size_in_bytes;
>> +	unsigned int  ecc_chunk_count;
>> +	unsigned int  payload_size_in_bytes;
>> +	unsigned int  auxiliary_size_in_bytes;
>> +	unsigned int  auxiliary_status_offset;
>> +	unsigned int  block_mark_byte_offset;
>> +	unsigned int  block_mark_bit_offset;
>> +};
> Most of these parameters are already available in the mtd_info
> structure. No need to duplicate them here!
I will remove some ones.
>> +
>> +/**
>> + * struct boot_rom_geometry - Boot ROM geometry description.
>> + *
>> + * This structure encapsulates decisions made by the Boot ROM Helper.
>> + *
>> + * @boot_area_count:             The number of boot areas. The first boot area
>> + *                               appears at the beginning of chip 0, the next
>> + *                               at the beginning of chip 1, etc.
>> + * @boot_area_size_in_bytes:     The size, in bytes, of each boot area.
>> + * @stride_size_in_pages:        The size of a boot block stride, in pages.
>> + * @search_area_stride_exponent: The logarithm to base 2 of the size of a
>> + *                               search area in boot block strides.
>> + */
>> +struct boot_rom_geometry {
>> +	unsigned int  boot_area_count;
>> +	unsigned int  boot_area_size_in_bytes;
>> +	unsigned int  stride_size_in_pages;
>> +	unsigned int  search_area_stride_exponent;
>> +};
>>
> IMO the whole boot_rom stuff should not be part of an mtd chip driver,
> but has its place in the mtd partition handlers.
>
I have explained this in preview email. thanks
>> +/* Can we use the upper's buffer directly for DMA? */
>> +void prepare_data_dma(struct gpmi_nfc_data *this, enum dma_data_direction dr)
>> +{
>> +	struct mil *mil =&this->mil;
>> +	struct scatterlist *sgl =&mil->data_sgl;
>> +	int ret = 0;
>> +
>> +	mil->direct_dma_map_ok = true;
>> +
>> +	/* first try to map the upper buffer directly */
>> +	sg_init_one(sgl, mil->upper_buf, mil->upper_len);
>> +	ret = dma_map_sg(this->dev, sgl, 1, dr);
>> +	if (ret == 0) {
>> +		/* We have to use our own DMA buffer. */
>> +		sg_init_one(sgl, mil->data_buffer_dma, PAGE_SIZE);
>> +		ret = dma_map_sg(this->dev, sgl, 1, dr);
>> +		BUG_ON(ret == 0);
>> +
>> +		if (dr == DMA_TO_DEVICE)
>> +			memcpy(mil->data_buffer_dma, mil->upper_buf,
>> +				mil->upper_len);
>> +		mil->direct_dma_map_ok = false;
>> +	}
>> +	sgl->length = mil->upper_len;
>>
> This has already been done by sg_init_one().
>
thanks.
>> +}
>> +
>> +/* This will be called after the DMA operation is finished. */
>> +static void dma_irq_callback(void *param)
>> +{
>> +	struct gpmi_nfc_data *this = param;
>> +	struct nfc_hal *nfc = this->nfc;
>> +	struct mil *mil =&this->mil;
>> +
>> +	complete(&nfc->dma_done);
>> +
>> +	switch (this->dma_type) {
>> +	case DMA_FOR_COMMAND:
>> +		dma_unmap_sg(this->dev,&mil->cmd_sgl, 1, DMA_TO_DEVICE);
>> +		break;
>> +
>> +	case DMA_FOR_READ_DATA:
>> +		if (mil->direct_dma_map_ok == false)
>> +			memcpy(mil->upper_buf, (char *)mil->data_buffer_dma,
>> +				mil->upper_len);
>> +		dma_unmap_sg(this->dev,&mil->data_sgl, 1, DMA_FROM_DEVICE);
>> +		break;
>> +
>> +	case DMA_FOR_WRITE_DATA:
>> +		dma_unmap_sg(this->dev,&mil->data_sgl, 1, DMA_TO_DEVICE);
>> +		break;
>> +
>> +	case DMA_FOR_READ_ECC_PAGE:
>> +	case DMA_FOR_WRITE_ECC_PAGE:
>> +		break;
>> +
>> +	default:
>> +		BUG();
>> +	}
>> +}
>> +
>>
>> +static uint8_t mil_read_byte(struct mtd_info *mtd)
>> +{
>> +	uint8_t  byte = 0;
>> +	mil_read_buf(mtd, (uint8_t *)&byte, 1);
>>
> With CONFIG_DMA_API_DEBUG enabled this would blow up right in your
> face:
> |gpmi-nfc gpmi-nfc: DMA-API: device driver maps memory fromstack [addr=c732bd3f]
>
Thanks a lot.
>> +	return byte;
>> +}
>> +
>> +/**
>> + * mil_handle_block_mark_swapping() - Handles block mark swapping.
>> + *
>> + * Note that, when this function is called, it doesn't know whether it's
>> + * swapping the block mark, or swapping it *back* -- but it doesn't matter
>> + * because the the operation is the same.
>> + *
>> + * @this:       Per-device data.
>> + * @payload:    A pointer to the payload buffer.
>> + * @auxiliary:  A pointer to the auxiliary buffer.
>> + */
>> +static void mil_handle_block_mark_swapping(struct gpmi_nfc_data *this,
>> +						void *payload, void *auxiliary)
>> +{
>> +	struct nfc_geometry     *nfc_geo =&this->nfc_geometry;
>> +	struct boot_rom_helper  *rom     =  this->rom;
>> +	unsigned char           *p;
>> +	unsigned char           *a;
>> +	unsigned int            bit;
>> +	unsigned char           mask;
>> +	unsigned char           from_data;
>> +	unsigned char           from_oob;
>> +
>> +	/* Check if we're doing block mark swapping. */
>> +	if (!rom->swap_block_mark)
>> +		return;
>> +
>> +	/*
>> +	 * If control arrives here, we're swapping. Make some convenience
>> +	 * variables.
>> +	 */
>> +	bit = nfc_geo->block_mark_bit_offset;
>> +	p   = ((unsigned char *) payload) + nfc_geo->block_mark_byte_offset;
>>
> Useless cast.
ok.
>> +	a   = auxiliary;
>> +
>> +	/*
>> +	 * Get the byte from the data area that overlays the block mark. Since
>> +	 * the ECC engine applies its own view to the bits in the page, the
>> +	 * physical block mark won't (in general) appear on a byte boundary in
>> +	 * the data.
>> +	 */
>> +	from_data = (p[0]>>  bit) | (p[1]<<  (8 - bit));
>> +
>> +	/* Get the byte from the OOB. */
>> +	from_oob = a[0];
>> +
>> +	/* Swap them. */
>> +	a[0] = from_data;
>> +
>> +	mask = (0x1<<  bit) - 1;
>> +	p[0] = (p[0]&  mask) | (from_oob<<  bit);
>> +
>> +	mask = ~0<<  bit;
>> +	p[1] = (p[1]&  mask) | (from_oob>>  (8 - bit));
>> +}
>> +
>> +static int mil_ecc_read_page(struct mtd_info *mtd, struct nand_chip *nand,
>> +				uint8_t *buf, int page)
>> +{
>> +	struct gpmi_nfc_data    *this    = nand->priv;
>> +	struct nfc_hal          *nfc     =  this->nfc;
>> +	struct nfc_geometry     *nfc_geo =&this->nfc_geometry;
>> +	struct mil              *mil     =&this->mil;
>> +	void                    *payload_virt   =  0;
>> +	dma_addr_t              payload_phys    = ~0;
>> +	void                    *auxiliary_virt =  0;
>> +	dma_addr_t              auxiliary_phys  = ~0;
> Useless initialization.
>
ok.
>> +	unsigned int            i;
>> +	unsigned char           *status;
>> +	unsigned int            failed;
>> +	unsigned int            corrected;
>> +	int                     error = 0;
>> +
> Dto.
>
>> +	error = read_page_prepare(this, buf, mtd->writesize,
>> +					mil->payload_virt, mil->payload_phys,
>> +					nfc_geo->payload_size_in_bytes,
>> +					&payload_virt,&payload_phys);
>> +	if (error) {
>> +		log("Inadequate DMA buffer");
>> +		error = -ENOMEM;
>> +		return error;
>> +	}
>> +	auxiliary_virt = mil->auxiliary_virt;
>> +	auxiliary_phys = mil->auxiliary_phys;
>> +
>> +	/* ask the NFC */
>> +	error = nfc->read_page(this, payload_phys, auxiliary_phys);
>> +	if (error) {
>> +		log("Error in ECC-based read: %d", error);
>> +		goto exit_nfc;
>> +	}
>> +
>> +	/* handle the block mark swapping */
>> +	mil_handle_block_mark_swapping(this, payload_virt, auxiliary_virt);
>> +
>> +	/* Loop over status bytes, accumulating ECC status. */
>> +	failed		= 0;
>> +	corrected	= 0;
>> +	status		= ((unsigned char *) auxiliary_virt) +
>> +					nfc_geo->auxiliary_status_offset;
>>
> Useless cast.
>> +
>> +	for (i = 0; i<  nfc_geo->ecc_chunk_count; i++, status++) {
>> +		if ((*status == STATUS_GOOD) || (*status == STATUS_ERASED))
>> +			continue;
>> +
>> +		if (*status == STATUS_UNCORRECTABLE) {
>> +			failed++;
>> +			continue;
>> +		}
>> +		corrected += *status;
>> +	}
>> +
>> +	/*
>> +	 * Propagate ECC status to the owning MTD only when failed or
>> +	 * corrected times nearly reaches our ECC correction threshold.
>> +	 */
>> +	if (failed || corrected>= (nfc_geo->ecc_strength - 1)) {
>> +		mtd->ecc_stats.failed    += failed;
>> +		mtd->ecc_stats.corrected += corrected;
>> +	}
>> +
>> +	/*
>> +	 * It's time to deliver the OOB bytes. See mil_ecc_read_oob() for
>> +	 * details about our policy for delivering the OOB.
>> +	 *
>> +	 * We fill the caller's buffer with set bits, and then copy the block
>> +	 * mark to th caller's buffer. Note that, if block mark swapping was
>> +	 * necessary, it has already been done, so we can rely on the first
>> +	 * byte of the auxiliary buffer to contain the block mark.
>> +	 */
>> +	memset(nand->oob_poi, ~0, mtd->oobsize);
>> +	nand->oob_poi[0] = ((uint8_t *) auxiliary_virt)[0];
>> +
>> +exit_nfc:
>> +	read_page_end(this, buf, mtd->writesize,
>> +					mil->payload_virt, mil->payload_phys,
>> +					nfc_geo->payload_size_in_bytes,
>> +					payload_virt, payload_phys);
>> +	return error;
>> +}
>> +
>> +static void mil_ecc_write_page(struct mtd_info *mtd,
>> +				struct nand_chip *nand, const uint8_t *buf)
>> +{
>> +	struct gpmi_nfc_data    *this    = nand->priv;
>> +	struct nfc_hal          *nfc     =  this->nfc;
>> +	struct nfc_geometry     *nfc_geo =&this->nfc_geometry;
>> +	struct boot_rom_helper  *rom     =  this->rom;
>> +	struct mil              *mil     =&this->mil;
>> +	const void              *payload_virt   =  0;
>> +	dma_addr_t              payload_phys    = ~0;
>> +	const void              *auxiliary_virt =  0;
>> +	dma_addr_t              auxiliary_phys  = ~0;
>>
> Useless initialization.
>
>> +	int                     error;
>> +
>> +	if (rom->swap_block_mark) {
>> +		/*
>> +		 * If control arrives here, we're doing block mark swapping.
>> +		 * Since we can't modify the caller's buffers, we must copy them
>> +		 * into our own.
>> +		 */
>> +		memcpy(mil->payload_virt, buf, mtd->writesize);
>> +		payload_virt = mil->payload_virt;
>> +		payload_phys = mil->payload_phys;
>> +
>> +		memcpy(mil->auxiliary_virt, nand->oob_poi,
>> +				nfc_geo->auxiliary_size_in_bytes);
>> +		auxiliary_virt = mil->auxiliary_virt;
>> +		auxiliary_phys = mil->auxiliary_phys;
>> +
>> +		/* Handle block mark swapping. */
>> +		mil_handle_block_mark_swapping(this,
>> +				(void *) payload_virt, (void *) auxiliary_virt);
>> +	} else {
>> +		/*
>> +		 * If control arrives here, we're not doing block mark swapping,
>> +		 * so we can to try and use the caller's buffers.
>> +		 */
>> +		error = send_page_prepare(this,
>> +				buf, mtd->writesize,
>> +				mil->payload_virt, mil->payload_phys,
>> +				nfc_geo->payload_size_in_bytes,
>> +				&payload_virt,&payload_phys);
>> +		if (error) {
>> +			log("Inadequate payload DMA buffer");
>> +			return;
>> +		}
>> +
>> +		error = send_page_prepare(this,
>> +				nand->oob_poi, mtd->oobsize,
>> +				mil->auxiliary_virt, mil->auxiliary_phys,
>> +				nfc_geo->auxiliary_size_in_bytes,
>> +				&auxiliary_virt,&auxiliary_phys);
>> +		if (error) {
>> +			log("Inadequate auxiliary DMA buffer");
>> +			goto exit_auxiliary;
>> +		}
>> +	}
>> +
>> +	/* Ask the NFC. */
>> +	error = nfc->send_page(this, payload_phys, auxiliary_phys);
>> +	if (error)
>> +		log("Error in ECC-based write: %d", error);
>> +
>> +	if (!rom->swap_block_mark) {
>> +		send_page_end(this, nand->oob_poi, mtd->oobsize,
>> +				mil->auxiliary_virt, mil->auxiliary_phys,
>> +				nfc_geo->auxiliary_size_in_bytes,
>> +				auxiliary_virt, auxiliary_phys);
>> +exit_auxiliary:
>> +		send_page_end(this, buf, mtd->writesize,
>> +				mil->payload_virt, mil->payload_phys,
>> +				nfc_geo->payload_size_in_bytes,
>> +				payload_virt, payload_phys);
>> +	}
>> +}
>> +
>> +/**
>> + * mil_hook_block_markbad() - Hooked MTD Interface block_markbad().
>> + *
>> + * This function is a veneer that replaces the function originally installed by
>> + * the NAND Flash MTD code. See the description of the marking_a_bad_block field
>> + * in struct mil for more information about this.
>> + *
>> + * @mtd:  A pointer to the MTD.
>> + * @ofs:  Byte address of the block to mark.
>> + */
>> +static int mil_hook_block_markbad(struct mtd_info *mtd, loff_t ofs)
>> +{
>> +	register struct nand_chip  *chip = mtd->priv;
>> +	struct gpmi_nfc_data       *this = chip->priv;
>> +	struct mil                 *mil  =&this->mil;
>> +	int                        ret;
>> +
>> +	mil->marking_a_bad_block = true;
>> +	ret = mil->hooked_block_markbad(mtd, ofs);
>> +	mil->marking_a_bad_block = false;
>> +	return ret;
>> +}
>> +
>> +/**
>> + * mil_ecc_read_oob() - MTD Interface ecc.read_oob().
>> + *
>> + * There are several places in this driver where we have to handle the OOB and
>> + * block marks. This is the function where things are the most complicated, so
>> + * this is where we try to explain it all. All the other places refer back to
>> + * here.
>> + *
>> + * These are the rules, in order of decreasing importance:
>> + *
>> + * 1) Nothing the caller does can be allowed to imperil the block mark, so all
>> + *    write operations take measures to protect it.
>> + *
>> + * 2) In read operations, the first byte of the OOB we return must reflect the
>> + *    true state of the block mark, no matter where that block mark appears in
>> + *    the physical page.
>> + *
>> + * 3) ECC-based read operations return an OOB full of set bits (since we never
>> + *    allow ECC-based writes to the OOB, it doesn't matter what ECC-based reads
>> + *    return).
>> + *
>> + * 4) "Raw" read operations return a direct view of the physical bytes in the
>> + *    page, using the conventional definition of which bytes are data and which
>> + *    are OOB. This gives the caller a way to see the actual, physical bytes
>> + *    in the page, without the distortions applied by our ECC engine.
>> + *
>> + *
>> + * What we do for this specific read operation depends on two questions:
>> + *
>> + * 1) Are we doing a "raw" read, or an ECC-based read?
>> + *
>> + * 2) Are we using block mark swapping or transcription?
>> + *
>> + * There are four cases, illustrated by the following Karnaugh map:
>> + *
>> + *                    |           Raw           |         ECC-based       |
>> + *       -------------+-------------------------+-------------------------+
>> + *                    | Read the conventional   |                         |
>> + *                    | OOB at the end of the   |                         |
>> + *       Swapping     | page and return it. It  |                         |
>> + *                    | contains exactly what   |                         |
>> + *                    | we want.                | Read the block mark and |
>> + *       -------------+-------------------------+ return it in a buffer   |
>> + *                    | Read the conventional   | full of set bits.       |
>> + *                    | OOB at the end of the   |                         |
>> + *                    | page and also the block |                         |
>> + *       Transcribing | mark in the metadata.   |                         |
>> + *                    | Copy the block mark     |                         |
>> + *                    | into the first byte of  |                         |
>> + *                    | the OOB.                |                         |
>> + *       -------------+-------------------------+-------------------------+
>> + *
>> + * Note that we break rule #4 in the Transcribing/Raw case because we're not
>> + * giving an accurate view of the actual, physical bytes in the page (we're
>> + * overwriting the block mark). That's OK because it's more important to follow
>> + * rule #2.
>> + *
>> + * It turns out that knowing whether we want an "ECC-based" or "raw" read is not
>> + * easy. When reading a page, for example, the NAND Flash MTD code calls our
>> + * ecc.read_page or ecc.read_page_raw function. Thus, the fact that MTD wants an
>> + * ECC-based or raw view of the page is implicit in which function it calls
>> + * (there is a similar pair of ECC-based/raw functions for writing).
>> + *
>> + * Since MTD assumes the OOB is not covered by ECC, there is no pair of
>> + * ECC-based/raw functions for reading or or writing the OOB. The fact that the
>> + * caller wants an ECC-based or raw view of the page is not propagated down to
>> + * this driver.
>> + *
>> + * @mtd:     A pointer to the owning MTD.
>> + * @nand:    A pointer to the owning NAND Flash MTD.
>> + * @page:    The page number to read.
>> + * @sndcmd:  Indicates this function should send a command to the chip before
>> + *           reading the out-of-band bytes. This is only false for small page
>> + *           chips that support auto-increment.
>> + */
>> +static int mil_ecc_read_oob(struct mtd_info *mtd, struct nand_chip *nand,
>> +							int page, int sndcmd)
>> +{
>> +	struct gpmi_nfc_data      *this     = nand->priv;
>> +	struct boot_rom_helper    *rom      =  this->rom;
>> +
>> +	/* clear the OOB buffer */
>> +	memset(nand->oob_poi, ~0, mtd->oobsize);
>> +
>> +	/* Read out the conventional OOB. */
>> +	nand->cmdfunc(mtd, NAND_CMD_READ0, mtd->writesize, page);
>> +	nand->read_buf(mtd, nand->oob_poi, mtd->oobsize);
>> +
>> +	/*
>> +	 * Now, we want to make sure the block mark is correct. In the
>> +	 * Swapping/Raw case, we already have it. Otherwise, we need to
>> +	 * explicitly read it.
>> +	 */
>> +	if (!rom->swap_block_mark) {
>> +		/* Read the block mark into the first byte of the OOB buffer. */
>> +		nand->cmdfunc(mtd, NAND_CMD_READ0, 0, page);
>> +		nand->oob_poi[0] = nand->read_byte(mtd);
>> +	}
>> +
>> +	/*
>> +	 * Return true, indicating that the next call to this function must send
>> +	 * a command.
>> +	 */
>> +	return true;
>> +}
>> +
>> +static int mil_ecc_write_oob(struct mtd_info *mtd,
>> +					struct nand_chip *nand, int page)
>> +{
>> +	struct gpmi_nfc_data      *this     = nand->priv;
>> +	struct device             *dev      =  this->dev;
>> +	struct mil                *mil      =&this->mil;
>> +	struct boot_rom_helper    *rom      =  this->rom;
>> +	uint8_t                   block_mark = 0;
>> +	int                       block_mark_column;
>> +	int                       status;
>> +	int                       error = 0;
>> +
>> +	/*
>> +	 * There are fundamental incompatibilities between the i.MX GPMI NFC and
>> +	 * the NAND Flash MTD model that make it essentially impossible to write
>> +	 * the out-of-band bytes.
>> +	 *
>> +	 * We permit *ONE* exception. If the *intent* of writing the OOB is to
>> +	 * mark a block bad, we can do that.
>> +	 */
>> +	if (!mil->marking_a_bad_block) {
>> +		dev_emerg(dev, "This driver doesn't support writing the OOB\n");
>> +		WARN_ON(1);
>> +		error = -EIO;
>> +		goto exit;
>> +	}
>> +
>> +	/*
>> +	 * If control arrives here, we're marking a block bad. First, figure out
>> +	 * where the block mark is.
>> +	 *
>> +	 * If we're using swapping, the block mark is in the conventional
>> +	 * location. Otherwise, we're using transcription, and the block mark
>> +	 * appears in the first byte of the page.
>> +	 */
>> +	if (rom->swap_block_mark)
>> +		block_mark_column = mtd->writesize;
>> +	else
>> +		block_mark_column = 0;
>> +
>> +	/* Write the block mark. */
>> +	nand->cmdfunc(mtd, NAND_CMD_SEQIN, block_mark_column, page);
>> +	nand->write_buf(mtd,&block_mark, 1);
>>
> DMA mapping memory from stack again.
thanks.
>> +	nand->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
>> +
>> +	status = nand->waitfunc(mtd, nand);
>> +
>> +	/* Check if it worked. */
>> +	if (status&  NAND_STATUS_FAIL)
>> +		error = -EIO;
>> +exit:
>> +	return error;
>> +}
>> +
>> +/**
>> + * mil_block_bad - Claims all blocks are good.
>> + *
>> + * In principle, this function is *only* called when the NAND Flash MTD system
>> + * isn't allowed to keep an in-memory bad block table, so it is forced to ask
>> + * the driver for bad block information.
>> + *
>> + * In fact, we permit the NAND Flash MTD system to have an in-memory BBT, so
>> + * this function is *only* called when we take it away.
>> + *
>> + * We take away the in-memory BBT when the user sets the "ignorebad" parameter,
>> + * which indicates that all blocks should be reported good.
>> + *
>> + * Thus, this function is only called when we want *all* blocks to look good,
>> + * so it *always* return success.
>> + *
>> + * @mtd:      Ignored.
>> + * @ofs:      Ignored.
>> + * @getchip:  Ignored.
>> + */
>> +static int mil_block_bad(struct mtd_info *mtd, loff_t ofs, int getchip)
>> +{
>> +	return 0;
>> +}
>> +
>> +/* Set up the Boot ROM Helper geometry. */
>> +static int mil_set_boot_rom_helper_geometry(struct gpmi_nfc_data  *this)
>> +{
>> +	struct boot_rom_helper    *rom =  this->rom;
>> +	struct boot_rom_geometry  *geo =&this->rom_geometry;
>> +
>> +	if (rom->set_geometry(this))
>> +		return !0;
>> +
>> +	pr_info("--------------------------------------------\n");
>> +	pr_info("	Boot ROM Geometry\n");
>> +	pr_info("--------------------------------------------\n");
>> +	pr_info("Boot Area Count            : %u\n", geo->boot_area_count);
>> +	pr_info("Boot Area Size in Bytes    : %u (0x%x)\n",
>> +					geo->boot_area_size_in_bytes,
>> +					geo->boot_area_size_in_bytes);
>> +	pr_info("Stride Size in Pages       : %u\n", geo->stride_size_in_pages);
>> +	pr_info("Search Area Stride Exponent: %u\n",
>> +					geo->search_area_stride_exponent);
>> +	return 0;
>> +}
>> +
>> +static int mil_set_geometry(struct gpmi_nfc_data *this)
>> +{
>> +	struct nfc_hal *nfc = this->nfc;
>> +	struct nfc_geometry *geo =&this->nfc_geometry;
>> +
>> +	/* Free the temporary DMA memory for read ID case */
>> +	mil_free_dma_buffer(this);
>> +
>> +	/* Set up the NFC geometry which is used by BCH. */
>> +	if (nfc->set_geometry(this))
>> +		return -ENXIO;
>>
> Promote the error code returned by set_geometry().
>
ok. thanks.
>> +	pr_info("---------------------------------------\n");
>> +	pr_info("	NFC Geometry (used by BCH)\n");
>> +	pr_info("---------------------------------------\n");
>> +	pr_info("ECC Algorithm          : %s\n", geo->ecc_algorithm);
>> +	pr_info("ECC Strength           : %u\n", geo->ecc_strength);
>> +	pr_info("Page Size in Bytes     : %u\n", geo->page_size_in_bytes);
>> +	pr_info("Metadata Size in Bytes : %u\n", geo->metadata_size_in_bytes);
>> +	pr_info("ECC Chunk Size in Bytes: %u\n", geo->ecc_chunk_size_in_bytes);
>> +	pr_info("ECC Chunk Count        : %u\n", geo->ecc_chunk_count);
>> +	pr_info("Payload Size in Bytes  : %u\n", geo->payload_size_in_bytes);
>> +	pr_info("Auxiliary Size in Bytes: %u\n", geo->auxiliary_size_in_bytes);
>> +	pr_info("Auxiliary Status Offset: %u\n", geo->auxiliary_status_offset);
>> +	pr_info("Block Mark Byte Offset : %u\n", geo->block_mark_byte_offset);
>> +	pr_info("Block Mark Bit Offset  : %u\n", geo->block_mark_bit_offset);
>> +
>> +	/* Alloc the new DMA buffers according to the pagesize and oobsize */
>> +	return mil_alloc_dma_buffer(this);
>> +}
>> +
>> +static int mil_pre_bbt_scan(struct gpmi_nfc_data  *this)
>> +{
>> +	struct boot_rom_helper	*rom	= this->rom;
>> +	int			error	= 0;
>> +
>> +	if (mil_set_boot_rom_helper_geometry(this))
>> +		return -ENXIO;
>>
> Promote the error code returned by mil_set_boot_rom_helper_geometry().
ok.


Huang Shijie
