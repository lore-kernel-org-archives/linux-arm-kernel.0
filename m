From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 21 Oct 2013 12:24:49 +0200
Subject: ARM topic: Is DT on ARM the solution, or is there something
 better?
In-Reply-To: <20131021095757.GY25034@n2100.arm.linux.org.uk>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020231134.GR25034@n2100.arm.linux.org.uk>
 <20131021083242.GB30088@pengutronix.de>
 <20131021084854.GV25034@n2100.arm.linux.org.uk>
 <20131021092730.GF30088@pengutronix.de>
 <20131021095757.GY25034@n2100.arm.linux.org.uk>
Message-ID: <20131021102448.GD21518@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 21, 2013 at 10:57:57AM +0100, Russell King - ARM Linux wrote:
> On Mon, Oct 21, 2013 at 11:27:30AM +0200, Sascha Hauer wrote:
> > If you have a better vision how imx-drm can be implemented without
> > getting crazy I'd love to hear about it. Please also think about the two
> > IPUs the i.MX6 has, the single one on i.MX5, parallel displays, HDMI
> > displays, LVDS displays, VGA encoder on i.MX53, external I2C slave
> > encoders,...
> 
> Well, the multi-driver solution is just too fragile: the problem
> with it is you can never be sure when all the drivers have definitely
> finished initialising.  This problem is made much worse should one of
> them use deferred probing.
> 
> To put it another way - with a multi-driver solution, there is no
> definite point you can say "okay, we got everything".
> 
> So, as long as a subsystem contains something that needs to be done
> once everything is known (such as initialising the fb_helper), there
> is a fundamental disconnect between a multi-driver solution and the
> subsystem.  To put it another way, a multi-driver solution should
> not be used.

Multi-driver with DRM has worked pretty well for Tegra. Essentially what
I created was a sort of abstraction layer between DRM and the individual
drivers so that each driver can register itself with that layer. Once it
has been determined that all drivers have been probed, that glue layer
can load the DRM driver and call back into the sub-drivers to register
their respective components with DRM.

That even works fairly nicely with deferred probing. Note that the code
currently in Linus' tree has some issues, but I've reworked it since in
linux-next and the final result isn't all that bad. I've even attempted
to make it somewhat generic so that it could potentially be reused by
other drivers. It's not reusable as-is, but perhaps it can be further
improved.

I agree that hotpluggability within DRM might have made things easier,
but it would likely also have made the core more complex. Furthermore
there simply was no need for DRM to provide that kind of flexibility,
simple because no driver has had that need so far. Quite a few ARM SoC
drivers have appeared lately, and hopefully that'll provide more of an
incentive to evolve DRM as needed, but I don't think we can hold it
against anyone that they haven't provided us with the ideal subsystem.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131021/fa70d69c/attachment.sig>
