From: broonie@kernel.org (Mark Brown)
Date: Wed, 13 May 2015 12:41:18 +0100
Subject: [PATCH] regulator: Add SPMI regulator driver
In-Reply-To: <1431466787-32247-1-git-send-email-sboyd@codeaurora.org>
References: <1431466787-32247-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150513114118.GJ3066@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 02:39:47PM -0700, Stephen Boyd wrote:

Lots of things with the DT bindings here.  In general if you're
introducing lots of custom properties I'd recommend doing a patch series
which starts off with the generic, bog standard driver and then adds on
the fancy bells and whistles later.  That way the simple stuff can get
merged easily which cuts down on review effort.

> +- qcom,system-load:
> +	Usage: optional
> +	Value type: <u32>
> +	Description: Load in uA present on regulator that is not captured by
> +		     any consumer request.

This doesn't seem at all specific to this hardware - please add it as a
generic property.

> +- qcom,auto-mode-enable:
> +	Usage: optional
> +	Value type: <u32>
> +	Description: 1 = Enable automatic hardware selection of regulator
> +			 mode (HPM vs LPM); not available on boost type
> +			 regulators. 0 = Disable auto mode selection.

Can we come up with a different name for this - IIRC (I'm working
offline as I reply to this) this is not about pulse skipping enabling
type automatic mode selection but rather about allowing other processors
to control things.  The current name makes me think of the former thing.
Perhaps just hpm-enable or something, or key it off specifying the
signal to be used?

> +- qcom,bypass-mode-enable:
> +	Usage: optional
> +	Value type: <u32>
> +	Description: 1 = Enable bypass mode for an LDO type regulator so that
> +		     it acts like a switch and simply outputs its input
> +		     voltage. 0 = Do not enable bypass mode.

We have generic regulator API support for this, we should have a generic
DT binding for it.

> +- qcom,pull-down-enable:
> +	Usage: optional
> +	Value type: <u32>
> +	Description: 1 = Enable output pull down resistor when the regulator
> +		     is disabled. 0 = Disable pull down resistor
> +
> +- qcom,soft-start-enable:
> +	Usage: optional
> +	Value type: <u32>
> +	Description: 1 = Enable soft start for LDO and voltage switch type
> +		     regulators so that output voltage slowly ramps up when the
> +		     regulator is enabled. 0 = Disable soft start


These also seem like generic properties (we don't currently have generic
APIs for them but these are by no means the only regulators I've seen
with these features).

> +- qcom,boost-current-limit:
> +	Usage: optional
> +	Value type: <u32>
> +	Description: This property sets the current limit of boost type
> +		     regulators; supported values are:
> +					0 =  300 mA
> +					1 =  600 mA
> +					2 =  900 mA
> +					3 = 1200 mA
> +					4 = 1500 mA
> +					5 = 1800 mA
> +					6 = 2100 mA
> +					7 = 2400 mA

Again seems generic - there seems like overlap with your own OCP
properties further above.

> +#define VOLTAGE_RANGE(_range_sel, _min_uV, _set_point_min_uV, \
> +			_set_point_max_uV, _max_uV, _step_uV) \
> +	{ \
> +		.min_uV			= _min_uV, \
> +		.max_uV			= _max_uV, \
> +		.set_point_min_uV	= _set_point_min_uV, \
> +		.set_point_max_uV	= _set_point_max_uV, \
> +		.step_uV		= _step_uV, \
> +		.range_sel		= _range_sel, \
> +	}

A lot of these macros have very generic names.  Also I have to say I'm a
bit confused about what a set point is and how it's used, "allowed
voltage" doesn't mean a huge amount in comparison with "programmable
voltage".

I got a bit lost with all this so I've not really got any comments on
the rest of the code as is, sorry.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150513/4a5268d2/attachment-0001.sig>
