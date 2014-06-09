From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 10 Jun 2014 01:40:30 +0200
Subject: [PATCH 1/5] mfd: Add driver for Maxim 77802 Power Management
 IC
In-Reply-To: <20140609194713.GF5099@sirena.org.uk>
References: <1402306670-17041-1-git-send-email-javier.martinez@collabora.co.uk>
 <1402306670-17041-2-git-send-email-javier.martinez@collabora.co.uk>
 <20140609194713.GF5099@sirena.org.uk>
Message-ID: <539645EE.6020009@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On 06/09/2014 09:47 PM, Mark Brown wrote:
> On Mon, Jun 09, 2014 at 11:37:46AM +0200, Javier Martinez Canillas wrote:
> 
>> +Optional node:
>> +- voltage-regulators : The regulators of max77802 have to be instantiated
>> +  under subnode named "voltage-regulators" using the following format.
> 
> Every other PMIC calls this node regulators...
> 

Ok, I'll change for consistency.

>> +	regulator_name {
>> +		regulator-compatible = LDOn/BUCKn
> 
> regulator-compatible is deprecated, use the node name instead.
> 

Ok.

>> +config MFD_MAX77802
>> +	bool "Maxim Integrated MAX77802 PMIC Support"
> 
> Why is this bool and not tristate?
> 

I noticed that the majority of the mfd PMIC drivers were bool and not tristate
so I thought it was a convention. But nothing prevents this driver to be built
as a module so I'll change it to tristate.

>> +int max77802_irq_resume(struct max77802_dev *max77802)
>> +{
>> +	/*
>> +	 * The IRQ that woke us up may still need to be ACK'ed on resume.
>> +	 * If it isn't ever ACK'ed, future IRQs may not be delivered.
>> +	 */
>> +	if (max77802->irq)
>> +		max77802_irq_thread(0, max77802);
>> +
>> +	return 0;
>> +}
> 
> As covered in another subthread all this code looks like it should be
> regmap-irq.
> 

It seems so, I'll take that into account for v2.

>> +	if (regmap_read(max77802->regmap,
>> +			 MAX77802_REG_DEVICE_ID, &data) < 0) {
>> +		dev_err(max77802->dev,
>> +			"device not found on this channel (this is not an error)\n");
>> +		return -ENODEV;
> 
> If this is not an error why is it printed as dev_err()?  It does look
> like an error to me, though.
> 

Yeah, it is an error so I'll clean that message.

>> +	} else {
>> +		dev_info(max77802->dev, "device found\n");
>> +	}
> 
> These sort of prints are just noise, remove this unless there is some
> revision information you can display.  It's also better practice to
> check that the device ID is actually what was expected in case there was
> an error in the DT.
> 

Ok, will do.

>> +static const struct i2c_device_id max77802_i2c_id[] = {
>> +	{ "max77802", TYPE_MAX77802 },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, max77802_i2c_id);
> 
> We have type information here but not in the OF ID table (not that we
> ever look at it).
> 

Yeah, I'll remove the type information here. It is a left over when trying to
combine both max77802 and max77686 drivers since in a combined driver we need
the type information.

Thanks a lot for your feedback.

Best regards,
Javier
