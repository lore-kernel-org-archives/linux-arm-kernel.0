From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Jun 2012 14:18:58 +0000
Subject: [PATCH 1/3] mfd: support 88pm80x in 80x driver
In-Reply-To: <CAN1soZwwWhNC2pQjwYz-jUjNrnnPfshyPQJL-8uM6z6BKvCwMA@mail.gmail.com>
References: <1340853214-5429-1-git-send-email-zhouqiao@marvell.com>
 <201206281432.24061.arnd@arndb.de>
 <CAN1soZwwWhNC2pQjwYz-jUjNrnnPfshyPQJL-8uM6z6BKvCwMA@mail.gmail.com>
Message-ID: <201206291418.59108.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 June 2012, Haojian Zhuang wrote:
> On Thu, Jun 28, 2012 at 10:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 28 June 2012, Mark Brown wrote:
> >> Show Details
> >>   On Thu, Jun 28, 2012 at 11:21:56AM +0000, Arnd Bergmann wrote:
> >>
> >> > What platform is this driver for?
> >> >  - If it's for an existing platform that does not have DT support, please
> >> >    include the platform changes for that platform so we can see what gets
> >> >    done in there.
> >>
> >> This is really not normal practice for device drivers, it'd be a serious
> >> obstacle to getting drivers integrated if we have to have a board merged
> >> with every driver.
> >
> > But it would be very helpful to see how the platform data is set, especially
> > with the callback. If the callback is just there to set up a regulator
> > or clock, then it should be changed to a more generic way.
> 
> No, the callbacks is not used to set up a regulator or clock. They're used to
> configure the logic that are not integrated into drivers yet. For example, one
> special regulator needs active in sleep mode; some power saving configuration
> with board; accessing special register for fuse or OTP, .... Could we set up
> milestones for this? I agree that we need to move to DT support. But we have
> the interface of OF_DEV_AUXDATA in machine driver. We can use them to
> deliver platform data even with callback into drivers.

Yes, this is complex enough that using auxdata sounds like the right approach
in this case for now, thanks for the explanation.

> By the way, this PMIC is installed on new platforms that are not
> submitted patches
> into mainline yet. They're used and verified in internal code without
> DT support. The
> plan is submitting PMIC pathces before the new platform. If we only
> support DT, we
> can't verify these code.

Well, as long as no platform in the mainline kernel supports this driver,
it does not matter the upstream maintainers whether the code has been
verified. The more important question is whether it is done the right way.

My usual recommendation for cases like this is to submit the driver in the
way it would be written if all the other code using it was already perfect.
In your internal verification, you already carry patches to add the new
platform support, so you can add more patches to work around missing parts
of the driver, like adding back the platform_data. What is more important
for you is that you get as much as possible upstream in a version that has
been reviewed and acked by the relevant maintainers.

I guess it's ok here to leave the platform data in for now, as it sounds
that it can take a longer time (if ever) to fully eliminate it. However,
I think it would be nice to also add preliminary DT bindings for the
things that can be DT properties.


 	Arnd
