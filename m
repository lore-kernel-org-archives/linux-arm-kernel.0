From: broonie@kernel.org (Mark Brown)
Date: Thu, 12 Jul 2018 17:54:57 +0100
Subject: [PATCH v8 2/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <9bbfb628-018d-2d89-257b-9cc4e716cb46@codeaurora.org>
References: <cover.1529712888.git.collinsd@codeaurora.org>
 <35c4ea70cdf5caba560fb6f40e866ee8bc456d93.1529712888.git.collinsd@codeaurora.org>
 <20180702102853.GI18211@sirena.org.uk>
 <9bbfb628-018d-2d89-257b-9cc4e716cb46@codeaurora.org>
Message-ID: <20180712165457.GI10369@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 09, 2018 at 04:44:14PM -0700, David Collins wrote:
> On 07/02/2018 03:28 AM, Mark Brown wrote:
> > On Fri, Jun 22, 2018 at 05:46:14PM -0700, David Collins wrote:

> >> +static const int pmic_mode_map_pmic4_ldo[REGULATOR_MODE_STANDBY + 1] = {
> >> +	[REGULATOR_MODE_INVALID] = -EINVAL,
> >> +	[REGULATOR_MODE_STANDBY] = PMIC4_LDO_MODE_RETENTION,
> >> +	[REGULATOR_MODE_IDLE]    = PMIC4_LDO_MODE_LPM,
> >> +	[REGULATOR_MODE_NORMAL]  = -EINVAL,
> >> +	[REGULATOR_MODE_FAST]    = PMIC4_LDO_MODE_HPM,
> >> +};

> > This mapping is really weird, I'd expect one of the modes to correspond
> > to the normal operating mode of the regulator.  

> My thinking here was to have a consistent mapping for consumers to use
> between REGULATOR_MODE_* and physical regulator modes for both LDO and
> SMPS type regulators:

No, that's not useful or helpful - if there's any modes I'd *really*
expect to see one of them be _NORMAL.

> This allows a consumer to request NORMAL in typical use cases and FAST in
> use cases that require low voltage ripple.  If NORMAL is not supported,
> then it automatically gets upgraded to FAST by the regulator framework.

> I could change it so that REGULATOR_MODE_NORMAL maps to LDO HPM mode.
> However, doing so would make it so that REGULATOR_MODE_FAST requests would
> fail for LDOs.  Thus, consumers would need to know if their supply is an
> LDO or an SMPS (which seems undesirable).

You've just discovered why it's a bad idea for consumers to do anything
with modes directly!  The mappings are just never going to be consistent
given the massive variation in what regulators can support, the
retention mode of one regulator might be able to deliver more power than
the normal mode of another.

> Would it be acceptable to have both NORMAL and FAST map to LDO HPM?

Having something other than a 1:1 mapping is going to lead to pain at
some point.

> >> +static unsigned int rpmh_regulator_pmic4_ldo_of_map_mode(unsigned int mode)
> >> +{
> >> +	static const unsigned int of_mode_map[RPMH_REGULATOR_MODE_COUNT] = {
> >> +		[RPMH_REGULATOR_MODE_RET]  = REGULATOR_MODE_STANDBY,
> >> +		[RPMH_REGULATOR_MODE_LPM]  = REGULATOR_MODE_IDLE,
> >> +		[RPMH_REGULATOR_MODE_AUTO] = REGULATOR_MODE_INVALID,
> >> +		[RPMH_REGULATOR_MODE_HPM]  = REGULATOR_MODE_FAST,
> >> +	};

> > Same here, based on that it looks like auto mode is a good map for
> > normal.

> LDO type regulators physically do not support AUTO mode.  That is why I
> specified REGULATOR_MODE_INVALID in the mapping.

The other question here is why this is even in the table if it's not
valid (I'm not seeing a need for the MODE_COUNT define)?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180712/aa913186/attachment.sig>
