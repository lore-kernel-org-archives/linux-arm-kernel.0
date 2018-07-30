From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Mon, 30 Jul 2018 09:50:55 +0200
Subject: [PATCH v8 5/6] regulator: pfuze100-regulator: provide
 pm_power_off_prepare handler
In-Reply-To: <DB6PR04MB32233832762D02F1023861A1892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-6-o.rempel@pengutronix.de>
 <DB6PR04MB32233832762D02F1023861A1892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
Message-ID: <06313062-70db-9c10-048e-78ca267da959@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 27.07.2018 11:32, Robin Gong wrote:
> 
> 
>> -----Original Message-----
>> From: Oleksij Rempel [mailto:o.rempel at pengutronix.de]
>> Sent: 2018?7?26? 17:22
>> To: Shawn Guo <shawnguo@kernel.org>; Mark Brown <broonie@kernel.org>;
>> Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; kernel at pengutronix.de;
>> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>> linux-clk at vger.kernel.org; linux-kernel at vger.kernel.org; Andrew Morton
>> <akpm@linux-foundation.org>; Liam Girdwood <lgirdwood@gmail.com>;
>> Leonard Crestez <leonard.crestez@nxp.com>; Rob Herring
>> <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Michael
>> Turquette <mturquette@baylibre.com>; Stephen Boyd
>> <sboyd@codeaurora.org>; Fabio Estevam <fabio.estevam@nxp.com>; Russell
>> King <linux@armlinux.org.uk>; dl-linux-imx <linux-imx@nxp.com>; Robin Gong
>> <yibin.gong@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>
>> Subject: [PATCH v8 5/6] regulator: pfuze100-regulator: provide
>> pm_power_off_prepare handler
>>
>> On some boards the SoC can use one pin "PMIC_STBY_REQ" to notify th PMIC
>> about state changes. In this case internal state of PMIC must be preconfigured
>> for upcomming state change.
>> It works fine with the current regulator framework, except with the power-off
>> case.
>>
>> This patch is providing an optional pm_power_off_prepare handler which will
>> configure standby state of the PMIC to disable all power lines.
>>
>> In my power consumption test on RIoTBoard, I got the following results:
>> power off without this patch:	320 mA
>> power off with this patch:	2   mA
>> suspend to ram:			40  mA
>>
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> ---
>>  drivers/regulator/pfuze100-regulator.c | 92 ++++++++++++++++++++++++++
>>  1 file changed, 92 insertions(+)
>>
>> diff --git a/drivers/regulator/pfuze100-regulator.c
>> b/drivers/regulator/pfuze100-regulator.c
>> index 8d9dbcc775ea..e386e9acb3f7 100644
>> --- a/drivers/regulator/pfuze100-regulator.c
>> +++ b/drivers/regulator/pfuze100-regulator.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/regulator/pfuze100.h>
>>  #include <linux/i2c.h>
>>  #include <linux/slab.h>
>> +#include <linux/kallsyms.h>
> Is it necessary?

yes, for pm_power_off_prepare

