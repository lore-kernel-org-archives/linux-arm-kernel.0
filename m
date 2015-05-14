From: broonie@kernel.org (Mark Brown)
Date: Thu, 14 May 2015 20:20:18 +0100
Subject: [PATCH] regulator: Add SPMI regulator driver
In-Reply-To: <5553F434.4020102@codeaurora.org>
References: <1431466787-32247-1-git-send-email-sboyd@codeaurora.org>
 <20150513114118.GJ3066@sirena.org.uk>
 <5553F434.4020102@codeaurora.org>
Message-ID: <20150514192018.GU2761@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 06:02:44PM -0700, Stephen Boyd wrote:

> This is about configuring the regulator to switch mode between HPM and
> LPM automatically based on current. You're right that it's not about
> pulse skipping, but it isn't about letting other processors control
> things either. I think you're thinking about pin control?

Possibly, this stuff is all system jargon heavy and I've not context
switched that in recently.  The above sounds like it pretty much *is*
the equivalent of pulse skipping in which case it's much more like the
normal modes (that we were going to abandon...).

> The register field is called AUTO_MODE, so I'm finding it hard to come
> up with a better name. Perhaps qcom,auto-efficient-mode-enable?
> qcom,auto-current-mode-enable?

This definitely sounds like traditional regulator modes.

> >> +- qcom,bypass-mode-enable:
> >> +	Usage: optional
> >> +	Value type: <u32>
> >> +	Description: 1 = Enable bypass mode for an LDO type regulator so that
> >> +		     it acts like a switch and simply outputs its input
> >> +		     voltage. 0 = Do not enable bypass mode.

> > We have generic regulator API support for this, we should have a generic
> > DT binding for it.

> Given that regulator_allow_bypass() is a consumer facing API should I
> just change this to regulator-allow-bypass and then add a set_bypass() op?

Yes.

> >> +- qcom,soft-start-enable:
> >> +	Usage: optional
> >> +	Value type: <u32>
> >> +	Description: 1 = Enable soft start for LDO and voltage switch type
> >> +		     regulators so that output voltage slowly ramps up when the
> >> +		     regulator is enabled. 0 = Disable soft start

> > These also seem like generic properties (we don't currently have generic
> > APIs for them but these are by no means the only regulators I've seen
> > with these features).

> So for these sorts of generic properties how do I get them all the way
> into the driver? Are you suggesting adding new ops for setting pull-down
> and soft-start-enable and then parsing DT properties, setting those in
> the regulation_constraints structure, and then calling the ops when we
> apply constraints in set_machine_constraints()?

Yeah, if it's becoming something that does need setting from DT (which
it seems to) then we probably need to go through all that.  With helpers
and so on.

> >> +- qcom,boost-current-limit:
> >> +	Usage: optional
> >> +	Value type: <u32>
> >> +	Description: This property sets the current limit of boost type
> >> +		     regulators; supported values are:
> >> +					0 =  300 mA

> > Again seems generic - there seems like overlap with your own OCP
> > properties further above.

> Yes it's generic. This property only applies to boost regulators on this
> PMIC whereas OCP is only used for voltage switch type regulators. I
> wonder if this should be done via regulator-min-microamp and
> regulator-max-microamp being set to the same value and then implementing
> a .set_current_limit() function?

Yes, that was what I was thinking.  Perhaps a current-limit or something
property rather than the min and max thing for clarity (to avoid
confusion with actual current regulators).

> >> +#define VOLTAGE_RANGE(_range_sel, _min_uV, _set_point_min_uV, \
> >> +			_set_point_max_uV, _max_uV, _step_uV) \
> >> +	{ \

> > A lot of these macros have very generic names.  Also I have to say I'm a
> > bit confused about what a set point is and how it's used, "allowed
> > voltage" doesn't mean a huge amount in comparison with "programmable
> > voltage".

> These regulators have two registers. The first register says what range
> (or row in the *_ranges arrays) we should use. The second register is a
> selector that's used in the linear range calculation min_uV + sel *
> step. The complication is here because we want to try and keep using the

Hardware engineers are truly innovative and creative people sometimes.
That all makes sense, but the thing about the generic names still
applies - at least namespace them please.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150514/42fa2013/attachment-0001.sig>
