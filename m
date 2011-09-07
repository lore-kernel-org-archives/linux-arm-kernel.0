From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Sep 2011 09:56:21 +0200
Subject: [PATCH 3/6] arm/imx6q: add core drivers clock, gpc, mmdc and src
In-Reply-To: <20110907060501.GE8148@S2100-06.ap.freescale.net>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<1711465.COqYbTSZES@wuerfel>
	<20110907060501.GE8148@S2100-06.ap.freescale.net>
Message-ID: <2937243.vrss2TdbGN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 September 2011 14:05:03 Shawn Guo wrote:

> > >  arch/arm/mach-imx/Kconfig       |   13 +
> > >  arch/arm/mach-imx/Makefile      |    4 +
> > >  arch/arm/mach-imx/clock-imx6q.c | 1990 +++++++++++++++++++++++++++++++++++++++
> > >  arch/arm/mach-imx/gpc.c         |  110 +++
> > >  arch/arm/mach-imx/mmdc.c        |   71 ++
> > >  arch/arm/mach-imx/src.c         |   52 +
> > >  6 files changed, 2240 insertions(+), 0 deletions(-)
> > 
> > This is unfortunately still a major problem.
> 
> It's so sad to still get this comment.  Back to Linaro Connect on
> Cambridge, I believe I asked for your opinion on new SoC clock support
> without waiting for the clock framework.  You said you do not have a
> strong position on this and would defer to others' judgement.  Then
> I talked to Russell and Grant respectively, and they both agree that
> we should not be blocked by the clock framework.  That's why I decided
> to start upstreaming imx6q.

I don't mind being overruled on this if Russell, Grant or others have a good
feeling about the clock code going in like this.

I thought that the discussion we had in Cambridge was about migrating the
existing i.mx code to device tree without waiting for the clock framework.
If I misremember that and we had actually made a different decision back
then, then please forgive my overreaction.

> > I realize that we don't
> > yet have a good framework to do this with significantly less code,
> > but adding a platform that is mostly consisting of stupid additions
> > of clock descriptions that really should be in the device tree does
> > not scale much longer.
> 
> I definitely agree this does not scale for long term.  And I would
> immediately migrate it to clock framework once it gets ready and put
> the description into device tree when clock binding is ready.  Before
> we get there, we need a way out.  It's unreasonable for us to hold
> the new soc support for an unspecified time.  It's been 20 months since
> we saw the common clock patches[1] from Jeremy, and we do not know yet
> how many months we still have to wait.  Grant worked out the auxdata to
> remove the device tree dependency on clock framework.  I think we
> should not get new soc support blocked by clock framework either.
> 
> > We decided to let this still get in for prima2,
> > which was also ugly in this regard but much simpler than imx6.
> > 
> It's unfair to me that you reject imx6q clock code just because it's
> an implementation for a hardware complexer than prima2.

We have to stop taking new platform clock code at some point and get
all new platforms to use common code as much as possible. The unresolved
question here is when that will be. My feeling is that prima2 was
borderline and this is too far, but I may be pushing it here given
that we are still waiting for the clock framework to actually get
merged.

However, if there is no pressure at all, we might never see that framework.

> > My feeling is that this time, we should wait for the common clock
> > framework to get in and simplify this. I believe Thomas is now planning
> > to do this, but I haven't followed what the current state is.
> > 
> Sadly, if this is the position of entire arm-soc maintainer group,
> I think I have made a wrong decision to start upstreaming imx6q now.

We haven't discussed it as a group, it's my own opinion.

> > The other three drivers in this patch are basically ok, so you can
> > definitely post them as a separate patch and perhaps get minor comments
> > for those, similar to what I commented on the other patches.
> > 
> > For the clock-imx6q.c file, what I first want to hear from someone
> > is how this is supposed to look like in the long run with device tree
> > integration, and how far away from that we are.
> > 
> > Can you comment on how far we get without the clock driver with imx6?
> > Is is basically useless, or is there a way we can merge the remaining
> > imx6 code and other drivers but postpone the large clock driver?
> > 
> Unfortunately, clock is pretty fundamental for imx6q support.  Without
> clock support, imx6q platform is useless.  We have a real example here.
> Back to Dec. 2010, Sascha refused to take clock patch when Freescale
> was submitting imx50 platform support, because he thought the clock
> framework will get merged pretty soon.  But we end up with the facts
> that clock framework is still up in the air and imx50 platform support
> on mainline is totally useless.
> 
> I have been tried very hard to reduce the LOC of clock-imx6q.c.  It's
> a 5K LOC file in the Freescale internal tree.  Now it's 2K LOC.  I know
> it's still large enough for you to dislike it.  But this is the clock
> that the hardware has.  I'm afraid we can not do much to reduce the LOC
> significantly, unless we only implement the small portion other than
> the full clock tree, which is what I really hate to do.

I actually think that you have done a great job on the code and that it
certainly looks better than a lot of the other implementations that we
have in the tree.

Also, at least half of the code is now real driver code that we won't
be able to reduce any further even with the clock framework. However,
when I look at long sets of DEF_CLK and DEF_*MUX and _REGISTER_CLOCK,
it feels like exactly the stuff that we should be moving into the
device tree and have automatically parsed.

	Arnd
