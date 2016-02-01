From: wdc@rock-chips.com (David.Wu)
Date: Mon, 1 Feb 2016 16:54:38 +0800
Subject: [PATCH] PM / AVS: rockchip-io: add GRF and PMUGRF types to
 distinguish
In-Reply-To: <5387650.lAgTxexlF2@phil>
References: <1454155305-55516-1-git-send-email-david.wu@rock-chips.com>
 <5387650.lAgTxexlF2@phil>
Message-ID: <56AF1D4E.40307@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

? 2016/1/30 20:39, Heiko Stuebner ??:
> Hi David,
>
> Am Samstag, 30. Januar 2016, 20:01:45 schrieb David Wu:
>> As rk3368 contained two separated iodomain areas, this was
>> determined to use which regmap base address.
>>
>> Signed-off-by: David Wu <david.wu@rock-chips.com>
> I don't think we need to specify this on a driver level. Both GRF areas are
> "General register files" only located in two separate power-domains.
> So the rockchip,grf property should work for both. Especially as nothing
> keeps designers from introducing yet another GRF-area somewhere else ;-)
>
> >From when I started working on the rk3368, I still have a preliminary
> patches for that sitting here, so I've attached on how I envisoned that to
> work.

Okay, i agree to you, but it make someone a little confused just from 
the drive code,
not DT file,  about  pmugrf regmap base address.:-)

How do you feel about intergating GRF and PMU drivers in one driver?
Thanks!

