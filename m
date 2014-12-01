From: broonie@kernel.org (Mark Brown)
Date: Mon, 1 Dec 2014 16:12:19 +0000
Subject: [PATCH v2 3/8] regulator: MT6397: Add support for MT6397 regulator
In-Reply-To: <1417402305.30873.78.camel@mtksdaap41>
References: <1417146874-5232-1-git-send-email-flora.fu@mediatek.com>
 <1417146874-5232-4-git-send-email-flora.fu@mediatek.com>
 <20141128152247.GR7712@sirena.org.uk>
 <1417402305.30873.78.camel@mtksdaap41>
Message-ID: <20141201161219.GG7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 01, 2014 at 10:51:44AM +0800, Flora Fu wrote:
> On Fri, 2014-11-28 at 15:22 +0000, Mark Brown wrote:

> > Why does nothing else in the driver know about this "hw control mode" -
> > what does it actually mean, shouldn't it affect some of the other
> > operations?

> In the regulator, we have two parts of registers to control the output
> in voltage selection. The mode setting is done in boot loader stage
> before kernel.

> The hw control mode is used for external signal to control voltage
> selection. When the hw control mode is chosen, "voselon" register is the
> action register to do voltage selection if consumer make voltage
> selection. Without hw control mode, vsel_reg is the action register.
> To fit all mode selection, we update and sync two parts of registers in
> regulator framework.

There must be more going on in hardware control mode than that, for
example this "external signal to control voltage selection" must be able
to pick between at least different voltages otherwise it wouldn't seem
to make sense.  I'm concerned that this implementation is making some
assumption about the way in which the hardware control is being used in
a particular system and will be broken in other systems, for example if
something does start actively trying to vary the voltage.

> > > +static int mt6397_buck_get_voltage_sel(struct regulator_dev *rdev)
> > > +{

> > > +static int mt6397_regulator_is_enabled(struct regulator_dev *rdev)
> > > +{

> > To repeat my comments on the last version: please use the generic regmap
> > operations rather than copying them.

> The generic helper function does not fit usage of the regulator. 
> In general function, it considers that the vsel_reg for selection
> voltage is also the register for querying voltage selection. The enable
> bit for enable function is the bit for querying the status. 

> In the hardware design, the output of voltage selection register is
> different from vsel_reg. Is is located in nivosel. The enable bit is
> locate in the other bit called "qi_mask".  

Since you've currently got a custom set voltage function there's no
reason not to use this as the register that gets passed to the core and
hence to use the generic operation.  However I am a bit concerned about
this - what is this actually reporting?  Is it just something that
switches between the hardware and software control voltage automatically
or is it doing some kind of measurment of the output and reporting that?
The general idea is that get_voltage() should report the configured
voltage, monitoring of performance should be done via hwmon or similar.

Similarly for the enable state; we're looking for the state requested by
software not the current state of the regulator - that should be
reported via get_status() for use in error handling cases.

> > > +	np = of_node_get(pdev->dev.parent->of_node);
> > > +	if (!np)
> > > +		return -EINVAL;

> > > +	regulators = of_get_child_by_name(np, "regulators");

> > To further repeat my

> >  previous review comments:

> > | Define regulators_node and of_match in the regulator desc and you can
> > | remove both this table and all your DT matching code in the driver, the
> > | core will handle it for you.

> > Please don't ignore review comments.

> Sure, I think I completely misunderstood what you meant. Could you give
> more details about the comments?
> In this version, the table for DT matching is removed and merged into
> regulator info in table mt6397_regulators. To register every regulator
> by devm_regulator_register(), the of_node is parsed from
> of_regulator_match() by name. Here is to retrieves the device_node
> "regulators" for of_regulator_match() to get all regulator_init_data and
> corresponding of_node.
> Is any other mechanism I can use to achieve these part without
> of_regulstor_match()?

What I'm understanding from the above is that the code currently only
registers regulators that are listed in DT (I've not read it in detail).
This is not what should be happening, the driver should always register
all the regulators for the device regardless of if they are mentioned in
a DT somewhere.  That way people can read what's currently set in the
hardware which is useful for bringup and diagnostics.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141201/839f1e0f/attachment.sig>
