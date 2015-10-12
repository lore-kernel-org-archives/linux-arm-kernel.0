From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 12 Oct 2015 13:42:59 +0200
Subject: [PATCH 4/6] regulator: core: Propagate voltage changes to supply
 regulators
In-Reply-To: <20151002173256.GZ12635@sirena.org.uk>
References: <1443621946-8712-1-git-send-email-s.hauer@pengutronix.de>
 <1443621946-8712-5-git-send-email-s.hauer@pengutronix.de>
 <20151002173256.GZ12635@sirena.org.uk>
Message-ID: <20151012114259.GU7858@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Fri, Oct 02, 2015 at 06:32:56PM +0100, Mark Brown wrote:
> On Wed, Sep 30, 2015 at 04:05:44PM +0200, Sascha Hauer wrote:
> 
> > A new min_dropout_uv field is added to struct regulator_desc. Regulators
> > can specify the minimun dropout voltage they need for proper function
> > here. Now when the voltage is changed on a regulator the regulator core
> > makes sure that
> 
> Can we have this interface addition as a separate patch please?  Makes
> it easier to add to other devices.  I could've sworn I'd already done
> that bit but obviously never got the patch mailed out.
> 
> One change I think we need here is only doing the propagation if either
> the device lacks a set_voltage() operation (in which case it's just a
> switch passing through the parent voltage)

Does the lack of a set_voltage() operation automatically mean it's a
switch passing through the parent voltage? What if the regulator is a
fixed regulator and the output can't be controlled because there is only
one voltage?

Currently we bail out int regulator_set_voltage() when we do not have a
set_voltage() or set_voltage_sel() operation. Instead of propagating the
voltage change up I would keep the current behaviour and implement voltage
propagation for switches when we need it. Then we could also introduce a
REGULATOR_IS_SWITCH flag indicating that this is a switch and not a
fixed voltage regulator.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
