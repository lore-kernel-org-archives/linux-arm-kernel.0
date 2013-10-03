From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 3 Oct 2013 08:17:32 -0400
Subject: [PATCH] clk: armada-370: fix tclk frequencies
In-Reply-To: <20131003090057.GF1356@kw.sim.vm.gnt>
References: <1380729418-14393-1-git-send-email-simon.guinot@sequanux.org>
 <20131002162221.GN31178@titan.lakedaemon.net>
 <20131002165754.GE1356@kw.sim.vm.gnt>
 <20131002170448.GO31178@titan.lakedaemon.net>
 <20131003090057.GF1356@kw.sim.vm.gnt>
Message-ID: <20131003121732.GU31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 03, 2013 at 11:00:58AM +0200, Simon Guinot wrote:
> On Wed, Oct 02, 2013 at 01:04:49PM -0400, Jason Cooper wrote:
> > On Wed, Oct 02, 2013 at 06:57:54PM +0200, Simon Guinot wrote:
> > > On Wed, Oct 02, 2013 at 12:22:21PM -0400, Jason Cooper wrote:
> > > > Simon,
> > > > 
> > > > On Wed, Oct 02, 2013 at 05:56:58PM +0200, Simon Guinot wrote:
> > > > > Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> > > > 
> > > > Could you elaborate on this?  What symptom did you notice?  How did this
> > > > fix it?  When was the regression introduced?
> > > 
> > > Hi Jason,
> > > 
> > > While benchmarking Linux 3.12-rc3 on an Armada-370-RD, I noticed bad
> > > networking performances... After some investigations, I found out that
> > > the coalescence configuration (derived from the tclk) was suspect.
> > > 
> > > While checking for the tclk value, I found this typo. There is not much
> > > to say about this patch except that the correct tclk frequencies for
> > > Armada-370 are 166 and 200MHz, not 16.6 and 20MHz.
> > 
> > Yes, I know it's simple, but it's a huge help to us when trying to
> > decide whether or not to flag it for stable.  fwiw, the regression was
> > introduced by:
> > 
> >   6b72333d clk: mvebu: add Armada 370 SoC-centric clock init
> > 
> > and this should be applied from v3.11 onwards.
> 
> Ok, I will reword this commit. Note that this bug can't be called a
> regression. The tclk frequencies array was wrong from the beginning:
> 
>   97fa4cf4: clk: mvebu: add mvebu core clocks
> 
> The commit you pointed out simply moves the typo.

Ahh, good catch!  Yes, please reword the commit.

> I am not familiar with the stable process but if needed I can provide
> a patch against some stable branches.

Usually, there should only need to be one patch against mainline.  But
since the bad values were moved during the lifetime of the error, there
may need to be two patches.  Depends on how magical git is.  I've seen
it do some pretty amazing stuff.

Please find the original commit introducing the error, reference that in
the commit, and use 'tag --contains ...' to see which versions need the
fix.  You can mention that below the cutoff.  That's generally all we
need to flag it for stable and help the stable guys figure out which
trees to apply it to.

hth,

Jason.
