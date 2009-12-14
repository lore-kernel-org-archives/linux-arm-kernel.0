From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Mon, 14 Dec 2009 11:59:32 +0100
Subject: [PATCH 4/4] regulator: mc13783 change to platform_driver_register.
In-Reply-To: <20091213200509.GD14024@pengutronix.de>
References: <1260635829.2054.16.camel@climbing-alby>
	<1260636523.2054.28.camel@climbing-alby>
	<1260636819.2054.33.camel@climbing-alby>
	<1260636976.2054.36.camel@climbing-alby>
	<1260637577.2054.43.camel@climbing-alby>
	<20091213200509.GD14024@pengutronix.de>
Message-ID: <1260788372.2022.73.camel@climbing-alby>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il giorno dom, 13/12/2009 alle 21.05 +0100, Uwe Kleine-K?nig ha scritto:
> Hello,
> 
> On Sat, Dec 12, 2009 at 06:06:17PM +0100, Alberto Panizzo wrote:
> > Change the instant when regulator driver is probed. 
> > To have a correct regulators initialisation (enable, disable and voltages 
> > selection), the driver must have access to mc13783 registers and so 
> > mc13783-core must be loaded before this.
> > 
> > With this patch mc13783_regulator_probe is called when mc13783-core
> > register the regulator subsystem.
> > 
> > Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
> I think the change is OK, the commit log isn't optimal though.
> 
> You might want to point out that the problem only occurs if the driver
> is built-in and that mc13783_regulator_probe doesn't need to be changed
> as it already lives in .devinit.text
> 

My problem is a not great knowledge of different types of initcall, I 
have to improve myself in this! 

> As if mc13783-regulator is built-in mc13783-core is built-in, too, the
> wording isn't good.  The problem is (I suppose) that regulators are
> linked first and so mc13783-core isn't *probed* early enough and so the
> mc13783-regulator device isn't available at mc13783-regulator probing
> time.

This is the problem. As I understand subsystem_initcall it is the function
called by the system when that subsystem is initialised.
Because of mc13783-regulator is in the regulator subsystem it is called very 
early in the boot process (regulators are meant to be initialised in a very
early phase).

The way that mc13783-regulator's subsystem_initcall call mc13783_regulator_probe
is correct, is only if mc13783-regulator is a subsystem of mc13783-core (mfd?).


Thanks all for reviewing!

Best regards.
Alberto!
