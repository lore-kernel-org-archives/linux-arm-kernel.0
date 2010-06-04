From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 04 Jun 2010 16:51:24 -0400 (EDT)
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <AANLkTil1IetX6koHVRrgnWs3DqhPtZVqR2euEdg9lZUa@mail.gmail.com>
References: <20100603192459.GA9169@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1006031829020.24526@xanadu.home>
	<4C083BCF.2060500@bluewatersys.com>
	<201006040310.15019.marek.vasut@gmail.com>
	<4C0853E1.1080005@bluewatersys.com>
	<AANLkTinEq99_8UyVNnmzNEreDoyHKEnxpuJmaAo_kpPN@mail.gmail.com>
	<20100604061034.GI6499@atomide.com>
	<AANLkTikrK-RkDntgrpptBaG6TvnesNFncOw3DW4Jt-TY@mail.gmail.com>
	<AANLkTil1IetX6koHVRrgnWs3DqhPtZVqR2euEdg9lZUa@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1006041418390.22319@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 4 Jun 2010, Martin Guy wrote:

> I think you've missed the point.
> 
> Linus' problem is that he is spending MOST of his linux-kernel-support
> time fielding patches from a dozen port maintainers, and dropping
> defconfigs is a desperate attempt to cut the amount of arm fiddling he
> is asked to do, and I guess droppiong defconfigs seems to him to be
> they way to cut the least important and most verbose part of this
> drudgery.

Not exactly.  If you read along the thread, you'll see that what Linus 
is actually complaining about is the fact that those defconfig files are 
huge and clutter the source tree for little value.  When someone sends 
him a pull request for some ARM target, the actual diffstat/dirstat is 
dominated by the defconfig file changes, making the review exercise 
futile (even if Linus is probably merely only looking at the diffstat 
for ARM merges).

> While a defconfig restructuring does address the specific issue it's
> pointless. He's going to drop defconfigs, so we'll all just have to
> have our own web pages giving our suggested defconfigs for our own
> boards.

Linus wants something to be done about the current defconfig mess which 
is perfectly legitimate.  He even suggested a possible solution.  I 
don't think he'll simply drop those defconfig files if we demonstrate 
that we're taking action to fix the actual problem.

In the mean time, anything that can be done today to reduce the number 
of defconfig files is a good thing.  In some cases we're even talking 
about merging 7 of those into 1.  Those are low hanging fruits that are 
absolutely worth the little effort required, and that would help with 
kernel compilation tests.

> Shame. I was about to post a Sim.One defconfig patch (while fully
> realizing that the choice of options is largely arbitrary. and copied
> ad-hoc from some other similar defconfig). While it's nice to be able
> to tell people "make foobar_defconfig; make (z|u|bz)Image" in reality
> the config is as arbitrary as the root filesystem in use (and should
> be chosen to match it).

Sure.  All the defconfigs are largely arbitrary.  What needs to be done, 
though, is some way to preserve the info for a default minimal 
configuration a given target require to support all its on-board 
soldered peripherals.  That is hardly arbitrary as those peripherals 
cannot be changed, and their config options are often buried down into 
the Kconfig jungle.

> The best way to free up many hours every day of Linus' time is for one
> person to isolate him from the port maintainers, so that he only has
> to pull (ideally) once per release cycle from one repository.

Possibly, but that's an orthogonal issue to the matter at hand.  It used 
to be RMK who did gather all the patches in addition to his current role 
as the gatekeeper and reviewer for core ARM patches.  And that didn't 
scale as RMK became overworked.  It was then proposed that large 
isolated subarchitecture changes be maintained separately from RMK's 
tree and pulled directly by Linus.

And even if only one person was gathering all the ARM patches together, 
then Linus would still be presented with a humongous amount of lines 
added/changed in arch/arm/configs/* which would still skew the diffstat 
and dirstat, effectively not solving the current issue at all.

What really needs to be done is to remove those defconfig files from the 
code churn picture, so when Linus is asked to pull ARM stuff he's not 
presented with defconfig crap shadowing the real changes.  To achieve 
that, we need to:

1) Collapse as many defconfig files together as possible.  That can be 
   done easily now (even during the -rc period IMHO) with immediate 
   advantages:
   a) reduce the weight of arch/arm/configs/
   b) make fewer machine configs to build for KAutobuild
   c) provide the beginning of a solution to tell Linus that we're 
      concerned too and dealing with the issue.

2) Consider alternative ways to encode those non arbitrary config 
   defaults in a human readable way (that's another of Linus' 
   complaints).  For that, some solutions were proposed, but they won't 
   be developed in a single day like (1) can.

Now the discussion around the ability to compile many machine classes 
(in addition to multiple machines from the same machine class as we 
already can do) together in a single kernel will certainly have some 
effect on the number of defconfig files, but there are other more 
important reasons for doing that other than this issue.


Nicolas
