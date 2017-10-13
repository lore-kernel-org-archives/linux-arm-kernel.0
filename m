From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 13 Oct 2017 16:44:43 -0700
Subject: [PATCH 1/2] hwmon: (jc42) optionally try to disable the SMBUS
 timeout
In-Reply-To: <20171013203527.GA14166@roeck-us.net>
References: <20171013092705.7038-1-peda@axentia.se>
 <20171013092705.7038-2-peda@axentia.se>
 <554a4494-14c9-7743-898c-5f83e3de227d@roeck-us.net>
 <2d1bf447-489f-9e15-3b1e-d2f4a2c1dcfe@axentia.se>
 <20171013203527.GA14166@roeck-us.net>
Message-ID: <20171013234443.GA31590@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ resending - looks like my primary email provider ended up on a spam list
  and almost all of my e-mail gets dropped ]

On Fri, Oct 13, 2017 at 04:26:57PM +0200, Peter Rosin wrote:
> On 2017-10-13 15:50, Guenter Roeck wrote:
> > On 10/13/2017 02:27 AM, Peter Rosin wrote:
> >> With a nxp,se97 chip on an atmel sama5d31 board, the I2C adapter driver
> >> is not always capable of avoiding the 25-35 ms timeout as specified by
> >> the SMBUS protocol. This may cause silent corruption of the last bit of
> >> any transfer, e.g. a one is read instead of a zero if the sensor chip
> >> times out. This also affects the eeprom half of the nxp-se97 chip, where
> >> this silent corruption was originally noticed. Other I2C adapters probably
> >> suffer similar issues, e.g. bit-banging comes to mind as risky...
> >>
> >> The SMBUS register in the nxp chip is not a standard Jedec register, but
> >> it is not special to the nxp chips either, at least the atmel chips
> >> have the same mechanism. Therefore, do not special case this on the
> >> manufacturer, it is opt-in via the device property anyway.
> >>
> >> Signed-off-by: Peter Rosin <peda@axentia.se>
> >> ---
> >>   Documentation/devicetree/bindings/hwmon/jc42.txt |  4 ++++
> >>   drivers/hwmon/jc42.c                             | 20 ++++++++++++++++++++
> >>   2 files changed, 24 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/hwmon/jc42.txt b/Documentation/devicetree/bindings/hwmon/jc42.txt
> >> index 07a250498fbb..f569db58f64a 100644
> >> --- a/Documentation/devicetree/bindings/hwmon/jc42.txt
> >> +++ b/Documentation/devicetree/bindings/hwmon/jc42.txt
> >> @@ -34,6 +34,10 @@ Required properties:
> >>   
> >>   - reg: I2C address
> >>   
> >> +Optional properties:
> >> +- smbus-timeout-disable: When set, the smbus timeout function will be disabled.
> >> +			 This is not supported on all chips.
> >> +
> >>   Example:
> >>   
> >>   temp-sensor at 1a {
> >> diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
> >> index 1bf22eff0b08..fd816902fa30 100644
> >> --- a/drivers/hwmon/jc42.c
> >> +++ b/drivers/hwmon/jc42.c
> >> @@ -45,6 +45,7 @@ static const unsigned short normal_i2c[] = {
> >>   #define JC42_REG_TEMP		0x05
> >>   #define JC42_REG_MANID		0x06
> >>   #define JC42_REG_DEVICEID	0x07
> >> +#define JC42_REG_SMBUS		0x22 /* NXP and Atmel, possibly others? */
> >>   
> >>   /* Status bits in temperature register */
> >>   #define JC42_ALARM_CRIT_BIT	15
> >> @@ -73,6 +74,9 @@ static const unsigned short normal_i2c[] = {
> >>   #define ONS_MANID		0x1b09  /* ON Semiconductor */
> >>   #define STM_MANID		0x104a  /* ST Microelectronics */
> >>   
> >> +/* SMBUS register */
> >> +#define SMBUS_STMOUT		BIT(7)  /* SMBus time-out, active low */
> >> +
> >>   /* Supported chips */
> >>   
> >>   /* Analog Devices */
> >> @@ -476,6 +480,22 @@ static int jc42_probe(struct i2c_client *client, const struct i2c_device_id *id)
> >>   
> >>   	data->extended = !!(cap & JC42_CAP_RANGE);
> >>   
> >> +	if (device_property_read_bool(dev, "smbus-timeout-disable")) {
> >> +		int smbus;
> >> +
> >> +		/*
> >> +		 * Not all chips support this register, but from a
> >> +		 * quick read of various datasheets no chip appears
> >> +		 * incompatible with the below attempt to disable
> >> +		 * the timeout. And the whole thing is opt-in...
> >> +		 */
> >> +		smbus = i2c_smbus_read_word_swapped(client, JC42_REG_SMBUS);
> >> +		if (smbus < 0)
> >> +			return smbus;
> >> +		i2c_smbus_write_word_swapped(client, JC42_REG_SMBUS,
> >> +					     smbus | SMBUS_STMOUT);
> > 
> > Looking into the SE97 datasheet, the bit is only writable if the alarm bits
> > are not locked. Should we take this into account and unlock the alarm bits
> > if necessary ?
> 
> Right. And I thought about the case when the timeout was disabled before
> probing but with the property not present (perhaps by someone trying things
> out, like I have). Should the timeout be re-enabled in that case?

No, because the property only states that the timeout should be disabled.
It does not say that it should be _enabled_ if the property is not there.
That would require a different property. A -> B does not imply B -> A.

> But, someone might have disabled the timeout by some previous arrangement
> (e.g. in a boot-loader) but without having this newfangled property in the
> device tree. Re-enabling the timeout in that case would break things. Slim
> chance for that to be an issue, but perhaps not?
> 
> Unlocking the alarm bits is somewhat similar, since it should only be an
> issue for warm starts. But the risk of breakage is perhaps not there at
> all?
> 
We would have to lock the alarm bits again, leaving them in a consistent
state.

> Your call, I can fix thing however you like...
> 

Let's just leave it as-is. If we encounter a problem later we can always
add code to unlock/lock the alarm bits.

Guenter
