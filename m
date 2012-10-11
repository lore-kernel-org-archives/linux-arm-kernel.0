From: vipin.kumar@st.com (Vipin Kumar)
Date: Thu, 11 Oct 2012 09:55:31 +0530
Subject: [PATCH 04/11] fsmc/nand: Accept nand timing parameters via DT
In-Reply-To: <20121009115705.GN12801@game.jcrosoft.org>
References: <cover.1349778820.git.vipin.kumar@st.com>
 <54eda40e56e8ea02ed9c5332ca6d3fb90d617cc7.1349778821.git.vipin.kumar@st.com>
 <20121009115705.GN12801@game.jcrosoft.org>
Message-ID: <50764A3B.8070406@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/9/2012 5:27 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 16:14 Tue 09 Oct     , Vipin Kumar wrote:
>> Add support to accept nand timing parameters via device tree
>>
>> Signed-off-by: Vipin Kumar<vipin.kumar@st.com>
>> ---
>>   .../devicetree/bindings/mtd/fsmc-nand.txt          | 20 ++++++++
>>   drivers/mtd/nand/fsmc_nand.c                       | 59 ++++++++++++++--------
>>   include/linux/mtd/fsmc.h                           |  2 +-
>>   3 files changed, 59 insertions(+), 22 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/fsmc-nand.txt b/Documentation/devicetree/bindings/mtd/fsmc-nand.txt
>> index 29d1a2f..6a7fc43 100644
>> --- a/Documentation/devicetree/bindings/mtd/fsmc-nand.txt
>> +++ b/Documentation/devicetree/bindings/mtd/fsmc-nand.txt
>> @@ -13,6 +13,18 @@ Optional properties:
>>     defaults to 1 byte
>>   - nand-skip-bbtscan: Indicates the the BBT scanning should be skipped
>>
>> +- nand-timings-enabled: Indicates if the timing parameters are passed
>> +  via DT
>> +- nand-timings,tclr:
>> +- nand-timings,tar:
>> +- nand-timings,thiz:
>> +- nand-timings,thold:
>> +- nand-timings,twait:
>> +- nand-timings,tset: All these timing parameters come from the actual
>> +  nand device specification. Each of this represents a number of time
>> +  period of hclk ie a number 4 in thold with hclk = 166MHz means that
>> +  thold = (1000 / 166) * 4 ns = 24.09ns
>> +
>>   Example:
>>
>>   	fsmc: flash at d1800000 {
>> @@ -26,6 +38,14 @@ Example:
>>   		st,cle-off =<0x10000>;
>>   		maxbanks =<1>;
>>
>> +		nand-timings-enabled;
>> +		nand-timings,tclr =<1>;
>> +		nand-timings,tar =<1>;
>> +		nand-timings,thiz =<1>;
>> +		nand-timings,thold =<4>;
>> +		nand-timings,twait =<6>;
>> +		nand-timings,tset =<0>;
>> +
>>   		bank-width =<1>;
>>   		nand-skip-bbtscan;
>>
>> diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
>> index fc6a044..f3d69b3 100644
>> --- a/drivers/mtd/nand/fsmc_nand.c
>> +++ b/drivers/mtd/nand/fsmc_nand.c
>> @@ -415,27 +415,13 @@ static void fsmc_nand_setup(void __iomem *regs, uint32_t bank,
>>   {
>>   	uint32_t value = FSMC_DEVTYPE_NAND | FSMC_ENABLE | FSMC_WAITON;
>>   	uint32_t tclr, tar, thiz, thold, twait, tset;
>> -	struct fsmc_nand_timings *tims;
>> -	struct fsmc_nand_timings default_timings = {
>> -		.tclr	= FSMC_TCLR_1,
>> -		.tar	= FSMC_TAR_1,
>> -		.thiz	= FSMC_THIZ_1,
>> -		.thold	= FSMC_THOLD_4,
>> -		.twait	= FSMC_TWAIT_6,
>> -		.tset	= FSMC_TSET_0,
>> -	};
>> -
>> -	if (timings)
>> -		tims = timings;
>> -	else
>> -		tims =&default_timings;
>>
>> -	tclr = (tims->tclr&  FSMC_TCLR_MASK)<<  FSMC_TCLR_SHIFT;
>> -	tar = (tims->tar&  FSMC_TAR_MASK)<<  FSMC_TAR_SHIFT;
>> -	thiz = (tims->thiz&  FSMC_THIZ_MASK)<<  FSMC_THIZ_SHIFT;
>> -	thold = (tims->thold&  FSMC_THOLD_MASK)<<  FSMC_THOLD_SHIFT;
>> -	twait = (tims->twait&  FSMC_TWAIT_MASK)<<  FSMC_TWAIT_SHIFT;
>> -	tset = (tims->tset&  FSMC_TSET_MASK)<<  FSMC_TSET_SHIFT;
>> +	tclr = (timings->tclr&  FSMC_TCLR_MASK)<<  FSMC_TCLR_SHIFT;
>> +	tar = (timings->tar&  FSMC_TAR_MASK)<<  FSMC_TAR_SHIFT;
>> +	thiz = (timings->thiz&  FSMC_THIZ_MASK)<<  FSMC_THIZ_SHIFT;
>> +	thold = (timings->thold&  FSMC_THOLD_MASK)<<  FSMC_THOLD_SHIFT;
>> +	twait = (timings->twait&  FSMC_TWAIT_MASK)<<  FSMC_TWAIT_SHIFT;
>> +	tset = (timings->tset&  FSMC_TSET_MASK)<<  FSMC_TSET_SHIFT;
>>
>>   	if (busw)
>>   		writel(value | FSMC_DEVWID_16, FSMC_NAND_REG(regs, bank, PC));
>> @@ -876,6 +862,14 @@ static int __devinit fsmc_nand_probe_config_dt(struct platform_device *pdev,
>>   					       struct device_node *np)
>>   {
>>   	struct fsmc_nand_platform_data *pdata = dev_get_platdata(&pdev->dev);
>> +	struct fsmc_nand_timings default_timings = {
>> +		.tclr	= FSMC_TCLR_1,
>> +		.tar	= FSMC_TAR_1,
>> +		.thiz	= FSMC_THIZ_1,
>> +		.thold	= FSMC_THOLD_4,
>> +		.twait	= FSMC_TWAIT_6,
>> +		.tset	= FSMC_TSET_0,
>> +	};
>>   	u32 val;
>>
>>   	/* Set default NAND width to 8 bits */
>> @@ -894,6 +888,29 @@ static int __devinit fsmc_nand_probe_config_dt(struct platform_device *pdev,
>>   		pdata->options = NAND_SKIP_BBTSCAN;
>>   	of_property_read_u32(np, "maxbanks",&pdata->max_banks);
>>
>> +	if (of_property_read_bool(np, "nand-timings-enabled")) {
>> +		of_property_read_u32(np, "nand-timings,tclr",&val);
>> +		pdata->nand_timings.tclr = (uint8_t)val;
> use a mask will be better

OK, will add a mask in v2

>> +
>> +		of_property_read_u32(np, "nand-timings,tar",&val);
>> +		pdata->nand_timings.tar = (uint8_t)val;
>> +
>> +		of_property_read_u32(np, "nand-timings,thiz",&val);
>> +		pdata->nand_timings.thiz = (uint8_t)val;
>> +
>> +		of_property_read_u32(np, "nand-timings,thold",&val);
>> +		pdata->nand_timings.thold = (uint8_t)val;
>> +
>> +		of_property_read_u32(np, "nand-timings,twait",&val);
>> +		pdata->nand_timings.twait = (uint8_t)val;
>> +
>> +		of_property_read_u32(np, "nand-timings,tset",&val);
>> +		pdata->nand_timings.tset = (uint8_t)val;
>> +	} else {
>> +		memcpy(&pdata->nand_timings,&default_timings,
>> +				sizeof(default_timings));
>> +	}
>> +
>>   	return 0;
>>   }
>>   #else
>> @@ -1031,7 +1048,7 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
>>   	host->partitions = pdata->partitions;
>>   	host->nr_partitions = pdata->nr_partitions;
>>   	host->dev =&pdev->dev;
>> -	host->dev_timings = pdata->nand_timings;
>> +	host->dev_timings =&pdata->nand_timings;
>>   	host->mode = pdata->mode;
>>   	host->max_banks = pdata->max_banks;
>>
>> diff --git a/include/linux/mtd/fsmc.h b/include/linux/mtd/fsmc.h
>> index f0ab734..4fbdce4 100644
>> --- a/include/linux/mtd/fsmc.h
>> +++ b/include/linux/mtd/fsmc.h
>> @@ -148,7 +148,7 @@ enum access_mode {
>>    * this may be set to NULL
>>    */
>>   struct fsmc_nand_platform_data {
>> -	struct fsmc_nand_timings *nand_timings;
>> +	struct fsmc_nand_timings nand_timings;
>>   	struct mtd_partition	*partitions;
>>   	unsigned int		nr_partitions;
>>   	unsigned int		options;
>> --
>> 1.7.11.4
>>
> .
>
