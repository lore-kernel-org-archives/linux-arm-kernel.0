From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 19 Jan 2015 15:28:02 +0000
Subject: [PATCH] soc: tegra: Add Tegra132 SoC to the DT list of Tegra SoCs
In-Reply-To: <20150119132453.GG7312@ulmo.nvidia.com>
References: <alpine.DEB.2.02.1501161137351.9776@utopia.booyaka.com>
 <20150116150749.GA32155@leverpostej>
 <20150116170926.GA17763@ulmo.nvidia.com>
 <20150116173005.GH32155@leverpostej>
 <20150119132453.GG7312@ulmo.nvidia.com>
Message-ID: <20150119152801.GG21553@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 01:24:55PM +0000, Thierry Reding wrote:
> On Fri, Jan 16, 2015 at 05:30:05PM +0000, Mark Rutland wrote:
> > On Fri, Jan 16, 2015 at 05:09:28PM +0000, Thierry Reding wrote:
> > > On Fri, Jan 16, 2015 at 03:07:49PM +0000, Mark Rutland wrote:
> > > > Hi Paul,
> > > > 
> > > > /me opens a delicious can of Lumbricus terrestris
> > > > 
> > > > My comments below aren't so much about this patch alone, but more about
> > > > the entire strategy with drivers/soc and the kind of code living there.
> > > > 
> > > > On Fri, Jan 16, 2015 at 11:39:13AM +0000, Paul Walmsley wrote:
> > > > > 
> > > > > Add "nvidia,tegra132" as a compatible string that denotes a Tegra SoC.
> > > > > 
> > > > > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > > > > Cc: Paul Walmsley <pwalmsley@nvidia.com>
> > > > > Cc: Stephen Warren <swarren@wwwdotorg.org>
> > > > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > > > Cc: Alexandre Courbot <gnurou@gmail.com>
> > > > > ---
> > > > >  drivers/soc/tegra/common.c | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
> > > > > index a71cb74..a952986 100644
> > > > > --- a/drivers/soc/tegra/common.c
> > > > > +++ b/drivers/soc/tegra/common.c
> > > > > @@ -15,6 +15,7 @@ static const struct of_device_id tegra_machine_match[] = {
> > > > >  	{ .compatible = "nvidia,tegra30", },
> > > > >  	{ .compatible = "nvidia,tegra114", },
> > > > >  	{ .compatible = "nvidia,tegra124", },
> > > > > +	{ .compatible = "nvidia,tegra132", },
> > > > >  	{ }
> > > > >  };
> > > > 
> > > > I'm rather worried by this.
> > > > 
> > > > The only user of this table is soc_is_tegra(), which seems to guard
> > > > several probe paths in drivers which are DT driven. Given that, I don't
> > > > see why this is necessary at all, because the presence of the
> > > > appropriate nodes should be sufficient to handle the early return from
> > > > an initcall.
> > > 
> > > We need this to preserve backward-compatibility. There are some
> > > instances where any device tree nodes that could be used to guard the
> > > code execution were only added after the fact. So in order to keep
> > > systems with an old DTB running we need to continue running with hard
> > > coded physical addresses.
> > 
> > Except that you don't need them for arm64 systems, becuase we don't yet
> > have that legacy for arm64...
> > 
> > > > More worryingly, if soc_is_tegra() returns true but the node isn't
> > > > found, the drivers decide to do things. If tegra_pmc_early_init passes
> > > > soc_is_tegra() (because we happened to match "nvidia,tegra132"), but
> > > > doesn't find a DTB entry for the pmc, it then pokes an assumed
> > > > hard-coded physical address.
> > > 
> > > And that's (currently) safe. It at least makes sure that breakage (if
> > > any) is restricted to Tegra boards. There are other occurrences where
> > > drivers don't even bother checking for this at all and simply use an
> > > initcall to unconditionally create a platform device which then goes
> > > and tries to access physical addresses on *every* board in a multi-
> > > platform kernel.
> > 
> > So doing the wrong thing on a subset of boards is fine because it's not
> > all boards?
> 
> It's not doing anything wrong. If the string is added to the above table
> then the assumption is that it supports the (very few) cases where we've
> needed physical addresses. For anything sufficiently recent we already
> have all the nodes in the DTB, so there's no issue.
> 
> > Imagine I make a typo in a DT for a 64-bit system, and suddnely hit
> > youre legacy code. Things happen to work, because I don't botehr reading
> > the splat in dmesg for whatever reason.
> 
> That's a bit of a stretch. You'd have to typo the top-level compatible
> string of some future board that happens not to have this IP anymore.
> Catching those types of mistakes is what we have the review process for.

