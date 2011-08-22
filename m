From: b32955@freescale.com (Huang Shijie)
Date: Mon, 22 Aug 2011 13:03:56 +0800
Subject: [PATCH v9 2/3] MTD : add helper functions library and header
	files for GPMI NAND driver
In-Reply-To: <201108201346.21647.marek.vasut@gmail.com>
References: <1313581828-16625-1-git-send-email-b32955@freescale.com>
	<1313581828-16625-3-git-send-email-b32955@freescale.com>
	<201108201346.21647.marek.vasut@gmail.com>
Message-ID: <4E51E33C.8090800@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
> On Wednesday, August 17, 2011 01:50:27 PM Huang Shijie wrote:
>> bch-regs.h : registers file for BCH module
>> gpmi-regs.h: registers file for GPMI module
>> gpmi-lib.c: helper functions library.
>>
>> Signed-off-by: Huang Shijie<b32955@freescale.com>
>> ---
>>   drivers/mtd/nand/gpmi-nand/bch-regs.h  |   88 +++
>>   drivers/mtd/nand/gpmi-nand/gpmi-lib.c  |  978
>> ++++++++++++++++++++++++++++++++ drivers/mtd/nand/gpmi-nand/gpmi-regs.h |
>> 174 ++++++
>>   3 files changed, 1240 insertions(+), 0 deletions(-)
>>   create mode 100644 drivers/mtd/nand/gpmi-nand/bch-regs.h
>>   create mode 100644 drivers/mtd/nand/gpmi-nand/gpmi-lib.c
>>   create mode 100644 drivers/mtd/nand/gpmi-nand/gpmi-regs.h
>>
>> diff --git a/drivers/mtd/nand/gpmi-nand/bch-regs.h
>> b/drivers/mtd/nand/gpmi-nand/bch-regs.h new file mode 100644
>> index 0000000..cec1dfa
>> --- /dev/null
>> +++ b/drivers/mtd/nand/gpmi-nand/bch-regs.h
>> @@ -0,0 +1,88 @@
>> +/*
>> + * Freescale GPMI NAND Flash Driver
>> + *
>> + * Copyright 2008-2011 Freescale Semiconductor, Inc.
>> + * Copyright 2008 Embedded Alley Solutions, Inc.
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
>> +#ifndef __GPMI_NAND_BCH_REGS_H
>> +#define __GPMI_NAND_BCH_REGS_H
>> +
> Aaargh, please remove these separators.
>
ok.
>> +/*========================================================================
>> ====*/ +#define HW_BCH_CTRL				0x00000000
>> +#define HW_BCH_CTRL_SET				0x00000004
>> +#define HW_BCH_CTRL_CLR				0x00000008
>> +#define HW_BCH_CTRL_TOG				0x0000000c
>> +
>> +#define BM_BCH_CTRL_COMPLETE_IRQ_EN		(1<<  8)
>> +#define BM_BCH_CTRL_COMPLETE_IRQ		(1<<  0)
>> +
>> +/*========================================================================
>> ====*/ +#define HW_BCH_STATUS0				0x00000010
>> +#define HW_BCH_MODE				0x00000020
>> +#define HW_BCH_ENCODEPTR			0x00000030
>> +#define HW_BCH_DATAPTR				0x00000040
>> +#define HW_BCH_METAPTR				0x00000050
>> +#define HW_BCH_LAYOUTSELECT			0x00000070
>> +
>> +/*========================================================================
>> ====*/ +#define HW_BCH_FLASH0LAYOUT0			0x00000080
>> +
>> +#define BP_BCH_FLASH0LAYOUT0_NBLOCKS		24
>> +#define BM_BCH_FLASH0LAYOUT0_NBLOCKS	(0xff<<
>> BP_BCH_FLASH0LAYOUT0_NBLOCKS) +#define BF_BCH_FLASH0LAYOUT0_NBLOCKS(v)		\
>> +	(((v)<<  BP_BCH_FLASH0LAYOUT0_NBLOCKS)&  BM_BCH_FLASH0LAYOUT0_NBLOCKS)
>> +
>> +#define BP_BCH_FLASH0LAYOUT0_META_SIZE		16
>> +#define BM_BCH_FLASH0LAYOUT0_META_SIZE	(0xff<<
>> BP_BCH_FLASH0LAYOUT0_META_SIZE) +#define
>> BF_BCH_FLASH0LAYOUT0_META_SIZE(v)	\
>> +	(((v)<<  BP_BCH_FLASH0LAYOUT0_META_SIZE)\
>> +					&  BM_BCH_FLASH0LAYOUT0_META_SIZE)
>> +
>> +#define BP_BCH_FLASH0LAYOUT0_ECC0		12
>> +#define BM_BCH_FLASH0LAYOUT0_ECC0	(0xf<<  BP_BCH_FLASH0LAYOUT0_ECC0)
>> +#define BF_BCH_FLASH0LAYOUT0_ECC0(v)		\
>> +	(((v)<<  BP_BCH_FLASH0LAYOUT0_ECC0)&  BM_BCH_FLASH0LAYOUT0_ECC0)
>> +
>> +#define BP_BCH_FLASH0LAYOUT0_DATA0_SIZE		0
>> +#define BM_BCH_FLASH0LAYOUT0_DATA0_SIZE		\
>> +			(0xfff<<  BP_BCH_FLASH0LAYOUT0_DATA0_SIZE)
>> +#define BF_BCH_FLASH0LAYOUT0_DATA0_SIZE(v)	\
>> +	(((v)<<  BP_BCH_FLASH0LAYOUT0_DATA0_SIZE)\
>> +					&  BM_BCH_FLASH0LAYOUT0_DATA0_SIZE)
>> +
>> +/*========================================================================
>> ====*/ +#define HW_BCH_FLASH0LAYOUT1			0x00000090
>> +
>> +#define BP_BCH_FLASH0LAYOUT1_PAGE_SIZE		16
>> +#define BM_BCH_FLASH0LAYOUT1_PAGE_SIZE		\
>> +			(0xffff<<  BP_BCH_FLASH0LAYOUT1_PAGE_SIZE)
>> +#define BF_BCH_FLASH0LAYOUT1_PAGE_SIZE(v)	\
>> +	(((v)<<  BP_BCH_FLASH0LAYOUT1_PAGE_SIZE) \
>> +					&  BM_BCH_FLASH0LAYOUT1_PAGE_SIZE)
>> +
>> +#define BP_BCH_FLASH0LAYOUT1_ECCN		12
>> +#define BM_BCH_FLASH0LAYOUT1_ECCN	(0xf<<  BP_BCH_FLASH0LAYOUT1_ECCN)
>> +#define BF_BCH_FLASH0LAYOUT1_ECCN(v)		\
>> +	(((v)<<  BP_BCH_FLASH0LAYOUT1_ECCN)&  BM_BCH_FLASH0LAYOUT1_ECCN)
>> +
>> +#define BP_BCH_FLASH0LAYOUT1_DATAN_SIZE		0
>> +#define BM_BCH_FLASH0LAYOUT1_DATAN_SIZE		\
>> +			(0xfff<<  BP_BCH_FLASH0LAYOUT1_DATAN_SIZE)
>> +#define BF_BCH_FLASH0LAYOUT1_DATAN_SIZE(v)	\
>> +	(((v)<<  BP_BCH_FLASH0LAYOUT1_DATAN_SIZE) \
>> +					&  BM_BCH_FLASH0LAYOUT1_DATAN_SIZE)
>> +#endif
>> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
>> b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c new file mode 100644
>> index 0000000..1368842
>> --- /dev/null
>> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
>> @@ -0,0 +1,978 @@
>> +/*
>> + * Freescale GPMI NAND Flash Driver
>> + *
>> + * Copyright (C) 2008-2011 Freescale Semiconductor, Inc.
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
>> +#include "gpmi-nand.h"
>> +#include "gpmi-regs.h"
>> +#include "bch-regs.h"
>> +
>> +struct timing_threshod timing_default_threshold = {
>> +	.max_data_setup_cycles       = (BM_GPMI_TIMING0_DATA_SETUP>>
>> +						BP_GPMI_TIMING0_DATA_SETUP),
>> +	.internal_data_setup_in_ns   = 0,
>> +	.max_sample_delay_factor     = (BM_GPMI_CTRL1_RDN_DELAY>>
>> +						BP_GPMI_CTRL1_RDN_DELAY),
>> +	.max_dll_clock_period_in_ns  = 32,
>> +	.max_dll_delay_in_ns         = 16,
>> +};
>> +
>> +int gpmi_init(struct gpmi_nand_data *this)
>> +{
>> +	struct resources *r =&this->resources;
>> +	int ret;
>> +
>> +	ret = clk_enable(r->clock);
>> +	if (ret)
>> +		goto err_out;
>> +	ret = mxs_reset_block(r->gpmi_regs);
>> +	if (ret)
>> +		goto err_out;
>> +
>> +	/* Choose NAND mode. */
>> +	writel(BM_GPMI_CTRL1_GPMI_MODE, r->gpmi_regs + HW_GPMI_CTRL1_CLR);
>> +
>> +	/* Set the IRQ polarity. */
>> +	writel(BM_GPMI_CTRL1_ATA_IRQRDY_POLARITY,
>> +				r->gpmi_regs + HW_GPMI_CTRL1_SET);
>> +
>> +	/* Disable Write-Protection. */
>> +	writel(BM_GPMI_CTRL1_DEV_RESET, r->gpmi_regs + HW_GPMI_CTRL1_SET);
>> +
>> +	/* Select BCH ECC. */
>> +	writel(BM_GPMI_CTRL1_BCH_MODE, r->gpmi_regs + HW_GPMI_CTRL1_SET);
>> +
>> +	clk_disable(r->clock);
>> +	return 0;
>> +err_out:
>> +	return ret;
>> +}
>> +
>> +/* This is very useful! */
> Really? Cool, what for ?
> btw. this should really be enclosed in some #ifdef debug or whatnot.
>
Yes, it shows the register contents when DMA timeout occurs.
this routine is called only when error occurs.



