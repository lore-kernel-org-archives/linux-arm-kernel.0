From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 28 Mar 2017 15:39:41 +0300
Subject: [RFC 4/8] regulator: core: Check enabling bypass respects
 constraints
In-Reply-To: <20170324125212.vikgekqxsnu7htzl@sirena.org.uk>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
 <1edff9bc610969b0c53fa1080d5db021c8e00b2d.1490199005.git.leonard.crestez@nxp.com>
 <20170324125212.vikgekqxsnu7htzl@sirena.org.uk>
Message-ID: <1490704781.3546.57.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-03-24 at 12:52 +0000, Mark Brown wrote:
> On Wed, Mar 22, 2017 at 06:53:06PM +0200, Leonard Crestez wrote:
> 
> > 
> > Enabling bypass mode makes a regulator passthrough the supply voltage
> > directly. It is possible that the supply voltage is set high enough that
> > it violates machine constraints so let's check for that.
> > 
> > The supply voltage might be higher because of min_dropout_uV or maybe
> > there is just an unrelated consumer who requested a higher voltage.
> I would expect that if bypass is enabled then the constraints on the
> parent regulator would be set appropriately to support this, I wouldn't
> expect that we'd try to apply the operating constraints of the regulator
> to the supply.??Usually bypass is used for low power retention modes
> with different settings to those used in normal operation that wouldn't
> be desired in normal operation, if we were going to have constraints for
> this I'd expect a separate set used during bypass.

In this particular case it's not possible to set constraints on the parent
regulator so that both ldo-enable and ldo-bypass modes work. The maximum allowed
voltage for ldo-bypass is lower than the minimum required to support the chip at
max frequency wit ldo-enable.

It would be possible to also change the constraint values on the PMIC together
with ldo-bypass in the .dts files but that seems awful.

I'm not sure I understand why you are against applying constraints to the parent
when in bypass mode, it seems like the obvious thing to do if you want to
support flexible configuration. The check I introduced is probably not enough to
cover all cases, for example it would still be possible to explicitly change
parent voltage afterwards.

A regulator_dev registers a consumer for the supply. Right now this is being
used to propagate minimum voltages upwards since commit fc42112c0eaa ("Propagate
voltage changes to supply regulators"). It seems to me like it would be
reasonable to also use it to propagate maximum voltage from constraints, right?

Instead of asking for [best_uV + min_dropout_uV, INT_MAX] it could instead ask
for [min_uV + bypass ? min_dropout_uV : 0, min(max_uV, constraints->max_uV)].
The _regulator_do_set_voltage call on the supply can deal with stuff like
mapping it to a selector, just like it does for regulator consumers.

If more elaborate constraints are required instead of this simple behavior it
could be handled by?adding an interface for drivers to expose explicit dynamic
min/max constraints.

--
Regards,
Leonard
