From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 8 Apr 2015 18:23:44 +0100
Subject: [PATCH v6 4/4] clk: dt: Introduce binding for always-on clock
 support
In-Reply-To: <20150408155705.GF26727@lukather>
References: <1428432239-4114-1-git-send-email-lee.jones@linaro.org>
 <1428432239-4114-5-git-send-email-lee.jones@linaro.org>
 <20150407191746.GA26727@lukather> <20150408081450.GB5162@x1>
 <20150408094349.GC26727@lukather> <20150408103832.GG5162@x1>
 <20150408155705.GF26727@lukather>
Message-ID: <20150408172344.GH5162@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 08 Apr 2015, Maxime Ripard wrote:

> On Wed, Apr 08, 2015 at 11:38:32AM +0100, Lee Jones wrote:
> > On Wed, 08 Apr 2015, Maxime Ripard wrote:
> > 
> > > On Wed, Apr 08, 2015 at 09:14:50AM +0100, Lee Jones wrote:
> > > > > > +
> > > > > > +		    This property is not to be abused.  It is only to be used to
> > > > > > +		    protect platforms from being crippled by gated clocks, not
> > > > > > +		    as a convenience function to avoid using the framework
> > > > > > +		    correctly inside device drivers.
> > > > > 
> > > > > Disregarding what's stated here, I'm pretty sure that this will
> > > > > actually happen. Where do you place the cursor?
> > > > 
> > > > That's up to Mike.
> > > 
> > > Except that Mike won't review any of the DT changes, so he won't be
> > > able to refrain users from using it. Let alone out-of-tree DTs using a
> > > mainline kernel.
> > 
> > Ideally Mike should be Cc'ed on patches using clock bindings, but if
> > he isn't the DT guys are smart enough to either make the right
> > decisions themselves (Rob has Acked these bindings already, so will be
> > on the lookout for misuse, I'm sure), or ask for Mike's help.
> 
> Yeah, right, as if this strategy really worked in the past....
> 
> Do we really want to look at even the DT bindings that have actually
> been reviewed by maintainers that got merged?
> 
> They don't have time for that, which is totally fine, but we really
> should bury our head in the sand by actually thinking they will review
> every single DT-related patch.
> 
> Using that as an argument is just plain denial of what really happened
> for the past 4 years.

I agree that it's a problem, but this is a process problem and has
nothing to do with this set.  If you have a problem with the current
process and have a better alternative, submit your thoughts to the DT
list.  Rejecting all new bindings because you are frightened that they
will be used in a manner that they were not intended is not the way to
go though.

> > > > > Should we create a new driver for our RAM controller, or do we want to
> > > > > use clock-always-on?
> > > > 
> > > > I would say that if all the driver did was to enable clocks, then you
> > > > should use this instead.  This binding was designed specifically for
> > > > that purpose.
> > > > 
> > > > However, if the aforementioned driver clock can be safely gated, then
> > > > it should not be an always-on clock.
> > > 
> > > Yeah, of course, I understand the original intent of it, but that
> > > argument, which might very well be true at one point in time, might
> > > not be true anymore two or three releases later.
> > 
> > Why?  The H/W isn't going to change in two or three releases.  The
> > clocks designated as 'always-on' will have to be on forever, or
> > synonymously, 'always'.
> >
> > > And that driver might actually rely on the fact that the clock is shut
> > > down, which won't be the case.
> > 
> > I think you are missing the point of this binding.  The driver can
> > never rely on that in this use-case.  If the clock is off, there is no
> > device driver, period. 
> 
> Ok. So CPU hotplug or cpuidle is not a thing then? I'm pretty sure the
> PM guys will be happy to hear that.
> 
> And they are not device drivers, are not mandatory in the system, and
> it's usually a good thing to keep the CPU running whenever you don't
> have such drivers.
> 
> > > Introducing a DT interface solely by refering to the current state of
> > > a driver is a bit odd.
> > 
> > I'm not sure I get your point.  This binding has nothing to do with
> > drivers.
> 
> It's all about drivers. Or rather all about missing drivers.

I think you are going to have to be more forthcoming with your issues
with this binding, because I'm struggling to understand what your
problem with it is.  You have already pointed me to vendors which have
a genuine/valid need for it.  But instead you'd prefer they hand-roll
their own implementations over multiple lines of C code (each).

IMHO, that's madness.

> > > > > Do we really want to enforce this if we ever gain a driver that would
> > > > > actually be able to manage its clock (like do we want the CPU clock to
> > > > > never *ever* be gated just because we don't have a cpuidle/hotplug
> > > > > driver yet?)
> > > > 
> > > > As I've just mentioned, if a clock 'can' be turned off, this binding
> > > > should never be used. Situations where using always-on as a stop-gap
> > > > due to a lack of current functionality is what the paragraph above is
> > > > trying to mitigate.
> > > 
> > > But it's not really what this property is about. What this property
> > > describes is that these clocks should never be gated. Any point in
> > > time during the life of the system AND with in any kernel version.
> > 
> > You got it, that's correct -- these clocks should never be gated.
> > 
> > So why would that ever change?  If that is likely (or even possible)
> > to change in the future then this binding should not be used.
> >
> > To reiterate; this binding should be used on ungatable clocks only.
> > Non-negotiable, non-changeable either by the introduction of new
> > functionality/support or kernel version.
> 
> I'm pretty sure that if that patch gets merged, by the end of the
> year, there will be "incorrect" users by your standards.

It's possible to abuse any binding.  I don't see why you are so
offended of this one in particular.

> If you introduce a feature, you should expect people to use
> it.  If not, what's the point?

By your own admission, there are genuine users for this binding and I
expect people to use it.

> > > > > Have you seen the numerous NAK on such approach Mike did?
> > > > 
> > > > I haven't, but the folks reviewing previous versions have.  Do you
> > > > have something specific in mind that you'd like to bring to my
> > > > attention?
> > > 
> > > Unfortunately, I haven't been able to dig out such mails. But it's why
> > > we ended up with clock protection code in various clock drivers
> > > including:
> > > 
> > > AT91: http://lxr.free-electrons.com/source/drivers/clk/at91/clk-slow.c#L484
> > > iMX28: http://lxr.free-electrons.com/source/drivers/clk/mxs/clk-imx28.c#L154
> > > Rockchip: http://lxr.free-electrons.com/source/drivers/clk/rockchip/clk.c#L320
> > > sunXi: http://lxr.free-electrons.com/source/drivers/clk/sunxi/clk-sunxi.c#L1183
> > > Zynq: http://lxr.free-electrons.com/source/drivers/clk/zynq/clkc.c#L504
> > > 
> > > Which is much more flexible, since you won't have to modify the DT to
> > > change which clocks are to be left enabled, as well as way easier to
> > > debug if you ever have to remove that property from the DT.
> > 
> > You're right, you don't have the change the DT in these cases.  You
> > have to write new C code, which is _less_ flexible.
> 
> I'm sorry to learn that you never heard of that stable-DT thing.
> 
> And a bit sorry to see that a maintainer is really seeing C as not
> flexible.

You're putting words in my mouth.  I didn't say C was not flexible.

I'm referencing the original DT pros i.e. it is possible to supply a
different configuration without the need to compile the kernel.
That's certainly true in this case.  We can provide a clk-provider and
tag it as always-on, all without re-compile.

> > So all these platforms are adding their own hand-rolled version of
> > this binding, adding more duplication and cruft to the kernel.
> > Instead they can use this 'always-on' and we can consolidate and strip
> > it all out.
> 
> Except that all these platforms are actually not implementing a
> binding, ie not an interface with the DT they are bound to. Each and
> every of these platforms can change that list whenever they wish, just
> by sending a single one-liner patch (just like the DT, really.).
> 
> Which is not something that you can achieve with a DT binding.

Once again, can you give me more information about why you have such a
problem with this binding.  I wish for it to be stable/ABI, I wish for
it never to be removed, I envisage it will always be needed, so what's
the problem? 

Do you have a vested interest that I am missing?

Perhaps an example of possible calamity will help convince me that
you're not completely wrong and blowing everything out of proportion
for no good reason.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
