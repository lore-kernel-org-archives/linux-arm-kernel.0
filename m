From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 13 May 2015 18:02:44 -0700
Subject: [PATCH] regulator: Add SPMI regulator driver
In-Reply-To: <20150513114118.GJ3066@sirena.org.uk>
References: <1431466787-32247-1-git-send-email-sboyd@codeaurora.org>
 <20150513114118.GJ3066@sirena.org.uk>
Message-ID: <5553F434.4020102@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/15 04:41, Mark Brown wrote:
> On Tue, May 12, 2015 at 02:39:47PM -0700, Stephen Boyd wrote:
>
> Lots of things with the DT bindings here.  In general if you're
> introducing lots of custom properties I'd recommend doing a patch series
> which starts off with the generic, bog standard driver and then adds on
> the fancy bells and whistles later.  That way the simple stuff can get
> merged easily which cuts down on review effort.

Ok. I went for almost everything we had in the downstream kernel so we
can work through the binding. I'll split off all these custom properties
into a different patch.

>
>> +- qcom,system-load:
>> +	Usage: optional
>> +	Value type: <u32>
>> +	Description: Load in uA present on regulator that is not captured by
>> +		     any consumer request.
> This doesn't seem at all specific to this hardware - please add it as a
> generic property.

Ok.

>
>> +- qcom,auto-mode-enable:
>> +	Usage: optional
>> +	Value type: <u32>
>> +	Description: 1 = Enable automatic hardware selection of regulator
>> +			 mode (HPM vs LPM); not available on boost type
>> +			 regulators. 0 = Disable auto mode selection.
> Can we come up with a different name for this - IIRC (I'm working
> offline as I reply to this) this is not about pulse skipping enabling
> type automatic mode selection but rather about allowing other processors
> to control things.  The current name makes me think of the former thing.
> Perhaps just hpm-enable or something, or key it off specifying the
> signal to be used?

This is about configuring the regulator to switch mode between HPM and
LPM automatically based on current. You're right that it's not about
pulse skipping, but it isn't about letting other processors control
things either. I think you're thinking about pin control?

The register field is called AUTO_MODE, so I'm finding it hard to come
up with a better name. Perhaps qcom,auto-efficient-mode-enable?
qcom,auto-current-mode-enable?

>
>> +- qcom,bypass-mode-enable:
>> +	Usage: optional
>> +	Value type: <u32>
>> +	Description: 1 = Enable bypass mode for an LDO type regulator so that
>> +		     it acts like a switch and simply outputs its input
>> +		     voltage. 0 = Do not enable bypass mode.
> We have generic regulator API support for this, we should have a generic
> DT binding for it.

Given that regulator_allow_bypass() is a consumer facing API should I
just change this to regulator-allow-bypass and then add a set_bypass() op?

>
>> +- qcom,pull-down-enable:
>> +	Usage: optional
>> +	Value type: <u32>
>> +	Description: 1 = Enable output pull down resistor when the regulator
>> +		     is disabled. 0 = Disable pull down resistor

In qcom_rpm-regulator.c I think this is called bias-pull-down.

>> +
>> +- qcom,soft-start-enable:
>> +	Usage: optional
>> +	Value type: <u32>
>> +	Description: 1 = Enable soft start for LDO and voltage switch type
>> +		     regulators so that output voltage slowly ramps up when the
>> +		     regulator is enabled. 0 = Disable soft start
>
> These also seem like generic properties (we don't currently have generic
> APIs for them but these are by no means the only regulators I've seen
> with these features).

So for these sorts of generic properties how do I get them all the way
into the driver? Are you suggesting adding new ops for setting pull-down
and soft-start-enable and then parsing DT properties, setting those in
the regulation_constraints structure, and then calling the ops when we
apply constraints in set_machine_constraints()?

>
>> +- qcom,boost-current-limit:
>> +	Usage: optional
>> +	Value type: <u32>
>> +	Description: This property sets the current limit of boost type
>> +		     regulators; supported values are:
>> +					0 =  300 mA
>> +					1 =  600 mA
>> +					2 =  900 mA
>> +					3 = 1200 mA
>> +					4 = 1500 mA
>> +					5 = 1800 mA
>> +					6 = 2100 mA
>> +					7 = 2400 mA
> Again seems generic - there seems like overlap with your own OCP
> properties further above.

Yes it's generic. This property only applies to boost regulators on this
PMIC whereas OCP is only used for voltage switch type regulators. I
wonder if this should be done via regulator-min-microamp and
regulator-max-microamp being set to the same value and then implementing
a .set_current_limit() function?

>
>> +#define VOLTAGE_RANGE(_range_sel, _min_uV, _set_point_min_uV, \
>> +			_set_point_max_uV, _max_uV, _step_uV) \
>> +	{ \
>> +		.min_uV			= _min_uV, \
>> +		.max_uV			= _max_uV, \
>> +		.set_point_min_uV	= _set_point_min_uV, \
>> +		.set_point_max_uV	= _set_point_max_uV, \
>> +		.step_uV		= _step_uV, \
>> +		.range_sel		= _range_sel, \
>> +	}
> A lot of these macros have very generic names.  Also I have to say I'm a
> bit confused about what a set point is and how it's used, "allowed
> voltage" doesn't mean a huge amount in comparison with "programmable
> voltage".

These regulators have two registers. The first register says what range
(or row in the *_ranges arrays) we should use. The second register is a
selector that's used in the linear range calculation min_uV + sel *
step. The complication is here because we want to try and keep using the
same range register value for a new voltage. If we have to change the
range register to achieve a new voltage, then we want to keep the new
voltage within the set_point min/max values.

Let's take pldo_ranges for example:

static struct spmi_voltage_range pldo_ranges[] = {
        VOLTAGE_RANGE(2,  750000,  750000, 1537500, 1537500, 12500),
        VOLTAGE_RANGE(3, 1500000, 1550000, 3075000, 3075000, 25000),
        VOLTAGE_RANGE(4, 1750000, 3100000, 4900000, 4900000, 50000),
};

If the range register is programmed with '2' then the min_uV is 750000
and the step is 12500. We allow the full usage of this range up to
1537500. If the range register is programmed with '3', then the min_uV
is 1500000 and the step is 25000. This overlaps with range '2' between
1500000 and 1537500, so we force the minimum "selector" for range '3' to
be '2'. If we happen to be using range '3' and then a consumer requests
a voltage of 1500000 we'll stay in the same range register and program
the selector register to 0. If we had been on range '2' then we would
switch to range '3' and program 2 into the selector register to use 1550000.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