>> +void gpmi_show_regs(struct gpmi_nand_data *this)
>> +{
>> +	struct resources *r =&this->resources;
>> +	u32 reg;
>> +	int i;
>> +	int n;
>> +
>> +	n = HW_GPMI_DEBUG / 0x10 + 1;
>> +
>> +	pr_info("-------------- Show GPMI registers ----------\n");
>> +	for (i = 0; i<= n; i++) {
>> +		reg = readl(r->gpmi_regs + i * 0x10);
>> +		pr_info("offset 0x%.3x : 0x%.8x\n", i * 0x10, reg);
>> +	}
>> +	pr_info("-------------- Show GPMI registers end ----------\n");
>> +}
>> +
>> +/* Configures the geometry for BCH.  */
>> +int bch_set_geometry(struct gpmi_nand_data *this)
>> +{
>> +	struct resources *r =&this->resources;
>> +	struct bch_geometry *bch_geo =&this->bch_geometry;
>> +	unsigned int block_count;
>> +	unsigned int block_size;
>> +	unsigned int metadata_size;
>> +	unsigned int ecc_strength;
>> +	unsigned int page_size;
>> +	int ret;
>> +
>> +	if (common_nfc_set_geometry(this))
>> +		return !0;
>> +
>> +	block_count   = bch_geo->ecc_chunk_count - 1;
>> +	block_size    = bch_geo->ecc_chunk_size_in_bytes;
>> +	metadata_size = bch_geo->metadata_size_in_bytes;
>> +	ecc_strength  = bch_geo->ecc_strength>>  1;
>> +	page_size     = bch_geo->page_size_in_bytes;
>> +
>> +	ret = clk_enable(r->clock);
>> +	if (ret)
>> +		goto err_out;
>> +	ret = mxs_reset_block(r->bch_regs);
>> +	if (ret)
>> +		goto err_out;
>> +
>> +	/* Configure layout 0. */
>> +	writel(BF_BCH_FLASH0LAYOUT0_NBLOCKS(block_count)
>> +			| BF_BCH_FLASH0LAYOUT0_META_SIZE(metadata_size)
>> +			| BF_BCH_FLASH0LAYOUT0_ECC0(ecc_strength)
>> +			| BF_BCH_FLASH0LAYOUT0_DATA0_SIZE(block_size),
>> +			r->bch_regs + HW_BCH_FLASH0LAYOUT0);
>> +
>> +	writel(BF_BCH_FLASH0LAYOUT1_PAGE_SIZE(page_size)
>> +			| BF_BCH_FLASH0LAYOUT1_ECCN(ecc_strength)
>> +			| BF_BCH_FLASH0LAYOUT1_DATAN_SIZE(block_size),
>> +			r->bch_regs + HW_BCH_FLASH0LAYOUT1);
>> +
>> +	/* Set *all* chip selects to use layout 0. */
>> +	writel(0, r->bch_regs + HW_BCH_LAYOUTSELECT);
>> +
>> +	/* Enable interrupts. */
>> +	writel(BM_BCH_CTRL_COMPLETE_IRQ_EN,
>> +				r->bch_regs + HW_BCH_CTRL_SET);
>> +
>> +	clk_disable(r->clock);
>> +	return 0;
>> +err_out:
>> +	return ret;
>> +}
>> +
>> +/*
>> + * ns_to_cycles - Converts time in nanoseconds to cycles.
>> + *
>> + * @ntime:   The time, in nanoseconds.
>> + * @period:  The cycle period, in nanoseconds.
>> + * @min:     The minimum allowable number of cycles.
>> + */
>> +static unsigned int ns_to_cycles(unsigned int time,
>> +			unsigned int period, unsigned int min)
>> +{
>> +	unsigned int k;
>> +
>> +	/*
>> +	 * Compute the minimum number of cycles that entirely contain the
>> +	 * given time.
>> +	 */
>> +	k = (time + period - 1) / period;
>> +	return max(k, min);
>> +}
>> +
>> +/*
>> + * gpmi_compute_hardware_timing - Apply timing to current hardware
>> conditions. + *
>> + * @this:             Per-device data.
>> + * @hardware_timing:  A pointer to a hardware timing structure that will
>> receive + *                    the results of our calculations.
>> + */
>> +static int gpmi_nfc_compute_hardware_timing(struct gpmi_nand_data *this,
>> +					struct gpmi_nfc_hardware_timing *hw)
>> +{
>> +	struct gpmi_nand_platform_data *pdata = this->pdata;
>> +	struct timing_threshod *nfc =&timing_default_threshold;
>> +	struct nand_chip *nand =&this->mil.nand;
>> +	struct nand_timing target = this->timing;
>> +	bool improved_timing_is_available;
>> +	unsigned long clock_frequency_in_hz;
>> +	unsigned int clock_period_in_ns;
>> +	bool dll_use_half_periods;
>> +	unsigned int dll_delay_shift;
>> +	unsigned int max_sample_delay_in_ns;
>> +	unsigned int address_setup_in_cycles;
>> +	unsigned int data_setup_in_ns;
>> +	unsigned int data_setup_in_cycles;
>> +	unsigned int data_hold_in_cycles;
>> +	int ideal_sample_delay_in_ns;
>> +	unsigned int sample_delay_factor;
>> +	int tEYE;
>> +	unsigned int min_prop_delay_in_ns = pdata->min_prop_delay_in_ns;
>> +	unsigned int max_prop_delay_in_ns = pdata->max_prop_delay_in_ns;
>> +
>> +	/*
>> +	 * If there are multiple chips, we need to relax the timings to allow
>> +	 * for signal distortion due to higher capacitance.
>> +	 */
>> +	if (nand->numchips>  2) {
>> +		target.data_setup_in_ns    += 10;
>> +		target.data_hold_in_ns     += 10;
>> +		target.address_setup_in_ns += 10;
>> +	} else if (nand->numchips>  1) {
>> +		target.data_setup_in_ns    += 5;
>> +		target.data_hold_in_ns     += 5;
>> +		target.address_setup_in_ns += 5;
>> +	}
>> +
>> +	/* Check if improved timing information is available. */
>> +	improved_timing_is_available =
>> +		(target.tREA_in_ns>= 0)&&
>> +		(target.tRLOH_in_ns>= 0)&&
>> +		(target.tRHOH_in_ns>= 0) ;
>> +
>> +	/* Inspect the clock. */
>> +	clock_frequency_in_hz = nfc->clock_frequency_in_hz;
>> +	clock_period_in_ns    = 1000000000 / clock_frequency_in_hz;
>> +
>> +	/*
>> +	 * The NFC quantizes setup and hold parameters in terms of clock cycles.
>> +	 * Here, we quantize the setup and hold timing parameters to the
>> +	 * next-highest clock period to make sure we apply at least the
>> +	 * specified times.
>> +	 *
>> +	 * For data setup and data hold, the hardware interprets a value of zero
>> +	 * as the largest possible delay. This is not what's intended by a zero
>> +	 * in the input parameter, so we impose a minimum of one cycle.
>> +	 */
>> +	data_setup_in_cycles    = ns_to_cycles(target.data_setup_in_ns,
>> +							clock_period_in_ns, 1);
>> +	data_hold_in_cycles     = ns_to_cycles(target.data_hold_in_ns,
>> +							clock_period_in_ns, 1);
>> +	address_setup_in_cycles = ns_to_cycles(target.address_setup_in_ns,
>> +							clock_period_in_ns, 0);
>> +
>> +	/*
>> +	 * The clock's period affects the sample delay in a number of ways:
>> +	 *
>> +	 * (1) The NFC HAL tells us the maximum clock period the sample delay
>> +	 *     DLL can tolerate. If the clock period is greater than half that
>> +	 *     maximum, we must configure the DLL to be driven by half periods.
>> +	 *
>> +	 * (2) We need to convert from an ideal sample delay, in ns, to a
>> +	 *     "sample delay factor," which the NFC uses. This factor depends on
>> +	 *     whether we're driving the DLL with full or half periods.
>> +	 *     Paraphrasing the reference manual:
>> +	 *
>> +	 *         AD = SDF x 0.125 x RP
>> +	 *
>> +	 * where:
>> +	 *
>> +	 *     AD   is the applied delay, in ns.
>> +	 *     SDF  is the sample delay factor, which is dimensionless.
>> +	 *     RP   is the reference period, in ns, which is a full clock period
>> +	 *          if the DLL is being driven by full periods, or half that if
>> +	 *          the DLL is being driven by half periods.
>> +	 *
>> +	 * Let's re-arrange this in a way that's more useful to us:
>> +	 *
>> +	 *                        8
>> +	 *         SDF  =  AD x ----
>> +	 *                       RP
>> +	 *
>> +	 * The reference period is either the clock period or half that, so this
>> +	 * is:
>> +	 *
>> +	 *                        8       AD x DDF
>> +	 *         SDF  =  AD x -----  =  --------
>> +	 *                      f x P        P
>> +	 *
>> +	 * where:
>> +	 *
>> +	 *       f  is 1 or 1/2, depending on how we're driving the DLL.
>> +	 *       P  is the clock period.
>> +	 *     DDF  is the DLL Delay Factor, a dimensionless value that
>> +	 *          incorporates all the constants in the conversion.
>> +	 *
>> +	 * DDF will be either 8 or 16, both of which are powers of two. We can
>> +	 * reduce the cost of this conversion by using bit shifts instead of
>> +	 * multiplication or division. Thus:
>> +	 *
>> +	 *                 AD<<  DDS
>> +	 *         SDF  =  ---------
>> +	 *                     P
>> +	 *
>> +	 *     or
>> +	 *
>> +	 *         AD  =  (SDF>>  DDS) x P
>> +	 *
>> +	 * where:
>> +	 *
>> +	 *     DDS  is the DLL Delay Shift, the logarithm to base 2 of the DDF.
>> +	 */
>> +	if (clock_period_in_ns>  (nfc->max_dll_clock_period_in_ns>>  1)) {
>> +		dll_use_half_periods = true;
>> +		dll_delay_shift      = 3 + 1;
>> +	} else {
>> +		dll_use_half_periods = false;
>> +		dll_delay_shift      = 3;
>> +	}
>> +
>> +	/*
>> +	 * Compute the maximum sample delay the NFC allows, under current
>> +	 * conditions. If the clock is running too slowly, no sample delay is
>> +	 * possible.
>> +	 */
>> +	if (clock_period_in_ns>  nfc->max_dll_clock_period_in_ns)
>> +		max_sample_delay_in_ns = 0;
>> +	else {
>> +		/*
>> +		 * Compute the delay implied by the largest sample delay factor
>> +		 * the NFC allows.
>> +		 */
>> +		max_sample_delay_in_ns =
>> +			(nfc->max_sample_delay_factor * clock_period_in_ns)>>
>> +								dll_delay_shift;
>> +
>> +		/*
>> +		 * Check if the implied sample delay larger than the NFC
>> +		 * actually allows.
>> +		 */
>> +		if (max_sample_delay_in_ns>  nfc->max_dll_delay_in_ns)
>> +			max_sample_delay_in_ns = nfc->max_dll_delay_in_ns;
>> +	}
>> +
>> +	/*
>> +	 * Check if improved timing information is available. If not, we have to
>> +	 * use a less-sophisticated algorithm.
>> +	 */
>> +	if (!improved_timing_is_available) {
>> +		/*
>> +		 * Fold the read setup time required by the NFC into the ideal
>> +		 * sample delay.
>> +		 */
>> +		ideal_sample_delay_in_ns = target.gpmi_sample_delay_in_ns +
>> +						nfc->internal_data_setup_in_ns;
>> +
>> +		/*
>> +		 * The ideal sample delay may be greater than the maximum
>> +		 * allowed by the NFC. If so, we can trade off sample delay time
>> +		 * for more data setup time.
>> +		 *
>> +		 * In each iteration of the following loop, we add a cycle to
>> +		 * the data setup time and subtract a corresponding amount from
>> +		 * the sample delay until we've satisified the constraints or
>> +		 * can't do any better.
>> +		 */
>> +		while ((ideal_sample_delay_in_ns>  max_sample_delay_in_ns)&&
>> +			(data_setup_in_cycles<  nfc->max_data_setup_cycles)) {
>> +
>> +			data_setup_in_cycles++;
>> +			ideal_sample_delay_in_ns -= clock_period_in_ns;
>> +
>> +			if (ideal_sample_delay_in_ns<  0)
>> +				ideal_sample_delay_in_ns = 0;
>> +
>> +		}
>> +
>> +		/*
>> +		 * Compute the sample delay factor that corresponds most closely
>> +		 * to the ideal sample delay. If the result is too large for the
>> +		 * NFC, use the maximum value.
>> +		 *
>> +		 * Notice that we use the ns_to_cycles function to compute the
>> +		 * sample delay factor. We do this because the form of the
>> +		 * computation is the same as that for calculating cycles.
>> +		 */
>> +		sample_delay_factor =
>> +			ns_to_cycles(
>> +				ideal_sample_delay_in_ns<<  dll_delay_shift,
>> +							clock_period_in_ns, 0);
>> +
>> +		if (sample_delay_factor>  nfc->max_sample_delay_factor)
>> +			sample_delay_factor = nfc->max_sample_delay_factor;
>> +
>> +		/* Skip to the part where we return our results. */
>> +		goto return_results;
>> +	}
>> +
>> +	/*
>> +	 * If control arrives here, we have more detailed timing information,
>> +	 * so we can use a better algorithm.
>> +	 */
>> +
>> +	/*
>> +	 * Fold the read setup time required by the NFC into the maximum
>> +	 * propagation delay.
>> +	 */
>> +	max_prop_delay_in_ns += nfc->internal_data_setup_in_ns;
>> +
>> +	/*
>> +	 * Earlier, we computed the number of clock cycles required to satisfy
>> +	 * the data setup time. Now, we need to know the actual nanoseconds.
>> +	 */
>> +	data_setup_in_ns = clock_period_in_ns * data_setup_in_cycles;
>> +
>> +	/*
>> +	 * Compute tEYE, the width of the data eye when reading from the NAND
>> +	 * Flash. The eye width is fundamentally determined by the data setup
>> +	 * time, perturbed by propagation delays and some characteristics of the
>> +	 * NAND Flash device.
>> +	 *
>> +	 * start of the eye = max_prop_delay + tREA
>> +	 * end of the eye   = min_prop_delay + tRHOH + data_setup
>> +	 */
>> +	tEYE = (int)min_prop_delay_in_ns + (int)target.tRHOH_in_ns +
>> +							(int)data_setup_in_ns;
>> +
>> +	tEYE -= (int)max_prop_delay_in_ns + (int)target.tREA_in_ns;
>> +
>> +	/*
>> +	 * The eye must be open. If it's not, we can try to open it by
>> +	 * increasing its main forcer, the data setup time.
>> +	 *
>> +	 * In each iteration of the following loop, we increase the data setup
>> +	 * time by a single clock cycle. We do this until either the eye is
>> +	 * open or we run into NFC limits.
>> +	 */
>> +	while ((tEYE<= 0)&&
>> +			(data_setup_in_cycles<  nfc->max_data_setup_cycles)) {
>> +		/* Give a cycle to data setup. */
>> +		data_setup_in_cycles++;
>> +		/* Synchronize the data setup time with the cycles. */
>> +		data_setup_in_ns += clock_period_in_ns;
>> +		/* Adjust tEYE accordingly. */
>> +		tEYE += clock_period_in_ns;
>> +	}
>> +
>> +	/*
>> +	 * When control arrives here, the eye is open. The ideal time to sample
>> +	 * the data is in the center of the eye:
>> +	 *
>> +	 *     end of the eye + start of the eye
>> +	 *     ---------------------------------  -  data_setup
>> +	 *                    2
>> +	 *
>> +	 * After some algebra, this simplifies to the code immediately below.
>> +	 */
>> +	ideal_sample_delay_in_ns =
>> +		((int)max_prop_delay_in_ns +
>> +			(int)target.tREA_in_ns +
>> +				(int)min_prop_delay_in_ns +
>> +					(int)target.tRHOH_in_ns -
>> +						(int)data_setup_in_ns)>>  1;
>> +
>> +	/*
>> +	 * The following figure illustrates some aspects of a NAND Flash read:
>> +	 *
>> +	 *
>> +	 *           __                   _____________________________________
>> +	 * RDN         \_________________/
>> +	 *
>> +	 *<---- tEYE ----->
>> +	 *                                        /-----------------\
>> +	 * Read Data ----------------------------<                    >---------
>> +	 *                                        \-----------------/
>> +	 *             ^                 ^                 ^              ^
>> +	 *             |                 |                 |              |
>> +	 *             |<--Data Setup -->|<--Delay Time -->|              |
>> +	 *             |                 |                 |              |
>> +	 *             |                 |                                |
>> +	 *             |                 |<--   Quantized Delay Time   -->|
>> +	 *             |                 |                                |
>> +	 *
>> +	 *
>> +	 * We have some issues we must now address:
>> +	 *
>> +	 * (1) The *ideal* sample delay time must not be negative. If it is, we
>> +	 *     jam it to zero.
>> +	 *
>> +	 * (2) The *ideal* sample delay time must not be greater than that
>> +	 *     allowed by the NFC. If it is, we can increase the data setup
>> +	 *     time, which will reduce the delay between the end of the data
>> +	 *     setup and the center of the eye. It will also make the eye
>> +	 *     larger, which might help with the next issue...
>> +	 *
>> +	 * (3) The *quantized* sample delay time must not fall either before the
>> +	 *     eye opens or after it closes (the latter is the problem
>> +	 *     illustrated in the above figure).
>> +	 */
>> +
>> +	/* Jam a negative ideal sample delay to zero. */
>> +	if (ideal_sample_delay_in_ns<  0)
>> +		ideal_sample_delay_in_ns = 0;
>> +
>> +	/*
>> +	 * Extend the data setup as needed to reduce the ideal sample delay
>> +	 * below the maximum permitted by the NFC.
>> +	 */
>> +	while ((ideal_sample_delay_in_ns>  max_sample_delay_in_ns)&&
>> +			(data_setup_in_cycles<  nfc->max_data_setup_cycles)) {
>> +
>> +		/* Give a cycle to data setup. */
>> +		data_setup_in_cycles++;
>> +		/* Synchronize the data setup time with the cycles. */
>> +		data_setup_in_ns += clock_period_in_ns;
>> +		/* Adjust tEYE accordingly. */
>> +		tEYE += clock_period_in_ns;
>> +
>> +		/*
>> +		 * Decrease the ideal sample delay by one half cycle, to keep it
>> +		 * in the middle of the eye.
>> +		 */
>> +		ideal_sample_delay_in_ns -= (clock_period_in_ns>>  1);
>> +
>> +		/* Jam a negative ideal sample delay to zero. */
>> +		if (ideal_sample_delay_in_ns<  0)
>> +			ideal_sample_delay_in_ns = 0;
>> +	}
>> +
>> +	/*
>> +	 * Compute the sample delay factor that corresponds to the ideal sample
>> +	 * delay. If the result is too large, then use the maximum allowed
>> +	 * value.
>> +	 *
>> +	 * Notice that we use the ns_to_cycles function to compute the sample
>> +	 * delay factor. We do this because the form of the computation is the
>> +	 * same as that for calculating cycles.
>> +	 */
>> +	sample_delay_factor =
>> +		ns_to_cycles(ideal_sample_delay_in_ns<<  dll_delay_shift,
>> +							clock_period_in_ns, 0);
>> +
>> +	if (sample_delay_factor>  nfc->max_sample_delay_factor)
>> +		sample_delay_factor = nfc->max_sample_delay_factor;
>> +
>> +	/*
>> +	 * These macros conveniently encapsulate a computation we'll use to
>> +	 * continuously evaluate whether or not the data sample delay is inside
>> +	 * the eye.
>> +	 */
>> +	#define IDEAL_DELAY  ((int) ideal_sample_delay_in_ns)
>> +
>> +	#define QUANTIZED_DELAY  \
>> +		((int) ((sample_delay_factor * clock_period_in_ns)>>  \
>> +							dll_delay_shift))
>> +
>> +	#define DELAY_ERROR  (abs(QUANTIZED_DELAY - IDEAL_DELAY))
>> +
>> +	#define SAMPLE_IS_NOT_WITHIN_THE_EYE  (DELAY_ERROR>  (tEYE>>  1))
>> +
>> +	/*
>> +	 * While the quantized sample time falls outside the eye, reduce the
>> +	 * sample delay or extend the data setup to move the sampling point back
>> +	 * toward the eye. Do not allow the number of data setup cycles to
>> +	 * exceed the maximum allowed by the NFC.
>> +	 */
>> +	while (SAMPLE_IS_NOT_WITHIN_THE_EYE&&
>> +			(data_setup_in_cycles<  nfc->max_data_setup_cycles)) {
>> +		/*
>> +		 * If control arrives here, the quantized sample delay falls
>> +		 * outside the eye. Check if it's before the eye opens, or after
>> +		 * the eye closes.
>> +		 */
>> +		if (QUANTIZED_DELAY>  IDEAL_DELAY) {
>> +			/*
>> +			 * If control arrives here, the quantized sample delay
>> +			 * falls after the eye closes. Decrease the quantized
>> +			 * delay time and then go back to re-evaluate.
>> +			 */
>> +			if (sample_delay_factor != 0)
>> +				sample_delay_factor--;
>> +			continue;
>> +		}
>> +
>> +		/*
>> +		 * If control arrives here, the quantized sample delay falls
>> +		 * before the eye opens. Shift the sample point by increasing
>> +		 * data setup time. This will also make the eye larger.
>> +		 */
>> +
>> +		/* Give a cycle to data setup. */
>> +		data_setup_in_cycles++;
>> +		/* Synchronize the data setup time with the cycles. */
>> +		data_setup_in_ns += clock_period_in_ns;
>> +		/* Adjust tEYE accordingly. */
>> +		tEYE += clock_period_in_ns;
>> +
>> +		/*
>> +		 * Decrease the ideal sample delay by one half cycle, to keep it
>> +		 * in the middle of the eye.
>> +		 */
>> +		ideal_sample_delay_in_ns -= (clock_period_in_ns>>  1);
>> +
>> +		/* ...and one less period for the delay time. */
>> +		ideal_sample_delay_in_ns -= clock_period_in_ns;
>> +
>> +		/* Jam a negative ideal sample delay to zero. */
>> +		if (ideal_sample_delay_in_ns<  0)
>> +			ideal_sample_delay_in_ns = 0;
>> +
>> +		/*
>> +		 * We have a new ideal sample delay, so re-compute the quantized
>> +		 * delay.
>> +		 */
>> +		sample_delay_factor =
>> +			ns_to_cycles(
>> +				ideal_sample_delay_in_ns<<  dll_delay_shift,
>> +							clock_period_in_ns, 0);
>> +
>> +		if (sample_delay_factor>  nfc->max_sample_delay_factor)
>> +			sample_delay_factor = nfc->max_sample_delay_factor;
>> +	}
>> +
>> +	/* Control arrives here when we're ready to return our results. */
>> +return_results:
>> +	hw->data_setup_in_cycles    = data_setup_in_cycles;
>> +	hw->data_hold_in_cycles     = data_hold_in_cycles;
>> +	hw->address_setup_in_cycles = address_setup_in_cycles;
>> +	hw->use_half_periods        = dll_use_half_periods;
>> +	hw->sample_delay_factor     = sample_delay_factor;
>> +
>> +	/* Return success. */
>> +	return 0;
>> +}
>> +
>> +/* Begin the I/O */
>> +void gpmi_begin(struct gpmi_nand_data *this)
>> +{
>> +	struct resources *r =&this->resources;
>> +	struct timing_threshod *nfc =&timing_default_threshold;
>> +	unsigned char  *gpmi_regs = r->gpmi_regs;
>> +	unsigned int   clock_period_in_ns;
>> +	uint32_t       reg;
>> +	unsigned int   dll_wait_time_in_us;
>> +	struct gpmi_nfc_hardware_timing  hw;
>> +	int ret;
>> +
>> +	/* Enable the clock. */
>> +	ret = clk_enable(r->clock);
>> +	if (ret) {
>> +		pr_info("We failed in enable the clk\n");
>> +		goto err_out;
>> +	}
>> +
>> +	/* set ready/busy timeout */
>> +	writel(0x500<<  16, gpmi_regs + HW_GPMI_TIMING1);
>> +
>> +	/* Get the timing information we need. */
>> +	nfc->clock_frequency_in_hz = clk_get_rate(r->clock);
>> +	clock_period_in_ns = 1000000000 / nfc->clock_frequency_in_hz;
>> +
>> +	gpmi_nfc_compute_hardware_timing(this,&hw);
>> +
>> +	/* Set up all the simple timing parameters. */
>> +	reg = BF_GPMI_TIMING0_ADDRESS_SETUP(hw.address_setup_in_cycles) |
>> +		BF_GPMI_TIMING0_DATA_HOLD(hw.data_hold_in_cycles)         |
>> +		BF_GPMI_TIMING0_DATA_SETUP(hw.data_setup_in_cycles)       ;
>> +
>> +	writel(reg, gpmi_regs + HW_GPMI_TIMING0);
>> +
>> +	/*
>> +	 * HEY - PAY ATTENTION!
> Please fix this comment and pay attention to other comments ;-)
>
ok :)

thanks

Huang Shijie