>>  #include <linux/regmap.h>
>>
>>  #define PFUZE_NUMREGS		128
>> @@ -29,11 +30,17 @@
>>
>>  #define PFUZE100_COINVOL	0x1a
>>  #define PFUZE100_SW1ABVOL	0x20
>> +#define PFUZE100_SW1ABMODE	0x23
>>  #define PFUZE100_SW1CVOL	0x2e
>> +#define PFUZE100_SW1CMODE	0x31
>>  #define PFUZE100_SW2VOL		0x35
>> +#define PFUZE100_SW2MODE	0x38
>>  #define PFUZE100_SW3AVOL	0x3c
>> +#define PFUZE100_SW3AMODE	0x3f
>>  #define PFUZE100_SW3BVOL	0x43
>> +#define PFUZE100_SW3BMODE	0x46
>>  #define PFUZE100_SW4VOL		0x4a
>> +#define PFUZE100_SW4MODE	0x4d
>>  #define PFUZE100_SWBSTCON1	0x66
>>  #define PFUZE100_VREFDDRCON	0x6a
>>  #define PFUZE100_VSNVSVOL	0x6b
>> @@ -44,6 +51,13 @@
>>  #define PFUZE100_VGEN5VOL	0x70
>>  #define PFUZE100_VGEN6VOL	0x71
>>
>> +#define PFUZE100_SWxMODE_MASK	0xf
>> +#define PFUZE100_SWxMODE_APS_APS	0x8
>> +#define PFUZE100_SWxMODE_APS_OFF	0x4
>> +
>> +#define PFUZE100_VGENxLPWR	BIT(6)
>> +#define PFUZE100_VGENxSTBY	BIT(5)
>> +
>>  enum chips { PFUZE100, PFUZE200, PFUZE3000 = 3 };
>>
>>  struct pfuze_regulator {
>> @@ -492,6 +506,69 @@ static inline struct device_node *match_of_node(int
>> index)  }  #endif
>>
>> +static struct pfuze_chip *syspm_pfuze_chip;
>> +
>> +static void pfuze_power_off_prepare(void) 
>> +	dev_info(syspm_pfuze_chip->dev, "Configure standy mode for power
>> +off");
> Add 'if (syspm_pfuze_chip ->chip_id == PFUZE100))' here is easy for extend 
> Support on pfuze200/3000.. in the feature.

ok.

>> +
>> +	/* Switch from default mode: APS/APS to APS/Off */
>> +	regmap_update_bits(syspm_pfuze_chip->regmap,
>> PFUZE100_SW1ABMODE,
>> +			   PFUZE100_SWxMODE_MASK,
>> PFUZE100_SWxMODE_APS_OFF);
>> +	regmap_update_bits(syspm_pfuze_chip->regmap,
>> PFUZE100_SW1CMODE,
>> +			   PFUZE100_SWxMODE_MASK,
>> PFUZE100_SWxMODE_APS_OFF);
>> +	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_SW2MODE,
>> +			   PFUZE100_SWxMODE_MASK,
>> PFUZE100_SWxMODE_APS_OFF);
>> +	regmap_update_bits(syspm_pfuze_chip->regmap,
>> PFUZE100_SW3AMODE,
>> +			   PFUZE100_SWxMODE_MASK,
>> PFUZE100_SWxMODE_APS_OFF);
>> +	regmap_update_bits(syspm_pfuze_chip->regmap,
>> PFUZE100_SW3BMODE,
>> +			   PFUZE100_SWxMODE_MASK,
>> PFUZE100_SWxMODE_APS_OFF);
>> +	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_SW4MODE,
>> +			   PFUZE100_SWxMODE_MASK,
>> PFUZE100_SWxMODE_APS_OFF);
>> +
>> +	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN1VOL,
>> +			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
>> +			   PFUZE100_VGENxSTBY);
>> +	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN2VOL,
>> +			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
>> +			   PFUZE100_VGENxSTBY);
>> +	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN3VOL,
>> +			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
>> +			   PFUZE100_VGENxSTBY);
>> +	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN4VOL,
>> +			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
>> +			   PFUZE100_VGENxSTBY);
>> +	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN5VOL,
>> +			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
>> +			   PFUZE100_VGENxSTBY);
>> +	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN6VOL,
>> +			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
>> +			   PFUZE100_VGENxSTBY);
>> +}
>> +
>> +static int pfuze_power_off_prepare_init(struct pfuze_chip *pfuze_chip)
>> +{
>> +	if (pfuze_chip->chip_id != PFUZE100) {
>> +		dev_warn(pfuze_chip->dev, "Requested pm_power_off_prepare
>> handler for not supported chip\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (pm_power_off_prepare) {
>> +		dev_warn(pfuze_chip->dev, "pm_power_off_prepare is already
>> registered.\n");
>> +		return -EBUSY;
>> +	}
>> +
>> +	if (syspm_pfuze_chip) {
>> +		dev_warn(pfuze_chip->dev, "syspm_pfuze_chip is already set.\n");
>> +		return -EBUSY;
>> +	}
>> +
>> +	syspm_pfuze_chip = pfuze_chip;
>> +	pm_power_off_prepare = pfuze_power_off_prepare;
>> +
>> +	return 0;
>> +}
>> +
>>  static int pfuze_identify(struct pfuze_chip *pfuze_chip)  {
>>  	unsigned int value;
>> @@ -661,6 +738,20 @@ static int pfuze100_regulator_probe(struct i2c_client
>> *client,
>>  		}
>>  	}
>>
>> +	if (of_property_read_bool(client->dev.of_node,
>> +				  "fsl,pmic-stby-poweroff"))
>> +		return pfuze_power_off_prepare_init(pfuze_chip);
>> +
>> +	return 0;
>> +}
>> +
>> +static int pfuze100_regulator_remove(struct i2c_client *client) {
>> +	if (syspm_pfuze_chip) {
>> +		syspm_pfuze_chip = NULL;
>> +		pm_power_off_prepare = NULL;
>> +	}
>> +
>>  	return 0;
>>  }
>>
>> @@ -671,6 +762,7 @@ static struct i2c_driver pfuze_driver = {
>>  		.of_match_table = pfuze_dt_ids,
>>  	},
>>  	.probe = pfuze100_regulator_probe,
>> +	.remove = pfuze100_regulator_remove,
>>  };
>>  module_i2c_driver(pfuze_driver);
>>
>> --
>> 2.18.0
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180730/83e11652/attachment.sig>
