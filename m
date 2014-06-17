From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 17 Jun 2014 12:49:56 +0200
Subject: [PATCH v2 07/10] regulator: Add driver for Maxim 77802 PMIC
 regulators
In-Reply-To: <20140616192500.GJ5099@sirena.org.uk>
References: <1402941758-11216-1-git-send-email-javier.martinez@collabora.co.uk>
 <1402941758-11216-8-git-send-email-javier.martinez@collabora.co.uk>
 <20140616192500.GJ5099@sirena.org.uk>
Message-ID: <53A01D54.10506@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

Thanks a lot for your feedback.

On 06/16/2014 09:25 PM, Mark Brown wrote:
> On Mon, Jun 16, 2014 at 08:02:35PM +0200, Javier Martinez Canillas wrote:
> 
>> --- a/drivers/mfd/max77802.c
>> +++ b/drivers/mfd/max77802.c
>> @@ -37,6 +37,7 @@
>>  #include <linux/err.h>
>>  
>>  static const struct mfd_cell max77802_devs[] = {
>> +	{ .name = "max77802-pmic", },
>>  };
>>  
>>  static bool max77802_pmic_is_accessible_reg(struct device *dev,
> 
> Please don't do things like this, it makes it harder to apply your
> series.  Just register all the devices in the MFD when you add the MFD
> driver.
> 

Ok, I'll do that. After all mfd core just omits the devices that don't match.

>> +	default:
>> +		pr_warn("%s: regulator_suspend_mode : 0x%x not supported\n",
>> +			rdev->desc->name, mode);
>> +		return -EINVAL;
> 
> dev_warn().
> 

Ok.

>> +static void max77802_copy_reg(struct device *dev, struct regmap *regmap,
>> +			      int from_reg, int to_reg)
>> +{
>> +	int val;
>> +	int ret;
>> +
>> +	if (from_reg == to_reg)
>> +		return;
>> +
>> +	ret = regmap_read(regmap, from_reg, &val);
>> +	if (!ret)
>> +		ret = regmap_write(regmap, to_reg, val);
>> +
>> +	if (ret)
>> +		dev_warn(dev, "Copy err %d => %d (%d)\n",
>> +			 from_reg, to_reg, ret);
>> +}
> 
> Again, this looks like it should be generic.
> 

Yes, I missed this from your previous feedback, sorry about that.

I'll add a regmap_copy_reg() function to drivers/base/regmap/regmap.c instead.

>> +static int max77802_pmic_probe(struct platform_device *pdev)
>> +{
> 
>> +	dev_dbg(&pdev->dev, "%s\n", __func__);
> 
> This isn't adding anything, just remove it - the core already logs
> probes if you want.
> 

Ok.

>> +	config.dev = &pdev->dev;
> 
> Are you sure this shouldn't be the MFD?
> 

I just looked at regulator_register() and saw that it does rdev->dev.parent =
dev, so yes this has to be the MFD.

>> +	for (i = 0; i < MAX77802_MAX_REGULATORS; i++) {
>> +		struct regulator_dev *rdev;
>> +		int id = pdata->regulators[i].id;
>> +
>> +		config.init_data = pdata->regulators[i].initdata;
>> +		config.of_node = pdata->regulators[i].of_node;
>> +
>> +		max77802->opmode[id] = MAX77802_OPMODE_NORMAL;
> 
> Why isn't this being read from the hardware, this may lead to a
> configuration change the first time we pay attention?
> 

The original Chrome OS driver [0] had a "regulator-op-mode" property similar to
"op_mode" in Documentation/devicetree/bindings/regulator/s5m8767-regulator.txt
to specify the operating mode using DT.

But I removed that since I didn't want to have a specific property for what
appears to be a generic need. I wanted to re-post something along the lines of
what was discussed in [1] and add operating mode support to the generic
regulator code.

So, for now I thought it made sense to set the operating mode to normal on
probe() but I'll change it to read from the hardware if that is better.

I guess I should check in the datasheet if a sane default operating mode for
LDOs is expected when the chip is reseted or if this is left undefined and also
if the bootloader already set this.

Best regards,
Javier

[0]:
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.8/Documentation/devicetree/bindings/mfd/max77xxx.txt
[1]: https://patchwork.kernel.org/patch/1855331/
