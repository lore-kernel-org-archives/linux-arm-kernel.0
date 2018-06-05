From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 5 Jun 2018 11:46:05 +0200
Subject: [PATCH V3] ARM: shmobile: Rework the PMIC IRQ line quirk
In-Reply-To: <20180605080727.ygh25rmjsrs3dmlq@verge.net.au>
References: <20180604175911.799-1-marek.vasut+renesas@gmail.com>
 <20180605080727.ygh25rmjsrs3dmlq@verge.net.au>
Message-ID: <93393915-0343-00ce-506b-d5d6ba50bffa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2018 10:07 AM, Simon Horman wrote:
> On Mon, Jun 04, 2018 at 07:59:11PM +0200, Marek Vasut wrote:
>> Rather than hard-coding the quirk topology, which stopped scaling,
>> parse the information from DT. The code looks for all compatible
>> PMICs -- da9036 and da9210 -- and checks if their IRQ line is tied
>> to the same pin. If so, the code sends a matching sequence to the
>> PMIC to deassert the IRQ.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> Cc: Simon Horman <horms+renesas@verge.net.au>
>> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Cc: linux-renesas-soc at vger.kernel.org
>> ---
>> V2: - Replace the DT shared IRQ check loop with memcmp()
>>     - Send the I2C message to deassert the IRQ line to all PMICs
>>       in the list with shared IRQ line instead of just one
>>     - Add comment that this works only in case all the PMICs are
>>       on the same I2C bus
>> V3: - Drop the addr = 0x00 init
>>     - Drop reinit of argsa in rcar_gen2_regulator_quirk
>> ---
>>  arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c | 114 ++++++++++++++++-----
>>  1 file changed, 90 insertions(+), 24 deletions(-)
>>
>> diff --git a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
>> index 93f628acfd94..b919073aa27e 100644
>> --- a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
>> +++ b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
>> @@ -31,8 +31,10 @@
>>  #include <linux/i2c.h>
>>  #include <linux/init.h>
>>  #include <linux/io.h>
>> +#include <linux/list.h>
>>  #include <linux/notifier.h>
>>  #include <linux/of.h>
>> +#include <linux/of_irq.h>
>>  #include <linux/mfd/da9063/registers.h>
>>  
>>  
>> @@ -44,34 +46,45 @@
>>  /* start of DA9210 System Control and Event Registers */
>>  #define DA9210_REG_MASK_A		0x54
>>  
>> +struct regulator_quirk {
>> +	struct list_head		list;
>> +	const struct of_device_id	*id;
>> +	struct of_phandle_args		irq_args;
>> +	struct i2c_msg			i2c_msg;
>> +	bool				shared;	/* IRQ line is shared */
>> +};
>> +
>> +static LIST_HEAD(quirk_list);
>>  static void __iomem *irqc;
>>  
>>  /* first byte sets the memory pointer, following are consecutive reg values */
>>  static u8 da9063_irq_clr[] = { DA9063_REG_IRQ_MASK_A, 0xff, 0xff, 0xff, 0xff };
>>  static u8 da9210_irq_clr[] = { DA9210_REG_MASK_A, 0xff, 0xff };
>>  
>> -static struct i2c_msg da9xxx_msgs[3] = {
>> -	{
>> -		.addr = 0x58,
>> -		.len = ARRAY_SIZE(da9063_irq_clr),
>> -		.buf = da9063_irq_clr,
>> -	}, {
>> -		.addr = 0x68,
>> -		.len = ARRAY_SIZE(da9210_irq_clr),
>> -		.buf = da9210_irq_clr,
>> -	}, {
>> -		.addr = 0x70,
>> -		.len = ARRAY_SIZE(da9210_irq_clr),
>> -		.buf = da9210_irq_clr,
>> -	},
>> +static struct i2c_msg da9063_msgs = {
>> +	.len = ARRAY_SIZE(da9063_irq_clr),
>> +	.buf = da9063_irq_clr,
>> +};
>> +
>> +static struct i2c_msg da9210_msgs = {
>> +	.len = ARRAY_SIZE(da9210_irq_clr),
>> +	.buf = da9210_irq_clr,
>> +};
>> +
>> +static const struct of_device_id rcar_gen2_quirk_match[] = {
>> +	{ .compatible = "dlg,da9063", .data = &da9063_msgs },
>> +	{ .compatible = "dlg,da9210", .data = &da9210_msgs },
>> +	{},
>>  };
>>  
>>  static int regulator_quirk_notify(struct notifier_block *nb,
>>  				  unsigned long action, void *data)
>>  {
>> +	struct regulator_quirk *pos, *tmp;
>>  	struct device *dev = data;
>>  	struct i2c_client *client;
>>  	static bool done;
>> +	int ret;
>>  	u32 mon;
>>  
>>  	if (done)
>> @@ -88,17 +101,20 @@ static int regulator_quirk_notify(struct notifier_block *nb,
>>  	client = to_i2c_client(dev);
>>  	dev_dbg(dev, "Detected %s\n", client->name);
>>  
>> -	if ((client->addr == 0x58 && !strcmp(client->name, "da9063")) ||
>> -	    (client->addr == 0x68 && !strcmp(client->name, "da9210")) ||
>> -	    (client->addr == 0x70 && !strcmp(client->name, "da9210"))) {
>> -		int ret, len;
>> +	/*
>> +	 * Send message to all PMICs that share an IRQ line to deassert it.
>> +	 *
>> +	 * WARNING: This works only if all the PMICs are on the same I2C bus.
>> +	 */
>> +	list_for_each_entry(pos, &quirk_list, list) {
>> +		if (!pos->shared)
>> +			continue;
>>  
>> -		/* There are two DA9210 on Stout, one on the other boards. */
>> -		len = of_machine_is_compatible("renesas,stout") ? 3 : 2;
>> +		dev_info(&client->dev, "clearing %s at 0x%02x interrupts\n",
>> +			 pos->id->compatible, pos->i2c_msg.addr);
>>  
>> -		dev_info(&client->dev, "clearing da9063/da9210 interrupts\n");
>> -		ret = i2c_transfer(client->adapter, da9xxx_msgs, len);
>> -		if (ret != len)
>> +		ret = i2c_transfer(client->adapter, &pos->i2c_msg, 1);
>> +		if (ret != 1)
>>  			dev_err(&client->dev, "i2c error %d\n", ret);
>>  	}
>>  
>> @@ -111,6 +127,11 @@ static int regulator_quirk_notify(struct notifier_block *nb,
>>  remove:
>>  	dev_info(dev, "IRQ2 is not asserted, removing quirk\n");
>>  
>> +	list_for_each_entry_safe(pos, tmp, &quirk_list, list) {
>> +		list_del(&pos->list);
>> +		kfree(pos);
>> +	}
>> +
>>  	done = true;
>>  	iounmap(irqc);
>>  	return 0;
>> @@ -122,7 +143,13 @@ static struct notifier_block regulator_quirk_nb = {
>>  
>>  static int __init rcar_gen2_regulator_quirk(void)
>>  {
>> -	u32 mon;
>> +	struct device_node *np;
>> +	const struct of_device_id *id;
>> +	struct regulator_quirk *quirk;
>> +	struct regulator_quirk *pos;
>> +	struct of_phandle_args *argsa, *argsb;
>> +	u32 mon, addr;
>> +	int ret;
>>  
>>  	if (!of_machine_is_compatible("renesas,koelsch") &&
>>  	    !of_machine_is_compatible("renesas,lager") &&
>> @@ -130,6 +157,45 @@ static int __init rcar_gen2_regulator_quirk(void)
>>  	    !of_machine_is_compatible("renesas,gose"))
>>  		return -ENODEV;
>>  
>> +	for_each_matching_node_and_match(np, rcar_gen2_quirk_match, &id) {
>> +		if (!np || !of_device_is_available(np))
>> +			break;
>> +
>> +		quirk = kzalloc(sizeof(*quirk), GFP_KERNEL);
>> +
>> +		argsa = &quirk->irq_args;
>> +		memcpy(&quirk->i2c_msg, id->data, sizeof(quirk->i2c_msg));
>> +
>> +		ret = of_property_read_u32(np, "reg", &addr);
>> +		if (ret)
>> +			return ret;
>> +
>> +		quirk->id = id;
>> +		quirk->i2c_msg.addr = addr;
>> +		quirk->shared = false;
>> +
>> +		ret = of_irq_parse_one(np, 0, &quirk->irq_args);
> 
> As per my comment on v2,
> &quirk->irq_args is assigned to argsa above and used directly here.
> 

Hum, OK

-- 
Best regards,
Marek Vasut
