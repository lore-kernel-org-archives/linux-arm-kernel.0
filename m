From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 9 Nov 2010 11:30:43 +0800
Subject: [PATCH 2/2] ARM: mmp2: add sd card to jasper
In-Reply-To: <25B60CDC2F704E4E9D88FFD52780CB4C0598642CE8@SC-VEXCH1.marvell.com>
References: <AANLkTik8D8E+BkqWbvgTvaJyKHb0d1=cTJf2wfOmfBVx@mail.gmail.com>
	<25B60CDC2F704E4E9D88FFD52780CB4C0598642CE8@SC-VEXCH1.marvell.com>
Message-ID: <AANLkTimN0idvSC5DhLgys_q-qAbcJJNQh5VpwAD0tTe7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/8 Haojian Zhuang <hzhuang1@marvell.com>:
> Acked
>

I've removed those un-necessary #if .., and moved the mmp2_add_sdh
to jasper_init, and changed to mmp2_add_sdhost, add_sdh doesn't
read very well.

And applied. Please have a check in my devel branch.

>>-----Original Message-----
>>From: zhangfei gao [mailto:zhangfei.gao at gmail.com]
>>Sent: 2010?11?3? 5:07 PM
>>To: linux-arm-kernel at lists.infradead.org
>>Cc: Eric Miao; Haojian Zhuang; Chris Ball
>>Subject: [PATCH 2/2] ARM: mmp2: add sd card to jasper
>>
> >From 43ad4ff49d6e94e32468776a278baabc463a613f Mon Sep 17 00:00:00 2001
>>From: Zhangfei Gao <zhangfei.gao@marvell.com>
>>Date: Wed, 3 Nov 2010 01:15:32 -0400
>>Subject: [PATCH 2/2] ARM: mmp2: add sd card to jasper
>>
>>Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>>---
>> arch/arm/mach-mmp/jasper.c | ? 47
>>++++++++++++++++++++++++++++++++++++++++++++
>> 1 files changed, 47 insertions(+), 0 deletions(-)
>>
>>diff --git a/arch/arm/mach-mmp/jasper.c b/arch/arm/mach-mmp/jasper.c
>>index 2a684fa..757f251 100644
>>--- a/arch/arm/mach-mmp/jasper.c
>>+++ b/arch/arm/mach-mmp/jasper.c
>>@@ -67,6 +67,36 @@ static unsigned long jasper_pin_config[] __initdata = {
>>
>> ? ? ? /* PMIC */
>> ? ? ? PMIC_PMIC_INT | MFP_LPM_EDGE_FALL,
>>+
>>+ ? ? ?/* MMC1 */
>>+ ? ? ?GPIO131_MMC1_DAT3,
>>+ ? ? ?GPIO132_MMC1_DAT2,
>>+ ? ? ?GPIO133_MMC1_DAT1,
>>+ ? ? ?GPIO134_MMC1_DAT0,
>>+ ? ? ?GPIO136_MMC1_CMD,
>>+ ? ? ?GPIO139_MMC1_CLK,
>>+ ? ? ?GPIO140_MMC1_CD,
>>+ ? ? ?GPIO141_MMC1_WP,
>>+
>>+ ? ? ?/* MMC2 */
>>+ ? ? ?GPIO37_MMC2_DAT3,
>>+ ? ? ?GPIO38_MMC2_DAT2,
>>+ ? ? ?GPIO39_MMC2_DAT1,
>>+ ? ? ?GPIO40_MMC2_DAT0,
>>+ ? ? ?GPIO41_MMC2_CMD,
>>+ ? ? ?GPIO42_MMC2_CLK,
>>+
>>+ ? ? ?/* MMC3 */
>>+ ? ? ?GPIO165_MMC3_DAT7,
>>+ ? ? ?GPIO162_MMC3_DAT6,
>>+ ? ? ?GPIO166_MMC3_DAT5,
>>+ ? ? ?GPIO163_MMC3_DAT4,
>>+ ? ? ?GPIO167_MMC3_DAT3,
>>+ ? ? ?GPIO164_MMC3_DAT2,
>>+ ? ? ?GPIO168_MMC3_DAT1,
>>+ ? ? ?GPIO111_MMC3_DAT0,
>>+ ? ? ?GPIO112_MMC3_CMD,
>>+ ? ? ?GPIO151_MMC3_CLK,
>> };
>>
>> static struct regulator_consumer_supply max8649_supply[] = {
>>@@ -123,6 +153,19 @@ static struct i2c_board_info jasper_twsi1_info[] = {
>> ? ? ? },
>> };
>>
>>+#if defined(CONFIG_MMC_SDHCI_PXA)
>>+
>>+static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc0 = {
>>+ ? ? ?.max_speed ? ? ?= 25000000,
>>+};
>>+
>>+static void __init mmp2_init_mmc(void)
>>+{
>>+ ? ? ?mmp2_add_sdh(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
>>+}
>>+
>>+#endif
>>+
>> static void __init jasper_init(void)
>> {
>> ? ? ? mfp_config(ARRAY_AND_SIZE(jasper_pin_config));
>>@@ -132,6 +175,10 @@ static void __init jasper_init(void)
>> ? ? ? mmp2_add_uart(3);
>> ? ? ? mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(jasper_twsi1_info));
>>
>>+#if defined(CONFIG_MMC_SDHCI_PXA)
>>+ ? ? ?mmp2_init_mmc();
>>+#endif
>>+
>> ? ? ? regulator_has_full_constraints();
>> }
>>
>>--
>>1.7.0.4
>
