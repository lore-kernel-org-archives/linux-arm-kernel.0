From: b32955@freescale.com (Huang Shijie)
Date: Fri, 08 Jul 2011 16:46:48 -0000
Subject: [PATCH V3 4/6] MTD : add the common code for GPMI controller driver
In-Reply-To: <1301474413-28821-1-git-send-email-b32955@freescale.com>
References: <1301474413-28821-1-git-send-email-b32955@freescale.com>
Message-ID: <1301474413-28821-5-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These files contain the common code for the GPMI driver.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/gpmi-nfc/gpmi-nfc-main.c | 2451 +++++++++++++++++++++++++++++
 drivers/mtd/nand/gpmi-nfc/gpmi-nfc.h      |  549 +++++++
 2 files changed, 3000 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mtd/nand/gpmi-nfc/gpmi-nfc-main.c
 create mode 100644 drivers/mtd/nand/gpmi-nfc/gpmi-nfc.h

diff --git a/drivers/mtd/nand/gpmi-nfc/gpmi-nfc-main.c b/drivers/mtd/nand/gpmi-nfc/gpmi-nfc-main.c
new file mode 100644
index 0000000..ea7dfa7
--- /dev/null
+++ b/drivers/mtd/nand/gpmi-nfc/gpmi-nfc-main.c
@@ -0,0 +1,2451 @@
+/*
+ * Freescale GPMI NFC NAND Flash Driver
+ *
+ * Copyright (C) 2010-2011 Freescale Semiconductor, Inc.
+ * Copyright (C) 2008 Embedded Alley Solutions, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+#include <linux/slab.h>
+#include "gpmi-nfc.h"
+
+/* add our owner bbt descriptor */
+static uint8_t scan_ff_pattern[] = { 0xff };
+static struct nand_bbt_descr gpmi_bbt_descr = {
+	.options	= 0,
+	.offs		= 0,
+	.len		= 1,
+	.pattern	= scan_ff_pattern
+};
+
+/* debug control */
+int gpmi_debug;
+
+static ssize_t show_gpmi_debug(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", gpmi_debug);
+}
+
+static ssize_t
+store_gpmi_debug(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t size)
+{
+	const char *p = buf;
+	unsigned long v;
+
+	if (strict_strtoul(p, 0, &v) < 0)
+		return size;
+
+	gpmi_debug = v;
+	return size;
+}
+
+static ssize_t show_ignorebad(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct gpmi_nfc_data  *this = dev_get_drvdata(dev);
+	struct mil            *mil  = &this->mil;
+
+	return sprintf(buf, "%d\n", mil->ignore_bad_block_marks);
+}
+
+/* Sets the value of the 'ignorebad' flag. */
+static ssize_t
+store_ignorebad(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t size)
+{
+	struct gpmi_nfc_data  *this = dev_get_drvdata(dev);
+	struct mil            *mil  = &this->mil;
+	const char            *p = buf;
+	unsigned long         v;
+
+	/* Try to make sense of what arrived from user space. */
+	if (strict_strtoul(p, 0, &v) < 0)
+		return size;
+
+	if (v > 0)
+		v = 1;
+
+	if (v != mil->ignore_bad_block_marks) {
+		if (v) {
+			/*
+			 * If control arrives here, we want to begin ignoring
+			 * bad block marks. Reach into the NAND Flash MTD data
+			 * structures and set the in-memory BBT pointer to NULL.
+			 * This will cause the NAND Flash MTD code to believe
+			 * that it never created a BBT and force it to call our
+			 * block_bad function.
+			 *
+			 * See mil_block_bad for more details.
+			 */
+			mil->saved_bbt = mil->nand.bbt;
+			mil->nand.bbt  = 0;
+		} else {
+			/*
+			 * If control arrives here, we want to stop ignoring
+			 * bad block marks. Restore the NAND Flash MTD's pointer
+			 * to its in-memory BBT.
+			 */
+			mil->nand.bbt = mil->saved_bbt;
+		}
+		mil->ignore_bad_block_marks = v;
+	}
+	return size;
+}
+
+/* Device attributes that appear in sysfs. */
+static DEVICE_ATTR(ignorebad, 0644, show_ignorebad, store_ignorebad);
+static DEVICE_ATTR(gpmi_debug, 0644, show_gpmi_debug, store_gpmi_debug);
+static struct device_attribute *device_attributes[] = {
+	&dev_attr_ignorebad,
+	&dev_attr_gpmi_debug,
+};
+
+irqreturn_t bch_irq(int irq, void *cookie)
+{
+	struct gpmi_nfc_data  *this = cookie;
+	struct nfc_hal        *nfc  = this->nfc;
+
+	/* Clear the BCH interrupt */
+	nfc->clear_bch(this);
+
+	complete(&nfc->bch_done);
+	return IRQ_HANDLED;
+}
+
+/* get the ECC strength */
+static inline int get_ecc_strength(struct gpmi_nfc_data *this)
+{
+	return this->device_info.attr.ecc_strength_in_bits;
+}
+
+static inline int get_ecc_chunk_size(struct gpmi_nfc_data *this)
+{
+	return this->device_info.attr.ecc_size_in_bytes;
+}
+
+static inline bool is_ddr_nand(struct nand_chip *chip)
+{
+	return chip->onfi_version != 0;
+}
+
+int common_nfc_set_geometry(struct gpmi_nfc_data *this)
+{
+	struct nfc_geometry       *geo = &this->nfc_geometry;
+	struct boot_rom_helper    *rom =  this->rom;
+	struct mtd_info		  *mtd = &this->mil.mtd;
+	struct nand_chip	*chip = &this->mil.nand;
+	unsigned int              metadata_size;
+	unsigned int              status_size;
+	unsigned int              chunk_data_size_in_bits;
+	unsigned int              chunk_ecc_size_in_bits;
+	unsigned int              chunk_total_size_in_bits;
+	unsigned int              block_mark_chunk_number;
+	unsigned int              block_mark_chunk_bit_offset;
+	unsigned int              block_mark_bit_offset;
+
+	/* We only support BCH now. */
+	geo->ecc_algorithm = "BCH";
+
+	/*
+	 * We always choose a metadata size of 10. Don't try to make sense of
+	 * it -- this is really only for historical compatibility.
+	 */
+	geo->metadata_size_in_bytes = 10;
+
+	/* ECC chunks */
+	geo->ecc_chunk_size_in_bytes = get_ecc_chunk_size(this);
+
+	/*
+	 * Compute the total number of ECC chunks in a page. This includes the
+	 * slightly larger chunk at the beginning of the page, which contains
+	 * both data and metadata.
+	 */
+	geo->ecc_chunk_count = mtd->writesize / geo->ecc_chunk_size_in_bytes;
+
+	/*
+	 * We use the same ECC strength for all chunks, including the first one.
+	 */
+	geo->ecc_strength = get_ecc_strength(this);
+	if (!geo->ecc_strength) {
+		log("Unsupported page geometry.");
+		return -EINVAL;
+	}
+
+	/* Compute the page size, include page and oob. */
+	geo->page_size_in_bytes = mtd->writesize + mtd->oobsize;
+
+	/*
+	 * ONFI/TOGGLE nand needs GF14, so re-culculate DMA page size.
+	 * The ONFI nand must do the reculation,
+	 * else it will fail in DMA in some platform(such as imx50).
+	 */
+	if (is_ddr_nand(chip))
+		geo->page_size_in_bytes = mtd->writesize +
+				geo->metadata_size_in_bytes +
+			(geo->ecc_strength * 14 * 8 / geo->ecc_chunk_count);
+
+	/*
+	 * The payload buffer contains the data area of a page. The ECC engine
+	 * only needs what's required to hold the data.
+	 */
+	geo->payload_size_in_bytes = mtd->writesize;
+
+	/*
+	 * In principle, computing the auxiliary buffer geometry is NFC
+	 * version-specific. However, at this writing, all versions share the
+	 * same model, so this code can also be shared.
+	 *
+	 * The auxiliary buffer contains the metadata and the ECC status. The
+	 * metadata is padded to the nearest 32-bit boundary. The ECC status
+	 * contains one byte for every ECC chunk, and is also padded to the
+	 * nearest 32-bit boundary.
+	 */
+	metadata_size = (geo->metadata_size_in_bytes + 0x3) & ~0x3;
+	status_size   = (geo->ecc_chunk_count        + 0x3) & ~0x3;
+
+	geo->auxiliary_size_in_bytes = metadata_size + status_size;
+	geo->auxiliary_status_offset = metadata_size;
+
+	/* Check if we're going to do block mark swapping. */
+	if (!rom->swap_block_mark)
+		return 0;
+
+	/*
+	 * If control arrives here, we're doing block mark swapping, so we need
+	 * to compute the byte and bit offsets of the physical block mark within
+	 * the ECC-based view of the page data. In principle, this isn't a
+	 * difficult computation -- but it's very important and it's easy to get
+	 * it wrong, so we do it carefully.
+	 *
+	 * Note that this calculation is simpler because we use the same ECC
+	 * strength for all chunks, including the zero'th one, which contains
+	 * the metadata. The calculation would be slightly more complicated
+	 * otherwise.
+	 *
+	 * We start by computing the physical bit offset of the block mark. We
+	 * then subtract the number of metadata and ECC bits appearing before
+	 * the mark to arrive at its bit offset within the data alone.
+	 */
+
+	/* Compute some important facts about chunk geometry. */
+	chunk_data_size_in_bits = geo->ecc_chunk_size_in_bytes * 8;
+
+	/* ONFI/TOGGLE nand needs GF14 */
+	if (is_ddr_nand(chip))
+		chunk_ecc_size_in_bits  = geo->ecc_strength * 14;
+	else
+		chunk_ecc_size_in_bits  = geo->ecc_strength * 13;
+
+	chunk_total_size_in_bits =
+			chunk_data_size_in_bits + chunk_ecc_size_in_bits;
+
+	/* Compute the bit offset of the block mark within the physical page. */
+	block_mark_bit_offset = mtd->writesize * 8;
+
+	/* Subtract the metadata bits. */
+	block_mark_bit_offset -= geo->metadata_size_in_bytes * 8;
+
+	/*
+	 * Compute the chunk number (starting at zero) in which the block mark
+	 * appears.
+	 */
+	block_mark_chunk_number =
+			block_mark_bit_offset / chunk_total_size_in_bits;
+
+	/*
+	 * Compute the bit offset of the block mark within its chunk, and
+	 * validate it.
+	 */
+	block_mark_chunk_bit_offset =
+		block_mark_bit_offset -
+			(block_mark_chunk_number * chunk_total_size_in_bits);
+
+	if (block_mark_chunk_bit_offset > chunk_data_size_in_bits) {
+		/*
+		 * If control arrives here, the block mark actually appears in
+		 * the ECC bits of this chunk. This wont' work.
+		 */
+		log("Unsupported page geometry (block mark in ECC): %u:%u",
+					mtd->writesize, mtd->oobsize);
+		return !0;
+	}
+
+	/*
+	 * Now that we know the chunk number in which the block mark appears,
+	 * we can subtract all the ECC bits that appear before it.
+	 */
+	block_mark_bit_offset -=
+			block_mark_chunk_number * chunk_ecc_size_in_bits;
+
+	/*
+	 * We now know the absolute bit offset of the block mark within the
+	 * ECC-based data. We can now compute the byte offset and the bit
+	 * offset within the byte.
+	 */
+	geo->block_mark_byte_offset = block_mark_bit_offset / 8;
+	geo->block_mark_bit_offset  = block_mark_bit_offset % 8;
+
+	return 0;
+}
+
+struct dma_chan *get_dma_chan(struct gpmi_nfc_data *this)
+{
+	int chip = this->mil.current_chip;
+
+	BUG_ON(chip < 0);
+	return this->dma_chans[chip];
+}
+
+/* Can we use the upper's buffer directly for DMA? */
+void prepare_data_dma(struct gpmi_nfc_data *this, enum dma_data_direction dr)
+{
+	struct mil *mil = &this->mil;
+	struct scatterlist *sgl = &mil->data_sgl;
+	int ret;
+
+	mil->direct_dma_map_ok = true;
+
+	/* first try to map the upper buffer directly */
+	sg_init_one(sgl, mil->upper_buf, mil->upper_len);
+	ret = dma_map_sg(this->dev, sgl, 1, dr);
+	if (ret == 0) {
+		/* We have to use our own DMA buffer. */
+		sg_init_one(sgl, mil->data_buffer_dma, PAGE_SIZE);
+
+		if (dr == DMA_TO_DEVICE)
+			memcpy(mil->data_buffer_dma, mil->upper_buf,
+				mil->upper_len);
+
+		ret = dma_map_sg(this->dev, sgl, 1, dr);
+		BUG_ON(ret == 0);
+
+		mil->direct_dma_map_ok = false;
+	}
+}
+
+/* This will be called after the DMA operation is finished. */
+static void dma_irq_callback(void *param)
+{
+	struct gpmi_nfc_data *this = param;
+	struct nfc_hal *nfc = this->nfc;
+	struct mil *mil = &this->mil;
+
+	complete(&nfc->dma_done);
+
+	switch (this->dma_type) {
+	case DMA_FOR_COMMAND:
+		dma_unmap_sg(this->dev, &mil->cmd_sgl, 1, DMA_TO_DEVICE);
+		break;
+
+	case DMA_FOR_READ_DATA:
+		dma_unmap_sg(this->dev, &mil->data_sgl, 1, DMA_FROM_DEVICE);
+		if (mil->direct_dma_map_ok == false)
+			memcpy(mil->upper_buf, (char *)mil->data_buffer_dma,
+				mil->upper_len);
+		break;
+
+	case DMA_FOR_WRITE_DATA:
+		dma_unmap_sg(this->dev, &mil->data_sgl, 1, DMA_TO_DEVICE);
+		break;
+
+	case DMA_FOR_READ_ECC_PAGE:
+	case DMA_FOR_WRITE_ECC_PAGE:
+		/* We have to wait the BCH interrupt to finish. */
+		break;
+
+	default:
+		BUG();
+	}
+}
+
+int start_dma_without_bch_irq(struct gpmi_nfc_data *this,
+				struct dma_async_tx_descriptor *desc)
+{
+	struct nfc_hal *nfc = this->nfc;
+	int err;
+
+	init_completion(&nfc->dma_done);
+
+	desc->callback		= dma_irq_callback;
+	desc->callback_param	= this;
+	dmaengine_submit(desc);
+
+	/* Wait for the interrupt from the DMA block. */
+	err = wait_for_completion_timeout(&nfc->dma_done,
+					msecs_to_jiffies(1000));
+	err = (!err) ? -ETIMEDOUT : 0;
+	if (err)
+		log("DMA timeout!!!");
+	return err;
+}
+
+/*
+ * This function is used in BCH reading or BCH writing pages.
+ * It will wait for the BCH interrupt as long as ONE second.
+ * Actually, we must wait for two interrupts :
+ *	[1] firstly the DMA interrupt and
+ *	[2] secondly the BCH interrupt.
+ *
+ * @this:	Per-device data structure.
+ * @desc:	DMA channel
+ */
+int start_dma_with_bch_irq(struct gpmi_nfc_data *this,
+			struct dma_async_tx_descriptor *desc)
+{
+	struct nfc_hal *nfc = this->nfc;
+	int err;
+
+	/* Prepare to receive an interrupt from the BCH block. */
+	init_completion(&nfc->bch_done);
+
+	/* start the DMA */
+	start_dma_without_bch_irq(this, desc);
+
+	/* Wait for the interrupt from the BCH block. */
+	err = wait_for_completion_timeout(&nfc->bch_done,
+					msecs_to_jiffies(1000));
+	err = (!err) ? -ETIMEDOUT : 0;
+	if (err)
+		log("bch timeout!!!");
+	return err;
+}
+
+/**
+ * ns_to_cycles - Converts time in nanoseconds to cycles.
+ *
+ * @ntime:   The time, in nanoseconds.
+ * @period:  The cycle period, in nanoseconds.
+ * @min:     The minimum allowable number of cycles.
+ */
+static unsigned int ns_to_cycles(unsigned int time,
+					unsigned int period, unsigned int min)
+{
+	unsigned int k;
+
+	/*
+	 * Compute the minimum number of cycles that entirely contain the
+	 * given time.
+	 */
+	k = (time + period - 1) / period;
+	return max(k, min);
+}
+
+/**
+ * gpmi_compute_hardware_timing - Apply timing to current hardware conditions.
+ *
+ * @this:             Per-device data.
+ * @hardware_timing:  A pointer to a hardware timing structure that will receive
+ *                    the results of our calculations.
+ */
+int gpmi_nfc_compute_hardware_timing(struct gpmi_nfc_data *this,
+					struct gpmi_nfc_hardware_timing *hw)
+{
+	struct gpmi_nfc_platform_data  *pdata	=  this->pdata;
+	struct nfc_hal                 *nfc	=  this->nfc;
+	struct nand_chip		*nand	= &this->mil.nand;
+	struct nand_timing		target	= nfc->timing;
+	bool           improved_timing_is_available;
+	unsigned long  clock_frequency_in_hz;
+	unsigned int   clock_period_in_ns;
+	bool           dll_use_half_periods;
+	unsigned int   dll_delay_shift;
+	unsigned int   max_sample_delay_in_ns;
+	unsigned int   address_setup_in_cycles;
+	unsigned int   data_setup_in_ns;
+	unsigned int   data_setup_in_cycles;
+	unsigned int   data_hold_in_cycles;
+	int            ideal_sample_delay_in_ns;
+	unsigned int   sample_delay_factor;
+	int            tEYE;
+	unsigned int   min_prop_delay_in_ns = pdata->min_prop_delay_in_ns;
+	unsigned int   max_prop_delay_in_ns = pdata->max_prop_delay_in_ns;
+
+	/*
+	 * If there are multiple chips, we need to relax the timings to allow
+	 * for signal distortion due to higher capacitance.
+	 */
+	if (nand->numchips > 2) {
+		target.data_setup_in_ns    += 10;
+		target.data_hold_in_ns     += 10;
+		target.address_setup_in_ns += 10;
+	} else if (nand->numchips > 1) {
+		target.data_setup_in_ns    += 5;
+		target.data_hold_in_ns     += 5;
+		target.address_setup_in_ns += 5;
+	}
+
+	/* Check if improved timing information is available. */
+	improved_timing_is_available =
+		(target.tREA_in_ns  >= 0) &&
+		(target.tRLOH_in_ns >= 0) &&
+		(target.tRHOH_in_ns >= 0) ;
+
+	/* Inspect the clock. */
+	clock_frequency_in_hz = nfc->clock_frequency_in_hz;
+	clock_period_in_ns    = 1000000000 / clock_frequency_in_hz;
+
+	/*
+	 * The NFC quantizes setup and hold parameters in terms of clock cycles.
+	 * Here, we quantize the setup and hold timing parameters to the
+	 * next-highest clock period to make sure we apply at least the
+	 * specified times.
+	 *
+	 * For data setup and data hold, the hardware interprets a value of zero
+	 * as the largest possible delay. This is not what's intended by a zero
+	 * in the input parameter, so we impose a minimum of one cycle.
+	 */
+	data_setup_in_cycles    = ns_to_cycles(target.data_setup_in_ns,
+							clock_period_in_ns, 1);
+	data_hold_in_cycles     = ns_to_cycles(target.data_hold_in_ns,
+							clock_period_in_ns, 1);
+	address_setup_in_cycles = ns_to_cycles(target.address_setup_in_ns,
+							clock_period_in_ns, 0);
+
+	/*
+	 * The clock's period affects the sample delay in a number of ways:
+	 *
+	 * (1) The NFC HAL tells us the maximum clock period the sample delay
+	 *     DLL can tolerate. If the clock period is greater than half that
+	 *     maximum, we must configure the DLL to be driven by half periods.
+	 *
+	 * (2) We need to convert from an ideal sample delay, in ns, to a
+	 *     "sample delay factor," which the NFC uses. This factor depends on
+	 *     whether we're driving the DLL with full or half periods.
+	 *     Paraphrasing the reference manual:
+	 *
+	 *         AD = SDF x 0.125 x RP
+	 *
+	 * where:
+	 *
+	 *     AD   is the applied delay, in ns.
+	 *     SDF  is the sample delay factor, which is dimensionless.
+	 *     RP   is the reference period, in ns, which is a full clock period
+	 *          if the DLL is being driven by full periods, or half that if
+	 *          the DLL is being driven by half periods.
+	 *
+	 * Let's re-arrange this in a way that's more useful to us:
+	 *
+	 *                        8
+	 *         SDF  =  AD x ----
+	 *                       RP
+	 *
+	 * The reference period is either the clock period or half that, so this
+	 * is:
+	 *
+	 *                        8       AD x DDF
+	 *         SDF  =  AD x -----  =  --------
+	 *                      f x P        P
+	 *
+	 * where:
+	 *
+	 *       f  is 1 or 1/2, depending on how we're driving the DLL.
+	 *       P  is the clock period.
+	 *     DDF  is the DLL Delay Factor, a dimensionless value that
+	 *          incorporates all the constants in the conversion.
+	 *
+	 * DDF will be either 8 or 16, both of which are powers of two. We can
+	 * reduce the cost of this conversion by using bit shifts instead of
+	 * multiplication or division. Thus:
+	 *
+	 *                 AD << DDS
+	 *         SDF  =  ---------
+	 *                     P
+	 *
+	 *     or
+	 *
+	 *         AD  =  (SDF >> DDS) x P
+	 *
+	 * where:
+	 *
+	 *     DDS  is the DLL Delay Shift, the logarithm to base 2 of the DDF.
+	 */
+	if (clock_period_in_ns > (nfc->max_dll_clock_period_in_ns >> 1)) {
+		dll_use_half_periods = true;
+		dll_delay_shift      = 3 + 1;
+	} else {
+		dll_use_half_periods = false;
+		dll_delay_shift      = 3;
+	}
+
+	/*
+	 * Compute the maximum sample delay the NFC allows, under current
+	 * conditions. If the clock is running too slowly, no sample delay is
+	 * possible.
+	 */
+	if (clock_period_in_ns > nfc->max_dll_clock_period_in_ns)
+		max_sample_delay_in_ns = 0;
+	else {
+		/*
+		 * Compute the delay implied by the largest sample delay factor
+		 * the NFC allows.
+		 */
+		max_sample_delay_in_ns =
+			(nfc->max_sample_delay_factor * clock_period_in_ns) >>
+								dll_delay_shift;
+
+		/*
+		 * Check if the implied sample delay larger than the NFC
+		 * actually allows.
+		 */
+		if (max_sample_delay_in_ns > nfc->max_dll_delay_in_ns)
+			max_sample_delay_in_ns = nfc->max_dll_delay_in_ns;
+	}
+
+	/*
+	 * Check if improved timing information is available. If not, we have to
+	 * use a less-sophisticated algorithm.
+	 */
+	if (!improved_timing_is_available) {
+		/*
+		 * Fold the read setup time required by the NFC into the ideal
+		 * sample delay.
+		 */
+		ideal_sample_delay_in_ns = target.gpmi_sample_delay_in_ns +
+						nfc->internal_data_setup_in_ns;
+
+		/*
+		 * The ideal sample delay may be greater than the maximum
+		 * allowed by the NFC. If so, we can trade off sample delay time
+		 * for more data setup time.
+		 *
+		 * In each iteration of the following loop, we add a cycle to
+		 * the data setup time and subtract a corresponding amount from
+		 * the sample delay until we've satisified the constraints or
+		 * can't do any better.
+		 */
+		while ((ideal_sample_delay_in_ns > max_sample_delay_in_ns) &&
+			(data_setup_in_cycles < nfc->max_data_setup_cycles)) {
+
+			data_setup_in_cycles++;
+			ideal_sample_delay_in_ns -= clock_period_in_ns;
+
+			if (ideal_sample_delay_in_ns < 0)
+				ideal_sample_delay_in_ns = 0;
+
+		}
+
+		/*
+		 * Compute the sample delay factor that corresponds most closely
+		 * to the ideal sample delay. If the result is too large for the
+		 * NFC, use the maximum value.
+		 *
+		 * Notice that we use the ns_to_cycles function to compute the
+		 * sample delay factor. We do this because the form of the
+		 * computation is the same as that for calculating cycles.
+		 */
+		sample_delay_factor =
+			ns_to_cycles(
+				ideal_sample_delay_in_ns << dll_delay_shift,
+							clock_period_in_ns, 0);
+
+		if (sample_delay_factor > nfc->max_sample_delay_factor)
+			sample_delay_factor = nfc->max_sample_delay_factor;
+
+		/* Skip to the part where we return our results. */
+		goto return_results;
+	}
+
+	/*
+	 * If control arrives here, we have more detailed timing information,
+	 * so we can use a better algorithm.
+	 */
+
+	/*
+	 * Fold the read setup time required by the NFC into the maximum
+	 * propagation delay.
+	 */
+	max_prop_delay_in_ns += nfc->internal_data_setup_in_ns;
+
+	/*
+	 * Earlier, we computed the number of clock cycles required to satisfy
+	 * the data setup time. Now, we need to know the actual nanoseconds.
+	 */
+	data_setup_in_ns = clock_period_in_ns * data_setup_in_cycles;
+
+	/*
+	 * Compute tEYE, the width of the data eye when reading from the NAND
+	 * Flash. The eye width is fundamentally determined by the data setup
+	 * time, perturbed by propagation delays and some characteristics of the
+	 * NAND Flash device.
+	 *
+	 * start of the eye = max_prop_delay + tREA
+	 * end of the eye   = min_prop_delay + tRHOH + data_setup
+	 */
+	tEYE = (int)min_prop_delay_in_ns + (int)target.tRHOH_in_ns +
+							(int)data_setup_in_ns;
+
+	tEYE -= (int)max_prop_delay_in_ns + (int)target.tREA_in_ns;
+
+	/*
+	 * The eye must be open. If it's not, we can try to open it by
+	 * increasing its main forcer, the data setup time.
+	 *
+	 * In each iteration of the following loop, we increase the data setup
+	 * time by a single clock cycle. We do this until either the eye is
+	 * open or we run into NFC limits.
+	 */
+	while ((tEYE <= 0) &&
+			(data_setup_in_cycles < nfc->max_data_setup_cycles)) {
+		/* Give a cycle to data setup. */
+		data_setup_in_cycles++;
+		/* Synchronize the data setup time with the cycles. */
+		data_setup_in_ns += clock_period_in_ns;
+		/* Adjust tEYE accordingly. */
+		tEYE += clock_period_in_ns;
+	}
+
+	/*
+	 * When control arrives here, the eye is open. The ideal time to sample
+	 * the data is in the center of the eye:
+	 *
+	 *     end of the eye + start of the eye
+	 *     ---------------------------------  -  data_setup
+	 *                    2
+	 *
+	 * After some algebra, this simplifies to the code immediately below.
+	 */
+	ideal_sample_delay_in_ns =
+		((int)max_prop_delay_in_ns +
+			(int)target.tREA_in_ns +
+				(int)min_prop_delay_in_ns +
+					(int)target.tRHOH_in_ns -
+						(int)data_setup_in_ns) >> 1;
+
+	/*
+	 * The following figure illustrates some aspects of a NAND Flash read:
+	 *
+	 *
+	 *           __                   _____________________________________
+	 * RDN         \_________________/
+	 *
+	 *                                         <---- tEYE ----->
+	 *                                        /-----------------\
+	 * Read Data ----------------------------<                   >---------
+	 *                                        \-----------------/
+	 *             ^                 ^                 ^              ^
+	 *             |                 |                 |              |
+	 *             |<--Data Setup -->|<--Delay Time -->|              |
+	 *             |                 |                 |              |
+	 *             |                 |                                |
+	 *             |                 |<--   Quantized Delay Time   -->|
+	 *             |                 |                                |
+	 *
+	 *
+	 * We have some issues we must now address:
+	 *
+	 * (1) The *ideal* sample delay time must not be negative. If it is, we
+	 *     jam it to zero.
+	 *
+	 * (2) The *ideal* sample delay time must not be greater than that
+	 *     allowed by the NFC. If it is, we can increase the data setup
+	 *     time, which will reduce the delay between the end of the data
+	 *     setup and the center of the eye. It will also make the eye
+	 *     larger, which might help with the next issue...
+	 *
+	 * (3) The *quantized* sample delay time must not fall either before the
+	 *     eye opens or after it closes (the latter is the problem
+	 *     illustrated in the above figure).
+	 */
+
+	/* Jam a negative ideal sample delay to zero. */
+	if (ideal_sample_delay_in_ns < 0)
+		ideal_sample_delay_in_ns = 0;
+
+	/*
+	 * Extend the data setup as needed to reduce the ideal sample delay
+	 * below the maximum permitted by the NFC.
+	 */
+	while ((ideal_sample_delay_in_ns > max_sample_delay_in_ns) &&
+			(data_setup_in_cycles < nfc->max_data_setup_cycles)) {
+
+		/* Give a cycle to data setup. */
+		data_setup_in_cycles++;
+		/* Synchronize the data setup time with the cycles. */
+		data_setup_in_ns += clock_period_in_ns;
+		/* Adjust tEYE accordingly. */
+		tEYE += clock_period_in_ns;
+
+		/*
+		 * Decrease the ideal sample delay by one half cycle, to keep it
+		 * in the middle of the eye.
+		 */
+		ideal_sample_delay_in_ns -= (clock_period_in_ns >> 1);
+
+		/* Jam a negative ideal sample delay to zero. */
+		if (ideal_sample_delay_in_ns < 0)
+			ideal_sample_delay_in_ns = 0;
+	}
+
+	/*
+	 * Compute the sample delay factor that corresponds to the ideal sample
+	 * delay. If the result is too large, then use the maximum allowed
+	 * value.
+	 *
+	 * Notice that we use the ns_to_cycles function to compute the sample
+	 * delay factor. We do this because the form of the computation is the
+	 * same as that for calculating cycles.
+	 */
+	sample_delay_factor =
+		ns_to_cycles(ideal_sample_delay_in_ns << dll_delay_shift,
+							clock_period_in_ns, 0);
+
+	if (sample_delay_factor > nfc->max_sample_delay_factor)
+		sample_delay_factor = nfc->max_sample_delay_factor;
+
+	/*
+	 * These macros conveniently encapsulate a computation we'll use to
+	 * continuously evaluate whether or not the data sample delay is inside
+	 * the eye.
+	 */
+	#define IDEAL_DELAY  ((int) ideal_sample_delay_in_ns)
+
+	#define QUANTIZED_DELAY  \
+		((int) ((sample_delay_factor * clock_period_in_ns) >> \
+							dll_delay_shift))
+
+	#define DELAY_ERROR  (abs(QUANTIZED_DELAY - IDEAL_DELAY))
+
+	#define SAMPLE_IS_NOT_WITHIN_THE_EYE  (DELAY_ERROR > (tEYE >> 1))
+
+	/*
+	 * While the quantized sample time falls outside the eye, reduce the
+	 * sample delay or extend the data setup to move the sampling point back
+	 * toward the eye. Do not allow the number of data setup cycles to
+	 * exceed the maximum allowed by the NFC.
+	 */
+	while (SAMPLE_IS_NOT_WITHIN_THE_EYE &&
+			(data_setup_in_cycles < nfc->max_data_setup_cycles)) {
+		/*
+		 * If control arrives here, the quantized sample delay falls
+		 * outside the eye. Check if it's before the eye opens, or after
+		 * the eye closes.
+		 */
+		if (QUANTIZED_DELAY > IDEAL_DELAY) {
+			/*
+			 * If control arrives here, the quantized sample delay
+			 * falls after the eye closes. Decrease the quantized
+			 * delay time and then go back to re-evaluate.
+			 */
+			if (sample_delay_factor != 0)
+				sample_delay_factor--;
+			continue;
+		}
+
+		/*
+		 * If control arrives here, the quantized sample delay falls
+		 * before the eye opens. Shift the sample point by increasing
+		 * data setup time. This will also make the eye larger.
+		 */
+
+		/* Give a cycle to data setup. */
+		data_setup_in_cycles++;
+		/* Synchronize the data setup time with the cycles. */
+		data_setup_in_ns += clock_period_in_ns;
+		/* Adjust tEYE accordingly. */
+		tEYE += clock_period_in_ns;
+
+		/*
+		 * Decrease the ideal sample delay by one half cycle, to keep it
+		 * in the middle of the eye.
+		 */
+		ideal_sample_delay_in_ns -= (clock_period_in_ns >> 1);
+
+		/* ...and one less period for the delay time. */
+		ideal_sample_delay_in_ns -= clock_period_in_ns;
+
+		/* Jam a negative ideal sample delay to zero. */
+		if (ideal_sample_delay_in_ns < 0)
+			ideal_sample_delay_in_ns = 0;
+
+		/*
+		 * We have a new ideal sample delay, so re-compute the quantized
+		 * delay.
+		 */
+		sample_delay_factor =
+			ns_to_cycles(
+				ideal_sample_delay_in_ns << dll_delay_shift,
+							clock_period_in_ns, 0);
+
+		if (sample_delay_factor > nfc->max_sample_delay_factor)
+			sample_delay_factor = nfc->max_sample_delay_factor;
+	}
+
+	/* Control arrives here when we're ready to return our results. */
+return_results:
+	hw->data_setup_in_cycles    = data_setup_in_cycles;
+	hw->data_hold_in_cycles     = data_hold_in_cycles;
+	hw->address_setup_in_cycles = address_setup_in_cycles;
+	hw->use_half_periods        = dll_use_half_periods;
+	hw->sample_delay_factor     = sample_delay_factor;
+
+	/* Return success. */
+	return 0;
+}
+
+int gpmi_nfc_rom_helper_set_geometry(struct gpmi_nfc_data *this)
+{
+	struct boot_rom_geometry  *geometry = &this->rom_geometry;
+
+	/*
+	 * Set the boot block stride size.
+	 *
+	 * In principle, we should be reading this from the OTP bits, since
+	 * that's where the ROM is going to get it. In fact, we don't have any
+	 * way to read the OTP bits, so we go with the default and hope for the
+	 * best.
+	 */
+	geometry->stride_size_in_pages = 64;
+
+	/*
+	 * Set the search area stride exponent.
+	 *
+	 * In principle, we should be reading this from the OTP bits, since
+	 * that's where the ROM is going to get it. In fact, we don't have any
+	 * way to read the OTP bits, so we go with the default and hope for the
+	 * best.
+	 */
+	geometry->search_area_stride_exponent = 2;
+
+	return 0;
+}
+
+static int acquire_register_block(struct gpmi_nfc_data *this,
+			const char *resource_name, void **reg_block_base)
+{
+	struct platform_device  *pdev = this->pdev;
+	struct resource         *r;
+	void                    *p;
+
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, resource_name);
+	if (!r) {
+		log("Can't get resource information for '%s'", resource_name);
+		return -ENXIO;
+	}
+
+	/* remap the register block */
+	p = ioremap(r->start, resource_size(r));
+	if (!p) {
+		log("Can't remap %s", resource_name);
+		return -ENOMEM;
+	}
+
+	*reg_block_base = p;
+	return 0;
+}
+
+static void release_register_block(struct gpmi_nfc_data *this,
+				void *reg_block_base)
+{
+	iounmap(reg_block_base);
+}
+
+static int acquire_interrupt(struct gpmi_nfc_data *this,
+			const char *resource_name,
+			irq_handler_t interrupt_handler, int *lno, int *hno)
+{
+	struct platform_device  *pdev = this->pdev;
+	struct resource         *r;
+	int                     err;
+
+	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ, resource_name);
+	if (!r) {
+		log("Can't get resource information for '%s'", resource_name);
+		return -ENXIO;
+	}
+
+	BUG_ON(r->start != r->end);
+	err = request_irq(r->start, interrupt_handler, 0, resource_name, this);
+	if (err) {
+		log("Can't own %s", resource_name);
+		return err;
+	}
+
+	*lno = r->start;
+	*hno = r->end;
+	return 0;
+}
+
+static void release_interrupt(struct gpmi_nfc_data *this,
+			int low_interrupt_number, int high_interrupt_number)
+{
+	int i;
+	for (i = low_interrupt_number; i <= high_interrupt_number; i++)
+		free_irq(i, this);
+}
+
+static bool gpmi_dma_filter(struct dma_chan *chan, void *param)
+{
+	struct gpmi_nfc_data *this = param;
+	struct resource *r = this->private;
+
+	if (!mxs_dma_is_apbh(chan))
+		return false;
+	/*
+	 * only catch the GPMI dma channels :
+	 *	for mx23 :	MX23_DMA_GPMI0 ~ MX23_DMA_GPMI3
+	 *		(These four channels share the same IRQ!)
+	 *
+	 *	for mx28 :	MX28_DMA_GPMI0 ~ MX28_DMA_GPMI7
+	 *		(These eight channels share the same IRQ!)
+	 */
+	if (r->start <= chan->chan_id && chan->chan_id <= r->end) {
+		chan->private = &this->dma_data;
+		return true;
+	}
+	return false;
+}
+
+static void release_dma_channels(struct gpmi_nfc_data *this)
+{
+	unsigned int i;
+	for (i = 0; i < DMA_CHANS; i++)
+		if (this->dma_chans[i]) {
+			dma_release_channel(this->dma_chans[i]);
+			this->dma_chans[i] = NULL;
+		}
+}
+
+static int acquire_dma_channels(struct gpmi_nfc_data *this,
+				const char *resource_name,
+				unsigned *low_channel, unsigned *high_channel)
+{
+	struct platform_device  *pdev = this->pdev;
+	struct resource         *r, *r_dma;
+	unsigned int            i;
+
+	r = platform_get_resource_byname(pdev, IORESOURCE_DMA, resource_name);
+	r_dma = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
+					GPMI_NFC_DMA_INTERRUPT_RES_NAME);
+	if (!r || !r_dma) {
+		log("Can't get resource for DMA");
+		return -ENXIO;
+	}
+
+	/* get the DMA interrupt */
+	BUG_ON(r_dma->start != r_dma->end);
+	this->dma_data.chan_irq = r_dma->start;
+
+	/* used in gpmi_dma_filter() */
+	this->private = r;
+
+	for (i = r->start; i <= r->end; i++) {
+		dma_cap_mask_t		mask;
+		struct dma_chan		*dma_chan;
+
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
+
+		dma_chan = dma_request_channel(mask, gpmi_dma_filter, this);
+		if (!dma_chan)
+			goto acquire_err;
+		/* fill the first empty item */
+		this->dma_chans[i - r->start] = dma_chan;
+	}
+
+	*low_channel  = r->start;
+	*high_channel = r->end;
+	return 0;
+
+acquire_err:
+	log("Can't acquire DMA channel %u", i);
+	release_dma_channels(this);
+	return -EINVAL;
+}
+
+static inline int acquire_clock(struct gpmi_nfc_data *this, struct clk **clock)
+{
+	struct clk *c;
+
+	c = clk_get(&this->pdev->dev, NULL);
+	if (IS_ERR(c)) {
+		log("Can't own clock");
+		return PTR_ERR(c);
+	}
+	*clock = c;
+	return 0;
+}
+
+static void release_clock(struct gpmi_nfc_data *this, struct clk *clock)
+{
+	clk_put(clock);
+}
+
+static int acquire_resources(struct gpmi_nfc_data *this)
+{
+	struct resources *resources = &this->resources;
+	int error;
+
+	/* Attempt to acquire the GPMI register block. */
+	error = acquire_register_block(this,
+				GPMI_NFC_GPMI_REGS_ADDR_RES_NAME,
+				&resources->gpmi_regs);
+	if (error)
+		goto exit_gpmi_regs;
+
+	/* Attempt to acquire the BCH register block. */
+	error = acquire_register_block(this,
+				GPMI_NFC_BCH_REGS_ADDR_RES_NAME,
+				&resources->bch_regs);
+	if (error)
+		goto exit_bch_regs;
+
+	/* Attempt to acquire the BCH interrupt. */
+	error = acquire_interrupt(this,
+				GPMI_NFC_BCH_INTERRUPT_RES_NAME,
+				bch_irq,
+				&resources->bch_low_interrupt,
+				&resources->bch_high_interrupt);
+	if (error)
+		goto exit_bch_interrupt;
+
+	/* Attempt to acquire the DMA channels. */
+	error = acquire_dma_channels(this,
+				GPMI_NFC_DMA_CHANNELS_RES_NAME,
+				&resources->dma_low_channel,
+				&resources->dma_high_channel);
+	if (error)
+		goto exit_dma_channels;
+
+	/* Attempt to acquire our clock. */
+	error = acquire_clock(this, &resources->clock);
+	if (error)
+		goto exit_clock;
+	return 0;
+
+exit_clock:
+	release_dma_channels(this);
+exit_dma_channels:
+	release_interrupt(this, resources->bch_low_interrupt,
+				resources->bch_high_interrupt);
+exit_bch_interrupt:
+	release_register_block(this, resources->bch_regs);
+exit_bch_regs:
+	release_register_block(this, resources->gpmi_regs);
+exit_gpmi_regs:
+	return error;
+}
+
+static void release_resources(struct gpmi_nfc_data *this)
+{
+	struct resources  *resources = &this->resources;
+
+	release_clock(this, resources->clock);
+	release_register_block(this, resources->gpmi_regs);
+	release_register_block(this, resources->bch_regs);
+	release_interrupt(this, resources->bch_low_interrupt,
+				resources->bch_low_interrupt);
+	release_dma_channels(this);
+}
+
+static void exit_nfc_hal(struct gpmi_nfc_data *this)
+{
+	if (this->nfc)
+		this->nfc->exit(this);
+}
+
+static int set_up_nfc_hal(struct gpmi_nfc_data *this)
+{
+	struct nfc_hal *nfc = NULL;
+	int error;
+
+	/*
+	 * This structure contains the "safe" GPMI timing that should succeed
+	 * with any NAND Flash device
+	 * (although, with less-than-optimal performance).
+	 */
+	static struct nand_timing  safe_timing = {
+		.data_setup_in_ns        = 80,
+		.data_hold_in_ns         = 60,
+		.address_setup_in_ns     = 25,
+		.gpmi_sample_delay_in_ns =  6,
+		.tREA_in_ns              = -1,
+		.tRLOH_in_ns             = -1,
+		.tRHOH_in_ns             = -1,
+	};
+
+	if (cpu_is_mx23() || cpu_is_mx28())
+		nfc = &gpmi_nfc_hal_imx23_imx28;
+
+	BUG_ON(nfc == NULL);
+	this->nfc = nfc;
+
+	/* Initialize the NFC HAL. */
+	error = nfc->init(this);
+	if (error)
+		return error;
+
+	/* Set up safe timing. */
+	nfc->set_timing(this, &safe_timing);
+	return 0;
+}
+
+static int set_up_boot_rom_helper(struct gpmi_nfc_data *this)
+{
+	struct boot_rom_helper *rom = NULL;
+
+	if (cpu_is_mx23())
+		rom = &gpmi_nfc_boot_rom_imx23;
+	if (cpu_is_mx28())
+		rom = &gpmi_nfc_boot_rom_imx28;
+
+	BUG_ON(rom == NULL);
+
+	pr_info("Boot ROM: Version %u, %s\n", rom->version, rom->description);
+	this->rom = rom;
+	return 0;
+}
+
+/* Creates/Removes sysfs files for this device.*/
+static void manage_sysfs_files(struct gpmi_nfc_data *this, int create)
+{
+	struct device            *dev = this->dev;
+	int                      error;
+	unsigned int             i;
+	struct device_attribute  **attr;
+
+	for (i = 0, attr = device_attributes;
+			i < ARRAY_SIZE(device_attributes); i++, attr++) {
+
+		if (create) {
+			error = device_create_file(dev, *attr);
+			if (error) {
+				while (--attr >= device_attributes)
+					device_remove_file(dev, *attr);
+				return;
+			}
+		} else {
+			device_remove_file(dev, *attr);
+		}
+	}
+}
+
+static int read_page_prepare(struct gpmi_nfc_data *this,
+			void *destination, unsigned length,
+			void *alt_virt, dma_addr_t alt_phys, unsigned alt_size,
+			void **use_virt, dma_addr_t *use_phys)
+{
+	struct device  *dev = this->dev;
+	dma_addr_t destination_phys = ~0;
+
+	if (virt_addr_valid(destination))
+		destination_phys = dma_map_single(dev, (void *)destination,
+						length, DMA_FROM_DEVICE);
+
+	if (dma_mapping_error(dev, destination_phys)) {
+		if (alt_size < length) {
+			log("Alternate buffer is too small for incoming I/O.");
+			return -ENOMEM;
+		}
+
+		*use_virt = alt_virt;
+		*use_phys = alt_phys;
+	} else {
+		*use_virt = destination;
+		*use_phys = destination_phys;
+	}
+	return 0;
+}
+
+static void read_page_end(struct gpmi_nfc_data *this,
+			void *destination, unsigned length,
+			void *alt_virt, dma_addr_t alt_phys, unsigned alt_size,
+			void *used_virt, dma_addr_t used_phys)
+{
+	struct device  *dev = this->dev;
+
+	if (used_virt == destination)
+		dma_unmap_single(dev, used_phys, length, DMA_FROM_DEVICE);
+	else
+		memcpy(destination, alt_virt, length);
+}
+
+static int send_page_prepare(struct gpmi_nfc_data *this,
+			const void *source, unsigned length,
+			void *alt_virt, dma_addr_t alt_phys, unsigned alt_size,
+			const void **use_virt, dma_addr_t *use_phys)
+{
+	dma_addr_t source_phys = ~0;
+	struct device  *dev = this->dev;
+
+	if (virt_addr_valid(source))
+		source_phys = dma_map_single(dev,
+				(void *)source, length, DMA_TO_DEVICE);
+
+	if (dma_mapping_error(dev, source_phys)) {
+		if (alt_size < length) {
+			log("Alternate buffer is too small for outgoing I/O");
+			return -ENOMEM;
+		}
+
+		/*
+		 * Copy the contents of the source buffer into the alternate
+		 * buffer and set up the return values accordingly.
+		 */
+		memcpy(alt_virt, source, length);
+
+		*use_virt = alt_virt;
+		*use_phys = alt_phys;
+	} else {
+		*use_virt = source;
+		*use_phys = source_phys;
+	}
+	return 0;
+}
+
+static void send_page_end(struct gpmi_nfc_data *this,
+			const void *source, unsigned length,
+			void *alt_virt, dma_addr_t alt_phys, unsigned alt_size,
+			const void *used_virt, dma_addr_t used_phys)
+{
+	struct device  *dev = this->dev;
+	if (used_virt == source)
+		dma_unmap_single(dev, used_phys, length, DMA_TO_DEVICE);
+}
+
+static void mil_free_dma_buffer(struct gpmi_nfc_data *this)
+{
+	struct device *dev = this->dev;
+	struct mil *mil	= &this->mil;
+
+	if (mil->page_buffer_virt && virt_addr_valid(mil->page_buffer_virt))
+		dma_free_coherent(dev, mil->page_buffer_size,
+					mil->page_buffer_virt,
+					mil->page_buffer_phys);
+	kfree(mil->cmd_buffer);
+	kfree(mil->data_buffer_dma);
+
+	mil->cmd_buffer		= NULL;
+	mil->data_buffer_dma	= NULL;
+	mil->page_buffer_virt	= NULL;
+	mil->page_buffer_size	=  0;
+	mil->page_buffer_phys	= ~0;
+}
+
+/* Allocate the DMA buffers */
+static int mil_alloc_dma_buffer(struct gpmi_nfc_data *this)
+{
+	struct device        *dev	= this->dev;
+	struct nfc_geometry  *geo	= &this->nfc_geometry;
+	struct mil           *mil	= &this->mil;
+
+	/* [1] Allocate a command buffer. PAGE_SIZE is enough. */
+	mil->cmd_buffer = kzalloc(PAGE_SIZE, GFP_DMA);
+	if (mil->cmd_buffer == NULL)
+		goto error_alloc;
+
+	/* [2] Allocate a read/write data buffer. PAGE_SIZE is enough. */
+	mil->data_buffer_dma = kzalloc(PAGE_SIZE, GFP_DMA);
+	if (mil->data_buffer_dma == NULL)
+		goto error_alloc;
+
+	/*
+	 * [3] Allocate the page buffer.
+	 *
+	 * Both the payload buffer and the auxiliary buffer must appear on
+	 * 32-bit boundaries. We presume the size of the payload buffer is a
+	 * power of two and is much larger than four, which guarantees the
+	 * auxiliary buffer will appear on a 32-bit boundary.
+	 */
+	mil->page_buffer_size = geo->payload_size_in_bytes +
+				geo->auxiliary_size_in_bytes;
+
+	mil->page_buffer_virt = dma_alloc_coherent(dev, mil->page_buffer_size,
+					&mil->page_buffer_phys, GFP_DMA);
+	if (!mil->page_buffer_virt)
+		goto error_alloc;
+
+
+	/* Slice up the page buffer. */
+	mil->payload_virt = mil->page_buffer_virt;
+	mil->payload_phys = mil->page_buffer_phys;
+	mil->auxiliary_virt = ((char *) mil->payload_virt) +
+					geo->payload_size_in_bytes;
+	mil->auxiliary_phys = mil->payload_phys +
+					geo->payload_size_in_bytes;
+	return 0;
+
+error_alloc:
+	mil_free_dma_buffer(this);
+	log("allocate DMA buffer error!!");
+	return -ENOMEM;
+}
+
+static void mil_cmd_ctrl(struct mtd_info *mtd, int data, unsigned int ctrl)
+{
+	struct nand_chip      *nand = mtd->priv;
+	struct gpmi_nfc_data  *this = nand->priv;
+	struct mil            *mil  = &this->mil;
+	struct nfc_hal        *nfc  =  this->nfc;
+	int                   error;
+
+	/*
+	 * Every operation begins with a command byte and a series of zero or
+	 * more address bytes. These are distinguished by either the Address
+	 * Latch Enable (ALE) or Command Latch Enable (CLE) signals being
+	 * asserted. When MTD is ready to execute the command, it will deassert
+	 * both latch enables.
+	 *
+	 * Rather than run a separate DMA operation for every single byte, we
+	 * queue them up and run a single DMA operation for the entire series
+	 * of command and data bytes. NAND_CMD_NONE means the END of the queue.
+	 */
+	if ((ctrl & (NAND_ALE | NAND_CLE))) {
+		if (data != NAND_CMD_NONE)
+			mil->cmd_buffer[mil->command_length++] = data;
+		return;
+	}
+
+	if (!mil->command_length)
+		return;
+
+	error = nfc->send_command(this);
+	if (error)
+		log("Chip: %u, Error %d", mil->current_chip, error);
+
+	mil->command_length = 0;
+}
+
+static int mil_dev_ready(struct mtd_info *mtd)
+{
+	struct nand_chip      *nand = mtd->priv;
+	struct gpmi_nfc_data  *this = nand->priv;
+	struct nfc_hal        *nfc  = this->nfc;
+	struct mil            *mil  = &this->mil;
+
+	return nfc->is_ready(this, mil->current_chip);
+}
+
+static void mil_select_chip(struct mtd_info *mtd, int chip)
+{
+	struct nand_chip      *nand  = mtd->priv;
+	struct gpmi_nfc_data  *this  = nand->priv;
+	struct mil            *mil   = &this->mil;
+	struct nfc_hal        *nfc   =  this->nfc;
+
+	if ((mil->current_chip < 0) && (chip >= 0))
+		nfc->begin(this);
+	else if ((mil->current_chip >= 0) && (chip < 0))
+		nfc->end(this);
+	else
+		;
+
+	mil->current_chip = chip;
+}
+
+static void mil_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
+{
+	struct nand_chip      *nand     = mtd->priv;
+	struct gpmi_nfc_data  *this     = nand->priv;
+	struct nfc_hal        *nfc      = this->nfc;
+	struct mil            *mil      = &this->mil;
+
+	logio(GPMI_DEBUG_READ);
+	/* save the info in mil{} for future */
+	mil->upper_buf	= buf;
+	mil->upper_len	= len;
+
+	nfc->read_data(this);
+}
+
+static void mil_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
+{
+	struct nand_chip      *nand     = mtd->priv;
+	struct gpmi_nfc_data  *this     = nand->priv;
+	struct nfc_hal        *nfc      =  this->nfc;
+	struct mil            *mil      = &this->mil;
+
+	logio(GPMI_DEBUG_WRITE);
+	/* save the info in mil{} for future */
+	mil->upper_buf	= (uint8_t *)buf;
+	mil->upper_len	= len;
+
+	nfc->send_data(this);
+}
+
+static uint8_t mil_read_byte(struct mtd_info *mtd)
+{
+	struct nand_chip      *nand     = mtd->priv;
+	struct gpmi_nfc_data  *this     = nand->priv;
+	struct mil *mil = &this->mil;
+	uint8_t *buf = mil->data_buffer_dma;
+
+	mil_read_buf(mtd, buf, 1);
+	return buf[0];
+}
+
+/**
+ * mil_handle_block_mark_swapping() - Handles block mark swapping.
+ *
+ * Note that, when this function is called, it doesn't know whether it's
+ * swapping the block mark, or swapping it *back* -- but it doesn't matter
+ * because the the operation is the same.
+ *
+ * @this:       Per-device data.
+ * @payload:    A pointer to the payload buffer.
+ * @auxiliary:  A pointer to the auxiliary buffer.
+ */
+static void mil_handle_block_mark_swapping(struct gpmi_nfc_data *this,
+						void *payload, void *auxiliary)
+{
+	struct nfc_geometry     *nfc_geo = &this->nfc_geometry;
+	struct boot_rom_helper  *rom     =  this->rom;
+	unsigned char           *p;
+	unsigned char           *a;
+	unsigned int            bit;
+	unsigned char           mask;
+	unsigned char           from_data;
+	unsigned char           from_oob;
+
+	/* Check if we're doing block mark swapping. */
+	if (!rom->swap_block_mark)
+		return;
+
+	/*
+	 * If control arrives here, we're swapping. Make some convenience
+	 * variables.
+	 */
+	bit = nfc_geo->block_mark_bit_offset;
+	p   = payload + nfc_geo->block_mark_byte_offset;
+	a   = auxiliary;
+
+	/*
+	 * Get the byte from the data area that overlays the block mark. Since
+	 * the ECC engine applies its own view to the bits in the page, the
+	 * physical block mark won't (in general) appear on a byte boundary in
+	 * the data.
+	 */
+	from_data = (p[0] >> bit) | (p[1] << (8 - bit));
+
+	/* Get the byte from the OOB. */
+	from_oob = a[0];
+
+	/* Swap them. */
+	a[0] = from_data;
+
+	mask = (0x1 << bit) - 1;
+	p[0] = (p[0] & mask) | (from_oob << bit);
+
+	mask = ~0 << bit;
+	p[1] = (p[1] & mask) | (from_oob >> (8 - bit));
+}
+
+static int mil_ecc_read_page(struct mtd_info *mtd, struct nand_chip *nand,
+				uint8_t *buf, int page)
+{
+	struct gpmi_nfc_data    *this    = nand->priv;
+	struct nfc_hal          *nfc     =  this->nfc;
+	struct nfc_geometry     *nfc_geo = &this->nfc_geometry;
+	struct mil              *mil     = &this->mil;
+	void                    *payload_virt;
+	dma_addr_t              payload_phys;
+	void                    *auxiliary_virt;
+	dma_addr_t              auxiliary_phys;
+	unsigned int            i;
+	unsigned char           *status;
+	unsigned int            failed;
+	unsigned int            corrected;
+	int                     error;
+
+	logio(GPMI_DEBUG_ECC_READ);
+	error = read_page_prepare(this, buf, mtd->writesize,
+					mil->payload_virt, mil->payload_phys,
+					nfc_geo->payload_size_in_bytes,
+					&payload_virt, &payload_phys);
+	if (error) {
+		log("Inadequate DMA buffer");
+		error = -ENOMEM;
+		return error;
+	}
+	auxiliary_virt = mil->auxiliary_virt;
+	auxiliary_phys = mil->auxiliary_phys;
+
+	/* ask the NFC */
+	error = nfc->read_page(this, payload_phys, auxiliary_phys);
+	if (error) {
+		log("Error in ECC-based read: %d", error);
+		goto exit_nfc;
+	}
+
+	/* handle the block mark swapping */
+	mil_handle_block_mark_swapping(this, payload_virt, auxiliary_virt);
+
+	/* Loop over status bytes, accumulating ECC status. */
+	failed		= 0;
+	corrected	= 0;
+	status		= auxiliary_virt + nfc_geo->auxiliary_status_offset;
+
+	for (i = 0; i < nfc_geo->ecc_chunk_count; i++, status++) {
+		if ((*status == STATUS_GOOD) || (*status == STATUS_ERASED))
+			continue;
+
+		if (*status == STATUS_UNCORRECTABLE) {
+			failed++;
+			continue;
+		}
+		corrected += *status;
+	}
+
+	/*
+	 * Propagate ECC status to the owning MTD only when failed or
+	 * corrected times nearly reaches our ECC correction threshold.
+	 */
+	if (failed || corrected >= (nfc_geo->ecc_strength - 1)) {
+		mtd->ecc_stats.failed    += failed;
+		mtd->ecc_stats.corrected += corrected;
+	}
+
+	/*
+	 * It's time to deliver the OOB bytes. See mil_ecc_read_oob() for
+	 * details about our policy for delivering the OOB.
+	 *
+	 * We fill the caller's buffer with set bits, and then copy the block
+	 * mark to th caller's buffer. Note that, if block mark swapping was
+	 * necessary, it has already been done, so we can rely on the first
+	 * byte of the auxiliary buffer to contain the block mark.
+	 */
+	memset(nand->oob_poi, ~0, mtd->oobsize);
+	nand->oob_poi[0] = ((uint8_t *) auxiliary_virt)[0];
+
+exit_nfc:
+	read_page_end(this, buf, mtd->writesize,
+					mil->payload_virt, mil->payload_phys,
+					nfc_geo->payload_size_in_bytes,
+					payload_virt, payload_phys);
+	return error;
+}
+
+static void mil_ecc_write_page(struct mtd_info *mtd,
+				struct nand_chip *nand, const uint8_t *buf)
+{
+	struct gpmi_nfc_data    *this    = nand->priv;
+	struct nfc_hal          *nfc     =  this->nfc;
+	struct nfc_geometry     *nfc_geo = &this->nfc_geometry;
+	struct boot_rom_helper  *rom     =  this->rom;
+	struct mil              *mil     = &this->mil;
+	const void              *payload_virt;
+	dma_addr_t              payload_phys;
+	const void              *auxiliary_virt;
+	dma_addr_t              auxiliary_phys;
+	int                     error;
+
+	logio(GPMI_DEBUG_ECC_WRITE);
+	if (rom->swap_block_mark) {
+		/*
+		 * If control arrives here, we're doing block mark swapping.
+		 * Since we can't modify the caller's buffers, we must copy them
+		 * into our own.
+		 */
+		memcpy(mil->payload_virt, buf, mtd->writesize);
+		payload_virt = mil->payload_virt;
+		payload_phys = mil->payload_phys;
+
+		memcpy(mil->auxiliary_virt, nand->oob_poi,
+				nfc_geo->auxiliary_size_in_bytes);
+		auxiliary_virt = mil->auxiliary_virt;
+		auxiliary_phys = mil->auxiliary_phys;
+
+		/* Handle block mark swapping. */
+		mil_handle_block_mark_swapping(this,
+				(void *) payload_virt, (void *) auxiliary_virt);
+	} else {
+		/*
+		 * If control arrives here, we're not doing block mark swapping,
+		 * so we can to try and use the caller's buffers.
+		 */
+		error = send_page_prepare(this,
+				buf, mtd->writesize,
+				mil->payload_virt, mil->payload_phys,
+				nfc_geo->payload_size_in_bytes,
+				&payload_virt, &payload_phys);
+		if (error) {
+			log("Inadequate payload DMA buffer");
+			return;
+		}
+
+		error = send_page_prepare(this,
+				nand->oob_poi, mtd->oobsize,
+				mil->auxiliary_virt, mil->auxiliary_phys,
+				nfc_geo->auxiliary_size_in_bytes,
+				&auxiliary_virt, &auxiliary_phys);
+		if (error) {
+			log("Inadequate auxiliary DMA buffer");
+			goto exit_auxiliary;
+		}
+	}
+
+	/* Ask the NFC. */
+	error = nfc->send_page(this, payload_phys, auxiliary_phys);
+	if (error)
+		log("Error in ECC-based write: %d", error);
+
+	if (!rom->swap_block_mark) {
+		send_page_end(this, nand->oob_poi, mtd->oobsize,
+				mil->auxiliary_virt, mil->auxiliary_phys,
+				nfc_geo->auxiliary_size_in_bytes,
+				auxiliary_virt, auxiliary_phys);
+exit_auxiliary:
+		send_page_end(this, buf, mtd->writesize,
+				mil->payload_virt, mil->payload_phys,
+				nfc_geo->payload_size_in_bytes,
+				payload_virt, payload_phys);
+	}
+}
+
+/**
+ * mil_hook_block_markbad() - Hooked MTD Interface block_markbad().
+ *
+ * This function is a veneer that replaces the function originally installed by
+ * the NAND Flash MTD code. See the description of the marking_a_bad_block field
+ * in struct mil for more information about this.
+ *
+ * @mtd:  A pointer to the MTD.
+ * @ofs:  Byte address of the block to mark.
+ */
+static int mil_hook_block_markbad(struct mtd_info *mtd, loff_t ofs)
+{
+	register struct nand_chip  *chip = mtd->priv;
+	struct gpmi_nfc_data       *this = chip->priv;
+	struct mil                 *mil  = &this->mil;
+	int                        ret;
+
+	mil->marking_a_bad_block = true;
+	ret = mil->hooked_block_markbad(mtd, ofs);
+	mil->marking_a_bad_block = false;
+	return ret;
+}
+
+/**
+ * mil_ecc_read_oob() - MTD Interface ecc.read_oob().
+ *
+ * There are several places in this driver where we have to handle the OOB and
+ * block marks. This is the function where things are the most complicated, so
+ * this is where we try to explain it all. All the other places refer back to
+ * here.
+ *
+ * These are the rules, in order of decreasing importance:
+ *
+ * 1) Nothing the caller does can be allowed to imperil the block mark, so all
+ *    write operations take measures to protect it.
+ *
+ * 2) In read operations, the first byte of the OOB we return must reflect the
+ *    true state of the block mark, no matter where that block mark appears in
+ *    the physical page.
+ *
+ * 3) ECC-based read operations return an OOB full of set bits (since we never
+ *    allow ECC-based writes to the OOB, it doesn't matter what ECC-based reads
+ *    return).
+ *
+ * 4) "Raw" read operations return a direct view of the physical bytes in the
+ *    page, using the conventional definition of which bytes are data and which
+ *    are OOB. This gives the caller a way to see the actual, physical bytes
+ *    in the page, without the distortions applied by our ECC engine.
+ *
+ *
+ * What we do for this specific read operation depends on two questions:
+ *
+ * 1) Are we doing a "raw" read, or an ECC-based read?
+ *
+ * 2) Are we using block mark swapping or transcription?
+ *
+ * There are four cases, illustrated by the following Karnaugh map:
+ *
+ *                    |           Raw           |         ECC-based       |
+ *       -------------+-------------------------+-------------------------+
+ *                    | Read the conventional   |                         |
+ *                    | OOB at the end of the   |                         |
+ *       Swapping     | page and return it. It  |                         |
+ *                    | contains exactly what   |                         |
+ *                    | we want.                | Read the block mark and |
+ *       -------------+-------------------------+ return it in a buffer   |
+ *                    | Read the conventional   | full of set bits.       |
+ *                    | OOB at the end of the   |                         |
+ *                    | page and also the block |                         |
+ *       Transcribing | mark in the metadata.   |                         |
+ *                    | Copy the block mark     |                         |
+ *                    | into the first byte of  |                         |
+ *                    | the OOB.                |                         |
+ *       -------------+-------------------------+-------------------------+
+ *
+ * Note that we break rule #4 in the Transcribing/Raw case because we're not
+ * giving an accurate view of the actual, physical bytes in the page (we're
+ * overwriting the block mark). That's OK because it's more important to follow
+ * rule #2.
+ *
+ * It turns out that knowing whether we want an "ECC-based" or "raw" read is not
+ * easy. When reading a page, for example, the NAND Flash MTD code calls our
+ * ecc.read_page or ecc.read_page_raw function. Thus, the fact that MTD wants an
+ * ECC-based or raw view of the page is implicit in which function it calls
+ * (there is a similar pair of ECC-based/raw functions for writing).
+ *
+ * Since MTD assumes the OOB is not covered by ECC, there is no pair of
+ * ECC-based/raw functions for reading or or writing the OOB. The fact that the
+ * caller wants an ECC-based or raw view of the page is not propagated down to
+ * this driver.
+ *
+ * @mtd:     A pointer to the owning MTD.
+ * @nand:    A pointer to the owning NAND Flash MTD.
+ * @page:    The page number to read.
+ * @sndcmd:  Indicates this function should send a command to the chip before
+ *           reading the out-of-band bytes. This is only false for small page
+ *           chips that support auto-increment.
+ */
+static int mil_ecc_read_oob(struct mtd_info *mtd, struct nand_chip *nand,
+							int page, int sndcmd)
+{
+	struct gpmi_nfc_data      *this     = nand->priv;
+	struct boot_rom_helper    *rom      =  this->rom;
+
+	/* clear the OOB buffer */
+	memset(nand->oob_poi, ~0, mtd->oobsize);
+
+	/* Read out the conventional OOB. */
+	nand->cmdfunc(mtd, NAND_CMD_READ0, mtd->writesize, page);
+	nand->read_buf(mtd, nand->oob_poi, mtd->oobsize);
+
+	/*
+	 * Now, we want to make sure the block mark is correct. In the
+	 * Swapping/Raw case, we already have it. Otherwise, we need to
+	 * explicitly read it.
+	 */
+	if (!rom->swap_block_mark) {
+		/* Read the block mark into the first byte of the OOB buffer. */
+		nand->cmdfunc(mtd, NAND_CMD_READ0, 0, page);
+		nand->oob_poi[0] = nand->read_byte(mtd);
+	}
+
+	/*
+	 * Return true, indicating that the next call to this function must send
+	 * a command.
+	 */
+	return true;
+}
+
+static int mil_ecc_write_oob(struct mtd_info *mtd,
+				struct nand_chip *nand, int page)
+{
+	struct gpmi_nfc_data	*this	= nand->priv;
+	struct device		*dev	= this->dev;
+	struct mil		*mil	= &this->mil;
+	struct boot_rom_helper	*rom	= this->rom;
+	uint8_t			*block_mark;
+	int	block_mark_column;
+	int	status;
+	int	error = 0;
+
+	/*
+	 * There are fundamental incompatibilities between the i.MX GPMI NFC and
+	 * the NAND Flash MTD model that make it essentially impossible to write
+	 * the out-of-band bytes.
+	 *
+	 * We permit *ONE* exception. If the *intent* of writing the OOB is to
+	 * mark a block bad, we can do that.
+	 */
+	if (!mil->marking_a_bad_block) {
+		dev_emerg(dev, "This driver doesn't support writing the OOB\n");
+		WARN_ON(1);
+		error = -EIO;
+		goto exit;
+	}
+
+	/*
+	 * If control arrives here, we're marking a block bad. First, figure out
+	 * where the block mark is.
+	 *
+	 * If we're using swapping, the block mark is in the conventional
+	 * location. Otherwise, we're using transcription, and the block mark
+	 * appears in the first byte of the page.
+	 */
+	if (rom->swap_block_mark)
+		block_mark_column = mtd->writesize;
+	else
+		block_mark_column = 0;
+
+	/* Write the block mark. */
+	block_mark = mil->data_buffer_dma;
+	block_mark[0] = 0; /* bad block marker */
+
+	nand->cmdfunc(mtd, NAND_CMD_SEQIN, block_mark_column, page);
+	nand->write_buf(mtd, block_mark, 1);
+	nand->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
+
+	status = nand->waitfunc(mtd, nand);
+
+	/* Check if it worked. */
+	if (status & NAND_STATUS_FAIL)
+		error = -EIO;
+exit:
+	return error;
+}
+
+/**
+ * mil_block_bad - Claims all blocks are good.
+ *
+ * In principle, this function is *only* called when the NAND Flash MTD system
+ * isn't allowed to keep an in-memory bad block table, so it is forced to ask
+ * the driver for bad block information.
+ *
+ * In fact, we permit the NAND Flash MTD system to have an in-memory BBT, so
+ * this function is *only* called when we take it away.
+ *
+ * We take away the in-memory BBT when the user sets the "ignorebad" parameter,
+ * which indicates that all blocks should be reported good.
+ *
+ * Thus, this function is only called when we want *all* blocks to look good,
+ * so it *always* return success.
+ *
+ * @mtd:      Ignored.
+ * @ofs:      Ignored.
+ * @getchip:  Ignored.
+ */
+static int mil_block_bad(struct mtd_info *mtd, loff_t ofs, int getchip)
+{
+	return 0;
+}
+
+static void show_rom_geometry(struct boot_rom_geometry *geo)
+{
+	pr_info("--------------------------------------------\n");
+	pr_info("	Boot ROM Geometry\n");
+	pr_info("--------------------------------------------\n");
+	pr_info("Boot Area Count            : %u\n", geo->boot_area_count);
+	pr_info("Boot Area Size in Bytes    : %u (0x%x)\n",
+					geo->boot_area_size_in_bytes,
+					geo->boot_area_size_in_bytes);
+	pr_info("Stride Size in Pages       : %u\n", geo->stride_size_in_pages);
+	pr_info("Search Area Stride Exponent: %u\n",
+					geo->search_area_stride_exponent);
+}
+
+/* Set up the Boot ROM Helper geometry. */
+static int mil_set_boot_rom_helper_geometry(struct gpmi_nfc_data  *this)
+{
+	struct boot_rom_helper    *rom =  this->rom;
+	struct boot_rom_geometry  *geo = &this->rom_geometry;
+	int error;
+
+	error = rom->set_geometry(this);
+	if (error)
+		return error;
+
+	if (gpmi_debug & GPMI_DEBUG_INIT)
+		show_rom_geometry(geo);
+
+	return 0;
+}
+
+static void show_nfc_geometry(struct nfc_geometry *geo)
+{
+	pr_info("---------------------------------------\n");
+	pr_info("	NFC Geometry (used by BCH)\n");
+	pr_info("---------------------------------------\n");
+	pr_info("ECC Algorithm          : %s\n", geo->ecc_algorithm);
+	pr_info("ECC Strength           : %u\n", geo->ecc_strength);
+	pr_info("Page Size in Bytes     : %u\n", geo->page_size_in_bytes);
+	pr_info("Metadata Size in Bytes : %u\n", geo->metadata_size_in_bytes);
+	pr_info("ECC Chunk Size in Bytes: %u\n", geo->ecc_chunk_size_in_bytes);
+	pr_info("ECC Chunk Count        : %u\n", geo->ecc_chunk_count);
+	pr_info("Payload Size in Bytes  : %u\n", geo->payload_size_in_bytes);
+	pr_info("Auxiliary Size in Bytes: %u\n", geo->auxiliary_size_in_bytes);
+	pr_info("Auxiliary Status Offset: %u\n", geo->auxiliary_status_offset);
+	pr_info("Block Mark Byte Offset : %u\n", geo->block_mark_byte_offset);
+	pr_info("Block Mark Bit Offset  : %u\n", geo->block_mark_bit_offset);
+}
+
+static int mil_set_geometry(struct gpmi_nfc_data *this)
+{
+	struct nfc_hal *nfc = this->nfc;
+	struct nfc_geometry *geo = &this->nfc_geometry;
+	int error;
+
+	/* Free the temporary DMA memory for read ID case */
+	mil_free_dma_buffer(this);
+
+	/* Set up the NFC geometry which is used by BCH. */
+	error = nfc->set_geometry(this);
+	if (error != 0) {
+		log("NFC set geometry error : %d", error);
+		return error;
+	}
+	if (gpmi_debug & GPMI_DEBUG_INIT)
+		show_nfc_geometry(geo);
+
+	/* Alloc the new DMA buffers according to the pagesize and oobsize */
+	return mil_alloc_dma_buffer(this);
+}
+
+static int mil_pre_bbt_scan(struct gpmi_nfc_data  *this)
+{
+	struct boot_rom_helper	*rom = this->rom;
+	int error;
+
+	error = mil_set_boot_rom_helper_geometry(this);
+	if (error)
+		return error;
+
+	/* This is ROM arch-specific initilization before the BBT scanning. */
+	if (rom->rom_extra_init)
+		error = rom->rom_extra_init(this);
+	return error;
+}
+
+static int mil_scan_bbt(struct mtd_info *mtd)
+{
+	struct nand_chip         *nand = mtd->priv;
+	struct gpmi_nfc_data     *this = nand->priv;
+	int                      error;
+
+	/* Prepare for the BBT scan. */
+	error = mil_pre_bbt_scan(this);
+	if (error)
+		return error;
+
+	/* use the default BBT implementation */
+	return nand_default_bbt(mtd);
+}
+
+static int mil_boot_areas_init(struct gpmi_nfc_data *this)
+{
+	struct boot_rom_geometry       *rom      = &this->rom_geometry;
+	struct mil                     *mil      = &this->mil;
+	struct mtd_info                *mtd      = &mil->mtd;
+
+	if (rom->boot_area_count == 0) {
+		mil->general_use_mtd = &mil->mtd;
+		pr_info("There is no Boot area.\n");
+	} else if (rom->boot_area_count == 1) {
+		static char  *chip_0_boot_name = "gpmi-nfc-0-boot";
+		static char  *general_use_name = "gpmi-nfc-general-use";
+		struct mtd_partition partitions[2];
+
+		pr_info("Boot area protection is enabled.\n");
+		/*
+		 * We partition the medium like so:
+		 *
+		 * +------+----------------------------------------------------+
+		 * | Boot |                    General Use                     |
+		 * +------+----------------------------------------------------+
+		 */
+
+		/* Chip 0 Boot */
+		partitions[0].name       = chip_0_boot_name;
+		partitions[0].offset     = 0;
+		partitions[0].size       = rom->boot_area_size_in_bytes;
+		partitions[0].mask_flags = 0;
+
+		/* General Use */
+		partitions[1].name       = general_use_name;
+		partitions[1].offset     = rom->boot_area_size_in_bytes;
+		partitions[1].size       = MTDPART_SIZ_FULL;
+		partitions[1].mask_flags = 0;
+
+		/* Construct and register the partitions. */
+		add_mtd_partitions(mtd, partitions, 2);
+
+		/* Find the general use MTD. */
+		mil->general_use_mtd = get_mtd_device_nm(general_use_name);
+		if (IS_ERR(mil->general_use_mtd)) {
+			log("Can't find general use MTD");
+			BUG();
+		}
+	} else {
+		log("Boot area count greater than one is unimplemented.");
+		return -ENXIO;
+	}
+	return 0;
+}
+
+static void mil_boot_areas_exit(struct gpmi_nfc_data *this)
+{
+	struct boot_rom_geometry  *rom = &this->rom_geometry;
+	struct mil                *mil = &this->mil;
+	struct mtd_info           *mtd = &mil->mtd;
+
+	if (!rom->boot_area_count) {
+		mil->general_use_mtd = NULL;
+		return;
+	}
+	del_mtd_partitions(mtd);
+	mil->general_use_mtd = NULL;
+}
+
+static int construct_general_use_partitions(struct gpmi_nfc_data *this)
+{
+	struct mil                     *mil   = &this->mil;
+	unsigned int                   partition_count;
+	struct mtd_partition           *partitions;
+	unsigned int                   name_size;
+	char                           *names;
+	unsigned int                   size;
+	unsigned int                   i;
+	static const char              *name_prefix = "gpmi-nfc-ubi-";
+
+	/* Only handle the MTD which is larger than 2GiB. */
+	if (mil->general_use_mtd->size <= SZ_2G)
+		return 0;
+
+	/* Split it by 2G for historical reason*/
+	partition_count = mil->general_use_mtd->size >> 31;
+	if (mil->general_use_mtd->size & ((1 << 30) - 1))
+		partition_count++;
+
+	/* construct the partitions */
+	name_size = strlen(name_prefix) + 4;
+	size = (sizeof(*partitions) + name_size) * partition_count;
+	partitions = kzalloc(size, GFP_KERNEL);
+	if (!partitions) {
+		log("Could not allocate memory for UBI partitions.");
+		return -ENOMEM;
+	}
+
+	names = (char *)(partitions + partition_count);
+	for (i = 0; i < partition_count; i++) {
+		partitions[i].name   = names;
+		partitions[i].size   = SZ_2G;
+		partitions[i].offset = MTDPART_OFS_NXTBLK;
+
+		sprintf(names, "%s%u", name_prefix, i);
+		names += name_size;
+	}
+	/* Adjust the last partition to take up the remainder. */
+	partitions[i - 1].size = MTDPART_SIZ_FULL;
+
+	mil->partitions           = partitions;
+	mil->partition_count      = partition_count;
+	return 0;
+}
+
+static int mil_partitions_init(struct gpmi_nfc_data *this)
+{
+	struct mil *mil = &this->mil;
+	int  error;
+
+	error = mil_boot_areas_init(this);
+	if (error)
+		return error;
+
+	/* Construct partitions */
+	error = construct_general_use_partitions(this);
+	if (error) {
+		log("error : %d", error);
+		return error;
+	}
+	if (mil->partition_count)
+		add_mtd_partitions(mil->general_use_mtd, mil->partitions,
+					mil->partition_count);
+	return 0;
+}
+
+static void mil_partitions_exit(struct gpmi_nfc_data *this)
+{
+	struct mil *mil = &this->mil;
+
+	if (mil->partition_count) {
+		del_mtd_partitions(mil->general_use_mtd);
+		kfree(mil->partitions);
+		mil->partition_count = 0;
+	}
+	mil_boot_areas_exit(this);
+}
+
+/*
+ * This function is used to set the mtd->pagesize, mtd->oobsize,
+ * mtd->erasesize. Yes, we also do some initialization.
+ *
+ * Return with the bus width. 0 for 8-bit, -1 for error.
+ */
+static int gpmi_init_size(struct mtd_info *mtd, struct nand_chip *nand,
+				u8 *id_bytes)
+{
+	struct gpmi_nfc_data *this	= nand->priv;
+	struct nfc_hal       *nfc	= this->nfc;
+	struct mil           *mil	= &this->mil;
+	struct nand_ecclayout *layout	= &mil->oob_layout;
+	struct nand_device_info  *info;
+	struct nand_attr	 *attr;
+	int error;
+
+	/* Look up this device in our own database. */
+	info = nand_device_get_info(id_bytes);
+	if (!info) {
+		pr_err("Unrecognized NAND Flash device.\n");
+		return -EINVAL;
+	} else if (gpmi_debug & GPMI_DEBUG_INIT)
+		nand_device_print_info(info);
+	else
+		pr_info("We found nand : [ %s ]\n", info->desc);
+
+	attr = &info->attr;
+	/*
+	 *  Init the right NAND/MTD parameters which will be used
+	 *  in the following mil_set_geometry().
+	 */
+	mtd->writesize	= 1 << (fls(attr->page_total_size_in_bytes) - 1);
+	mtd->erasesize	= mtd->writesize * attr->block_size_in_pages;
+	mtd->oobsize	= attr->page_total_size_in_bytes - mtd->writesize;
+	nand->chipsize	= attr->chip_size_in_bytes;
+
+	/* Configure the struct nand_ecclayout. */
+	layout->eccbytes          = 0;
+	layout->oobavail          = mtd->oobsize;
+	layout->oobfree[0].offset = 0;
+	layout->oobfree[0].length = mtd->oobsize;
+
+	nand->ecc.layout = layout;
+
+	/* copy it. */
+	this->device_info = *info;
+	this->device_info.desc = kstrdup(info->desc, GFP_KERNEL);
+
+	/* Set up the medium geometry */
+	error = mil_set_geometry(this);
+	if (error)
+		return error;
+
+	/* extra init */
+	if (nfc->extra_init) {
+		error = nfc->extra_init(this);
+		if (error != 0)
+			return error;
+	}
+
+	/* We only use 8-bit bus now, not 16-bit. */
+	return 0;
+}
+
+/* Initializes the MTD Interface Layer */
+int gpmi_nfc_mil_init(struct gpmi_nfc_data *this)
+{
+	struct gpmi_nfc_platform_data  *pdata =  this->pdata;
+	struct mil                     *mil   = &this->mil;
+	struct mtd_info                *mtd   = &mil->mtd;
+	struct nand_chip               *nand  = &mil->nand;
+	int                            error;
+
+	/* Initialize MIL data */
+	mil->current_chip	= -1;
+	mil->command_length	=  0;
+	mil->page_buffer_virt	=  0;
+	mil->page_buffer_phys	= ~0;
+	mil->page_buffer_size	=  0;
+
+	/* Initialize the MTD data structures */
+	mtd->priv		= nand;
+	mtd->name		= "gpmi-nfc-main";
+	mtd->owner		= THIS_MODULE;
+	nand->priv		= this;
+
+	/* Controls */
+	nand->select_chip	= mil_select_chip;
+	nand->cmd_ctrl		= mil_cmd_ctrl;
+	nand->dev_ready		= mil_dev_ready;
+
+	/*
+	 * Low-level I/O :
+	 *	We don't support a 16-bit NAND Flash bus,
+	 *	so we don't implement read_word.
+	 */
+	nand->read_byte		= mil_read_byte;
+	nand->read_buf		= mil_read_buf;
+	nand->write_buf		= mil_write_buf;
+
+	/* ECC-aware I/O */
+	nand->ecc.read_page	= mil_ecc_read_page;
+	nand->ecc.write_page	= mil_ecc_write_page;
+
+	/* High-level I/O */
+	nand->ecc.read_oob	= mil_ecc_read_oob;
+	nand->ecc.write_oob	= mil_ecc_write_oob;
+
+	/* Bad Block Management */
+	nand->block_bad		= mil_block_bad;
+	nand->scan_bbt		= mil_scan_bbt;
+	nand->init_size		= gpmi_init_size;
+	nand->badblock_pattern	= &gpmi_bbt_descr;
+
+	/* Disallow partial page writes */
+	nand->options		|= NAND_NO_SUBPAGE_WRITE;
+
+	/*
+	 * Tell the NAND Flash MTD system that we'll be handling ECC with our
+	 * own hardware. It turns out that we still have to fill in the ECC size
+	 * because the MTD code will divide by it -- even though it doesn't
+	 * actually care.
+	 */
+	nand->ecc.mode		= NAND_ECC_HW;
+	nand->ecc.size		= 1;
+
+	/* Allocate a temporary DMA buffer for reading ID in the nand_scan() */
+	this->nfc_geometry.payload_size_in_bytes	= 1024;
+	this->nfc_geometry.auxiliary_size_in_bytes	= 128;
+	error = mil_alloc_dma_buffer(this);
+	if (error)
+		goto exit_dma_allocation;
+
+	pr_info("Scanning for NAND Flash chips...\n");
+	error = nand_scan(mtd, pdata->max_chip_count);
+	if (error) {
+		log("Chip scan failed");
+		goto exit_nand_scan;
+	}
+
+	/* Take over the management of the OOB */
+	mil->hooked_block_markbad = mtd->block_markbad;
+	mtd->block_markbad        = mil_hook_block_markbad;
+
+	/* Construct partitions as necessary. */
+	error = mil_partitions_init(this);
+	if (error)
+		goto exit_partitions;
+	return 0;
+
+exit_partitions:
+	nand_release(&mil->mtd);
+exit_nand_scan:
+	mil_free_dma_buffer(this);
+exit_dma_allocation:
+	return error;
+}
+
+void gpmi_nfc_mil_exit(struct gpmi_nfc_data *this)
+{
+	struct mil *mil = &this->mil;
+
+	mil_partitions_exit(this);
+	nand_release(&mil->mtd);
+	mil_free_dma_buffer(this);
+}
+static int gpmi_nfc_probe(struct platform_device *pdev)
+{
+	struct gpmi_nfc_platform_data  *pdata = pdev->dev.platform_data;
+	struct gpmi_nfc_data           *this;
+	int error;
+
+	this = kzalloc(sizeof(*this), GFP_KERNEL);
+	if (!this) {
+		log("Failed to allocate per-device memory\n");
+		return -ENOMEM;
+	}
+
+	/* Set up our data structures. */
+	platform_set_drvdata(pdev, this);
+	this->pdev  = pdev;
+	this->dev   = &pdev->dev;
+	this->pdata = pdata;
+
+	/* Acquire the resources we need. */
+	error = acquire_resources(this);
+	if (error)
+		goto exit_acquire_resources;
+
+	/* Set up the NFC. */
+	error = set_up_nfc_hal(this);
+	if (error)
+		goto exit_nfc_init;
+
+	/* Set up the Boot ROM Helper. */
+	error = set_up_boot_rom_helper(this);
+	if (error)
+		goto exit_boot_rom_helper_init;
+
+	/* Initialize the MTD Interface Layer. */
+	error = gpmi_nfc_mil_init(this);
+	if (error)
+		goto exit_mil_init;
+
+	manage_sysfs_files(this, true);
+	return 0;
+
+exit_mil_init:
+exit_boot_rom_helper_init:
+	exit_nfc_hal(this);
+exit_nfc_init:
+	release_resources(this);
+exit_acquire_resources:
+	platform_set_drvdata(pdev, NULL);
+	kfree(this);
+	return error;
+}
+
+static int __exit gpmi_nfc_remove(struct platform_device *pdev)
+{
+	struct gpmi_nfc_data *this = platform_get_drvdata(pdev);
+
+	manage_sysfs_files(this, false);
+	gpmi_nfc_mil_exit(this);
+	exit_nfc_hal(this);
+	release_resources(this);
+	platform_set_drvdata(pdev, NULL);
+	kfree(this);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int gpmi_nfc_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	return 0;
+}
+
+static int gpmi_nfc_resume(struct platform_device *pdev)
+{
+	return 0;
+}
+#else
+#define suspend  NULL
+#define resume   NULL
+#endif
+
+/* This structure represents this driver to the platform management system. */
+static struct platform_driver gpmi_nfc_driver = {
+	.driver = {
+		.name = GPMI_NFC_DRIVER_NAME,
+	},
+	.probe   = gpmi_nfc_probe,
+	.remove  = __exit_p(gpmi_nfc_remove),
+	.suspend = gpmi_nfc_suspend,
+	.resume  = gpmi_nfc_resume,
+};
+
+static int __init gpmi_nfc_init(void)
+{
+	int err;
+
+	err = platform_driver_register(&gpmi_nfc_driver);
+	if (err == 0)
+		printk(KERN_INFO "GPMI NFC driver registered. (IMX)\n");
+	else
+		pr_err("i.MX GPMI NFC driver registration failed\n");
+	return err;
+}
+
+static void __exit gpmi_nfc_exit(void)
+{
+	platform_driver_unregister(&gpmi_nfc_driver);
+}
+
+static int __init gpmi_debug_setup(char *__unused)
+{
+	gpmi_debug = GPMI_DEBUG_INIT;
+	return 1;
+}
+__setup("gpmi_debug_init", gpmi_debug_setup);
+
+module_init(gpmi_nfc_init);
+module_exit(gpmi_nfc_exit);
+
+MODULE_AUTHOR("Freescale Semiconductor, Inc.");
+MODULE_DESCRIPTION("i.MX GPMI NAND Flash Controller Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mtd/nand/gpmi-nfc/gpmi-nfc.h b/drivers/mtd/nand/gpmi-nfc/gpmi-nfc.h
new file mode 100644
index 0000000..d81262b
--- /dev/null
+++ b/drivers/mtd/nand/gpmi-nfc/gpmi-nfc.h
@@ -0,0 +1,549 @@
+/*
+ * Freescale GPMI NFC NAND Flash Driver
+ *
+ * Copyright (C) 2010-2011 Freescale Semiconductor, Inc.
+ * Copyright (C) 2008 Embedded Alley Solutions, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+#ifndef __DRIVERS_MTD_NAND_GPMI_NFC_H
+#define __DRIVERS_MTD_NAND_GPMI_NFC_H
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/concat.h>
+#include <linux/dmaengine.h>
+#include <asm/sizes.h>
+
+#include <mach/mxs.h>
+#include <mach/common.h>
+#include <mach/dma.h>
+#include <mach/gpmi-nfc.h>
+#include <mach/system.h>
+#include <mach/clock.h>
+
+#include "../nand_device_info.h"
+
+/**
+ * struct resources - The collection of resources the driver needs.
+ *
+ * @gpmi_regs:         A pointer to the GPMI registers.
+ * @bch_regs:          A pointer to the BCH registers.
+ * @bch_interrupt:     The BCH interrupt number.
+ * @dma_low_channel:   The low  DMA channel.
+ * @dma_high_channel:  The high DMA channel.
+ * @clock:             A pointer to the struct clk for the NFC's clock.
+ */
+struct resources {
+	void          *gpmi_regs;
+	void          *bch_regs;
+	unsigned int  bch_low_interrupt;
+	unsigned int  bch_high_interrupt;
+	unsigned int  dma_low_channel;
+	unsigned int  dma_high_channel;
+	struct clk    *clock;
+};
+
+/**
+ * struct mil - State for the MTD Interface Layer.
+ *
+ * @nand:                    The NAND Flash MTD data structure that represents
+ *                           the NAND Flash medium.
+ * @mtd:                     The MTD data structure that represents the NAND
+ *                           Flash medium.
+ * @oob_layout:              A structure that describes how bytes are laid out
+ *                           in the OOB.
+ * @general_use_mtd:         A pointer to an MTD we export for general use.
+ *                           This *may* simply be a pointer to the mtd field, if
+ *                           we've been instructed NOT to protect the boot
+ *                           areas.
+ * @partitions:              A pointer to a set of partitions applied to the
+ *                           general use MTD.
+ * @partition_count:         The number of partitions.
+ * @current_chip:            The chip currently selected by the NAND Fash MTD
+ *                           code. A negative value indicates that no chip is
+ *                           selected.
+ * @command_length:          The length of the command that appears in the
+ *                           command buffer (see cmd_virt, below).
+ * @ignore_bad_block_marks:  Indicates we are ignoring bad block marks.
+ * @saved_bbt:               A saved pointer to the in-memory NAND Flash MTD bad
+ *                           block table. See show_device_ignorebad() for more
+ *                           details.
+ * @marking_a_bad_block:     Indicates the caller is marking a bad block. See
+ *                           mil_ecc_write_oob() for details.
+ * @hooked_block_markbad:    A pointer to the block_markbad() function we
+ *                           we "hooked." See mil_ecc_write_oob() for details.
+ * @upper_buf:               The buffer passed from upper layer.
+ * @upper_len:               The buffer len passed from upper layer.
+ * @direct_dma_map_ok:       Is the direct DMA map is good for the upper_buf?
+ * @cmd_sgl/cmd_buffer:      For NAND command.
+ * @data_sgl/data_buffer_dma:For NAND DATA ops.
+ * @page_buffer_virt:        A pointer to a DMA-coherent buffer we use for
+ *                           reading and writing pages. This buffer includes
+ *                           space for both the payload data and the auxiliary
+ *                           data (including status bytes, but not syndrome
+ *                           bytes).
+ * @page_buffer_phys:        The physical address for the page_buffer_virt
+ *                           buffer.
+ * @page_buffer_size:        The size of the page buffer.
+ * @payload_virt:            A pointer to a location in the page buffer used
+ *                           for payload bytes. The size of this buffer is
+ *                           determined by struct nfc_geometry.
+ * @payload_phys:            The physical address for payload_virt.
+ * @auxiliary_virt:          A pointer to a location in the page buffer used
+ *                           for auxiliary bytes. The size of this buffer is
+ *                           determined by struct nfc_geometry.
+ * @auxiliary_phys:          The physical address for auxiliary_virt.
+ */
+struct mil {
+	/* MTD Data Structures */
+	struct nand_chip       nand;
+	struct mtd_info        mtd;
+	struct nand_ecclayout  oob_layout;
+
+	/* Partitioning and Boot Area Protection */
+	struct mtd_info        *general_use_mtd;
+	struct mtd_partition   *partitions;
+	unsigned int           partition_count;
+
+	/* General-use Variables */
+	int                    current_chip;
+	unsigned int           command_length;
+	int                    ignore_bad_block_marks;
+	void                   *saved_bbt;
+
+	/* MTD Function Pointer Hooks */
+	int                    marking_a_bad_block;
+	int                    (*hooked_block_markbad)(struct mtd_info *mtd,
+					loff_t ofs);
+
+	/* from upper layer */
+	uint8_t			*upper_buf;
+	int			upper_len;
+
+	/* DMA */
+	bool			direct_dma_map_ok;
+
+	struct scatterlist	cmd_sgl;
+	char			*cmd_buffer;
+
+	struct scatterlist	data_sgl;
+	char			*data_buffer_dma;
+
+	void                   *page_buffer_virt;
+	dma_addr_t             page_buffer_phys;
+	unsigned int           page_buffer_size;
+
+	void                   *payload_virt;
+	dma_addr_t             payload_phys;
+
+	void                   *auxiliary_virt;
+	dma_addr_t             auxiliary_phys;
+};
+
+/**
+ * struct nfc_geometry - NFC geometry description.
+ *
+ * This structure describes the NFC's view of the medium geometry.
+ *
+ * @ecc_algorithm:            The human-readable name of the ECC algorithm
+ *                            (e.g., "Reed-Solomon" or "BCH").
+ * @ecc_strength:             A number that describes the strength of the ECC
+ *                            algorithm.
+ * @page_size_in_bytes:       The size, in bytes, of a physical page, including
+ *                            both data and OOB.
+ * @metadata_size_in_bytes:   The size, in bytes, of the metadata.
+ * @ecc_chunk_size_in_bytes:  The size, in bytes, of a single ECC chunk. Note
+ *                            the first chunk in the page includes both data and
+ *                            metadata, so it's a bit larger than this value.
+ * @ecc_chunk_count:          The number of ECC chunks in the page,
+ * @payload_size_in_bytes:    The size, in bytes, of the payload buffer.
+ * @auxiliary_size_in_bytes:  The size, in bytes, of the auxiliary buffer.
+ * @auxiliary_status_offset:  The offset into the auxiliary buffer at which
+ *                            the ECC status appears.
+ * @block_mark_byte_offset:   The byte offset in the ECC-based page view at
+ *                            which the underlying physical block mark appears.
+ * @block_mark_bit_offset:    The bit offset into the ECC-based page view at
+ *                            which the underlying physical block mark appears.
+ */
+struct nfc_geometry {
+	char          *ecc_algorithm;
+	unsigned int  ecc_strength;
+	unsigned int  page_size_in_bytes;
+	unsigned int  metadata_size_in_bytes;
+	unsigned int  ecc_chunk_size_in_bytes;
+	unsigned int  ecc_chunk_count;
+	unsigned int  payload_size_in_bytes;
+	unsigned int  auxiliary_size_in_bytes;
+	unsigned int  auxiliary_status_offset;
+	unsigned int  block_mark_byte_offset;
+	unsigned int  block_mark_bit_offset;
+};
+
+/**
+ * struct boot_rom_geometry - Boot ROM geometry description.
+ *
+ * This structure encapsulates decisions made by the Boot ROM Helper.
+ *
+ * @boot_area_count:             The number of boot areas. The first boot area
+ *                               appears at the beginning of chip 0, the next
+ *                               at the beginning of chip 1, etc.
+ * @boot_area_size_in_bytes:     The size, in bytes, of each boot area.
+ * @stride_size_in_pages:        The size of a boot block stride, in pages.
+ * @search_area_stride_exponent: The logarithm to base 2 of the size of a
+ *                               search area in boot block strides.
+ */
+struct boot_rom_geometry {
+	unsigned int  boot_area_count;
+	unsigned int  boot_area_size_in_bytes;
+	unsigned int  stride_size_in_pages;
+	unsigned int  search_area_stride_exponent;
+};
+
+/* DMA operations types */
+enum dma_ops_type {
+	DMA_FOR_COMMAND = 1,
+	DMA_FOR_READ_DATA,
+	DMA_FOR_WRITE_DATA,
+	DMA_FOR_READ_ECC_PAGE,
+	DMA_FOR_WRITE_ECC_PAGE
+};
+
+/**
+ * This structure contains the fundamental timing attributes for NAND.
+ *
+ * @data_setup_in_ns:         The data setup time, in nanoseconds. Usually the
+ *                            maximum of tDS and tWP. A negative value
+ *                            indicates this characteristic isn't known.
+ * @data_hold_in_ns:          The data hold time, in nanoseconds. Usually the
+ *                            maximum of tDH, tWH and tREH. A negative value
+ *                            indicates this characteristic isn't known.
+ * @address_setup_in_ns:      The address setup time, in nanoseconds. Usually
+ *                            the maximum of tCLS, tCS and tALS. A negative
+ *                            value indicates this characteristic isn't known.
+ * @gpmi_sample_delay_in_ns:  A GPMI-specific timing parameter. A negative value
+ *                            indicates this characteristic isn't known.
+ * @tREA_in_ns:               tREA, in nanoseconds, from the data sheet. A
+ *                            negative value indicates this characteristic isn't
+ *                            known.
+ * @tRLOH_in_ns:              tRLOH, in nanoseconds, from the data sheet. A
+ *                            negative value indicates this characteristic isn't
+ *                            known.
+ * @tRHOH_in_ns:              tRHOH, in nanoseconds, from the data sheet. A
+ *                            negative value indicates this characteristic isn't
+ *                            known.
+ */
+struct nand_timing {
+	int8_t  data_setup_in_ns;
+	int8_t  data_hold_in_ns;
+	int8_t  address_setup_in_ns;
+	int8_t  gpmi_sample_delay_in_ns;
+	int8_t  tREA_in_ns;
+	int8_t  tRLOH_in_ns;
+	int8_t  tRHOH_in_ns;
+};
+
+/**
+ * struct gpmi_nfc_data - i.MX NFC per-device data.
+ *
+ * Note that the "device" managed by this driver represents the NAND Flash
+ * controller *and* the NAND Flash medium behind it. Thus, the per-device data
+ * structure has information about the controller, the chips to which it is
+ * connected, and properties of the medium as a whole.
+ *
+ * @dev:                 A pointer to the owning struct device.
+ * @pdev:                A pointer to the owning struct platform_device.
+ * @pdata:               A pointer to the device's platform data.
+ * @resources:           Information about system resources used by this driver.
+ * @device_info:         A structure that contains detailed information about
+ *                       the NAND Flash device.
+ * @nfc:                 A pointer to a structure that represents the underlying
+ *                       NFC hardware.
+ * @nfc_geometry:        A description of the medium geometry as viewed by the
+ *                       NFC.
+ * @rom:                 A pointer to a structure that represents the underlying
+ *                       Boot ROM.
+ * @rom_geometry:        A description of the medium geometry as viewed by the
+ *                       Boot ROM.
+ * @mil:                 A collection of information used by the MTD Interface
+ *                       Layer.
+ */
+struct gpmi_nfc_data {
+	/* System Interface */
+	struct device                  *dev;
+	struct platform_device         *pdev;
+	struct gpmi_nfc_platform_data  *pdata;
+
+	/* Resources */
+	struct resources               resources;
+
+	/* Flash Hardware */
+	struct nand_device_info		device_info;
+	struct nand_timing		timing;
+
+	/* NFC HAL */
+	struct nfc_hal                 *nfc;
+	struct nfc_geometry            nfc_geometry;
+
+	/* Boot ROM Helper */
+	struct boot_rom_helper         *rom;
+	struct boot_rom_geometry       rom_geometry;
+
+	/* MTD Interface Layer */
+	struct mil                     mil;
+
+	/* DMA channels */
+#define DMA_CHANS			8
+	struct dma_chan			*dma_chans[DMA_CHANS];
+	struct mxs_dma_data		dma_data;
+	enum dma_ops_type		dma_type;
+
+	/* private */
+	void				*private;
+};
+
+/**
+ * struct gpmi_nfc_hardware_timing - GPMI NFC hardware timing parameters.
+ *
+ * This structure contains timing information expressed in a form directly
+ * usable by the GPMI NFC hardware.
+ *
+ * @data_setup_in_cycles:      The data setup time, in cycles.
+ * @data_hold_in_cycles:       The data hold time, in cycles.
+ * @address_setup_in_cycles:   The address setup time, in cycles.
+ * @use_half_periods:          Indicates the clock is running slowly, so the
+ *                             NFC DLL should use half-periods.
+ * @sample_delay_factor:       The sample delay factor.
+ */
+struct gpmi_nfc_hardware_timing {
+	uint8_t  data_setup_in_cycles;
+	uint8_t  data_hold_in_cycles;
+	uint8_t  address_setup_in_cycles;
+	bool     use_half_periods;
+	uint8_t  sample_delay_factor;
+};
+
+/**
+ * struct nfc_hal - GPMI NFC HAL
+ *
+ * This structure embodies an abstract interface to the underlying NFC hardware.
+ *
+ * @version:                     The NFC hardware version.
+ * @description:                 A pointer to a human-readable description of
+ *                               the NFC hardware.
+ * @max_chip_count:              The maximum number of chips the NFC can
+ *                               possibly support (this value is a constant for
+ *                               each NFC version). This may *not* be the actual
+ *                               number of chips connected.
+ * @max_data_setup_cycles:       The maximum number of data setup cycles that
+ *                               can be expressed in the hardware.
+ * @internal_data_setup_in_ns:   The time, in ns, that the NFC hardware requires
+ *                               for data read internal setup. In the Reference
+ *                               Manual, see the chapter "High-Speed NAND
+ *                               Timing" for more details.
+ * @max_sample_delay_factor:     The maximum sample delay factor that can be
+ *                               expressed in the hardware.
+ * @max_dll_clock_period_in_ns:  The maximum period of the GPMI clock that the
+ *                               sample delay DLL hardware can possibly work
+ *                               with (the DLL is unusable with longer periods).
+ *                               If the full-cycle period is greater than HALF
+ *                               this value, the DLL must be configured to use
+ *                               half-periods.
+ * @max_dll_delay_in_ns:         The maximum amount of delay, in ns, that the
+ *                               DLL can implement.
+ * @dma_descriptors:             A pool of DMA descriptors.
+ * @isr_dma_channel:             The DMA channel with which the NFC HAL is
+ *                               working. We record this here so the ISR knows
+ *                               which DMA channel to acknowledge.
+ * @dma_done:                    The completion structure used for DMA
+ *                               interrupts.
+ * @bch_done:                    The completion structure used for BCH
+ *                               interrupts.
+ * @timing:                      The current timing configuration.
+ * @clock_frequency_in_hz:       The clock frequency, in Hz, during the current
+ *                               I/O transaction. If no I/O transaction is in
+ *                               progress, this is the clock frequency during
+ *                               the most recent I/O transaction.
+ * @hardware_timing:             The hardware timing configuration in effect
+ *                               during the current I/O transaction. If no I/O
+ *                               transaction is in progress, this is the
+ *                               hardware timing configuration during the most
+ *                               recent I/O transaction.
+ * @init:                        Initializes the NFC hardware and data
+ *                               structures. This function will be called after
+ *                               everything has been set up for communication
+ *                               with the NFC itself, but before the platform
+ *                               has set up off-chip communication. Thus, this
+ *                               function must not attempt to communicate with
+ *                               the NAND Flash hardware.
+ * @set_geometry:                Configures the NFC hardware and data structures
+ *                               to match the physical NAND Flash geometry.
+ * @set_geometry:                Configures the NFC hardware and data structures
+ *                               to match the physical NAND Flash geometry.
+ * @set_timing:                  Configures the NFC hardware and data structures
+ *                               to match the given NAND Flash bus timing.
+ * @get_timing:                  Returns the the clock frequency, in Hz, and
+ *                               the hardware timing configuration during the
+ *                               current I/O transaction. If no I/O transaction
+ *                               is in progress, this is the timing state during
+ *                               the most recent I/O transaction.
+ * @exit:                        Shuts down the NFC hardware and data
+ *                               structures. This function will be called after
+ *                               the platform has shut down off-chip
+ *                               communication but while communication with the
+ *                               NFC itself still works.
+ * @clear_bch:                   Clears a BCH interrupt (intended to be called
+ *                               by a more general interrupt handler to do
+ *                               device-specific clearing).
+ * @is_ready:                    Returns true if the given chip is ready.
+ * @begin:                       Begins an interaction with the NFC. This
+ *                               function must be called before *any* of the
+ *                               following functions so the NFC can prepare
+ *                               itself.
+ * @end:                         Ends interaction with the NFC. This function
+ *                               should be called to give the NFC a chance to,
+ *                               among other things, enter a lower-power state.
+ * @send_command:                Sends the given buffer of command bytes.
+ * @send_data:                   Sends the given buffer of data bytes.
+ * @read_data:                   Reads data bytes into the given buffer.
+ * @send_page:                   Sends the given given data and OOB bytes,
+ *                               using the ECC engine.
+ * @read_page:                   Reads a page through the ECC engine and
+ *                               delivers the data and OOB bytes to the given
+ *                               buffers.
+ */
+struct nfc_hal {
+	/* Hardware attributes. */
+	const unsigned int      version;
+	const char              *description;
+	const unsigned int      max_chip_count;
+	const unsigned int      max_data_setup_cycles;
+	const unsigned int      internal_data_setup_in_ns;
+	const unsigned int      max_sample_delay_factor;
+	const unsigned int      max_dll_clock_period_in_ns;
+	const unsigned int      max_dll_delay_in_ns;
+
+	int                     isr_dma_channel;
+	struct completion       dma_done;
+	struct completion       bch_done;
+	struct nand_timing      timing;
+	unsigned long           clock_frequency_in_hz;
+
+	/* Configuration functions. */
+	int   (*init)        (struct gpmi_nfc_data *);
+	int   (*extra_init)  (struct gpmi_nfc_data *);
+	int   (*set_geometry)(struct gpmi_nfc_data *);
+	int   (*set_timing)  (struct gpmi_nfc_data *,
+					const struct nand_timing *);
+	void  (*get_timing)  (struct gpmi_nfc_data *,
+					unsigned long *clock_frequency_in_hz,
+					struct gpmi_nfc_hardware_timing *);
+	void  (*exit)        (struct gpmi_nfc_data *);
+
+	/* Call these functions to begin and end I/O. */
+	void  (*begin)       (struct gpmi_nfc_data *);
+	void  (*end)         (struct gpmi_nfc_data *);
+
+	/* Call these I/O functions only between begin() and end(). */
+	void  (*clear_bch)   (struct gpmi_nfc_data *);
+	int   (*is_ready)    (struct gpmi_nfc_data *, unsigned chip);
+	int   (*send_command)(struct gpmi_nfc_data *);
+	int   (*send_data)   (struct gpmi_nfc_data *);
+	int   (*read_data)   (struct gpmi_nfc_data *);
+	int   (*send_page)   (struct gpmi_nfc_data *,
+				dma_addr_t payload, dma_addr_t auxiliary);
+	int   (*read_page)   (struct gpmi_nfc_data *,
+				dma_addr_t payload, dma_addr_t auxiliary);
+};
+
+/**
+ * struct boot_rom_helper - Boot ROM Helper
+ *
+ * This structure embodies the interface to an object that assists the driver
+ * in making decisions that relate to the Boot ROM.
+ *
+ * @version:                    The Boot ROM version.
+ * @description:                A pointer to a human-readable description of the
+ *                              Boot ROM.
+ * @swap_block_mark:            Indicates that the Boot ROM will swap the block
+ *                              mark with the first byte of the OOB.
+ * @set_geometry:               Configures the Boot ROM geometry.
+ * @rom_extra_init:             Arch-specific init.
+ */
+struct boot_rom_helper {
+	const unsigned int  version;
+	const char          *description;
+	const int           swap_block_mark;
+	int  (*set_geometry)             (struct gpmi_nfc_data *);
+	int  (*rom_extra_init)           (struct gpmi_nfc_data *);
+};
+
+/* NFC HAL Common Services */
+extern int common_nfc_set_geometry(struct gpmi_nfc_data *this);
+extern int gpmi_nfc_compute_hardware_timing(struct gpmi_nfc_data *this,
+					struct gpmi_nfc_hardware_timing *hw);
+extern struct dma_chan *get_dma_chan(struct gpmi_nfc_data *this);
+extern void prepare_data_dma(struct gpmi_nfc_data *this,
+				enum dma_data_direction dr);
+extern int start_dma_without_bch_irq(struct gpmi_nfc_data *this,
+					struct dma_async_tx_descriptor *desc);
+extern int start_dma_with_bch_irq(struct gpmi_nfc_data *this,
+					struct dma_async_tx_descriptor *desc);
+/* NFC HAL Structures */
+extern struct nfc_hal  gpmi_nfc_hal_imx23_imx28;
+
+/* Boot ROM Helper Common Services */
+extern int gpmi_nfc_rom_helper_set_geometry(struct gpmi_nfc_data *this);
+
+/* Boot ROM Helper Structures */
+extern struct boot_rom_helper  gpmi_nfc_boot_rom_imx23;
+extern struct boot_rom_helper  gpmi_nfc_boot_rom_imx28;
+
+/* MTD Interface Layer */
+extern int  gpmi_nfc_mil_init(struct gpmi_nfc_data *this);
+extern void gpmi_nfc_mil_exit(struct gpmi_nfc_data *this);
+
+/* for log */
+extern int gpmi_debug;
+#define GPMI_DEBUG_INIT		0x0001
+#define GPMI_DEBUG_READ		0x0002
+#define GPMI_DEBUG_WRITE	0x0004
+#define GPMI_DEBUG_ECC_READ	0x0008
+#define GPMI_DEBUG_ECC_WRITE	0x0010
+
+#define log(a, ...) printk(KERN_INFO "[ %s : %.3d ] "a"\n", \
+			__func__, __LINE__,  ## __VA_ARGS__)
+#define logio(level)				\
+		do {				\
+			if (gpmi_debug & level)	\
+				log();		\
+		} while (0)
+
+/* BCH : Status Block Completion Codes */
+#define STATUS_GOOD		0x00
+#define STATUS_ERASED		0xff
+#define STATUS_UNCORRECTABLE	0xfe
+
+#endif
-- 
1.7.0.4



______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
