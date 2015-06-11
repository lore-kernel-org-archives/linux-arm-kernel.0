From: r.spliet@ultimaker.com (Roy Spliet)
Date: Thu, 11 Jun 2015 16:50:35 +0200
Subject: [PATCH v3 1/2] mtd: nand: sunxi: Replace failsafe timing cfg
 with calculated value
In-Reply-To: <20150610105913.1851241d@bbrezillon>
References: <1433924948-19288-1-git-send-email-r.spliet@ultimaker.com>
 <20150610105913.1851241d@bbrezillon>
Message-ID: <5579A03B.2010406@ultimaker.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Boris,

Op 10-06-15 om 10:59 schreef Boris Brezillon:
> Hi Roy,
>
> On Wed, 10 Jun 2015 10:29:07 +0200
> Roy Spliet <r.spliet@ultimaker.com> wrote:
>
>> Calculates the timing cfg value once when initialising a chip, then sets
>> it on chip select. Register definition documented the A83 user manual.
> How about rewording the sentence this way:
>
> "
> The TIMING_CFG register was previously statically set to a magic value
> (extracted from Allwinner's BSP) when initializing the NAND controller.
> Now that we have more details about the TIMING_CFG register layout
> (extracted from the A83 user manual) we can dynamically calculate the
> appropriate value for each NAND chip and set it when selecting the
> chip.
> "
>
>> Signed-off-by: Roy Spliet <r.spliet@ultimaker.com>
>>
>> V2:
>> - Fix crippled comments
>>
>> V3:
>> - Warn for invalid timings
>> - Style
> Almost right: the changelog should be placed after the '---' line ;-).
Git (format-patch, send-email) doesn't let me do that to the best of my 
knowledge. Other comments I will process, thanks.
Yours,

