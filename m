From: mniewoeh@stud.hs-offenburg.de (=?windows-1252?Q?Michael_Niew=F6hner?=)
Date: Tue, 12 May 2015 22:34:22 +0200
Subject: [PATCH 1/2] regulator: act8865: add restart handler for act8846
In-Reply-To: <2204003.IdqJV6LE2e@phil>
References: <A1C80CFB-CDCA-4F88-BA5F-371918CECD97@stud.hs-offenburg.de>
 <2204003.IdqJV6LE2e@phil>
Message-ID: <825B1E93-1012-4E76-A333-4D719EEE85AA@stud.hs-offenburg.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

thanks, I?ll rework the patch and the description on Thursday ;-)



Am 12.05.2015 um 22:22 schrieb Heiko Stuebner <heiko@sntech.de>:

> Hi Michael,
> 
> Am Montag, 11. Mai 2015, 22:54:11 schrieb Michael Niew?hner:
>> Rebooting radxa rock which uses act8846 results in kernel panic because the
>> bootloader doesn't readjust frequency or voltage for cpu correctly. This
>> workaround power cycles the act8846 at restart to reset the board.
> 
> Hmm, it might be nice to reword this, as this being a "workaround" for the 
> radxarock is a bit "short sighted".
> 
> The act8846 simply provides means to reset the system when used as main pmic 
> [hence the reliance on the system-power-controller] and other socs/boards 
> using it as pmic might also profit from exposing this function - for example if 
> there is no other means of reset.
> 
> 
>> Signed-off-by: Michael Niewoehner <mniewoeh@stud.hs-offenburg.de>
>> ---
>> drivers/regulator/act8865-regulator.c | 43
>> +++++++++++++++++++++++++++++++++++ 1 file changed, 43 insertions(+)
>> 
>> diff --git a/drivers/regulator/act8865-regulator.c
>> b/drivers/regulator/act8865-regulator.c index 2ff73d7..f8cdff3 100644
>> --- a/drivers/regulator/act8865-regulator.c
>> +++ b/drivers/regulator/act8865-regulator.c
>> @@ -27,6 +27,7 @@
>> #include <linux/of_device.h>
>> #include <linux/regulator/of_regulator.h>
>> #include <linux/regmap.h>
>> +#include <linux/reboot.h>
>> 
>> /*
>>  * ACT8600 Global Register Map.
>> @@ -133,10 +134,14 @@
>> #define	ACT8865_VOLTAGE_NUM	64
>> #define ACT8600_SUDCDC_VOLTAGE_NUM	255
>> 
>> +#define ACT8846_SIPC_MASK 0x01
>> +
>> struct act8865 {
>> 	struct regmap *regmap;
>> 	int off_reg;
>> 	int off_mask;
>> +	int sipc_reg;
>> +	int sipc_mask;
>> };
>> 
>> static const struct regmap_config act8865_regmap_config = {
>> @@ -402,6 +407,17 @@ static void act8865_power_off(void)
>> 	while (1);
>> }
>> 
>> +static int act8846_power_cycle(struct notifier_block *this,
>> +	unsigned long code, void *unused)
>> +{
>> +	struct act8865 *act8846;
>> +
>> +	act8846 = i2c_get_clientdata(act8865_i2c_client);
>> +	regmap_write(act8846->regmap, act8846->sipc_reg, act8846->sipc_mask);
> 
> The act8846 is currently the only one of the three types providing such 
> functionality, so until the second chip variant surfaces that provides a reset 
> capability, it might be less intrusive to simply do
> 
> 	regmap_write(act8846->regmap, ACT8846_GLB_OFF_CTRL, ACT8846_SIPC_MASK);
> 
> here and skip all the infrastructure like sipc_reg and sipc_mask assignment 
> and handling? But I guess that is Mark's call what he likes better.
> 
> 
>> +
>> +	return NOTIFY_DONE;
>> +}
>> +
> 
> structs like the restart_handler normally live near the function they 
> reference and not as static part of some function. And as the restart 
> functionality is not rockchip-specific, it should also not be named 
> rockchip_foo as below ;-)
> 
> static struct notifier_block act8846_restart_handler = {
> 	.notifier_call = act8846_power_cycle,
> 	.priority = 129,
> };
> 
> 
> 
>> static int act8865_pmic_probe(struct i2c_client *client,
>> 			      const struct i2c_device_id *i2c_id)
>> {
>> @@ -413,6 +429,7 @@ static int act8865_pmic_probe(struct i2c_client *client,
>> struct act8865 *act8865;
>> 	unsigned long type;
>> 	int off_reg, off_mask;
>> +	int sipc_reg, sipc_mask;
>> 
>> 	pdata = dev_get_platdata(dev);
>> 
>> @@ -434,18 +451,24 @@ static int act8865_pmic_probe(struct i2c_client
>> *client, num_regulators = ARRAY_SIZE(act8600_regulators);
>> 		off_reg = -1;
>> 		off_mask = -1;
>> +		sipc_reg = -1;
>> +		sipc_mask = -1;
>> 		break;
>> 	case ACT8846:
>> 		regulators = act8846_regulators;
>> 		num_regulators = ARRAY_SIZE(act8846_regulators);
>> 		off_reg = ACT8846_GLB_OFF_CTRL;
>> 		off_mask = ACT8846_OFF_SYSMASK;
>> +		sipc_reg = ACT8846_GLB_OFF_CTRL;
>> +		sipc_mask = ACT8846_SIPC_MASK;
>> 		break;
>> 	case ACT8865:
>> 		regulators = act8865_regulators;
>> 		num_regulators = ARRAY_SIZE(act8865_regulators);
>> 		off_reg = ACT8865_SYS_CTRL;
>> 		off_mask = ACT8865_MSTROFF;
>> +		sipc_reg = -1;
>> +		sipc_mask = -1;
>> 		break;
>> 	default:
>> 		dev_err(dev, "invalid device id %lu\n", type);
>> @@ -494,6 +517,26 @@ static int act8865_pmic_probe(struct i2c_client
>> *client, }
>> 	}
> 
> no need to add a second check for of_device_is_system_power_controller() as we 
> already have a check for this property directly above, simply extend it with 
> something like the following.
> 
> if (of_device_is_system_power_controller(dev->of_node)) {
> 	int ret;
> 
> 	/* already existing code to set poweroff handler */
> 
> 	if (type == ACT8846) {
> 		ret = register_restart_handler(&act8846_restart_handler);
> 		if (ret)
> 		pr_err("%s: cannot register restart handler, %d\n",
> 		       __func__, ret);
> 	}
> }
> 
> 
>> 
>> +	/* Register restart handler */
>> +	if (of_device_is_system_power_controller(dev->of_node)
>> +				&& sipc_reg > 0) {
>> +		static struct notifier_block rockchip_restart_handler = {
>> +			.notifier_call = act8846_power_cycle,
>> +			.priority = 129,
>> +		};
>> +
>> +		int ret;
>> +
>> +		act8865_i2c_client = client;
>> +		act8865->sipc_reg = sipc_reg;
>> +		act8865->sipc_mask = sipc_mask;
>> +
>> +		ret = register_restart_handler(&rockchip_restart_handler);
>> +		if (ret)
>> +			pr_err("%s: cannot register restart handler, %d\n",
>> +			       __func__, ret);
>> +	}
>> +
>> 	/* Finally register devices */
>> 	for (i = 0; i < num_regulators; i++) {
>> 		const struct regulator_desc *desc = &regulators[i];
