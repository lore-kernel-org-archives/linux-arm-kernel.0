From: broonie@kernel.org (Mark Brown)
Date: Fri, 21 Nov 2014 10:16:15 +0000
Subject: [PATCH 3/7] regulator: MT6397: Add support for MT6397 regulator
In-Reply-To: <1416553771.19764.51.camel@mtksdaap41>
References: <1416210027-5562-1-git-send-email-flora.fu@mediatek.com>
 <1416210027-5562-4-git-send-email-flora.fu@mediatek.com>
 <20141117234012.GE22111@sirena.org.uk>
 <1416553771.19764.51.camel@mtksdaap41>
Message-ID: <20141121101615.GP3815@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 03:09:31PM +0800, Flora Fu wrote:
> On Mon, 2014-11-17 at 23:40 +0000, Mark Brown wrote:

> > > +	vosel = info->buck_conf.vosel_reg;
> > > +	voselon = info->buck_conf.voselon_reg;
> > > +	vosel_mask = info->buck_conf.vosel_mask;

> > Please use the standard way of specifying data even if you can't use the
> > standard function.

> Could you specify the standard way of specification data? Thanks. 

Using the fields in the regulator_desc as you can see from the standard
helpers.

> > You should add comments here explaining what's going on - it's very
> > strange to have to write the same value to two different registers and
> > the names of the registers look suspiciously like this is something to do
> > with a suspend mode...

> Yes, its is for suspend mode control usage.
> For registers "vosel", "voselon", they is called register mode or
> hardware control mode voltage settings. Register mode is a default mode
> on the buck control. For quickly normal/sleep mode switch, hardware
> control can be enabled by controlling buck output by a CTRL_PIN. In the
> following diagram, there is a static settings on vosel_sleep for suspend
> mode output. According to CTRL_PIN's level, Vout can have different
> output (voselon or vosel_sleep). 

You need to represent this in your driver, the sleep mode controls
should either be controlled using the suspend API or the GPIO control
needs to be visible in the driver.  It's also OK to ignore the GPIO
control for now and do it later if complex work is needed to represent
it in the driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141121/7832427b/attachment.sig>
