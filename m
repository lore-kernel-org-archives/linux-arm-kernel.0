From: zgao6@marvell.com (Zhangfei Gao)
Date: Mon, 29 Nov 2010 17:35:00 -0800
Subject: PATCH 2/2] ARM: mmp2: add sd card to jasper
In-Reply-To: <0841A86E-129C-4ACE-B8C8-AB9EA2ECEA14@marvell.com>
References: <A8BF0628-3788-46BD-A8C1-069A25509DAB@marvell.com>
	<0841A86E-129C-4ACE-B8C8-AB9EA2ECEA14@marvell.com>
Message-ID: <ED64882F200EF5419CDAC2E6B5C4B3A2081D89A3B7@SC-VEXCH1.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



-----Original Message-----
From: Philip Rakity 
Sent: 2010?11?30? 9:25
To: Haojian Zhuang
Cc: linux-arm-kernel at lists.infradead.org; Mark Brown; Zhangfei Gao
Subject: Re: PATCH 2/2] ARM: mmp2: add sd card to jasper


On Nov 29, 2010, at 5:17 PM, Philip Rakity wrote:

>> -----Original Message-----
>> From: zhangfei gao [mailto:zhangfei.gao at gmail.com]
>> Sent: 2010?11?3? 5:07 PM
>> To: linux-arm-kernel at lists.infradead.org
>> Cc: Eric Miao; Haojian Zhuang; Chris Ball
>> Subject: [PATCH 2/2] ARM: mmp2: add sd card to jasper
>> 
>> From 43ad4ff49d6e94e32468776a278baabc463a613f Mon Sep 17 00:00:00 2001
>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>> Date: Wed, 3 Nov 2010 01:15:32 -0400
>> Subject: [PATCH 2/2] ARM: mmp2: add sd card to jasper
>> 
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>> ---
>> arch/arm/mach-mmp/jasper.c |   47
>> ++++++++++++++++++++++++++++++++++++++++++++
>> 1 files changed, 47 insertions(+), 0 deletions(-)
>> 
>> diff --git a/arch/arm/mach-mmp/jasper.c b/arch/arm/mach-mmp/jasper.c
>> index 2a684fa..757f251 100644
>> --- a/arch/arm/mach-mmp/jasper.c
>> +++ b/arch/arm/mach-mmp/jasper.c
>> @@ -67,6 +67,36 @@ static unsigned long jasper_pin_config[] __initdata = {
>> 
>> 	/* PMIC */
>> 	PMIC_PMIC_INT | MFP_LPM_EDGE_FALL,
>> +
>> +	/* MMC1 */
>> +	GPIO131_MMC1_DAT3,
>> +	GPIO132_MMC1_DAT2,
>> +	GPIO133_MMC1_DAT1,
>> +	GPIO134_MMC1_DAT0,
>> +	GPIO136_MMC1_CMD,
>> +	GPIO139_MMC1_CLK,
>> +	GPIO140_MMC1_CD,
>> +	GPIO141_MMC1_WP,
>> +
>> +	/* MMC2 */
>> +	GPIO37_MMC2_DAT3,
>> +	GPIO38_MMC2_DAT2,
>> +	GPIO39_MMC2_DAT1,
>> +	GPIO40_MMC2_DAT0,
>> +	GPIO41_MMC2_CMD,
>> +	GPIO42_MMC2_CLK,
>> +
>> +	/* MMC3 */
>> +	GPIO165_MMC3_DAT7,
>> +	GPIO162_MMC3_DAT6,
>> +	GPIO166_MMC3_DAT5,
>> +	GPIO163_MMC3_DAT4,
>> +	GPIO167_MMC3_DAT3,
>> +	GPIO164_MMC3_DAT2,
>> +	GPIO168_MMC3_DAT1,
>> +	GPIO111_MMC3_DAT0,
>> +	GPIO112_MMC3_CMD,
>> +	GPIO151_MMC3_CLK,
>> };
>> 
>> static struct regulator_consumer_supply max8649_supply[] = {
>> @@ -123,6 +153,19 @@ static struct i2c_board_info jasper_twsi1_info[] = {
>> 	},
>> };
>> 
>> +#if defined(CONFIG_MMC_SDHCI_PXA)
>> +
>> +static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc0 = {
>> +	.max_speed	= 25000000,
>> +};
>> +

There is no need to reduce the speed of the SD interface.  The SD/MMC/eMMC card has 
speed information in the card specific data area and the controller knows the max clock
from the capabilities register of the SD Host Controller.    Speeds up to 52MHz work on mmp2.

Thanks, however, since some card need time tuning, otherwise crc error will happen.
The time tuning patch still not be merged, so we only can wait.

>> +static void __init mmp2_init_mmc(void)
>> +{
>> +	mmp2_add_sdh(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
>> +}
>> +
>> +#endif
>> +
>> static void __init jasper_init(void)
>> {
>> 	mfp_config(ARRAY_AND_SIZE(jasper_pin_config));
>> @@ -132,6 +175,10 @@ static void __init jasper_init(void)
>> 	mmp2_add_uart(3);
>> 	mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(jasper_twsi1_info));
>> 
>> +#if defined(CONFIG_MMC_SDHCI_PXA)
>> +	mmp2_init_mmc();
>> +#endif
>> +
>> 	regulator_has_full_constraints();
>> }
>> 
>> --
>> 1.7.0.4
