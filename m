From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 7 Mar 2013 08:22:03 +0100
Subject: [PATCH 00/23] RFC: exynos multiplatform support
In-Reply-To: <201303070302.46593.arnd@arndb.de>
References: <1362505353-8873-1-git-send-email-arnd@arndb.de>
 <201303061050.42451.arnd@arndb.de>
 <20130306123426.GB17079@avionic-0098.mockup.avionic-design.de>
 <201303070302.46593.arnd@arndb.de>
Message-ID: <20130307072203.GC3451@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 03:02:46AM +0000, Arnd Bergmann wrote:
> On Wednesday 06 March 2013, Thierry Reding wrote:
> > > Option 2 would probably come down to having a trivial MFD driver exposing
> > > a regmap. You can probably reuse drivers/mfd/syscon.c for this and make
> > > the node compatible with "syscon" to designate the clock registers as
> > > a system-wide resource, making the other device nodes register-less.
> > 
> > I think option 2 is the standard method if one hardware block provides
> > several logical devices. I find it to be a pretty nice solution to this
> > problem. We also have precedent in the PWM subsystem. The TWL chips for
> > instance use it to create a platform device which is later driven by a
> > PWM driver.
> 
> One difference though is that the TWL chip is a heterogenous MFD that has
> a lot of different sub-devices, where in case of Exynos the timer device
> has a set of identical units, each of which can be used either as a PWM or
> as a clocksource or other timer.

I didn't know that. However I still making this an MFD driver is a good
fit because it'll move the logic of defining the mode of each unit is
kept in a parent driver which can instantiate the proper child devices
for the corresponding subsystems.

One big disadvantage of this approach is that if this is continued there
is a risk that MFD will turn into a dump for all kinds of devices that
provide more than a single service.

So if people prefer option 3 I'm fine with it as well.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130307/44a92c5e/attachment.sig>
