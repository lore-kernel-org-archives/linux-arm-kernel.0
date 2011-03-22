From: LW@KARO-electronics.de (=?us-ascii?Q?=3D=3Futf-8=3FQ=3FLothar=5FWa=3DC3=3D9Fmann=3F=3D?=)
Date: Tue, 22 Mar 2011 13:36:28 +0100
Subject: [PATCH 2/7] add the common code for GPMI driver
In-Reply-To: <1300239773-4222-3-git-send-email-b32955@freescale.com>
References: <1300239773-4222-1-git-send-email-b32955@freescale.com>
	<1300239773-4222-3-git-send-email-b32955@freescale.com>
Message-ID: <19848.38860.624803.339369@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

shortened and resent, to obey mailing list size limit.

Huang Shijie writes:
> These files contain the common code for the GPMI driver.
> 
> gpmi-nfc-main.c : the main file of GPMI
> mil.c		: the MTD interface layer of GPMI
> hal-common.c	: the hardware abstract layer of GPMI
> rom-common.c	: the NAND boot support of GPMI
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  drivers/mtd/nand/gpmi-nfc/Makefile        |   10 +
>  drivers/mtd/nand/gpmi-nfc/gpmi-nfc-main.c |  524 ++++++++++++++
>  drivers/mtd/nand/gpmi-nfc/gpmi-nfc.h      |  520 ++++++++++++++
>  drivers/mtd/nand/gpmi-nfc/hal-common.c    |  816 +++++++++++++++++++++
>  drivers/mtd/nand/gpmi-nfc/mil.c           | 1104 +++++++++++++++++++++++++++++
>  drivers/mtd/nand/gpmi-nfc/rom-common.c    |   48 ++
>  6 files changed, 3022 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/mtd/nand/gpmi-nfc/Makefile
>  create mode 100644 drivers/mtd/nand/gpmi-nfc/gpmi-nfc-main.c
>  create mode 100644 drivers/mtd/nand/gpmi-nfc/gpmi-nfc.h
>  create mode 100644 drivers/mtd/nand/gpmi-nfc/hal-common.c
>  create mode 100644 drivers/mtd/nand/gpmi-nfc/mil.c
>  create mode 100644 drivers/mtd/nand/gpmi-nfc/rom-common.c
> 
> diff --git a/drivers/mtd/nand/gpmi-nfc/Makefile b/drivers/mtd/nand/gpmi-nfc/Makefile
> new file mode 100644
> index 0000000..9026313
> --- /dev/null
> +++ b/drivers/mtd/nand/gpmi-nfc/Makefile
> @@ -0,0 +1,10 @@
> +obj-$(CONFIG_MTD_NAND_GPMI_NFC) += gpmi-nfc.o
> +gpmi-nfc-objs += gpmi-nfc-main.o
> +gpmi-nfc-objs += hal-common.o
> +gpmi-nfc-objs += hal-imx23.o
> +gpmi-nfc-objs += hal-imx28.o
> +gpmi-nfc-objs += rom-common.o
> +gpmi-nfc-objs += rom-imx23.o
> +gpmi-nfc-objs += rom-imx28.o
> +gpmi-nfc-objs += mil.o
> +gpmi-nfc-objs += nand_device_info.o
> diff --git a/drivers/mtd/nand/gpmi-nfc/gpmi-nfc-main.c b/drivers/mtd/nand/gpmi-nfc/gpmi-nfc-main.c
> new file mode 100644
> index 0000000..f22c9d5
> --- /dev/null
> +++ b/drivers/mtd/nand/gpmi-nfc/gpmi-nfc-main.c
> @@ -0,0 +1,524 @@
[...]
> +/* Device attributes that appear in sysfs. */
> +static DEVICE_ATTR(ignorebad, 0644, show_ignorebad, store_ignorebad);
> +static struct device_attribute *device_attributes[] = {
> +	&dev_attr_ignorebad,
> +};
> +
> +static int acquire_register_block(struct gpmi_nfc_data *this,
> +			const char *resource_name, void **reg_block_base)
> +{
> +	struct platform_device  *pdev = this->pdev;
> +	struct resource         *r;
> +	void                    *p;
> +
> +	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, resource_name);
> +	if (!r) {
> +		log("Can't get resource information for '%s'", resource_name);
> +		return -ENXIO;
> +	}
> +
> +	/* remap the register block */
> +	p = ioremap(r->start, r->end - r->start + 1);
                              ^^^^^^^^^^^^^^^^^^^^^
resource_size(r)