I was imagining that the root was correct, but a particular device was
wrong. A typo in the root is also a possibility.

Even if review is perfect in-tree, people are going to use out-of-tree
DTBs to some extent, and I'm not sure we can argue that's an entirely
wrong thing to do. So review may not help.

> If you're concerned about the splat, we could probably turn it into a
> WARN() to make it abundantly clear that you've done something wrong.
> 
> > Later we do some cleanup of the existing legacy, for whatever reason,
> > and we get rid of this particular path for arm64.
> > 
> > Suddenly my board won't boot, and to fix that we have to reintroduce
> > legacy support code only because said legacy support was enabled where
> > it should never have been in the first place. Another OS trying to
> > target/use these DTBs has barely any chance of success.
> 
> We've had cases in the past where it was argued that clearly broken DTBs
> didn't have to be considered for ABI stability. I'd argue that whatever
> kind of typo you're referring to falls into this obviously wrong
> category.

The line here is extremely fuzzy; I don't know what we can class as 
"clearly broken".

> > > > Assuming things because of the _lack_ of a node has been a major pain
> > > > point on 32-bit as DTBs advanced and code was changed, resulting in boot
> > > > breaking or DTB compatibility breaking over time as old and new kernels
> > > > made conflicting assumptions.
> > > 
> > > So what are you saying? We can't support 64-bit ARM because we need to
> > > keep backwards-compatibility with old DTBs and weren't smart enough to
> > > see this through all the way three years ago?
> > 
> > No. I'm saying that the workarounds we have in place for legacy DTBs
> > should be constrained to those cases where legacy DTBs actually exist.
> > There is no reason for that legacy to carry across to 64-bit.
> 
> That's fair. Note, though, that we're bound to make mistakes on 64-bit
> too, so it's wishful thinking that we'll live without legacy on 64-bit
> forever. But that's of course not to say we should start out with
> supporting legacy from the beginning.

I agree that we will accumulate legacy no matter how careful we are.

I would like to ensure that we avoid as much of that as possible. For
cases like these where the DTB has insufficient information, we can
avoid those for now by requiring the information to be in the DT and
doing nothing otherwise -- there's no legacy DT to support yet.

I can imagine that we may need to add workarounds of this sort in
future, and I'd like to ensure they are precisely targeted (e.g. have
needs_missing_dt_pmc rather than soc_is_tegra, and ideally warning).

I'm hoping that by being as explicit as possible now in the DT (e.g.
requiring enable-method), we can allow for future variation and not get
stuck in painful corners w.r.t. wide-reaching assumptions in platform
code. I'm also hoping that this will make sharing DTs with other
software more feasible, as it won't be necessary to make identical
assumptions regarding the platform.

> > > > I don't want to see arm64 kernels making assumptions in that manner (nor
> > > > would I like to see it in new code for 32-bit ARM); it always leads to
> > > > boot breakage, and it's completely avoidable. The only thing we can know
> > > > is what is described in the DTB.
> > > 
> > > I guess we could always make this conditional on 32-bit ARM. Or we could
> > > decide that we don't care about DTB backwards-compatibility anymore. In
> > > fact we're quite likely going to break it soon anyway because of Marc's
> > > gic_arch_extn rework, so might as well start with a clean plate after
> > > that...
> > 
> > At the very least I think the soc_is_tegra stuff needs to be constrained
> > to fallback paths that can only possibly run on 32-bit.
> 
> I think that's something we can do.

Exactly what I was hoping to hear :)

Thanks,
Mark.
