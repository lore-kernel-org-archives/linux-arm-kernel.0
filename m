From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 16 Jan 2015 18:09:28 +0100
Subject: [PATCH] soc: tegra: Add Tegra132 SoC to the DT list of Tegra SoCs
In-Reply-To: <20150116150749.GA32155@leverpostej>
References: <alpine.DEB.2.02.1501161137351.9776@utopia.booyaka.com>
 <20150116150749.GA32155@leverpostej>
Message-ID: <20150116170926.GA17763@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 03:07:49PM +0000, Mark Rutland wrote:
> Hi Paul,
> 
> /me opens a delicious can of Lumbricus terrestris
> 
> My comments below aren't so much about this patch alone, but more about
> the entire strategy with drivers/soc and the kind of code living there.
> 
> On Fri, Jan 16, 2015 at 11:39:13AM +0000, Paul Walmsley wrote:
> > 
> > Add "nvidia,tegra132" as a compatible string that denotes a Tegra SoC.
> > 
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > Cc: Paul Walmsley <pwalmsley@nvidia.com>
> > Cc: Stephen Warren <swarren@wwwdotorg.org>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Alexandre Courbot <gnurou@gmail.com>
> > ---
> >  drivers/soc/tegra/common.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
> > index a71cb74..a952986 100644
> > --- a/drivers/soc/tegra/common.c
> > +++ b/drivers/soc/tegra/common.c
> > @@ -15,6 +15,7 @@ static const struct of_device_id tegra_machine_match[] = {
> >  	{ .compatible = "nvidia,tegra30", },
> >  	{ .compatible = "nvidia,tegra114", },
> >  	{ .compatible = "nvidia,tegra124", },
> > +	{ .compatible = "nvidia,tegra132", },
> >  	{ }
> >  };
> 
> I'm rather worried by this.
> 
> The only user of this table is soc_is_tegra(), which seems to guard
> several probe paths in drivers which are DT driven. Given that, I don't
> see why this is necessary at all, because the presence of the
> appropriate nodes should be sufficient to handle the early return from
> an initcall.

We need this to preserve backward-compatibility. There are some
instances where any device tree nodes that could be used to guard the
code execution were only added after the fact. So in order to keep
systems with an old DTB running we need to continue running with hard
coded physical addresses.

> More worryingly, if soc_is_tegra() returns true but the node isn't
> found, the drivers decide to do things. If tegra_pmc_early_init passes
> soc_is_tegra() (because we happened to match "nvidia,tegra132"), but
> doesn't find a DTB entry for the pmc, it then pokes an assumed
> hard-coded physical address.

And that's (currently) safe. It at least makes sure that breakage (if
any) is restricted to Tegra boards. There are other occurrences where
drivers don't even bother checking for this at all and simply use an
initcall to unconditionally create a platform device which then goes
and tries to access physical addresses on *every* board in a multi-
platform kernel.

> Assuming things because of the _lack_ of a node has been a major pain
> point on 32-bit as DTBs advanced and code was changed, resulting in boot
> breaking or DTB compatibility breaking over time as old and new kernels
> made conflicting assumptions.

So what are you saying? We can't support 64-bit ARM because we need to
keep backwards-compatibility with old DTBs and weren't smart enough to
see this through all the way three years ago?

> I don't want to see arm64 kernels making assumptions in that manner (nor
> would I like to see it in new code for 32-bit ARM); it always leads to
> boot breakage, and it's completely avoidable. The only thing we can know
> is what is described in the DTB.

I guess we could always make this conditional on 32-bit ARM. Or we could
decide that we don't care about DTB backwards-compatibility anymore. In
fact we're quite likely going to break it soon anyway because of Marc's
gic_arch_extn rework, so might as well start with a clean plate after
that...

> So NAK to this addition while soc_is_tegra is in use in that way, and
> NAK to any DTS patches adding any of the strings that would cause
> soc_is_tegra to return true on arm64.
> 
> There's also the worrying pattern of initcalls that look for particular
> compatible strings -- why can't these use the existing DT probing
> infrastructure rather than rolling their own? It would be nice to not
> accumulate initcalls that only make sense on one platform.

You make it sound like the "existing DT probing infrastructure" is in
any way different from initcalls. Furthermore it's typically associated
with a specific subsystem or class of devices, so adding custom OF init
tables for a driver that's used on a single platform doesn't strike me
as something that people would be willing to merge.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150116/9943c6f4/attachment.sig>