> +	if (!p) {
> +		log("Can't remap %s", resource_name);
> +		return -EIO;
-ENOMEM;

> +	}
> +
> +	*reg_block_base = p;
> +	return 0;
> +}
> +
> +static void release_register_block(struct gpmi_nfc_data *this,
> +				void *reg_block_base)
> +{
> +	iounmap(reg_block_base);
> +}
> +
> +static int acquire_interrupt(struct gpmi_nfc_data *this,
> +			const char *resource_name,
> +			irq_handler_t interrupt_handler, int *lno, int *hno)
> +{
> +	struct platform_device  *pdev = this->pdev;
> +	struct resource         *r;
> +	int                     err = 0;
>
Useless initialization.

> +	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ, resource_name);
> +	if (!r) {
> +		log("Can't get resource information for '%s'", resource_name);
> +		return -ENXIO;
> +	}
> +
> +	BUG_ON(r->start != r->end);
> +	err = request_irq(r->start, interrupt_handler, 0, resource_name, this);
> +	if (err) {
> +		log("Can't own %s", resource_name);
> +		return -EIO;
>
Promote the error code from request_irq().

> +	}
> +
> +	*lno = r->start;
> +	*hno = r->end;
> +	return 0;
> +}
> +
> +static void release_interrupt(struct gpmi_nfc_data *this,
> +			int low_interrupt_number, int high_interrupt_number)
> +{
> +	int i;
> +	for (i = low_interrupt_number; i <= high_interrupt_number; i++)
> +		free_irq(i, this);
> +}
> +
> +static bool gpmi_dma_filter(struct dma_chan *chan, void *param)
> +{
> +	struct gpmi_nfc_data *this = param;
> +	struct resource *r = this->private;
> +
> +	if (!mxs_dma_is_apbh(chan))
> +		return false;
> +	/*
> +	 * only catch the GPMI dma channels :
> +	 *	for mx23 :	MX23_DMA_GPMI0 ~ MX23_DMA_GPMI3
> +	 *		(These four channels share the same IRQ!)
> +	 *
> +	 *	for mx28 :	MX28_DMA_GPMI0 ~ MX28_DMA_GPMI7
> +	 *		(These eight channels share the same IRQ!)
> +	 */
> +	if (r->start <= chan->chan_id && chan->chan_id <= r->end) {
> +		chan->private = &this->dma_data;
> +		return true;
> +	}
> +	return false;
> +}
> +
> +static void release_dma_channels(struct gpmi_nfc_data *this)
> +{
> +	unsigned int   i;
> +	for (i = 0; i <= DMA_CHANS; i++)
>
Obiwan error! should be 'i < DMA_CHANS'

> +		if (this->dma_chans[i]) {
> +			dma_release_channel(this->dma_chans[i]);
> +			this->dma_chans[i] = NULL;
> +		}
> +}
> +
[...]
> +static void release_clock(struct gpmi_nfc_data *this, struct clk *clock)
> +{
> +	clk_disable(clock);
>
Unbalanced clk_disable().

> +	clk_put(clock);
> +}
> +
> +static int acquire_resources(struct gpmi_nfc_data *this)
> +{
> +	struct gpmi_nfc_platform_data  *pdata     =  this->pdata;
> +	struct resources               *resources = &this->resources;
> +	int                            error      = 0;
>
Useless initialization.

> +
> +	/* Attempt to acquire the GPMI register block. */
> +	error = acquire_register_block(this,
> +				GPMI_NFC_GPMI_REGS_ADDR_RES_NAME,
> +				&resources->gpmi_regs);
> +	if (error)
> +		goto exit_gpmi_regs;
> +
> +	/* Attempt to acquire the BCH register block. */
> +	error = acquire_register_block(this,
> +				GPMI_NFC_BCH_REGS_ADDR_RES_NAME,
> +				&resources->bch_regs);
> +	if (error)
> +		goto exit_bch_regs;
> +
> +	/* Attempt to acquire the BCH interrupt. */
> +	error = acquire_interrupt(this,
> +				GPMI_NFC_BCH_INTERRUPT_RES_NAME,
> +				bch_irq,
> +				&resources->bch_low_interrupt,
> +				&resources->bch_high_interrupt);
> +	if (error)
> +		goto exit_bch_interrupt;
> +
> +	/* Attempt to acquire the DMA channels. */
> +	error = acquire_dma_channels(this,
> +				GPMI_NFC_DMA_CHANNELS_RES_NAME,
> +				&resources->dma_low_channel,
> +				&resources->dma_high_channel);
> +	if (error)
> +		goto exit_dma_channels;
> +
> +	/* Attempt to acquire our clock. */
> +	error = acquire_clock(this, pdata->clock_name, &resources->clock);
>
Abuse of the clock API. Don't pass clock names via platform_data.

[...]
> +static void exit_nfc_hal(struct gpmi_nfc_data *this)
> +{
> +	if (this->nfc)
> +		this->nfc->exit(this);
> +}
> +
> +static int set_up_nfc_hal(struct gpmi_nfc_data *this)
> +{
> +	struct gpmi_nfc_platform_data  *pdata = this->pdata;
> +	struct nfc_hal                 *nfc;
> +	int                            error = 0;
>
Useless initialization.

> +	/*
> +	 * This structure contains the "safe" GPMI timing that should succeed
> +	 * with any NAND Flash device
> +	 * (although, with less-than-optimal performance).
> +	 */
> +	static struct nand_timing  safe_timing = {
> +		.data_setup_in_ns        = 80,
> +		.data_hold_in_ns         = 60,
> +		.address_setup_in_ns     = 25,
> +		.gpmi_sample_delay_in_ns =  6,
> +		.tREA_in_ns              = -1,
> +		.tRLOH_in_ns             = -1,
> +		.tRHOH_in_ns             = -1,
> +	};
> +
> +	switch (pdata->chip_version) {
> +	case CHIP_VERSION_IMX23:
> +		nfc = &gpmi_nfc_hal_imx23;
> +		break;
> +	case CHIP_VERSION_IMX28:
> +		nfc = &gpmi_nfc_hal_imx28;
> +		break;
> +	default:
> +		log("Unkown NFC version %u", pdata->chip_version);
> +		return -ENXIO;
> +	}
>
Use platform_ids to distinguish between HW variants.

> +
> +	this->nfc = nfc;
> +
> +	/* Initialize the NFC HAL. */
> +	error = nfc->init(this);
> +	if (error)
> +		return error;
> +
> +	/* Set up safe timing. */
> +	nfc->set_timing(this, &safe_timing);
> +	return 0;
> +}
> +
> +static int set_up_boot_rom_helper(struct gpmi_nfc_data *this)
> +{
> +	struct gpmi_nfc_platform_data  *pdata = this->pdata;
> +	struct boot_rom_helper         *rom;
> +
> +	switch (pdata->chip_version) {
> +	case CHIP_VERSION_IMX23:
> +		rom = &gpmi_nfc_boot_rom_imx23;
> +		break;
> +	case CHIP_VERSION_IMX28:
> +		rom = &gpmi_nfc_boot_rom_imx28;
> +		break;
> +	default:
> +		log("Unkown NFC version %u", pdata->chip_version);
> +		return -ENXIO;
> +	}
Dto.

[...]
> +static int gpmi_nfc_probe(struct platform_device *pdev)
> +{
> +	struct gpmi_nfc_platform_data  *pdata = pdev->dev.platform_data;
> +	struct gpmi_nfc_data           *this  = 0;
> +	int                            error  = 0;
>
Useless initialization (NB: pointers are initialized with 'NULL' not
'0').

[...]
> +static int __init gpmi_nfc_init(void)
> +{
> +	printk(KERN_INFO "GPMI NFC driver registered. (IMX)\n");
> +	if (platform_driver_register(&gpmi_nfc_driver) != 0) {
> +		pr_err("i.MX GPMI NFC driver registration failed\n");
> +		return -ENODEV;
>
Promote the error code from platform_driver_register().

> +	}
> +	return 0;
> +}
> +
> +static void __exit gpmi_nfc_exit(void)
> +{
> +	platform_driver_unregister(&gpmi_nfc_driver);
> +}
> +
> +module_init(gpmi_nfc_init);
> +module_exit(gpmi_nfc_exit);
> +
> +MODULE_AUTHOR("Freescale Semiconductor, Inc.");
> +MODULE_DESCRIPTION("i.MX GPMI NAND Flash Controller Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/mtd/nand/gpmi-nfc/gpmi-nfc.h b/drivers/mtd/nand/gpmi-nfc/gpmi-nfc.h
> new file mode 100644
> index 0000000..b5a2d77
> --- /dev/null
> +++ b/drivers/mtd/nand/gpmi-nfc/gpmi-nfc.h
> @@ -0,0 +1,520 @@
> +/*
> + * Freescale GPMI NFC NAND Flash Driver
> + *
> + * Copyright (C) 2010-2011 Freescale Semiconductor, Inc.
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
> +
> +#ifndef __DRIVERS_MTD_NAND_GPMI_NFC_H
> +#define __DRIVERS_MTD_NAND_GPMI_NFC_H
> +
> +/* Linux header files. */
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/nand.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/mtd/concat.h>
> +#include <linux/dmaengine.h>
> +#include <asm/sizes.h>
> +
> +/* Platform header files. */
> +#include <mach/mxs.h>
> +#include <mach/common.h>
> +#include <mach/dma.h>
> +#include <mach/gpmi-nfc.h>
> +#include <mach/system.h>
> +#include <mach/clock.h>
> +
> +/* Driver header files. */
> +#include "nand_device_info.h"
> +
> +/*
> + *------------------------------------------------------------------------------
> + * Fundamental Data Structures
> + *------------------------------------------------------------------------------
> + */
> +
> +/**
> + * struct resources - The collection of resources the driver needs.
> + *
> + * @gpmi_regs:         A pointer to the GPMI registers.
> + * @bch_regs:          A pointer to the BCH registers.
> + * @bch_interrupt:     The BCH interrupt number.
> + * @dma_low_channel:   The low  DMA channel.
> + * @dma_high_channel:  The high DMA channel.
> + * @clock:             A pointer to the struct clk for the NFC's clock.
> + */
> +struct resources {
> +	void          *gpmi_regs;
> +	void          *bch_regs;
> +	unsigned int  bch_low_interrupt;
> +	unsigned int  bch_high_interrupt;
> +	unsigned int  dma_low_channel;
> +	unsigned int  dma_high_channel;
> +	struct clk    *clock;
> +};
> +
> +/**
> + * struct mil - State for the MTD Interface Layer.
> + *
> + * @nand:                    The NAND Flash MTD data structure that represents
> + *                           the NAND Flash medium.
> + * @mtd:                     The MTD data structure that represents the NAND
> + *                           Flash medium.
> + * @oob_layout:              A structure that describes how bytes are laid out
> + *                           in the OOB.
> + * @general_use_mtd:         A pointer to an MTD we export for general use.
> + *                           This *may* simply be a pointer to the mtd field, if
> + *                           we've been instructed NOT to protect the boot
> + *                           areas.
> + * @partitions:              A pointer to a set of partitions applied to the
> + *                           general use MTD.
> + * @partition_count:         The number of partitions.
> + * @current_chip:            The chip currently selected by the NAND Fash MTD
> + *                           code. A negative value indicates that no chip is
> + *                           selected.
> + * @command_length:          The length of the command that appears in the
> + *                           command buffer (see cmd_virt, below).
> + * @ignore_bad_block_marks:  Indicates we are ignoring bad block marks.
> + * @saved_bbt:               A saved pointer to the in-memory NAND Flash MTD bad
> + *                           block table. See show_device_ignorebad() for more
> + *                           details.
> + * @marking_a_bad_block:     Indicates the caller is marking a bad block. See
> + *                           mil_ecc_write_oob() for details.
> + * @hooked_block_markbad:    A pointer to the block_markbad() function we
> + *                           we "hooked." See mil_ecc_write_oob() for details.
> + * @upper_buf:               The buffer passed from upper layer.
> + * @upper_len:               The buffer len passed from upper layer.
> + * @direct_dma_map_ok:       Is the direct DMA map is good for the upper_buf?
> + * @cmd_sgl/cmd_buffer:      For NAND command.
> + * @data_sgl/data_buffer_dma:For NAND DATA ops.
> + * @page_buffer_virt:        A pointer to a DMA-coherent buffer we use for
> + *                           reading and writing pages. This buffer includes
> + *                           space for both the payload data and the auxiliary
> + *                           data (including status bytes, but not syndrome
> + *                           bytes).
> + * @page_buffer_phys:        The physical address for the page_buffer_virt
> + *                           buffer.
> + * @page_buffer_size:        The size of the page buffer.
> + * @payload_virt:            A pointer to a location in the page buffer used
> + *                           for payload bytes. The size of this buffer is
> + *                           determined by struct nfc_geometry.
> + * @payload_phys:            The physical address for payload_virt.
> + * @auxiliary_virt:          A pointer to a location in the page buffer used
> + *                           for auxiliary bytes. The size of this buffer is
> + *                           determined by struct nfc_geometry.
> + * @auxiliary_phys:          The physical address for auxiliary_virt.
> + */
> +struct mil {
> +	/* MTD Data Structures */
> +	struct nand_chip       nand;
> +	struct mtd_info        mtd;
> +	struct nand_ecclayout  oob_layout;
> +
> +	/* Partitioning and Boot Area Protection */
> +	struct mtd_info        *general_use_mtd;
> +	struct mtd_partition   *partitions;
> +	unsigned int           partition_count;
> +
> +	/* General-use Variables */
> +	int                    current_chip;
> +	unsigned int           command_length;
> +	int                    ignore_bad_block_marks;
> +	void                   *saved_bbt;
> +
> +	/* MTD Function Pointer Hooks */
> +	int                    marking_a_bad_block;
> +	int                    (*hooked_block_markbad)(struct mtd_info *mtd,
> +					loff_t ofs);
> +
> +	/* from upper layer */
> +	uint8_t			*upper_buf;
> +	int			upper_len;
> +
> +	/* DMA */
> +	bool			direct_dma_map_ok;
> +
> +	struct scatterlist	cmd_sgl;
> +	char			*cmd_buffer;
> +
> +	struct scatterlist	data_sgl;
> +	char			*data_buffer_dma;
> +
> +	void                   *page_buffer_virt;
> +	dma_addr_t             page_buffer_phys;
> +	unsigned int           page_buffer_size;
> +
> +	void                   *payload_virt;
> +	dma_addr_t             payload_phys;
> +
> +	void                   *auxiliary_virt;
> +	dma_addr_t             auxiliary_phys;
> +};
>
IMO this struct should be removed and the members integrated into the
struct gpmi_nfc_data.

> +
> +/**
> + * struct nfc_geometry - NFC geometry description.
> + *
> + * This structure describes the NFC's view of the medium geometry.
> + *
> + * @ecc_algorithm:            The human-readable name of the ECC algorithm
> + *                            (e.g., "Reed-Solomon" or "BCH").
> + * @ecc_strength:             A number that describes the strength of the ECC
> + *                            algorithm.
> + * @page_size_in_bytes:       The size, in bytes, of a physical page, including
> + *                            both data and OOB.
> + * @metadata_size_in_bytes:   The size, in bytes, of the metadata.
> + * @ecc_chunk_size_in_bytes:  The size, in bytes, of a single ECC chunk. Note
> + *                            the first chunk in the page includes both data and
> + *                            metadata, so it's a bit larger than this value.
> + * @ecc_chunk_count:          The number of ECC chunks in the page,
> + * @payload_size_in_bytes:    The size, in bytes, of the payload buffer.
> + * @auxiliary_size_in_bytes:  The size, in bytes, of the auxiliary buffer.
> + * @auxiliary_status_offset:  The offset into the auxiliary buffer at which
> + *                            the ECC status appears.
> + * @block_mark_byte_offset:   The byte offset in the ECC-based page view at
> + *                            which the underlying physical block mark appears.
> + * @block_mark_bit_offset:    The bit offset into the ECC-based page view at
> + *                            which the underlying physical block mark appears.
> + */
> +struct nfc_geometry {
> +	char          *ecc_algorithm;
> +	unsigned int  ecc_strength;
> +	unsigned int  page_size_in_bytes;
> +	unsigned int  metadata_size_in_bytes;
> +	unsigned int  ecc_chunk_size_in_bytes;
> +	unsigned int  ecc_chunk_count;
> +	unsigned int  payload_size_in_bytes;
> +	unsigned int  auxiliary_size_in_bytes;
> +	unsigned int  auxiliary_status_offset;
> +	unsigned int  block_mark_byte_offset;
> +	unsigned int  block_mark_bit_offset;
> +};
Most of these parameters are already available in the mtd_info
structure. No need to duplicate them here!

> +
> +/**
> + * struct boot_rom_geometry - Boot ROM geometry description.
> + *
> + * This structure encapsulates decisions made by the Boot ROM Helper.
> + *
> + * @boot_area_count:             The number of boot areas. The first boot area
> + *                               appears at the beginning of chip 0, the next
> + *                               at the beginning of chip 1, etc.
> + * @boot_area_size_in_bytes:     The size, in bytes, of each boot area.
> + * @stride_size_in_pages:        The size of a boot block stride, in pages.
> + * @search_area_stride_exponent: The logarithm to base 2 of the size of a
> + *                               search area in boot block strides.
> + */
> +struct boot_rom_geometry {
> +	unsigned int  boot_area_count;
> +	unsigned int  boot_area_size_in_bytes;
> +	unsigned int  stride_size_in_pages;
> +	unsigned int  search_area_stride_exponent;
> +};
>
IMO the whole boot_rom stuff should not be part of an mtd chip driver,
but has its place in the mtd partition handlers.

> +
> +/* DMA operations types */
> +enum dma_ops_type {
> +	DMA_FOR_COMMAND = 1,
> +	DMA_FOR_READ_DATA,
> +	DMA_FOR_WRITE_DATA,
> +	DMA_FOR_READ_ECC_PAGE,
> +	DMA_FOR_WRITE_ECC_PAGE
> +};
> +
> +/**
> + * struct gpmi_nfc_data - i.MX NFC per-device data.
> + *
> + * Note that the "device" managed by this driver represents the NAND Flash
> + * controller *and* the NAND Flash medium behind it. Thus, the per-device data
> + * structure has information about the controller, the chips to which it is
> + * connected, and properties of the medium as a whole.
> + *
> + * @dev:                 A pointer to the owning struct device.
> + * @pdev:                A pointer to the owning struct platform_device.
> + * @pdata:               A pointer to the device's platform data.
> + * @resources:           Information about system resources used by this driver.
> + * @device_info:         A structure that contains detailed information about
> + *                       the NAND Flash device.
> + * @nfc:                 A pointer to a structure that represents the underlying
> + *                       NFC hardware.
> + * @nfc_geometry:        A description of the medium geometry as viewed by the
> + *                       NFC.
> + * @rom:                 A pointer to a structure that represents the underlying
> + *                       Boot ROM.
> + * @rom_geometry:        A description of the medium geometry as viewed by the
> + *                       Boot ROM.
> + * @mil:                 A collection of information used by the MTD Interface
> + *                       Layer.
> + */
> +struct gpmi_nfc_data {
> +	/* System Interface */
> +	struct device                  *dev;
> +	struct platform_device         *pdev;
> +	struct gpmi_nfc_platform_data  *pdata;
> +
> +	/* Resources */
> +	struct resources               resources;
> +
> +	/* Flash Hardware */
> +	struct nand_device_info        device_info;
> +
> +	/* NFC HAL */
> +	struct nfc_hal                 *nfc;
> +	struct nfc_geometry            nfc_geometry;
> +
> +	/* Boot ROM Helper */
> +	struct boot_rom_helper         *rom;
> +	struct boot_rom_geometry       rom_geometry;
> +
> +	/* MTD Interface Layer */
> +	struct mil                     mil;
> +
> +	/* DMA channels */
> +#define DMA_CHANS			8
> +	struct dma_chan			*dma_chans[DMA_CHANS];
> +	struct mxs_dma_data		dma_data;
> +	enum dma_ops_type		dma_type;
> +
> +	/* private */
> +	void				*private;
> +};
> +
> +/**
> + * struct gpmi_nfc_hardware_timing - GPMI NFC hardware timing parameters.
> + *
> + * This structure contains timing information expressed in a form directly
> + * usable by the GPMI NFC hardware.
> + *
> + * @data_setup_in_cycles:      The data setup time, in cycles.
> + * @data_hold_in_cycles:       The data hold time, in cycles.
> + * @address_setup_in_cycles:   The address setup time, in cycles.
> + * @use_half_periods:          Indicates the clock is running slowly, so the
> + *                             NFC DLL should use half-periods.
> + * @sample_delay_factor:       The sample delay factor.
> + */
> +struct gpmi_nfc_hardware_timing {
> +	uint8_t  data_setup_in_cycles;
> +	uint8_t  data_hold_in_cycles;
> +	uint8_t  address_setup_in_cycles;
> +	bool     use_half_periods;
> +	uint8_t  sample_delay_factor;
> +};
> +
> +/**
> + * struct nfc_hal - GPMI NFC HAL
> + *
> + * This structure embodies an abstract interface to the underlying NFC hardware.
> + *
> + * @version:                     The NFC hardware version.
> + * @description:                 A pointer to a human-readable description of
> + *                               the NFC hardware.
> + * @max_chip_count:              The maximum number of chips the NFC can
> + *                               possibly support (this value is a constant for
> + *                               each NFC version). This may *not* be the actual
> + *                               number of chips connected.
> + * @max_data_setup_cycles:       The maximum number of data setup cycles that
> + *                               can be expressed in the hardware.
> + * @internal_data_setup_in_ns:   The time, in ns, that the NFC hardware requires
> + *                               for data read internal setup. In the Reference
> + *                               Manual, see the chapter "High-Speed NAND
> + *                               Timing" for more details.
> + * @max_sample_delay_factor:     The maximum sample delay factor that can be
> + *                               expressed in the hardware.
> + * @max_dll_clock_period_in_ns:  The maximum period of the GPMI clock that the
> + *                               sample delay DLL hardware can possibly work
> + *                               with (the DLL is unusable with longer periods).
> + *                               If the full-cycle period is greater than HALF
> + *                               this value, the DLL must be configured to use
> + *                               half-periods.
> + * @max_dll_delay_in_ns:         The maximum amount of delay, in ns, that the
> + *                               DLL can implement.
> + * @dma_descriptors:             A pool of DMA descriptors.
> + * @isr_dma_channel:             The DMA channel with which the NFC HAL is
> + *                               working. We record this here so the ISR knows
> + *                               which DMA channel to acknowledge.
> + * @dma_done:                    The completion structure used for DMA
> + *                               interrupts.
> + * @bch_done:                    The completion structure used for BCH
> + *                               interrupts.
> + * @timing:                      The current timing configuration.
> + * @clock_frequency_in_hz:       The clock frequency, in Hz, during the current
> + *                               I/O transaction. If no I/O transaction is in
> + *                               progress, this is the clock frequency during
> + *                               the most recent I/O transaction.
> + * @hardware_timing:             The hardware timing configuration in effect
> + *                               during the current I/O transaction. If no I/O
> + *                               transaction is in progress, this is the
> + *                               hardware timing configuration during the most
> + *                               recent I/O transaction.
> + * @init:                        Initializes the NFC hardware and data
> + *                               structures. This function will be called after
> + *                               everything has been set up for communication
> + *                               with the NFC itself, but before the platform
> + *                               has set up off-chip communication. Thus, this
> + *                               function must not attempt to communicate with
> + *                               the NAND Flash hardware.
> + * @set_geometry:                Configures the NFC hardware and data structures
> + *                               to match the physical NAND Flash geometry.
> + * @set_geometry:                Configures the NFC hardware and data structures
> + *                               to match the physical NAND Flash geometry.
> + * @set_timing:                  Configures the NFC hardware and data structures
> + *                               to match the given NAND Flash bus timing.
> + * @get_timing:                  Returns the the clock frequency, in Hz, and
> + *                               the hardware timing configuration during the
> + *                               current I/O transaction. If no I/O transaction
> + *                               is in progress, this is the timing state during
> + *                               the most recent I/O transaction.
> + * @exit:                        Shuts down the NFC hardware and data
> + *                               structures. This function will be called after
> + *                               the platform has shut down off-chip
> + *                               communication but while communication with the
> + *                               NFC itself still works.
> + * @clear_bch:                   Clears a BCH interrupt (intended to be called
> + *                               by a more general interrupt handler to do
> + *                               device-specific clearing).
> + * @is_ready:                    Returns true if the given chip is ready.
> + * @begin:                       Begins an interaction with the NFC. This
> + *                               function must be called before *any* of the
> + *                               following functions so the NFC can prepare
> + *                               itself.
> + * @end:                         Ends interaction with the NFC. This function
> + *                               should be called to give the NFC a chance to,
> + *                               among other things, enter a lower-power state.
> + * @send_command:                Sends the given buffer of command bytes.
> + * @send_data:                   Sends the given buffer of data bytes.
> + * @read_data:                   Reads data bytes into the given buffer.
> + * @send_page:                   Sends the given given data and OOB bytes,
> + *                               using the ECC engine.
> + * @read_page:                   Reads a page through the ECC engine and
> + *                               delivers the data and OOB bytes to the given
> + *                               buffers.
> + */
> +struct nfc_hal {
> +	/* Hardware attributes. */
> +	const unsigned int      version;
> +	const char              *description;
> +	const unsigned int      max_chip_count;
> +	const unsigned int      max_data_setup_cycles;
> +	const unsigned int      internal_data_setup_in_ns;
> +	const unsigned int      max_sample_delay_factor;
> +	const unsigned int      max_dll_clock_period_in_ns;
> +	const unsigned int      max_dll_delay_in_ns;
> +
> +	int                     isr_dma_channel;
> +	struct completion       dma_done;
> +	struct completion       bch_done;
> +	struct nand_timing      timing;
> +	unsigned long           clock_frequency_in_hz;
> +
> +	/* Configuration functions. */
> +	int   (*init)        (struct gpmi_nfc_data *);
> +	int   (*extra_init)  (struct gpmi_nfc_data *);
> +	int   (*set_geometry)(struct gpmi_nfc_data *);
> +	int   (*set_timing)  (struct gpmi_nfc_data *,
> +					const struct nand_timing *);
> +	void  (*get_timing)  (struct gpmi_nfc_data *,
> +					unsigned long *clock_frequency_in_hz,
> +					struct gpmi_nfc_hardware_timing *);
> +	void  (*exit)        (struct gpmi_nfc_data *);
> +
> +	/* Call these functions to begin and end I/O. */
> +	void  (*begin)       (struct gpmi_nfc_data *);
> +	void  (*end)         (struct gpmi_nfc_data *);
> +
> +	/* Call these I/O functions only between begin() and end(). */
> +	void  (*clear_bch)   (struct gpmi_nfc_data *);
> +	int   (*is_ready)    (struct gpmi_nfc_data *, unsigned chip);
> +	int   (*send_command)(struct gpmi_nfc_data *);
> +	int   (*send_data)   (struct gpmi_nfc_data *);
> +	int   (*read_data)   (struct gpmi_nfc_data *);
> +	int   (*send_page)   (struct gpmi_nfc_data *,
> +				dma_addr_t payload, dma_addr_t auxiliary);
> +	int   (*read_page)   (struct gpmi_nfc_data *,
> +				dma_addr_t payload, dma_addr_t auxiliary);
> +};
>
Most of these functions are completely identical for the two currently
implemented variants, so there is no need for this extra complexity.
You could add pointers to the differing functions to struct
gpmi_nfc_data and remove struct nfc_hal completely.

[...]
> diff --git a/drivers/mtd/nand/gpmi-nfc/hal-common.c b/drivers/mtd/nand/gpmi-nfc/hal-common.c
> new file mode 100644
> index 0000000..d7e8075
> --- /dev/null
> +++ b/drivers/mtd/nand/gpmi-nfc/hal-common.c
[...]
> +int common_nfc_set_geometry(struct gpmi_nfc_data *this)
> +{
> +	struct nfc_geometry       *geo = &this->nfc_geometry;
> +	struct boot_rom_helper    *rom      =  this->rom;
> +	struct mtd_info		  *mtd	    = &this->mil.mtd;
> +	unsigned int              metadata_size;
> +	unsigned int              status_size;
> +	unsigned int              chunk_data_size_in_bits;
> +	unsigned int              chunk_ecc_size_in_bits;
> +	unsigned int              chunk_total_size_in_bits;
> +	unsigned int              block_mark_chunk_number;
> +	unsigned int              block_mark_chunk_bit_offset;
> +	unsigned int              block_mark_bit_offset;
> +
> +	/* We only support BCH now. */
> +	geo->ecc_algorithm = "BCH";
> +
> +	/*
> +	 * We always choose a metadata size of 10. Don't try to make sense of
> +	 * it -- this is really only for historical compatibility.
> +	 */
> +	geo->metadata_size_in_bytes = 10;
> +
> +	/* ECC chunks */
> +	geo->ecc_chunk_size_in_bytes = 512;
> +	if (is_ddr_nand(&this->device_info))
> +		geo->ecc_chunk_size_in_bytes = 1024;
> +
> +	/*
> +	 * Compute the total number of ECC chunks in a page. This includes the
> +	 * slightly larger chunk at the beginning of the page, which contains
> +	 * both data and metadata.
> +	 */
> +	geo->ecc_chunk_count = mtd->writesize / geo->ecc_chunk_size_in_bytes;
> +
> +	/*
> +	 * We use the same ECC strength for all chunks, including the first one.
> +	 * At this writing, we base our ECC strength choice entirely on the
> +	 * the physical page geo. In the future, this should be changed to
> +	 * pay attention to the detailed device information we gathered earlier.
> +	 */
> +	geo->ecc_strength = get_ecc_strength(this);
> +	if (!geo->ecc_strength) {
> +		log("Unsupported page geometry.");
> +		return !0;
> +	}
> +
> +	/* Compute the page size, include page and oob. */
> +	geo->page_size_in_bytes = mtd->writesize + mtd->oobsize;
> +	/*
> +	 * ONFI/TOGGLE nand needs GF14, so re-culculate DMA page size.
> +	 * The ONFI nand must do the reculation,
> +	 * else it will fail in DMA in some platform(such as imx50).
> +	 */
> +	if (is_ddr_nand(&this->device_info))
> +		geo->page_size_in_bytes = mtd->writesize +
> +				geo->metadata_size_in_bytes +
> +			(geo->ecc_strength * 14 * 8 / geo->ecc_chunk_count);
> +
> +	/*
> +	 * The payload buffer contains the data area of a page. The ECC engine
> +	 * only needs what's required to hold the data.
> +	 */
> +	geo->payload_size_in_bytes = mtd->writesize;
> +
> +	/*
> +	 * In principle, computing the auxiliary buffer geometry is NFC
> +	 * version-specific. However, at this writing, all versions share the
> +	 * same model, so this code can also be shared.
> +	 *
> +	 * The auxiliary buffer contains the metadata and the ECC status. The
> +	 * metadata is padded to the nearest 32-bit boundary. The ECC status
> +	 * contains one byte for every ECC chunk, and is also padded to the
> +	 * nearest 32-bit boundary.
> +	 */
> +	metadata_size = (geo->metadata_size_in_bytes + 0x3) & ~0x3;
> +	status_size   = (geo->ecc_chunk_count        + 0x3) & ~0x3;
>
ALIGN(x, 4);

[...]
> +struct dma_chan *get_dma_chan(struct gpmi_nfc_data *this)
> +{
> +	int chip = this->mil.current_chip;
> +
> +	BUG_ON(chip < 0);
> +	return this->dma_chans[chip];
> +}
> +
> +/* Can we use the upper's buffer directly for DMA? */
> +void prepare_data_dma(struct gpmi_nfc_data *this, enum dma_data_direction dr)
> +{
> +	struct mil *mil = &this->mil;
> +	struct scatterlist *sgl = &mil->data_sgl;
> +	int ret = 0;
> +
> +	mil->direct_dma_map_ok = true;
> +
> +	/* first try to map the upper buffer directly */
> +	sg_init_one(sgl, mil->upper_buf, mil->upper_len);
> +	ret = dma_map_sg(this->dev, sgl, 1, dr);
> +	if (ret == 0) {
> +		/* We have to use our own DMA buffer. */
> +		sg_init_one(sgl, mil->data_buffer_dma, PAGE_SIZE);
> +		ret = dma_map_sg(this->dev, sgl, 1, dr);
> +		BUG_ON(ret == 0);
> +
> +		if (dr == DMA_TO_DEVICE)
> +			memcpy(mil->data_buffer_dma, mil->upper_buf,
> +				mil->upper_len);
> +		mil->direct_dma_map_ok = false;
> +	}
> +	sgl->length = mil->upper_len;
        ^^^^^^^^^^^^^^
This has already been done by sg_init_one().

[...]
> +int gpmi_nfc_compute_hardware_timing(struct gpmi_nfc_data *this,
> +					struct gpmi_nfc_hardware_timing *hw)
> +{
[...]
> +	/*
> +	 * The clock's period affects the sample delay in a number of ways:
> +	 *
> +	 * (1) The NFC HAL tells us the maximum clock period the sample delay
> +	 *     DLL can tolerate. If the clock period is greater than half that
> +	 *     maximum, we must configure the DLL to be driven by half periods.
> +	 *
> +	 * (2) We need to convert from an ideal sample delay, in ns, to a
> +	 *     "sample delay factor," which the NFC uses. This factor depends on
> +	 *     whether we're driving the DLL with full or half periods.
> +	 *     Paraphrasing the reference manual:
> +	 *
> +	 *         AD = SDF x 0.125 x RP
> +	 *
> +	 * where:
> +	 *
> +	 *     AD   is the applied delay, in ns.
> +	 *     SDF  is the sample delay factor, which is dimensionless.
> +	 *     RP   is the reference period, in ns, which is a full clock period
> +	 *          if the DLL is being driven by full periods, or half that if
> +	 *          the DLL is being driven by half periods.
> +	 *
> +	 * Let's re-arrange this in a way that's more useful to us:
> +	 *
> +	 *                        8
> +	 *         SDF  =  AD x ----
> +	 *                       RP
> +	 *
> +	 * The reference period is either the clock period or half that, so this
> +	 * is:
> +	 *
> +	 *                        8       AD x DDF
> +	 *         SDF  =  AD x -----  =  --------
> +	 *                      f x P        P
> +	 *
> +	 * where:
> +	 *
> +	 *       f  is 1 or 1/2, depending on how we're driving the DLL.
> +	 *       P  is the clock period.
> +	 *     DDF  is the DLL Delay Factor, a dimensionless value that
> +	 *          incorporates all the constants in the conversion.
> +	 *
> +	 * DDF will be either 8 or 16, both of which are powers of two. We can
> +	 * reduce the cost of this conversion by using bit shifts instead of
> +	 * multiplication or division. Thus:
> +	 *
> +	 *                 AD << DDS
> +	 *         SDF  =  ---------
> +	 *                     P
> +	 *
> +	 *     or
> +	 *
> +	 *         AD  =  (SDF >> DDS) x P
[...]
> +return_results:
> +	hw->data_setup_in_cycles    = data_setup_in_cycles;
> +	hw->data_hold_in_cycles     = data_hold_in_cycles;
> +	hw->address_setup_in_cycles = address_setup_in_cycles;
> +	hw->use_half_periods        = dll_use_half_periods;
> +	hw->sample_delay_factor     = sample_delay_factor;
> +
> +	/* Return success. */
> +	return 0;
>
Does this complicated calculation buy anything, or could we just use
some failsafe timing values that could possibly be adjusted via
platform_data.

> +}
> diff --git a/drivers/mtd/nand/gpmi-nfc/mil.c b/drivers/mtd/nand/gpmi-nfc/mil.c
> new file mode 100644
> index 0000000..defd19e
> --- /dev/null
> +++ b/drivers/mtd/nand/gpmi-nfc/mil.c
> @@ -0,0 +1,1104 @@
> +/*
> + * Freescale GPMI NFC NAND Flash Driver
> + *
> + * Copyright (C) 2010-2011 Freescale Semiconductor, Inc.
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
> +
> +#include <linux/slab.h>
> +#include "gpmi-nfc.h"
> +#include "linux/slab.h"
> +
> +/* add our owner bbt descriptor */
> +static uint8_t scan_ff_pattern[] = { 0xff };
> +static struct nand_bbt_descr gpmi_bbt_descr = {
> +	.options	= 0,
> +	.offs		= 0,
> +	.len		= 1,
> +	.pattern	= scan_ff_pattern
> +};
> +
> +static int read_page_prepare(struct gpmi_nfc_data *this,
> +			void *destination, unsigned length,
> +			void *alt_virt, dma_addr_t alt_phys, unsigned alt_size,
> +			void **use_virt, dma_addr_t *use_phys)
> +{
> +	struct device  *dev = this->dev;
> +	dma_addr_t destination_phys = ~0;
> +
> +	if (virt_addr_valid(destination))
> +		destination_phys = dma_map_single(dev, (void *)destination,
> +						length, DMA_FROM_DEVICE);
> +
> +	if (dma_mapping_error(dev, destination_phys)) {
> +		if (alt_size < length) {
> +			log("Alternate buffer is too small for incoming I/O.");
> +			return -ENOMEM;
> +		}
> +
> +		*use_virt = alt_virt;
> +		*use_phys = alt_phys;
> +	} else {
> +		*use_virt = destination;
> +		*use_phys = destination_phys;
> +	}
> +	return 0;
> +}
> +
> +static void read_page_end(struct gpmi_nfc_data *this,
> +			void *destination, unsigned length,
> +			void *alt_virt, dma_addr_t alt_phys, unsigned alt_size,
> +			void *used_virt, dma_addr_t used_phys)
> +{
> +	struct device  *dev = this->dev;
> +
> +	if (used_virt == destination)
> +		dma_unmap_single(dev, used_phys, length, DMA_FROM_DEVICE);
> +	else
> +		memcpy(destination, alt_virt, length);
> +}
> +
> +static int send_page_prepare(struct gpmi_nfc_data *this,
> +			const void *source, unsigned length,
> +			void *alt_virt, dma_addr_t alt_phys, unsigned alt_size,
> +			const void **use_virt, dma_addr_t *use_phys)
> +{
> +	dma_addr_t source_phys = ~0;
> +	struct device  *dev = this->dev;
> +
> +	if (virt_addr_valid(source))
> +		source_phys = dma_map_single(dev,
> +				(void *)source, length, DMA_TO_DEVICE);
> +
> +	if (dma_mapping_error(dev, source_phys)) {
> +		if (alt_size < length) {
> +			log("Alternate buffer is too small for outgoing I/O");
> +			return -ENOMEM;
> +		}
> +
> +		/*
> +		 * Copy the contents of the source buffer into the alternate
> +		 * buffer and set up the return values accordingly.
> +		 */
> +		memcpy(alt_virt, source, length);
> +
> +		*use_virt = alt_virt;
> +		*use_phys = alt_phys;
> +	} else {
> +		*use_virt = source;
> +		*use_phys = source_phys;
> +	}
> +	return 0;
> +}
> +
> +static void send_page_end(struct gpmi_nfc_data *this,
> +			const void *source, unsigned length,
> +			void *alt_virt, dma_addr_t alt_phys, unsigned alt_size,
> +			const void *used_virt, dma_addr_t used_phys)
> +{
> +	struct device  *dev = this->dev;
> +	if (used_virt == source)
> +		dma_unmap_single(dev, used_phys, length, DMA_TO_DEVICE);
> +}
> +
> +static void mil_free_dma_buffer(struct gpmi_nfc_data *this)
> +{
> +	struct device *dev = this->dev;
> +	struct mil *mil	= &this->mil;
> +
> +	if (mil->page_buffer_virt && virt_addr_valid(mil->page_buffer_virt))
> +		dma_free_coherent(dev, mil->page_buffer_size,
> +					mil->page_buffer_virt,
> +					mil->page_buffer_phys);
> +	kfree(mil->cmd_buffer);
> +	kfree(mil->data_buffer_dma);
> +
> +	mil->cmd_buffer		= NULL;
> +	mil->data_buffer_dma	= NULL;
> +	mil->page_buffer_virt	= NULL;
> +	mil->page_buffer_size	=  0;
> +	mil->page_buffer_phys	= ~0;
> +}
> +
> +/* Allocate the DMA buffers */
> +static int mil_alloc_dma_buffer(struct gpmi_nfc_data *this)
> +{
> +	struct device        *dev	= this->dev;
> +	struct nfc_geometry  *geo	= &this->nfc_geometry;
> +	struct mil           *mil	= &this->mil;
> +
> +	/* [1] Allocate a command buffer. PAGE_SIZE is enough. */
> +	mil->cmd_buffer = kzalloc(PAGE_SIZE, GFP_DMA);
> +	if (mil->cmd_buffer == NULL)
> +		goto error_alloc;
> +	sg_init_one(&mil->cmd_sgl, mil->cmd_buffer, PAGE_SIZE);
> +
> +	/* [2] Allocate a read/write data buffer. PAGE_SIZE is enough. */
> +	mil->data_buffer_dma = kzalloc(PAGE_SIZE, GFP_DMA);
> +	if (mil->data_buffer_dma == NULL)
> +		goto error_alloc;
> +
> +	/*
> +	 * [3] Allocate the page buffer.
> +	 *
> +	 * Both the payload buffer and the auxiliary buffer must appear on
> +	 * 32-bit boundaries. We presume the size of the payload buffer is a
> +	 * power of two and is much larger than four, which guarantees the
> +	 * auxiliary buffer will appear on a 32-bit boundary.
> +	 */
> +	mil->page_buffer_size = geo->payload_size_in_bytes +
> +				geo->auxiliary_size_in_bytes;
> +
> +	mil->page_buffer_virt = dma_alloc_coherent(dev, mil->page_buffer_size,
> +					&mil->page_buffer_phys, GFP_DMA);
> +	if (!mil->page_buffer_virt)
> +		goto error_alloc;
> +
> +
> +	/* Slice up the page buffer. */
> +	mil->payload_virt = mil->page_buffer_virt;
> +	mil->payload_phys = mil->page_buffer_phys;
> +	mil->auxiliary_virt = ((char *) mil->payload_virt) +
> +					geo->payload_size_in_bytes;
> +	mil->auxiliary_phys = mil->payload_phys +
> +					geo->payload_size_in_bytes;
> +	return 0;
> +
> +error_alloc:
> +	mil_free_dma_buffer(this);
> +	log("allocate DMA buffer error!!");
> +	return -ENOMEM;
> +}
> +
> +static void mil_cmd_ctrl(struct mtd_info *mtd, int data, unsigned int ctrl)
> +{
> +	struct nand_chip      *nand = mtd->priv;
> +	struct gpmi_nfc_data  *this = nand->priv;
> +	struct mil            *mil  = &this->mil;
> +	struct nfc_hal        *nfc  =  this->nfc;
> +	int                   error;
> +
> +	/*
> +	 * Every operation begins with a command byte and a series of zero or
> +	 * more address bytes. These are distinguished by either the Address
> +	 * Latch Enable (ALE) or Command Latch Enable (CLE) signals being
> +	 * asserted. When MTD is ready to execute the command, it will deassert
> +	 * both latch enables.
> +	 *
> +	 * Rather than run a separate DMA operation for every single byte, we
> +	 * queue them up and run a single DMA operation for the entire series
> +	 * of command and data bytes. NAND_CMD_NONE means the END of the queue.
> +	 */
> +	if ((ctrl & (NAND_ALE | NAND_CLE))) {
> +		if (data != NAND_CMD_NONE)
> +			mil->cmd_buffer[mil->command_length++] = data;
> +		return;
> +	}
> +
> +	if (!mil->command_length)
> +		return;
> +
> +	error = nfc->send_command(this);
> +	if (error)
> +		log("Chip: %u, Error %d", mil->current_chip, error);
> +
> +	mil->command_length = 0;
> +}
> +
> +static int mil_dev_ready(struct mtd_info *mtd)
> +{
> +	struct nand_chip      *nand = mtd->priv;
> +	struct gpmi_nfc_data  *this = nand->priv;
> +	struct nfc_hal        *nfc  = this->nfc;
> +	struct mil            *mil  = &this->mil;
> +
> +	return nfc->is_ready(this, mil->current_chip);
> +}
> +
> +static void mil_select_chip(struct mtd_info *mtd, int chip)
> +{
> +	struct nand_chip      *nand  = mtd->priv;
> +	struct gpmi_nfc_data  *this  = nand->priv;
> +	struct mil            *mil   = &this->mil;
> +	struct nfc_hal        *nfc   =  this->nfc;
> +
> +	if ((mil->current_chip < 0) && (chip >= 0))
> +		nfc->begin(this);
> +	else if ((mil->current_chip >= 0) && (chip < 0))
> +		nfc->end(this);
> +	else
> +		;
> +
> +	mil->current_chip = chip;
> +}
> +
> +static void mil_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
> +{
> +	struct nand_chip      *nand     = mtd->priv;
> +	struct gpmi_nfc_data  *this     = nand->priv;
> +	struct nfc_hal        *nfc      = this->nfc;
> +	struct mil            *mil      = &this->mil;
> +
> +	/* save the info in mil{} for future */
> +	mil->upper_buf	= buf;
> +	mil->upper_len	= len;
> +
> +	nfc->read_data(this);
> +}
> +
> +static void mil_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
> +{
> +	struct nand_chip      *nand     = mtd->priv;
> +	struct gpmi_nfc_data  *this     = nand->priv;
> +	struct nfc_hal        *nfc      =  this->nfc;
> +	struct mil            *mil      = &this->mil;
> +
> +	/* save the info in mil{} for future */
> +	mil->upper_buf	= (uint8_t *)buf;
> +	mil->upper_len	= len;
> +
> +	nfc->send_data(this);
> +}
> +
> +static uint8_t mil_read_byte(struct mtd_info *mtd)
> +{
> +	uint8_t  byte = 0;
> +	mil_read_buf(mtd, (uint8_t *)&byte, 1);
>
With CONFIG_DMA_API_DEBUG enabled this would blow up right in your
face:
|gpmi-nfc gpmi-nfc: DMA-API: device driver maps memory fromstack [addr=c732bd3f]

> +	return byte;
> +}
> +
> +/**
> + * mil_handle_block_mark_swapping() - Handles block mark swapping.
> + *
> + * Note that, when this function is called, it doesn't know whether it's
> + * swapping the block mark, or swapping it *back* -- but it doesn't matter
> + * because the the operation is the same.
> + *
> + * @this:       Per-device data.
> + * @payload:    A pointer to the payload buffer.
> + * @auxiliary:  A pointer to the auxiliary buffer.
> + */
> +static void mil_handle_block_mark_swapping(struct gpmi_nfc_data *this,
> +						void *payload, void *auxiliary)
> +{
> +	struct nfc_geometry     *nfc_geo = &this->nfc_geometry;
> +	struct boot_rom_helper  *rom     =  this->rom;
> +	unsigned char           *p;
> +	unsigned char           *a;
> +	unsigned int            bit;
> +	unsigned char           mask;
> +	unsigned char           from_data;
> +	unsigned char           from_oob;
> +
> +	/* Check if we're doing block mark swapping. */
> +	if (!rom->swap_block_mark)
> +		return;
> +
> +	/*
> +	 * If control arrives here, we're swapping. Make some convenience
> +	 * variables.
> +	 */
> +	bit = nfc_geo->block_mark_bit_offset;
> +	p   = ((unsigned char *) payload) + nfc_geo->block_mark_byte_offset;
>
Useless cast.

[...]
> +static int mil_ecc_read_page(struct mtd_info *mtd, struct nand_chip *nand,
> +				uint8_t *buf, int page)
> +{
> +	struct gpmi_nfc_data    *this    = nand->priv;
> +	struct nfc_hal          *nfc     =  this->nfc;
> +	struct nfc_geometry     *nfc_geo = &this->nfc_geometry;
> +	struct mil              *mil     = &this->mil;
> +	void                    *payload_virt   =  0;
> +	dma_addr_t              payload_phys    = ~0;
> +	void                    *auxiliary_virt =  0;
> +	dma_addr_t              auxiliary_phys  = ~0;
Useless initialization.

> +	unsigned int            i;
> +	unsigned char           *status;
> +	unsigned int            failed;
> +	unsigned int            corrected;
> +	int                     error = 0;
> +
Dto.

> +	error = read_page_prepare(this, buf, mtd->writesize,
> +					mil->payload_virt, mil->payload_phys,
> +					nfc_geo->payload_size_in_bytes,
> +					&payload_virt, &payload_phys);
> +	if (error) {
> +		log("Inadequate DMA buffer");
> +		error = -ENOMEM;
> +		return error;
> +	}
> +	auxiliary_virt = mil->auxiliary_virt;
> +	auxiliary_phys = mil->auxiliary_phys;
> +
> +	/* ask the NFC */
> +	error = nfc->read_page(this, payload_phys, auxiliary_phys);
> +	if (error) {
> +		log("Error in ECC-based read: %d", error);
> +		goto exit_nfc;
> +	}
> +
> +	/* handle the block mark swapping */
> +	mil_handle_block_mark_swapping(this, payload_virt, auxiliary_virt);
> +
> +	/* Loop over status bytes, accumulating ECC status. */
> +	failed		= 0;
> +	corrected	= 0;
> +	status		= ((unsigned char *) auxiliary_virt) +
> +					nfc_geo->auxiliary_status_offset;
>
Useless cast.
> +
> +	for (i = 0; i < nfc_geo->ecc_chunk_count; i++, status++) {
> +		if ((*status == STATUS_GOOD) || (*status == STATUS_ERASED))
> +			continue;
> +
> +		if (*status == STATUS_UNCORRECTABLE) {
> +			failed++;
> +			continue;
> +		}
> +		corrected += *status;
> +	}
> +
> +	/*
> +	 * Propagate ECC status to the owning MTD only when failed or
> +	 * corrected times nearly reaches our ECC correction threshold.
> +	 */
> +	if (failed || corrected >= (nfc_geo->ecc_strength - 1)) {
> +		mtd->ecc_stats.failed    += failed;
> +		mtd->ecc_stats.corrected += corrected;
> +	}
> +
> +	/*
> +	 * It's time to deliver the OOB bytes. See mil_ecc_read_oob() for
> +	 * details about our policy for delivering the OOB.
> +	 *
> +	 * We fill the caller's buffer with set bits, and then copy the block
> +	 * mark to th caller's buffer. Note that, if block mark swapping was
> +	 * necessary, it has already been done, so we can rely on the first
> +	 * byte of the auxiliary buffer to contain the block mark.
> +	 */
> +	memset(nand->oob_poi, ~0, mtd->oobsize);
> +	nand->oob_poi[0] = ((uint8_t *) auxiliary_virt)[0];
> +
> +exit_nfc:
> +	read_page_end(this, buf, mtd->writesize,
> +					mil->payload_virt, mil->payload_phys,
> +					nfc_geo->payload_size_in_bytes,
> +					payload_virt, payload_phys);
> +	return error;
> +}
> +
> +static void mil_ecc_write_page(struct mtd_info *mtd,
> +				struct nand_chip *nand, const uint8_t *buf)
> +{
> +	struct gpmi_nfc_data    *this    = nand->priv;
> +	struct nfc_hal          *nfc     =  this->nfc;
> +	struct nfc_geometry     *nfc_geo = &this->nfc_geometry;
> +	struct boot_rom_helper  *rom     =  this->rom;
> +	struct mil              *mil     = &this->mil;
> +	const void              *payload_virt   =  0;
> +	dma_addr_t              payload_phys    = ~0;
> +	const void              *auxiliary_virt =  0;
> +	dma_addr_t              auxiliary_phys  = ~0;
>
Useless initialization.

> +	int                     error;
> +
> +	if (rom->swap_block_mark) {
> +		/*
> +		 * If control arrives here, we're doing block mark swapping.
> +		 * Since we can't modify the caller's buffers, we must copy them
> +		 * into our own.
> +		 */
> +		memcpy(mil->payload_virt, buf, mtd->writesize);
> +		payload_virt = mil->payload_virt;
> +		payload_phys = mil->payload_phys;
> +
> +		memcpy(mil->auxiliary_virt, nand->oob_poi,
> +				nfc_geo->auxiliary_size_in_bytes);
> +		auxiliary_virt = mil->auxiliary_virt;
> +		auxiliary_phys = mil->auxiliary_phys;
> +
> +		/* Handle block mark swapping. */
> +		mil_handle_block_mark_swapping(this,
> +				(void *) payload_virt, (void *) auxiliary_virt);
> +	} else {
> +		/*
> +		 * If control arrives here, we're not doing block mark swapping,
> +		 * so we can to try and use the caller's buffers.
> +		 */
> +		error = send_page_prepare(this,
> +				buf, mtd->writesize,
> +				mil->payload_virt, mil->payload_phys,
> +				nfc_geo->payload_size_in_bytes,
> +				&payload_virt, &payload_phys);
> +		if (error) {
> +			log("Inadequate payload DMA buffer");
> +			return;
> +		}
> +
> +		error = send_page_prepare(this,
> +				nand->oob_poi, mtd->oobsize,
> +				mil->auxiliary_virt, mil->auxiliary_phys,
> +				nfc_geo->auxiliary_size_in_bytes,
> +				&auxiliary_virt, &auxiliary_phys);
> +		if (error) {
> +			log("Inadequate auxiliary DMA buffer");
> +			goto exit_auxiliary;
> +		}
> +	}
> +
> +	/* Ask the NFC. */
> +	error = nfc->send_page(this, payload_phys, auxiliary_phys);
> +	if (error)
> +		log("Error in ECC-based write: %d", error);
> +
> +	if (!rom->swap_block_mark) {
> +		send_page_end(this, nand->oob_poi, mtd->oobsize,
> +				mil->auxiliary_virt, mil->auxiliary_phys,
> +				nfc_geo->auxiliary_size_in_bytes,
> +				auxiliary_virt, auxiliary_phys);
> +exit_auxiliary:
> +		send_page_end(this, buf, mtd->writesize,
> +				mil->payload_virt, mil->payload_phys,
> +				nfc_geo->payload_size_in_bytes,
> +				payload_virt, payload_phys);
> +	}
> +}
> +
> +/**
> + * mil_hook_block_markbad() - Hooked MTD Interface block_markbad().
> + *
> + * This function is a veneer that replaces the function originally installed by
> + * the NAND Flash MTD code. See the description of the marking_a_bad_block field
> + * in struct mil for more information about this.
> + *
> + * @mtd:  A pointer to the MTD.
> + * @ofs:  Byte address of the block to mark.
> + */
> +static int mil_hook_block_markbad(struct mtd_info *mtd, loff_t ofs)
> +{
> +	register struct nand_chip  *chip = mtd->priv;
> +	struct gpmi_nfc_data       *this = chip->priv;
> +	struct mil                 *mil  = &this->mil;
> +	int                        ret;
> +
> +	mil->marking_a_bad_block = true;
> +	ret = mil->hooked_block_markbad(mtd, ofs);
> +	mil->marking_a_bad_block = false;
> +	return ret;
> +}
> +
> +/**
> + * mil_ecc_read_oob() - MTD Interface ecc.read_oob().
> + *
> + * There are several places in this driver where we have to handle the OOB and
> + * block marks. This is the function where things are the most complicated, so
> + * this is where we try to explain it all. All the other places refer back to
> + * here.
> + *
> + * These are the rules, in order of decreasing importance:
> + *
> + * 1) Nothing the caller does can be allowed to imperil the block mark, so all
> + *    write operations take measures to protect it.
> + *
> + * 2) In read operations, the first byte of the OOB we return must reflect the
> + *    true state of the block mark, no matter where that block mark appears in
> + *    the physical page.
> + *
> + * 3) ECC-based read operations return an OOB full of set bits (since we never
> + *    allow ECC-based writes to the OOB, it doesn't matter what ECC-based reads
> + *    return).
> + *
> + * 4) "Raw" read operations return a direct view of the physical bytes in the
> + *    page, using the conventional definition of which bytes are data and which
> + *    are OOB. This gives the caller a way to see the actual, physical bytes
> + *    in the page, without the distortions applied by our ECC engine.
> + *
> + *
> + * What we do for this specific read operation depends on two questions:
> + *
> + * 1) Are we doing a "raw" read, or an ECC-based read?
> + *
> + * 2) Are we using block mark swapping or transcription?
> + *
> + * There are four cases, illustrated by the following Karnaugh map:
> + *
> + *                    |           Raw           |         ECC-based       |
> + *       -------------+-------------------------+-------------------------+
> + *                    | Read the conventional   |                         |
> + *                    | OOB at the end of the   |                         |
> + *       Swapping     | page and return it. It  |                         |
> + *                    | contains exactly what   |                         |
> + *                    | we want.                | Read the block mark and |
> + *       -------------+-------------------------+ return it in a buffer   |
> + *                    | Read the conventional   | full of set bits.       |
> + *                    | OOB at the end of the   |                         |
> + *                    | page and also the block |                         |
> + *       Transcribing | mark in the metadata.   |                         |
> + *                    | Copy the block mark     |                         |
> + *                    | into the first byte of  |                         |
> + *                    | the OOB.                |                         |
> + *       -------------+-------------------------+-------------------------+
> + *
> + * Note that we break rule #4 in the Transcribing/Raw case because we're not
> + * giving an accurate view of the actual, physical bytes in the page (we're
> + * overwriting the block mark). That's OK because it's more important to follow
> + * rule #2.
> + *
> + * It turns out that knowing whether we want an "ECC-based" or "raw" read is not
> + * easy. When reading a page, for example, the NAND Flash MTD code calls our
> + * ecc.read_page or ecc.read_page_raw function. Thus, the fact that MTD wants an
> + * ECC-based or raw view of the page is implicit in which function it calls
> + * (there is a similar pair of ECC-based/raw functions for writing).
> + *
> + * Since MTD assumes the OOB is not covered by ECC, there is no pair of
> + * ECC-based/raw functions for reading or or writing the OOB. The fact that the
> + * caller wants an ECC-based or raw view of the page is not propagated down to
> + * this driver.
> + *
> + * @mtd:     A pointer to the owning MTD.
> + * @nand:    A pointer to the owning NAND Flash MTD.
> + * @page:    The page number to read.
> + * @sndcmd:  Indicates this function should send a command to the chip before
> + *           reading the out-of-band bytes. This is only false for small page
> + *           chips that support auto-increment.
> + */
> +static int mil_ecc_read_oob(struct mtd_info *mtd, struct nand_chip *nand,
> +							int page, int sndcmd)
> +{
> +	struct gpmi_nfc_data      *this     = nand->priv;
> +	struct boot_rom_helper    *rom      =  this->rom;
> +
> +	/* clear the OOB buffer */
> +	memset(nand->oob_poi, ~0, mtd->oobsize);
> +
> +	/* Read out the conventional OOB. */
> +	nand->cmdfunc(mtd, NAND_CMD_READ0, mtd->writesize, page);
> +	nand->read_buf(mtd, nand->oob_poi, mtd->oobsize);
> +
> +	/*
> +	 * Now, we want to make sure the block mark is correct. In the
> +	 * Swapping/Raw case, we already have it. Otherwise, we need to
> +	 * explicitly read it.
> +	 */
> +	if (!rom->swap_block_mark) {
> +		/* Read the block mark into the first byte of the OOB buffer. */
> +		nand->cmdfunc(mtd, NAND_CMD_READ0, 0, page);
> +		nand->oob_poi[0] = nand->read_byte(mtd);
> +	}
> +
> +	/*
> +	 * Return true, indicating that the next call to this function must send
> +	 * a command.
> +	 */
> +	return true;
> +}
> +
> +static int mil_ecc_write_oob(struct mtd_info *mtd,
> +					struct nand_chip *nand, int page)
> +{
> +	struct gpmi_nfc_data      *this     = nand->priv;
> +	struct device             *dev      =  this->dev;
> +	struct mil                *mil      = &this->mil;
> +	struct boot_rom_helper    *rom      =  this->rom;
> +	uint8_t                   block_mark = 0;
> +	int                       block_mark_column;
> +	int                       status;
> +	int                       error = 0;
> +
> +	/*
> +	 * There are fundamental incompatibilities between the i.MX GPMI NFC and
> +	 * the NAND Flash MTD model that make it essentially impossible to write
> +	 * the out-of-band bytes.
> +	 *
> +	 * We permit *ONE* exception. If the *intent* of writing the OOB is to
> +	 * mark a block bad, we can do that.
> +	 */
> +	if (!mil->marking_a_bad_block) {
> +		dev_emerg(dev, "This driver doesn't support writing the OOB\n");
> +		WARN_ON(1);
> +		error = -EIO;
> +		goto exit;
> +	}
> +
> +	/*
> +	 * If control arrives here, we're marking a block bad. First, figure out
> +	 * where the block mark is.
> +	 *
> +	 * If we're using swapping, the block mark is in the conventional
> +	 * location. Otherwise, we're using transcription, and the block mark
> +	 * appears in the first byte of the page.
> +	 */
> +	if (rom->swap_block_mark)
> +		block_mark_column = mtd->writesize;
> +	else
> +		block_mark_column = 0;
> +
> +	/* Write the block mark. */
> +	nand->cmdfunc(mtd, NAND_CMD_SEQIN, block_mark_column, page);
> +	nand->write_buf(mtd, &block_mark, 1);
>
DMA mapping memory from stack again.

> +	nand->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
> +
> +	status = nand->waitfunc(mtd, nand);
> +
> +	/* Check if it worked. */
> +	if (status & NAND_STATUS_FAIL)
> +		error = -EIO;
> +exit:
> +	return error;
> +}
> +
> +/**
> + * mil_block_bad - Claims all blocks are good.
> + *
> + * In principle, this function is *only* called when the NAND Flash MTD system
> + * isn't allowed to keep an in-memory bad block table, so it is forced to ask
> + * the driver for bad block information.
> + *
> + * In fact, we permit the NAND Flash MTD system to have an in-memory BBT, so
> + * this function is *only* called when we take it away.
> + *
> + * We take away the in-memory BBT when the user sets the "ignorebad" parameter,
> + * which indicates that all blocks should be reported good.
> + *
> + * Thus, this function is only called when we want *all* blocks to look good,
> + * so it *always* return success.
> + *
> + * @mtd:      Ignored.
> + * @ofs:      Ignored.
> + * @getchip:  Ignored.
> + */
> +static int mil_block_bad(struct mtd_info *mtd, loff_t ofs, int getchip)
> +{
> +	return 0;
> +}
> +
> +/* Set up the Boot ROM Helper geometry. */
> +static int mil_set_boot_rom_helper_geometry(struct gpmi_nfc_data  *this)
> +{
> +	struct boot_rom_helper    *rom =  this->rom;
> +	struct boot_rom_geometry  *geo = &this->rom_geometry;
> +
> +	if (rom->set_geometry(this))
> +		return !0;
> +
> +	pr_info("--------------------------------------------\n");
> +	pr_info("	Boot ROM Geometry\n");
> +	pr_info("--------------------------------------------\n");
> +	pr_info("Boot Area Count            : %u\n", geo->boot_area_count);
> +	pr_info("Boot Area Size in Bytes    : %u (0x%x)\n",
> +					geo->boot_area_size_in_bytes,
> +					geo->boot_area_size_in_bytes);
> +	pr_info("Stride Size in Pages       : %u\n", geo->stride_size_in_pages);
> +	pr_info("Search Area Stride Exponent: %u\n",
> +					geo->search_area_stride_exponent);
> +	return 0;
> +}
> +
> +static int mil_set_geometry(struct gpmi_nfc_data *this)
> +{
> +	struct nfc_hal *nfc = this->nfc;
> +	struct nfc_geometry *geo = &this->nfc_geometry;
> +
> +	/* Free the temporary DMA memory for read ID case */
> +	mil_free_dma_buffer(this);
> +
> +	/* Set up the NFC geometry which is used by BCH. */
> +	if (nfc->set_geometry(this))
> +		return -ENXIO;
>
Promote the error code returned by set_geometry().

> +	pr_info("---------------------------------------\n");
> +	pr_info("	NFC Geometry (used by BCH)\n");
> +	pr_info("---------------------------------------\n");
> +	pr_info("ECC Algorithm          : %s\n", geo->ecc_algorithm);
> +	pr_info("ECC Strength           : %u\n", geo->ecc_strength);
> +	pr_info("Page Size in Bytes     : %u\n", geo->page_size_in_bytes);
> +	pr_info("Metadata Size in Bytes : %u\n", geo->metadata_size_in_bytes);
> +	pr_info("ECC Chunk Size in Bytes: %u\n", geo->ecc_chunk_size_in_bytes);
> +	pr_info("ECC Chunk Count        : %u\n", geo->ecc_chunk_count);
> +	pr_info("Payload Size in Bytes  : %u\n", geo->payload_size_in_bytes);
> +	pr_info("Auxiliary Size in Bytes: %u\n", geo->auxiliary_size_in_bytes);
> +	pr_info("Auxiliary Status Offset: %u\n", geo->auxiliary_status_offset);
> +	pr_info("Block Mark Byte Offset : %u\n", geo->block_mark_byte_offset);
> +	pr_info("Block Mark Bit Offset  : %u\n", geo->block_mark_bit_offset);
> +
> +	/* Alloc the new DMA buffers according to the pagesize and oobsize */
> +	return mil_alloc_dma_buffer(this);
> +}
> +
> +static int mil_pre_bbt_scan(struct gpmi_nfc_data  *this)
> +{
> +	struct boot_rom_helper	*rom	= this->rom;
> +	int			error	= 0;
> +
> +	if (mil_set_boot_rom_helper_geometry(this))
> +		return -ENXIO;
>
Promote the error code returned by mil_set_boot_rom_helper_geometry().
> +
> +	/* This is ROM arch-specific initilization before the BBT scanning. */
> +	if (rom->rom_extra_init)
> +		error = rom->rom_extra_init(this);
> +	return error;
> +}
> +
> +static int mil_scan_bbt(struct mtd_info *mtd)
> +{
> +	struct nand_chip         *nand = mtd->priv;
> +	struct gpmi_nfc_data     *this = nand->priv;
> +	int                      error;
> +
> +	/* Prepare for the BBT scan. */
> +	error = mil_pre_bbt_scan(this);
> +	if (error)
> +		return error;
> +
> +	/* use the default BBT implementation */
> +	return nand_default_bbt(mtd);
> +}
> +
> +static int mil_boot_areas_init(struct gpmi_nfc_data *this)
> +{
> +	struct boot_rom_geometry       *rom      = &this->rom_geometry;
> +	struct mil                     *mil      = &this->mil;
> +	struct mtd_info                *mtd      = &mil->mtd;
> +
> +	if (rom->boot_area_count == 0) {
> +		mil->general_use_mtd = &mil->mtd;
> +		pr_info("There is no Boot area.\n");
> +	} else if (rom->boot_area_count == 1) {
> +		static char  *chip_0_boot_name = "gpmi-nfc-0-boot";
> +		static char  *general_use_name = "gpmi-nfc-general-use";
> +		struct mtd_partition partitions[2];
> +
> +		pr_info("Boot area protection is enabled.\n");
> +		/*
> +		 * We partition the medium like so:
> +		 *
> +		 * +------+----------------------------------------------------+
> +		 * | Boot |                    General Use                     |
> +		 * +------+----------------------------------------------------+
> +		 */
> +
> +		/* Chip 0 Boot */
> +		partitions[0].name       = chip_0_boot_name;
> +		partitions[0].offset     = 0;
> +		partitions[0].size       = rom->boot_area_size_in_bytes;
> +		partitions[0].mask_flags = 0;
> +
> +		/* General Use */
> +		partitions[1].name       = general_use_name;
> +		partitions[1].offset     = rom->boot_area_size_in_bytes;
> +		partitions[1].size       = MTDPART_SIZ_FULL;
> +		partitions[1].mask_flags = 0;
> +
> +		/* Construct and register the partitions. */
> +		add_mtd_partitions(mtd, partitions, 2);
> +
> +		/* Find the general use MTD. */
> +		mil->general_use_mtd = get_mtd_device_nm(general_use_name);
> +		if (IS_ERR(mil->general_use_mtd)) {
> +			log("Can't find general use MTD");
> +			BUG();
> +		}
> +	} else {
> +		log("Boot area count greater than one is unimplemented.");
> +		return -ENXIO;
> +	}
> +	return 0;
> +}
> +
> +static void mil_boot_areas_exit(struct gpmi_nfc_data *this)
> +{
> +	struct boot_rom_geometry  *rom = &this->rom_geometry;
> +	struct mil                *mil = &this->mil;
> +	struct mtd_info           *mtd = &mil->mtd;
> +
> +	if (!rom->boot_area_count) {
> +		mil->general_use_mtd = NULL;
> +		return;
> +	}
> +	del_mtd_partitions(mtd);
> +	mil->general_use_mtd = NULL;
> +}
> +
> +static int construct_general_use_partitions(struct gpmi_nfc_data *this)
> +{
> +	struct mil                     *mil   = &this->mil;
> +	unsigned int                   partition_count;
> +	struct mtd_partition           *partitions;
> +	unsigned int                   name_size;
> +	char                           *names;
> +	unsigned int                   size;
> +	unsigned int                   i;
> +	static const char              *name_prefix = "gpmi-nfc-ubi-";
> +
> +	/* Only handle the MTD which is larger than 2GiB. */
> +	if (mil->general_use_mtd->size <= SZ_2G)
> +		return 0;
> +
> +	/* Split it by 2G for historical reason*/
> +	partition_count = mil->general_use_mtd->size >> 31;
> +	if (mil->general_use_mtd->size & ((1 << 30) - 1))
> +		partition_count++;
> +
> +	/* construct the partitions */
> +	name_size = strlen(name_prefix) + 4;
> +	size = (sizeof(*partitions) + name_size) * partition_count;
> +	partitions = kzalloc(size, GFP_KERNEL);
> +	if (!partitions) {
> +		log("Could not allocate memory for UBI partitions.");
> +		return -ENOMEM;
> +	}
> +
> +	names = (char *)(partitions + partition_count);
> +	for (i = 0; i < partition_count; i++) {
> +		partitions[i].name   = names;
> +		partitions[i].size   = SZ_2G;
> +		partitions[i].offset = MTDPART_OFS_NXTBLK;
> +
> +		sprintf(names, "%s%u", name_prefix, i);
> +		names += name_size;
> +	}
> +	/* Adjust the last partition to take up the remainder. */
> +	partitions[i - 1].size = MTDPART_SIZ_FULL;
> +
> +	mil->partitions           = partitions;
> +	mil->partition_count      = partition_count;
> +	return 0;
> +}
> +
> +static int mil_partitions_init(struct gpmi_nfc_data *this)
> +{
> +	struct mil *mil = &this->mil;
> +	int  error;
> +
> +	error = mil_boot_areas_init(this);
> +	if (error)
> +		return error;
> +
> +	/* Construct partitions */
> +	error = construct_general_use_partitions(this);
> +	if (error) {
> +		log("error : %d", error);
> +		return error;
> +	}
> +	if (mil->partition_count)
> +		add_mtd_partitions(mil->general_use_mtd, mil->partitions,
> +					mil->partition_count);
> +	return 0;
> +}
> +
> +static void mil_partitions_exit(struct gpmi_nfc_data *this)
> +{
> +	struct mil *mil = &this->mil;
> +
> +	if (mil->partition_count) {
> +		del_mtd_partitions(mil->general_use_mtd);
> +		kfree(mil->partitions);
> +		mil->partition_count = 0;
> +	}
> +	mil_boot_areas_exit(this);
> +}
> +
> +/*
> + * This function is used to set the mtd->pagesize, mtd->oobsize,
> + * mtd->erasesize. Yes, we also do some initialization.
> + *
> + * Return with the bus width. 0 for 8-bit, -1 for error.
> + */
> +static int gpmi_init_size(struct mtd_info *mtd, struct nand_chip *nand,
> +				u8 *id_bytes)
> +{
> +	struct gpmi_nfc_data *this	= nand->priv;
> +	struct nfc_hal       *nfc	= this->nfc;
> +	struct mil           *mil	= &this->mil;
> +	struct nand_ecclayout *layout	= &mil->oob_layout;
> +	struct nand_device_info  *info;
> +	struct nand_attr	 *attr;
> +	int error;
> +
> +	/* Look up this device in our own database. */
> +	info = nand_device_get_info(id_bytes);
> +	if (!info) {
> +		pr_err("Unrecognized NAND Flash device.\n");
> +		return -1;
> +	}
> +
> +	attr = &info->attr;
> +	/*
> +	 *  Init the right NAND/MTD parameters which will be used
> +	 *  in the following mil_set_geometry().
> +	 */
> +	mtd->writesize	= 1 << (fls(attr->page_total_size_in_bytes) - 1);
> +	mtd->erasesize	= mtd->writesize * attr->block_size_in_pages;
> +	mtd->oobsize	= attr->page_total_size_in_bytes - mtd->writesize;
> +	nand->chipsize	= attr->chip_size_in_bytes;
> +
> +	/* Configure the struct nand_ecclayout. */
> +	layout->eccbytes          = 0;
> +	layout->oobavail          = mtd->oobsize;
> +	layout->oobfree[0].offset = 0;
> +	layout->oobfree[0].length = mtd->oobsize;
> +
> +	nand->ecc.layout = layout;
> +
> +	/*
> +	 * Copy the device info into the per-device data. We can't just keep
> +	 * the pointer because that storage is reclaimed after initialization.
> +	 */
> +	this->device_info = *info;
> +	this->device_info.desc = kstrdup(info->desc, GFP_KERNEL);
> +
> +	/* Set up the medium geometry */
> +	error = mil_set_geometry(this);
> +	if (error)
> +		return -1;
> +
> +	/* Set up timing. */
> +	error = nfc->set_timing(this, &info->timing);
> +	if (error)
> +		return -1;
> +
> +	if (nfc->extra_init) {
> +		error = nfc->extra_init(this);
> +		if (error != 0)
> +			return -1;
> +	}
> +
> +	/* We only use 8-bit bus now, not 16-bit. */
> +	return 0;
> +}
> +
> +/* Initializes the MTD Interface Layer */
> +int gpmi_nfc_mil_init(struct gpmi_nfc_data *this)
> +{
> +	struct gpmi_nfc_platform_data  *pdata =  this->pdata;
> +	struct mil                     *mil   = &this->mil;
> +	struct mtd_info                *mtd   = &mil->mtd;
> +	struct nand_chip               *nand  = &mil->nand;
> +	int                            error = 0;
>
Useless initialization.

> +	/* Initialize MIL data */
> +	mil->current_chip	= -1;
> +	mil->command_length	=  0;
> +	mil->page_buffer_virt	=  0;
> +	mil->page_buffer_phys	= ~0;
> +	mil->page_buffer_size	=  0;
> +
> +	/* Initialize the MTD data structures */
> +	mtd->priv		= nand;
> +	mtd->name		= "gpmi-nfc-main";
> +	mtd->owner		= THIS_MODULE;
> +	nand->priv		= this;
> +
> +	/* Controls */
> +	nand->select_chip	= mil_select_chip;
> +	nand->cmd_ctrl		= mil_cmd_ctrl;
> +	nand->dev_ready		= mil_dev_ready;
> +
> +	/*
> +	 * Low-level I/O :
> +	 *	We don't support a 16-bit NAND Flash bus,
> +	 *	so we don't implement read_word.
> +	 */
> +	nand->read_byte		= mil_read_byte;
> +	nand->read_buf		= mil_read_buf;
> +	nand->write_buf		= mil_write_buf;
> +
> +	/* ECC-aware I/O */
> +	nand->ecc.read_page	= mil_ecc_read_page;
> +	nand->ecc.write_page	= mil_ecc_write_page;
> +
> +	/* High-level I/O */
> +	nand->ecc.read_oob	= mil_ecc_read_oob;
> +	nand->ecc.write_oob	= mil_ecc_write_oob;
> +
> +	/* Bad Block Management */
> +	nand->block_bad		= mil_block_bad;
> +	nand->scan_bbt		= mil_scan_bbt;
> +	nand->init_size		= gpmi_init_size;
> +	nand->badblock_pattern	= &gpmi_bbt_descr;
> +
> +	/* Disallow partial page writes */
> +	nand->options		|= NAND_NO_SUBPAGE_WRITE;
> +
> +	/*
> +	 * Tell the NAND Flash MTD system that we'll be handling ECC with our
> +	 * own hardware. It turns out that we still have to fill in the ECC size
> +	 * because the MTD code will divide by it -- even though it doesn't
> +	 * actually care.
> +	 */
> +	nand->ecc.mode		= NAND_ECC_HW;
>
IMO this should be NAND_ECC_HW_SYNDROME.


Lothar Wa??mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra??e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch??ftsf??hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