>
> Heiko
>
>> ---
>>   drivers/power/avs/rockchip-io-domain.c | 32
>> ++++++++++++++++++++++++-------- 1 file changed, 24 insertions(+), 8
>> deletions(-)
>>
>> diff --git a/drivers/power/avs/rockchip-io-domain.c
>> b/drivers/power/avs/rockchip-io-domain.c index 8099456..b17aeb7 100644
>> --- a/drivers/power/avs/rockchip-io-domain.c
>> +++ b/drivers/power/avs/rockchip-io-domain.c
>> @@ -47,6 +47,11 @@
>>   #define RK3368_SOC_CON15_FLASH0		BIT(14)
>>   #define RK3368_SOC_FLASH_SUPPLY_NUM	2
>>
>> +enum rockchip_iodomain_grf_type {
>> +	GRF,
>> +	PMUGRF
>> +};
>> +
>>   struct rockchip_iodomain;
>>
>>   /**
>> @@ -54,6 +59,7 @@ struct rockchip_iodomain;
>>    */
>>   struct rockchip_iodomain_soc_data {
>>   	int grf_offset;
>> +	enum rockchip_iodomain_grf_type type;
>>   	const char *supply_names[MAX_SUPPLIES];
>>   	void (*init)(struct rockchip_iodomain *iod);
>>   };
>> @@ -67,7 +73,7 @@ struct rockchip_iodomain_supply {
>>
>>   struct rockchip_iodomain {
>>   	struct device *dev;
>> -	struct regmap *grf;
>> +	struct regmap *base;
>>   	struct rockchip_iodomain_soc_data *soc_data;
>>   	struct rockchip_iodomain_supply supplies[MAX_SUPPLIES];
>>   };
>> @@ -86,7 +92,7 @@ static int rockchip_iodomain_write(struct
>> rockchip_iodomain_supply *supply, /* apply hiword-mask */
>>   	val |= (BIT(supply->idx) << 16);
>>
>> -	ret = regmap_write(iod->grf, iod->soc_data->grf_offset, val);
>> +	ret = regmap_write(iod->base, iod->soc_data->grf_offset, val);
>>   	if (ret)
>>   		dev_err(iod->dev, "Couldn't write to GRF\n");
>>
>> @@ -157,7 +163,7 @@ static void rk3288_iodomain_init(struct
>> rockchip_iodomain *iod) * instead of a special gpio.
>>   	 */
>>   	val = RK3288_SOC_CON2_FLASH0 | (RK3288_SOC_CON2_FLASH0 << 16);
>> -	ret = regmap_write(iod->grf, RK3288_SOC_CON2, val);
>> +	ret = regmap_write(iod->base, RK3288_SOC_CON2, val);
>>   	if (ret < 0)
>>   		dev_warn(iod->dev, "couldn't update flash0 ctrl\n");
>>   }
>> @@ -176,7 +182,7 @@ static void rk3368_iodomain_init(struct
>> rockchip_iodomain *iod) * instead of a special gpio.
>>   	 */
>>   	val = RK3368_SOC_CON15_FLASH0 | (RK3368_SOC_CON15_FLASH0 << 16);
>> -	ret = regmap_write(iod->grf, RK3368_SOC_CON15, val);
>> +	ret = regmap_write(iod->base, RK3368_SOC_CON15, val);
>>   	if (ret < 0)
>>   		dev_warn(iod->dev, "couldn't update flash0 ctrl\n");
>>   }
>> @@ -187,6 +193,7 @@ static void rk3368_iodomain_init(struct
>> rockchip_iodomain *iod) */
>>   static const struct rockchip_iodomain_soc_data soc_data_rk3188 = {
>>   	.grf_offset = 0x104,
>> +	.type = GRF,
>>   	.supply_names = {
>>   		NULL,
>>   		NULL,
>> @@ -209,6 +216,7 @@ static const struct rockchip_iodomain_soc_data
>> soc_data_rk3188 = {
>>
>>   static const struct rockchip_iodomain_soc_data soc_data_rk3288 = {
>>   	.grf_offset = 0x380,
>> +	.type = GRF,
>>   	.supply_names = {
>>   		"lcdc",		/* LCDC_VDD */
>>   		"dvp",		/* DVPIO_VDD */
>> @@ -226,6 +234,7 @@ static const struct rockchip_iodomain_soc_data
>> soc_data_rk3288 = {
>>
>>   static const struct rockchip_iodomain_soc_data soc_data_rk3368 = {
>>   	.grf_offset = 0x900,
>> +	.type = GRF,
>>   	.supply_names = {
>>   		NULL,		/* reserved */
>>   		"dvp",		/* DVPIO_VDD */
>> @@ -242,6 +251,7 @@ static const struct rockchip_iodomain_soc_data
>> soc_data_rk3368 = {
>>
>>   static const struct rockchip_iodomain_soc_data soc_data_rk3368_pmu = {
>>   	.grf_offset = 0x100,
>> +	.type = PMUGRF,
>>   	.supply_names = {
>>   		NULL,
>>   		NULL,
>> @@ -293,10 +303,16 @@ static int rockchip_iodomain_probe(struct
>> platform_device *pdev) match = of_match_node(rockchip_iodomain_match,
>> np);
>>   	iod->soc_data = (struct rockchip_iodomain_soc_data *)match->data;
>>
>> -	iod->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
>> -	if (IS_ERR(iod->grf)) {
>> -		dev_err(&pdev->dev, "couldn't find grf regmap\n");
>> -		return PTR_ERR(iod->grf);
>> +	if (iod->soc_data->type == PMUGRF)
>> +		iod->base = syscon_regmap_lookup_by_phandle(
>> +				np, "rockchip,pmugrf");
>> +	else
>> +		iod->base = syscon_regmap_lookup_by_phandle(
>> +				np, "rockchip,grf");
>> +	if (IS_ERR(iod->base)) {
>> +		dev_err(&pdev->dev, "couldn't find %s regmap\n",
>> +			(iod->soc_data->type == PMUGRF) ? "pmugrf" : "grf");
>> +		return PTR_ERR(iod->base);
>>   	}
>>
>>   	for (i = 0; i < MAX_SUPPLIES; i++) {

-------------- next part --------------
>From 73cc56277c42fd13bed3921b07c84ac4b030321a Mon Sep 17 00:00:00 2001
From: David Wu <wdc@rock-chips.com>
Date: Wed, 24 Dec 2014 16:31:09 +0800
Subject: [PATCH 1/5] rk3368: io-domain: add io domain volt sel
Content-Type: text/plain; charset="utf-8"

Signed-off-by: David Wu <wdc@rock-chips.com>
---
 drivers/power/avs/rockchip-io-domain.c | 184 +++++++++++++++++++++++----------
 1 file changed, 130 insertions(+), 54 deletions(-)

diff --git a/drivers/power/avs/rockchip-io-domain.c b/drivers/power/avs/rockchip-io-domain.c
index b160132..d096457 100755
--- a/drivers/power/avs/rockchip-io-domain.c
+++ b/drivers/power/avs/rockchip-io-domain.c
@@ -43,19 +43,28 @@
 #define RK3288_SOC_CON2_FLASH0		BIT(7)
 #define RK3288_SOC_FLASH_SUPPLY_NUM	2
 
-#define RK3368_GRF_SOC_CON15			0x43c
-#define RK3368_GRF_SOC_CON15_FLASH0		BIT(14)
+#define RK3368_GRF_SOC_CON15		0x43c
+#define RK3368_GRF_SOC_CON15_FLASH0	BIT(14)
 #define RK3368_SOC_FLASH_SUPPLY_NUM	2
 
+#define MAX_ROCKCHIP_GRF_NUM        2
 
 struct rockchip_iodomain;
 
 /**
  * @supplies: voltage settings matching the register bits.
  */
+
+enum rockchip_iodomain_grf_type {
+	GRF,
+	PMU_GRF,
+};
+
 struct rockchip_iodomain_soc_data {
 	int grf_offset;
-	const char *supply_names[MAX_SUPPLIES];
+	int pmugrf_offset;
+	const char *grf_supply_names[MAX_SUPPLIES];
+	const char *pmugrf_supply_names[MAX_SUPPLIES];
 	void (*init)(struct rockchip_iodomain *iod);
 };
 
@@ -64,19 +73,24 @@ struct rockchip_iodomain_supply {
 	struct regulator *reg;
 	struct notifier_block nb;
 	int idx;
+	enum rockchip_iodomain_grf_type type;
 };
 
 struct rockchip_iodomain {
 	struct device *dev;
 	struct regmap *grf;
+	struct regmap *pmu;
 	struct rockchip_iodomain_soc_data *soc_data;
-	struct rockchip_iodomain_supply supplies[MAX_SUPPLIES];
+	struct rockchip_iodomain_supply grf_supplies[MAX_SUPPLIES];
+	struct rockchip_iodomain_supply pmugrf_supplies[MAX_SUPPLIES];
 };
 
 static int rockchip_iodomain_write(struct rockchip_iodomain_supply *supply,
 				   int uV)
 {
 	struct rockchip_iodomain *iod = supply->iod;
+	struct regmap *reg;
+	int offset;
 	u32 val;
 	int ret;
 
@@ -87,7 +101,15 @@ static int rockchip_iodomain_write(struct rockchip_iodomain_supply *supply,
 	/* apply hiword-mask */
 	val |= (BIT(supply->idx) << 16);
 
-	ret = regmap_write(iod->grf, iod->soc_data->grf_offset, val);
+	if (supply->type == GRF) {
+		reg = iod->grf;
+		offset = iod->soc_data->grf_offset;
+	} else if (supply->type == PMU_GRF) {
+		reg = iod->pmu;
+		offset = iod->soc_data->pmugrf_offset;
+	}
+
+	ret = regmap_write(reg, offset, val);
 	if (ret)
 		dev_err(iod->dev, "Couldn't write to GRF\n");
 
@@ -150,7 +172,7 @@ static void rk3288_iodomain_init(struct rockchip_iodomain *iod)
 	u32 val;
 
 	/* if no flash supply we should leave things alone */
-	if (!iod->supplies[RK3288_SOC_FLASH_SUPPLY_NUM].reg)
+	if (!iod->grf_supplies[RK3288_SOC_FLASH_SUPPLY_NUM].reg)
 		return;
 
 	/*
@@ -169,7 +191,7 @@ static void rk3368_iodomain_init(struct rockchip_iodomain *iod)
 	u32 val;
 
 	/* if no flash supply we should leave things alone */
-	if (!iod->supplies[RK3368_SOC_FLASH_SUPPLY_NUM].reg)
+	if (!iod->grf_supplies[RK3368_SOC_FLASH_SUPPLY_NUM].reg)
 		return;
 
 	/*
@@ -189,7 +211,7 @@ static void rk3368_iodomain_init(struct rockchip_iodomain *iod)
  */
 static const struct rockchip_iodomain_soc_data soc_data_rk3188 = {
 	.grf_offset = 0x104,
-	.supply_names = {
+	.grf_supply_names = {
 		NULL,
 		NULL,
 		NULL,
@@ -211,7 +233,7 @@ static const struct rockchip_iodomain_soc_data soc_data_rk3188 = {
 
 static const struct rockchip_iodomain_soc_data soc_data_rk3288 = {
 	.grf_offset = 0x380,
-	.supply_names = {
+	.grf_supply_names = {
 		"lcdc",		/* LCDC_VDD */
 		"dvp",		/* DVPIO_VDD */
 		"flash0",	/* FLASH0_VDD (emmc) */
@@ -228,16 +250,25 @@ static const struct rockchip_iodomain_soc_data soc_data_rk3288 = {
 
 static const struct rockchip_iodomain_soc_data soc_data_rk3368 = {
 	.grf_offset = 0x900,
-	.supply_names = {
+	.pmugrf_offset = 0x100,
+	.grf_supply_names = {
+		NULL,
+		"dvp",		/*DVP IO domain*/
+		"flash0",	/*FLASH0 IO domain*/
+		"wifi",         /*APIO2 IO domain*/
+		NULL,
+		"audio",	/*APIO3 IO domain*/
+		"sdcard",	/*SDCARD IO domain*/
+		"gpio30",	/*APIO1 IO domain*/
+		"gpio1830",	/*ADIO4 IO domain*/
+	},
+	.pmugrf_supply_names = {
+		NULL,
+		NULL,
 		NULL,
-		"dvp_v18sel",		/*DVP IO domain*/
-		"flash0_v18sel",		/*FLASH0 IO domain*/
-		"wifi_v18sel",	/*WIFI IO domain*/
 		NULL,
-		"audio_v18sel",	/*AUDIO IO domain*/
-		"sdcard_v18sel",		/*SDCARD IO domain*/
-		"gpio30_v18sel",		/*GPIO30 IO domain*/
-		"gpio1830_v18sel",	/*GPIO1830 IO domain*/
+		"pmu",	        /*PMU IO domain*/
+		"vop",	        /*LCDC IO domain*/
 	},
 	.init = rk3368_iodomain_init,
 };
@@ -259,47 +290,34 @@ static const struct of_device_id rockchip_iodomain_match[] = {
 	{ /* sentinel */ },
 };
 
-static int rockchip_iodomain_probe(struct platform_device *pdev)
+static int rockchip_iodomain_parse_supply(struct rockchip_iodomain *iod,
+					  struct device_node *np,
+					  enum rockchip_iodomain_grf_type type)
 {
-	struct device_node *np = pdev->dev.of_node;
-	const struct of_device_id *match;
-	struct rockchip_iodomain *iod;
+	struct rockchip_iodomain_supply *group_supply;
+	const char **group_supply_names;
 	int i, ret = 0;
 
-	if (!np)
-		return -ENODEV;
-
-	iod = devm_kzalloc(&pdev->dev, sizeof(*iod), GFP_KERNEL);
-	if (!iod)
-		return -ENOMEM;
-
-	iod->dev = &pdev->dev;
-	platform_set_drvdata(pdev, iod);
-
-	match = of_match_node(rockchip_iodomain_match, np);
-	iod->soc_data = (struct rockchip_iodomain_soc_data *)match->data;
-
-	iod->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
-	if (IS_ERR(iod->grf)) {
-		dev_err(&pdev->dev, "couldn't find grf regmap\n");
-		return PTR_ERR(iod->grf);
+	if (type == GRF) {
+		group_supply_names =
+			(const char **)iod->soc_data->grf_supply_names;
+		group_supply = iod->grf_supplies;
+	} else if (type == PMU_GRF) {
+		group_supply_names =
+			(const char **)iod->soc_data->pmugrf_supply_names;
+		group_supply = iod->pmugrf_supplies;
 	}
 
 	for (i = 0; i < MAX_SUPPLIES; i++) {
-		const char *supply_name = iod->soc_data->supply_names[i];
-		struct rockchip_iodomain_supply *supply = &iod->supplies[i];
+		const char *supply_name = group_supply_names[i];
+		struct rockchip_iodomain_supply *supply = &group_supply[i];
 		struct regulator *reg;
 		int uV;
-		const char *regulator_name = NULL;
 
 		if (!supply_name)
 			continue;
 
-		of_property_read_string(np, supply_name, &regulator_name);
-		if (!regulator_name)
-			continue;
-
-		reg = regulator_get(NULL, regulator_name);
+		reg = devm_regulator_get_optional(iod->dev, supply_name);
 		if (IS_ERR(reg)) {
 			ret = PTR_ERR(reg);
 
@@ -334,6 +352,7 @@ static int rockchip_iodomain_probe(struct platform_device *pdev)
 		supply->idx = i;
 		supply->iod = iod;
 		supply->reg = reg;
+		supply->type = type;
 		supply->nb.notifier_call = rockchip_iodomain_notify;
 
 		ret = rockchip_iodomain_write(supply, uV);
@@ -345,21 +364,16 @@ static int rockchip_iodomain_probe(struct platform_device *pdev)
 		/* register regulator notifier */
 		ret = regulator_register_notifier(reg, &supply->nb);
 		if (ret) {
-			dev_err(&pdev->dev,
+			dev_err(iod->dev,
 				"regulator notifier request failed\n");
 			supply->reg = NULL;
 			goto unreg_notify;
 		}
 	}
 
-	if (iod->soc_data->init)
-		iod->soc_data->init(iod);
-
-	return 0;
-
 unreg_notify:
 	for (i = MAX_SUPPLIES - 1; i >= 0; i--) {
-		struct rockchip_iodomain_supply *io_supply = &iod->supplies[i];
+		struct rockchip_iodomain_supply *io_supply = &group_supply[i];
 
 		if (io_supply->reg)
 			regulator_unregister_notifier(io_supply->reg,
@@ -369,13 +383,75 @@ unreg_notify:
 	return ret;
 }
 
+static int rockchip_iodomain_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node, *node;
+	const struct of_device_id *match;
+	struct rockchip_iodomain *iod;
+	int ret = 0;
+
+	if (!np)
+		return -ENODEV;
+
+	iod = devm_kzalloc(&pdev->dev, sizeof(*iod), GFP_KERNEL);
+	if (!iod)
+		return -ENOMEM;
+
+	iod->dev = &pdev->dev;
+	platform_set_drvdata(pdev, iod);
+
+	match = of_match_node(rockchip_iodomain_match, np);
+	iod->soc_data = (struct rockchip_iodomain_soc_data *)match->data;
+
+	iod->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
+	if (IS_ERR(iod->grf)) {
+		dev_err(&pdev->dev, "couldn't find grf regmap\n");
+		return PTR_ERR(iod->grf);
+	}
+	ret = rockchip_iodomain_parse_supply(iod, np, GRF);
+	if (ret) {
+		dev_err(iod->dev,
+			"rockchip iodomain parse grf supply failed\n");
+		return ret;
+	}
+
+	/* try to find the optional reference to the pmu syscon */
+	node = of_parse_phandle(np, "rockchip,pmu", 0);
+	if (node) {
+		iod->pmu = syscon_node_to_regmap(node);
+		if (IS_ERR(iod->pmu))
+			return PTR_ERR(iod->pmu);
+		ret = rockchip_iodomain_parse_supply(iod, np, PMU_GRF);
+		if (ret) {
+			dev_err(iod->dev,
+				"rockchip iodomain parse pmu_grf supply failed\n");
+			return ret;
+		}
+	}
+
+	if (iod->soc_data->init)
+		iod->soc_data->init(iod);
+
+	return ret;
+}
+
 static int rockchip_iodomain_remove(struct platform_device *pdev)
 {
 	struct rockchip_iodomain *iod = platform_get_drvdata(pdev);
 	int i;
 
 	for (i = MAX_SUPPLIES - 1; i >= 0; i--) {
-		struct rockchip_iodomain_supply *io_supply = &iod->supplies[i];
+		struct rockchip_iodomain_supply *io_supply
+			= &iod->grf_supplies[i];
+
+		if (io_supply->reg)
+			regulator_unregister_notifier(io_supply->reg,
+						      &io_supply->nb);
+	}
+
+	for (i = MAX_SUPPLIES - 1; i >= 0; i--) {
+		struct rockchip_iodomain_supply *io_supply =
+			&iod->pmugrf_supplies[i];
 
 		if (io_supply->reg)
 			regulator_unregister_notifier(io_supply->reg,
-- 
1.9.1
