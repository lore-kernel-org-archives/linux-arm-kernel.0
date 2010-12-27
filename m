From: dh09.lee@samsung.com (Donghwa Lee)
Date: Mon, 27 Dec 2010 13:34:23 +0900
Subject: [PATCH V2] S5PC210: universal: update support pmic for c210
	universal board
In-Reply-To: <20101224173531.GA26913@sirena.org.uk>
References: <1293168299-11552-1-git-send-email-dh09.lee@samsung.com>
	<20101224173531.GA26913@sirena.org.uk>
Message-ID: <4D18174F.8060804@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 On 2010-12-25 ?? 2:35 , Mark Brown wrote:
> On Fri, Dec 24, 2010 at 02:24:59PM +0900, Donghwa Lee wrote:
>
>> +	select HAVE_SPARSE_IRQ
>> +	select HAVE_GENERIC_HARDIRQS
> I really would expect to see these controlled by the generic support for
> the CPU or CPU architecture rather than by an individual machine -
> they're properties of the core IRQ infrastructure for the system.
>

Yes, you're right. i will modify it next patch.

>> +/* I2C5: PMICs LP3974, MAX8952 */
>> +static struct regulator_consumer_supply max8952_consumer[] = {
>> +	{
>> +		.supply		= "varm_1.2v_c210",
>> +	}, {
>> +		.supply		= "vdd_arm",
>> +	},
> This looks very suspicious - you've got two supplies, both of which look
> like the CPU core rail provided by the same regulator, one of which
> looks like it's got the name of the supply hard coded into it.  What are
> these two supplies exactly?
>

 I will remove "vdd_arm" next patch.



>> +	.reg_data		= {
>> +		.constraints	= {
>> +			.name		= "VARM_1.2V",
>> +			.min_uV		= 770000,
>> +			.max_uV		= 1400000,
>> +			.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE,
> Interesting name for a supply that can change voltage :)
>

1.2V is default voltage. If it is needed , volatage can be changed.
Is the name changed?

>> +static struct regulator_consumer_supply lp3974_buck2_consumer[] = {
>> +	{
>> +		.supply		= "vg3d_1.2v_c210",
>> +	},
>> +};
> This and most of the other consumers you're defining look like they're
> actually the names for the relevant rails rather than supplies for
> individual devices.  You shouldn't do this, supplies should be actual
> supplies on individual consumers - probably most of these consumers
> should just be removed.  You can name the supplies for UI purposes using
> the .name field in the constraints.
>

Supplies name of this patch is defined in the schematic diagram.
Could you suggest the name for UI purposes?

>> +static struct regulator_consumer_supply lp3974_ldo13_consumer[] = {
>> +	REGULATOR_SUPPLY("vhsic", NULL),
>> +};
>> +
>> +static struct regulator_consumer_supply lp3974_ldo14_consumer[] = {
>> +	{
>> +		.supply		= "cam_i_host_1.8v",
>> +	},
> There's also a mix of regulator_consumer_supply and open coding, please
> be consistent.
>

.

>> +static struct regulator_init_data lp3974_buck1_data = {
>> +	.constraints	= {
>> +		.name		= "VINT_1.1V",
>> +		.min_uV		= 750000,
>> +		.max_uV		= 1500000,
>> +		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE |
>> +			REGULATOR_CHANGE_STATUS,
> Can you really turn off the VINT regulator at runtime?  I'd expect that
> to crash the processor.  Similarly for many of the other supplies.
>

If it turns off at run time, it would be crash the processor, but, it will be turn off
only when executing SLEEP, maybe no problem.

Thank you,
Donghwa Lee
