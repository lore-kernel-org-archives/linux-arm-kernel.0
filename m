From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 5 Jun 2014 16:27:29 +0200
Subject: [PATCH 3/5] regulator: axp20x: Update the bindings to use a
 local parent regulator
In-Reply-To: <20140603144319.GD31751@sirena.org.uk>
References: <1401297069-7423-1-git-send-email-maxime.ripard@free-electrons.com>
 <1401297069-7423-4-git-send-email-maxime.ripard@free-electrons.com>
 <20140528185051.GB22488@sirena.org.uk>
 <20140603131204.GJ27722@lukather>
 <20140603144319.GD31751@sirena.org.uk>
Message-ID: <20140605142729.GG5765@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 03, 2014 at 03:43:19PM +0100, Mark Brown wrote:
> On Tue, Jun 03, 2014 at 03:12:04PM +0200, Maxime Ripard wrote:
> > On Wed, May 28, 2014 at 07:50:51PM +0100, Mark Brown wrote:
> > > On Wed, May 28, 2014 at 07:11:07PM +0200, Maxime Ripard wrote:
> 
> > > >  		axp_mic_reg: ldo5 {
> > > > +			vin-supply = <&axp_ipsout_reg>;
> 
> > > This is saying that every single regulator on the device is powered by a
> > > (presumably) single input called "vin".  This would certainly be an
> > > unusual package design...  As ever the name of the supply should follow
> > > the name of the pin on the device.
> 
> > Not exactly. Each regulator has its own input pin, named
> > <regulator_name>in in the schematics, with the exception of LDO2 and
> > LDO4 that share the same pin.
> 
> OK, so the supplies should be called <regulator_name>in then not vin.

Which they already do. So I guess we don't have to change the bindings
after all. One last thing I fail to understand though, is why do we
need to have that duplication of the informations between the mfd
driver and the regulator one.

You already list the regulators available and their supply in the
regulator driver, why do you need to set the regulator parents in the
mfd driver as well?

My guess is that it's to work around the fact that
regulator_dev_lookup only looks for the regulator's device of_node (so
not the PMIC one, but one of its child), which doesn't have the supply
properties, and then just falls back on the regulator alias
list. Would it make some sense to add a lookup in the parent device
of_node (which would be the "main" PMIC node in our case)?

Also, there's also the fact that all the supply properties seems to
also be mandatory in the DT, even though the regulator itself might
not be used at all on the board, and the input voltage not wired to
anything.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140605/d2ca14ff/attachment.sig>
