From: k.lewandowsk@samsung.com (Karol Lewandowski)
Date: Wed, 25 Jan 2012 13:02:29 +0100
Subject: [PATCH v2 2/2] regulator: add device tree support for max8997
In-Reply-To: <20120125112602.GB2991@opensource.wolfsonmicro.com>
References: <1326353738-26864-1-git-send-email-thomas.abraham@linaro.org>
 <1326353738-26864-3-git-send-email-thomas.abraham@linaro.org>
 <4F1FD1A5.1060305@samsung.com>
 <20120125112602.GB2991@opensource.wolfsonmicro.com>
Message-ID: <4F1FEF55.8030604@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.01.2012 12:26, Mark Brown wrote:
> On Wed, Jan 25, 2012 at 10:55:49AM +0100, Karol Lewandowski wrote:
>> On 12.01.2012 08:35, Thomas Abraham wrote:
>>> Add device tree based discovery support for max8997.
>>
>>> +	pdata->regulators = rdata;
>>> +	for_each_child_of_node(regulators_np, reg_np) {
>>> +		for (i = 0; i<   ARRAY_SIZE(regulators); i++)
>>> +			if (!of_node_cmp(reg_np->name, regulators[i].name))
>>> +				break;
>>> +		rdata->id = i;
>>> +		rdata->initdata = of_get_regulator_init_data(
>>> +						iodev->dev, reg_np);
>
>> One more thing - of_get_regulator_init_data() will set apply_uV to 1
>> so we need to reset it for BUCK6, which doesn't provide
>> set_voltage() ops, like:
>
>> 	if (rdata->initdata&&  regulators[i].id == MAX8997_BUCK6)
>> 		rdata->initdata->constraints.apply_uV = 0;
>
> So, over in the other thready you were referring to mailing list posts
> you made in the past few moments as examples of past issues.  Please at
> least mention that there hasn't been any actual discussion when doing
> this...

Sorry if this caused confusion.  I'll be more cautious next time.

> I don't see a problem here, if the device can't set the voltage then
> setting constraints to allow the voltage to be changed is silly and the
> user just shouldn't do that.

Agreed.  I've assumed that old platform code done right thing when it 
set buck6 voltage constraints [1].

However, I still find it little problematic that dt and non-dt versions 
behave differently when given the same set of parameters (previously 
apply_uV wasn't the default and required explicit flag).


Thomas, would you mind adding small note to pmic's bindings 
documentation stating that Buck6 is basically on/off switch? (Thus, no 
voltage should nor can be specified).

[1] http://lxr.linux.no/linux+v3.2.1/arch/arm/mach-exynos/mach-nuri.c#L802

Regards,
-- 
Karol Lewandowski | Samsung Poland R&D Center | Linux/Platform
