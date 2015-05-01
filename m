From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 1 May 2015 07:34:06 +0200
Subject: [PATCH v6 4/4] clk: dt: Introduce binding for always-on clock
 support
In-Reply-To: <20150430095722.GB1815@x1>
References: <20150407191746.GA26727@lukather> <20150408081450.GB5162@x1>
 <20150408094349.GC26727@lukather> <20150408103832.GG5162@x1>
 <20150408155705.GF26727@lukather> <20150408172344.GH5162@x1>
 <20150422093446.GA28007@lukather> <20150429141751.GR9169@x1>
 <20150429202332.GG6062@lukather> <20150430095722.GB1815@x1>
Message-ID: <20150501053406.GI4946@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 10:57:22AM +0100, Lee Jones wrote:
> On Wed, 29 Apr 2015, Maxime Ripard wrote:
> 
> > On Wed, Apr 29, 2015 at 03:17:51PM +0100, Lee Jones wrote:
> > > On Wed, 22 Apr 2015, Maxime Ripard wrote:
> > > 
> > > > On Wed, Apr 08, 2015 at 06:23:44PM +0100, Lee Jones wrote:
> > > > > On Wed, 08 Apr 2015, Maxime Ripard wrote:
> > > > > 
> > > > > > On Wed, Apr 08, 2015 at 11:38:32AM +0100, Lee Jones wrote:
> > > > > > > On Wed, 08 Apr 2015, Maxime Ripard wrote:
> > > > > > > 
> > > > > > > > On Wed, Apr 08, 2015 at 09:14:50AM +0100, Lee Jones wrote:
> > > > > > > > > > > +
> > > > > > > > > > > +		    This property is not to be abused.  It is only to be used to
> > > > > > > > > > > +		    protect platforms from being crippled by gated clocks, not
> > > > > > > > > > > +		    as a convenience function to avoid using the framework
> > > > > > > > > > > +		    correctly inside device drivers.
> > > > > > > > > > 
> > > > > > > > > > Disregarding what's stated here, I'm pretty sure that this will
> > > > > > > > > > actually happen. Where do you place the cursor?
> > > > > > > > > 
> > > > > > > > > That's up to Mike.
> > > > > > > > 
> > > > > > > > Except that Mike won't review any of the DT changes, so he won't be
> > > > > > > > able to refrain users from using it. Let alone out-of-tree DTs using a
> > > > > > > > mainline kernel.
> > > > > > > 
> > > > > > > Ideally Mike should be Cc'ed on patches using clock bindings, but if
> > > > > > > he isn't the DT guys are smart enough to either make the right
> > > > > > > decisions themselves (Rob has Acked these bindings already, so will be
> > > > > > > on the lookout for misuse, I'm sure), or ask for Mike's help.
> > > > > > 
> > > > > > Yeah, right, as if this strategy really worked in the past....
> > > > > > 
> > > > > > Do we really want to look at even the DT bindings that have actually
> > > > > > been reviewed by maintainers that got merged?
> > > > > > 
> > > > > > They don't have time for that, which is totally fine, but we really
> > > > > > should bury our head in the sand by actually thinking they will review
> > > > > > every single DT-related patch.
> > > > > > 
> > > > > > Using that as an argument is just plain denial of what really happened
> > > > > > for the past 4 years.
> > > > > 
> > > > > I agree that it's a problem, but this is a process problem and has
> > > > > nothing to do with this set.  If you have a problem with the current
> > > > > process and have a better alternative, submit your thoughts to the DT
> > > > > list.  Rejecting all new bindings because you are frightened that they
> > > > > will be used in a manner that they were not intended is not the way to
> > > > > go though.
> > > > 
> > > > I'm not saying that this binding should not go in because of a process
> > > > issue.
> > > > 
> > > > I'm saying that discarding arguments against your binding by adding
> > > > restrictions that cannot be enforced is not reasonable.
> > > 
> > > I'm open to constructive suggestions/alternatives.
> > > 
> > > Hand rolling this stuff in C per vendor is not of of them.
> > 
> > I'm sorry, but ruling out alternatives that work for everyone (and
> > actually work better) just because you don't want to edit a C file is
> > not really constructive either.
> > 
> > > > > > > > > > Should we create a new driver for our RAM controller, or do we want to
> > > > > > > > > > use clock-always-on?
> > > > > > > > > 
> > > > > > > > > I would say that if all the driver did was to enable clocks, then you
> > > > > > > > > should use this instead.  This binding was designed specifically for
> > > > > > > > > that purpose.
> > > > > > > > > 
> > > > > > > > > However, if the aforementioned driver clock can be safely gated, then
> > > > > > > > > it should not be an always-on clock.
> > > > > > > > 
> > > > > > > > Yeah, of course, I understand the original intent of it, but that
> > > > > > > > argument, which might very well be true at one point in time, might
> > > > > > > > not be true anymore two or three releases later.
> > > > > > > 
> > > > > > > Why?  The H/W isn't going to change in two or three releases.  The
> > > > > > > clocks designated as 'always-on' will have to be on forever, or
> > > > > > > synonymously, 'always'.
> > > > > > >
> > > > > > > > And that driver might actually rely on the fact that the clock is shut
> > > > > > > > down, which won't be the case.
> > > > > > > 
> > > > > > > I think you are missing the point of this binding.  The driver can
> > > > > > > never rely on that in this use-case.  If the clock is off, there is no
> > > > > > > device driver, period. 
> > > > > > 
> > > > > > Ok. So CPU hotplug or cpuidle is not a thing then? I'm pretty sure the
> > > > > > PM guys will be happy to hear that.
> > > > > > 
> > > > > > And they are not device drivers, are not mandatory in the system, and
> > > > > > it's usually a good thing to keep the CPU running whenever you don't
> > > > > > have such drivers.
> > > > > > 
> > > > > > > > Introducing a DT interface solely by refering to the current state of
> > > > > > > > a driver is a bit odd.
> > > > > > > 
> > > > > > > I'm not sure I get your point.  This binding has nothing to do with
> > > > > > > drivers.
> > > > > > 
> > > > > > It's all about drivers. Or rather all about missing drivers.
> > > > > 
> > > > > I think you are going to have to be more forthcoming with your issues
> > > > > with this binding, because I'm struggling to understand what your
> > > > > problem with it is.  You have already pointed me to vendors which have
> > > > > a genuine/valid need for it.  But instead you'd prefer they hand-roll
> > > > > their own implementations over multiple lines of C code (each).
> > > > 
> > > > I told you already.
> > > > 
> > > > If you have that property, there's absolutely no way to do any kind of
> > > > clock management in the future.
> > > > 
> > > > It might be fine for your use case, but see my point about the
> > > > unreasonable restriction. People are going to use it for clocks that
> > > > just don't have a driver *yet*, and when that driver will be merged we
> > > > will end up with a driver that (for example) makes the assumption that
> > > > the clock has been shut down to reset the IP, that might or might not
> > > > be the case, depending on how old the DT is exactly.
> > > 
> > > There is a need for this binding,
> > 
> > That's your opinion. Several people already disagreed on this.
> > 
> > Now, what we probably need is a generic way to flag the clocks as
> > supposed to be enabled. The fact that this information should be in
> > the DT is a different story.
> > 
> > > but as you say, it must not be abused.  So how to we get people not
> > > to use it willy-nilly?
> > > 
> > > IMO, if people choose to ignore the stark warning in the documentation
> > > then that's they're lookout.  I guess you'd like to wrap them in more
> > > cotton wool than I would.  That's fine too, but how.
> > 
> > You've chosen to ignore all our warnings. Fine. Assume that other
> > people will ignore yours.
> > 
> > This is not about whatever you put in the documentation or checkpatch,
> > there will be people and/or maintainers that will go against that.
> > 
> > The only way to prevent any abuse of the binding, is not to have any
> > binding, really.
> > 
> > > > This will be even a bigger madness if you ask me.
> > > > 
> > > > > > > > > > Do we really want to enforce this if we ever gain a driver that would
> > > > > > > > > > actually be able to manage its clock (like do we want the CPU clock to
> > > > > > > > > > never *ever* be gated just because we don't have a cpuidle/hotplug
> > > > > > > > > > driver yet?)
> > > > > > > > > 
> > > > > > > > > As I've just mentioned, if a clock 'can' be turned off, this binding
> > > > > > > > > should never be used. Situations where using always-on as a stop-gap
> > > > > > > > > due to a lack of current functionality is what the paragraph above is
> > > > > > > > > trying to mitigate.
> > > > > > > > 
> > > > > > > > But it's not really what this property is about. What this property
> > > > > > > > describes is that these clocks should never be gated. Any point in
> > > > > > > > time during the life of the system AND with in any kernel version.
> > > > > > > 
> > > > > > > You got it, that's correct -- these clocks should never be gated.
> > > > > > > 
> > > > > > > So why would that ever change?  If that is likely (or even possible)
> > > > > > > to change in the future then this binding should not be used.
> > > > > > >
> > > > > > > To reiterate; this binding should be used on ungatable clocks only.
> > > > > > > Non-negotiable, non-changeable either by the introduction of new
> > > > > > > functionality/support or kernel version.
> > > > > > 
> > > > > > I'm pretty sure that if that patch gets merged, by the end of the
> > > > > > year, there will be "incorrect" users by your standards.
> > > > > 
> > > > > It's possible to abuse any binding.  I don't see why you are so
> > > > > offended of this one in particular.
> > > > 
> > > > I'm not offended, I just tried to push the same kind of patches two
> > > > years ago, with Mike pushing back, and actually came to see that he
> > > > was right a few monthes down the road.
> > > 
> > > Well this was suggested by Mike.  I even have his Ack already.  So I
> > > guess he too has changed the error of his ways. :)
> > 
> > I wonder why it's not even merged yet then if you have the maintainers
> > Acked-by, and want to ignore any other review.
> > 
> > > > And yeah, your point that any binding can be abused is true. This one
> > > > is only so easy to abuse it's not even funny.
> > > > 
> > > > > > If you introduce a feature, you should expect people to use
> > > > > > it.  If not, what's the point?
> > > > > 
> > > > > By your own admission, there are genuine users for this binding and I
> > > > > expect people to use it.
> > > > 
> > > > The only thing that we really disagree upon is that whether that
> > > > restriction will really be followed. You expect people to, I
> > > > don't. It's the fundamental disagreement we have, that really prevent
> > > > any purely technical discussion.
> > > > 
> > > > Maybe we can try to address that before moving forward?
> > > 
> > > I'd like that.
> > > 
> > > If a firm warning isn't good enough, then what will be?
> > > 
> > > > > > > > > > Have you seen the numerous NAK on such approach Mike did?
> > > > > > > > > 
> > > > > > > > > I haven't, but the folks reviewing previous versions have.  Do you
> > > > > > > > > have something specific in mind that you'd like to bring to my
> > > > > > > > > attention?
> > > > > > > > 
> > > > > > > > Unfortunately, I haven't been able to dig out such mails. But it's why
> > > > > > > > we ended up with clock protection code in various clock drivers
> > > > > > > > including:
> > > > > > > > 
> > > > > > > > AT91: http://lxr.free-electrons.com/source/drivers/clk/at91/clk-slow.c#L484
> > > > > > > > iMX28: http://lxr.free-electrons.com/source/drivers/clk/mxs/clk-imx28.c#L154
> > > > > > > > Rockchip: http://lxr.free-electrons.com/source/drivers/clk/rockchip/clk.c#L320
> > > > > > > > sunXi: http://lxr.free-electrons.com/source/drivers/clk/sunxi/clk-sunxi.c#L1183
> > > > > > > > Zynq: http://lxr.free-electrons.com/source/drivers/clk/zynq/clkc.c#L504
> > > > > > > > 
> > > > > > > > Which is much more flexible, since you won't have to modify the DT to
> > > > > > > > change which clocks are to be left enabled, as well as way easier to
> > > > > > > > debug if you ever have to remove that property from the DT.
> > > > > > > 
> > > > > > > You're right, you don't have the change the DT in these cases.  You
> > > > > > > have to write new C code, which is _less_ flexible.
> > > > > > 
> > > > > > I'm sorry to learn that you never heard of that stable-DT thing.
> > > > > > 
> > > > > > And a bit sorry to see that a maintainer is really seeing C as not
> > > > > > flexible.
> > > > > 
> > > > > You're putting words in my mouth.  I didn't say C was not flexible.
> > > > > 
> > > > > I'm referencing the original DT pros i.e. it is possible to supply a
> > > > > different configuration without the need to compile the kernel.
> > > > > That's certainly true in this case.  We can provide a clk-provider and
> > > > > tag it as always-on, all without re-compile.
> > > > > 
> > > > > > > So all these platforms are adding their own hand-rolled version of
> > > > > > > this binding, adding more duplication and cruft to the kernel.
> > > > > > > Instead they can use this 'always-on' and we can consolidate and strip
> > > > > > > it all out.
> > > > > > 
> > > > > > Except that all these platforms are actually not implementing a
> > > > > > binding, ie not an interface with the DT they are bound to. Each and
> > > > > > every of these platforms can change that list whenever they wish, just
> > > > > > by sending a single one-liner patch (just like the DT, really.).
> > > > > > 
> > > > > > Which is not something that you can achieve with a DT binding.
> > > > > 
> > > > > Once again, can you give me more information about why you have such a
> > > > > problem with this binding.  I wish for it to be stable/ABI, I wish for
> > > > > it never to be removed, I envisage it will always be needed, so what's
> > > > > the problem? 
> > > > > 
> > > > > Do you have a vested interest that I am missing?
> > > > > 
> > > > > Perhaps an example of possible calamity will help convince me that
> > > > > you're not completely wrong and blowing everything out of proportion
> > > > > for no good reason.
> > > > 
> > > > Let's say you've introduced such a clock in kernel 4.0 for the memory
> > > > clock.
> > > > 
> > > > At some point down the road, you create a ddrfreq driver (if that ever
> > > > exists). You have a new driver, which will manage the clock.
> > > > 
> > > > In that driver, for some reason, you have to shutdown the clock to
> > > > reset the DDR controller. Of course that also means that you will be
> > > > removing the clk-always-on property from your DT.
> > > > 
> > > > You will have in your driver something like:
> > > > 
> > > > /* Reset our controller */
> > > > clk_disable(clk);
> > > > clk_enable(clk):
> > > > 
> > > > And then, you expect your controller to be in its out-of-reset
> > > > state. Which will be the case with a new DT, and not with the old one,
> > > > probably creating all kind of very entertaining issues to debug.
> > > > 
> > > > All of this wouldn't be the case if you had this inside the kernel,
> > > > since (hopefully) the kernel is consistent with itself.
> > > 
> > > Surely you must have realised already that DTBs are more tightly
> > > coupled to kernel versions than we would have initially liked?
> > 
> > Just to get things straight. I'm *not* one proponent of the "DT as an
> > ABI" rule.
> > 
> > BUT, if you're designing a generic property, then you're also
> > designing it for platforms that have chose to have that stability. And
> > we do have some of those in the tree.
> > 
> > And of course, that's assuming that the ABI stability is never going
> > to be a thing (which might or might not happen).
> > 
> > > It's naive to assume that old DTBs will 'just-work' with newer
> > > kernels.
> > 
> > Like I said, it does work on some mainline ARM platforms.
> > 
> > > Wrong decisions related to DT are being made daily. Adding
> > > mistakenly or foolhardily adding 'clk-always-on' to a DTS is not
> > > going to be the sole cause of breakage somewhere down the line.
> > 
> > I'm not sure that saying that accepting bindings because some other
> > bindings are just as bad is a good argument, especially on bindings
> > that do impact all the platforms.
> > 
> > > Pushing back on the acceptance of this binding based on idealistic,
> > > possibly already out-of-date premise is just frustrating.
> > 
> > Don't worry, it's just as frustrating on the other end. Showing you
> > exactly why it's going to be an issue with you simply ignoring by
> > saying something close to "not my use case" is just as frustrating.
> > 
> > > This useful binding should be accepted and people should not abuse
> > > it.  If they do and the vendor Maintainer's review and accept then
> > > they have no foundation for recourse.
> > 
> > And in the end, there will be more and more bloated and / or poor code
> > in the kernel, hurting it as a whole.
> > 
> > > Would you prefer it if I made the warning starker?
> > 
> > The only kind of warning that would be noticed by anyone is a runtime
> > warning. I'm not sure this is a reasonable option :)
> 
> Does Sascha's antidote patch change your opinion?  We can use DT to
> declare critical clocks, and in the rare case of the introduction of a
> new DDRFreq-like feature, which doesn't adapt the DT will still be
> able to unlock the criticalness of the clock and use it as expected?

Honestly I'm not very fond of declaring these in the device tree, but
naming them 'critical-clocks' rather than 'always-on' seems more
acceptable for me. It leaves a way out for the user to turn the clock
off later as it only means "you may turn them off when you know what you
are doing".

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
