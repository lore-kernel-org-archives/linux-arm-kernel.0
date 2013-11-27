From: stefan@agner.ch (Stefan Agner)
Date: Wed, 27 Nov 2013 22:56:10 +0100
Subject: [PATCH 2/3] regulator: tps6586x: add voltage table for tps658643
In-Reply-To: <5296273C.1000705@wwwdotorg.org>
References: <cover.1385508112.git.stefan@agner.ch>
 <8be2fe8560cc19f03d5be40ad3dc21d5979c8358.1385508112.git.stefan@agner.ch>
 <5296273C.1000705@wwwdotorg.org>
Message-ID: <93a0f4b1da2a54e58cee0756ab5f3e36@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 2013-11-27 18:09, schrieb Stephen Warren:
> On 11/26/2013 04:45 PM, Stefan Agner wrote:
>> Depending on version, the voltage table might be different. Add version
>> compatibility to the regulator information in order to select correct
>> voltage table.
> 
>> diff --git a/drivers/regulator/tps6586x-regulator.c b/drivers/regulator/tps6586x-regulator.c
> 
>> -static const unsigned int tps6586x_ldo4_voltages[] = {
>> +static const unsigned int tps6586x_ldo4_sm2_voltages[] = {
> 
>> +static const unsigned int tps658643_sm2_voltages[] = {
> 
> What's the logic behind the "ldo4_sm2" v.s. "sm2" naming? Does it match
> the data sheet in some way? If not, it might be better to name this
> something like "tps6586x_ldo4_voltages" and "tps65863_ldo4_voltages".
> 

This table is used for the TPS6586X (e.g. TPS658621A/D, maybe others)
variant for the LDO_4 regulator. The same table applies for TPS658623
for the SM2 regulator as well, so this naming should reflect that fact.

I could be some more verbose, e.g. tps6586x_ldo4_tps658623_sm2_voltages.
The other solution would be to create two independent (but identically)
voltage tables, but takes up more space...

>> -#define TPS6586X_REGULATOR(_id, _pin_name, vdata, vreg, shift, nbits,	\
>> -			   ereg0, ebit0, ereg1, ebit1, goreg, gobit)	\
>> +#define TPS6586X_REG(_ver, _id, _pin_name, vdata, vreg, shift,	nbits,	\
>> +		     ereg0, ebit0, ereg1, ebit1, goreg, gobit)		\
> 
> Why rename the macro?
> 
> There's an embedded TAB before "nbits".
> 

I must admit that the only reason doing the renaming was to allow the
parameters on two lines while keeping the 80 character limit...

>> +/* Add version specific entries before any */
>>  static struct tps6586x_regulator tps6586x_regulator[] = {
>>  	TPS6586X_SYS_REGULATOR(),
>> -	TPS6586X_LDO(LDO_0, "vinldo01", ldo0, SUPPLYV1, 5, 3, ENC, 0, END, 0),
> ...
>> +	TPS6586X_LDO(TPS6586X_ANY, LDO_0, "vinldo01", tps6586x_ldo0, SUPPLYV1,
>> +			5, 3, ENC, 0, END, 0),
> 
> Rather than changing all the macros and table entries, wouldn't it be
> much simpler to:
> 
> 1) Make tps6586x_regulator[] only contain all the common regulator
> definitions.
> 
> 2) Add new version-specific tables for each version of regulator, so
> tps6586x_other_regulator[] and tps65863_regulator[].
> 
> 3) Have probe() walk multiple tables of regulators, selecting which
> tables to walk based on version.
> 
> That would result in a much smaller and less invasive diff.

Hm, sounds easier yes. Would also remove the need for correct ordering,
which is a bit ugly. I will try that, lets see how this works out.