Roy
>
>> ---
>>   drivers/mtd/nand/sunxi_nand.c | 71 ++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 66 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
>> index 6f93b29..68090b7 100644
>> --- a/drivers/mtd/nand/sunxi_nand.c
>> +++ b/drivers/mtd/nand/sunxi_nand.c
>> @@ -99,6 +99,13 @@
>>   				 NFC_CMD_INT_ENABLE | \
>>   				 NFC_DMA_INT_ENABLE)
>>   
>> +/* define bit use in NFC_TIMING_CFG */
>    /* define NFC_TIMING_CFG register layout */
>
>> +#define NFC_TIMING_CFG(tWB, tADL, tWHR, tRHW, tCAD)		\
>> +	((tWB) & 0x3) | (((tADL) & 0x3) << 2) |			\
>> +	(((tWHR) & 0x3) << 4) | (((tRHW) & 0x3) << 6) |		\
>> +	(((tCAD) & 0x7) << 8);
>> +
>> +
>>   /* define bit use in NFC_CMD */
>>   #define NFC_CMD_LOW_BYTE	GENMASK(7, 0)
>>   #define NFC_CMD_HIGH_BYTE	GENMASK(15, 8)
>> @@ -208,6 +215,7 @@ struct sunxi_nand_hw_ecc {
>>    * @nand:		base NAND chip structure
>>    * @mtd:		base MTD structure
>>    * @clk_rate:		clk_rate required for this NAND chip
>> + * @timing_cfg		TIMING_CFG register value for this NAND chip
>>    * @selected:		current active CS
>>    * @nsels:		number of CS lines required by the NAND chip
>>    * @sels:		array of CS lines descriptions
>> @@ -217,6 +225,7 @@ struct sunxi_nand_chip {
>>   	struct nand_chip nand;
>>   	struct mtd_info mtd;
>>   	unsigned long clk_rate;
>> +	u32 timing_cfg;
>>   	int selected;
>>   	int nsels;
>>   	struct sunxi_nand_chip_sel sels[0];
>> @@ -403,6 +412,7 @@ static void sunxi_nfc_select_chip(struct mtd_info *mtd, int chip)
>>   		}
>>   	}
>>   
>> +	writel(sunxi_nand->timing_cfg, nfc->regs + NFC_REG_TIMING_CFG);
>>   	writel(ctl, nfc->regs + NFC_REG_CTL);
>>   
>>   	sunxi_nand->selected = chip;
>> @@ -807,10 +817,33 @@ static int sunxi_nfc_hw_syndrome_ecc_write_page(struct mtd_info *mtd,
>>   	return 0;
>>   }
>>   
>> +static const s32 tWB_lut[] = {6, 12, 16, 20};
>> +static const s32 tRHW_lut[] = {4, 8, 12, 20};
>> +
>> +static s32 _sunxi_nand_lookup_timing(const s32 *lut, int lut_size, u32 duration,
>> +		u32 clk_period)
> You can return an int here.
>
>> +{
>> +	u32 clk_cycles = (duration + clk_period - 1) / clk_period;
> DIV_ROUND_UP(duration, clk_period) ??
>
>> +	int i;
>> +
>> +	for (i = 0; i < lut_size; i++) {
>> +		if (clk_cycles <= lut[i])
>> +			return i;
>> +	}
>> +
>> +	/* Doesn't fit */
>> +	return -1;
> How about returning -EINVAL (or -ENOTSUP) directly ?
>
>> +}
>> +
>> +#define sunxi_nand_lookup_timing(l,p,c) \
>> +			_sunxi_nand_lookup_timing(l, ARRAY_SIZE(l), p, c)
>> +
>>   static int sunxi_nand_chip_set_timings(struct sunxi_nand_chip *chip,
>>   				       const struct nand_sdr_timings *timings)
>>   {
>> +	struct sunxi_nfc *nfc = to_sunxi_nfc(chip->nand.controller);
>>   	u32 min_clk_period = 0;
>> +	u32 tWB, tADL, tWHR, tRHW, tCAD;
>>   
>>   	/* T1 <=> tCLS */
>>   	if (timings->tCLS_min > min_clk_period)
>> @@ -872,6 +905,37 @@ static int sunxi_nand_chip_set_timings(struct sunxi_nand_chip *chip,
>>   	if (timings->tWC_min > (min_clk_period * 2))
>>   		min_clk_period = DIV_ROUND_UP(timings->tWC_min, 2);
>>   
>> +	/* T16 - T19 + tCAD */
>> +	tWB  = sunxi_nand_lookup_timing(tWB_lut, timings->tWB_max,
>> +					min_clk_period);
>> +	if (tWB == -1) {
>> +		dev_err(nfc->dev, "unsupported tWB\n");
>> +		return -EINVAL;
> If you return -EINVAL in case of failure, you can just replace that
> test by
>
> 	if (tWB < 0) {
> 		dev_err(nfc->dev, "unsupported tWB\n");
> 		return tWB;
> 	}
>
>> +	}
>> +
>> +	tADL = DIV_ROUND_UP(timings->tADL_min, min_clk_period) >> 3;
>> +	if (tADL > 3) {
>> +		dev_err(nfc->dev, "unsupported tADL\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	tWHR = DIV_ROUND_UP(timings->tWHR_min, min_clk_period) >> 3;
>> +	if (tWHR > 3) {
>> +		dev_err(nfc->dev, "unsupported tWHR\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	tRHW = sunxi_nand_lookup_timing(tRHW_lut, timings->tRHW_min,
>> +					min_clk_period);
>> +	if (tRHW == -1) {
>> +		dev_err(nfc->dev, "unsupported tRHW\n");
>> +		return -EINVAL;
>> +	}
> Ditto
>
>> +
>> +	tCAD = 0x7;
> Can you add a comment explaining why you're hardcoding the tCAD value
> (AFAIR, tCAD is specific to DDR NANDs, and the NAND layer does not
> support DDR NAND timings yet, maybe we should also add a FIXME or TODO
> tag).
>
>> +
>> +	/* TODO: A83 has some more bits for CDQSS, CS, CLHZ, CCS, WC */
>> +	chip->timing_cfg = NFC_TIMING_CFG(tWB, tADL, tWHR, tRHW, tCAD);
>>   
>>   	/* Convert min_clk_period from picoseconds to nanoseconds */
>>   	min_clk_period = DIV_ROUND_UP(min_clk_period, 1000);
>> @@ -884,8 +948,6 @@ static int sunxi_nand_chip_set_timings(struct sunxi_nand_chip *chip,
>>   	 */
>>   	chip->clk_rate = (2 * NSEC_PER_SEC) / min_clk_period;
>>   
>> -	/* TODO: configure T16-T19 */
>> -
>>   	return 0;
>>   }
>>   
>> @@ -1168,6 +1230,7 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
>>   
>>   	chip->nsels = nsels;
>>   	chip->selected = -1;
>> +	chip->timing_cfg = 0x7ff;
> Why do you need to initialize this field ?
>
>>   
>>   	for (i = 0; i < nsels; i++) {
>>   		ret = of_property_read_u32_index(np, "reg", i, &tmp);
>> @@ -1377,11 +1440,9 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
>>   	platform_set_drvdata(pdev, nfc);
>>   
>>   	/*
>> -	 * TODO: replace these magic values with proper flags as soon as we
>> -	 * know what they are encoding.
>> +	 * TODO: replace this magic value with EDO flag
>>   	 */
>>   	writel(0x100, nfc->regs + NFC_REG_TIMING_CTL);
>> -	writel(0x7ff, nfc->regs + NFC_REG_TIMING_CFG);
>>   
>>   	ret = sunxi_nand_chips_init(dev, nfc);
>>   	if (ret) {
>>


-- 


IMAGINE IT >> MAKE IT

Meet us online at Twitter <http://twitter.com/ultimaker>, Facebook 
<http://facebook.com/ultimaker>, Google+ <http://google.com/+Ultimaker>

www.ultimaker.com
