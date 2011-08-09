From: will.deacon@arm.com (Will Deacon)
Date: Tue, 9 Aug 2011 09:32:17 +0100
Subject: [PATCH 2/6] ARM: realview: ensure visibility of writes during
	reset
In-Reply-To: <4E405221.7050800@gmail.com>
References: <1312823424-9654-1-git-send-email-will.deacon@arm.com>
	<1312823424-9654-3-git-send-email-will.deacon@arm.com>
	<4E405221.7050800@gmail.com>
Message-ID: <20110809083216.GA2991@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Mon, Aug 08, 2011 at 10:16:17PM +0100, Rob Herring wrote:
> On 08/08/2011 12:10 PM, Will Deacon wrote:
> > The various reset routines in mach-realview rely on an FPGA to
> > power-cycle the board after writing some magic runes to memory-mapped
> > registers.
> > 
> > This patch adds a dsb() following the writes, so that they become
> > visible before we mdelay(1000) in the arch_reset code. Without this
> > patch, the timeout would expire sporadically, causing the reset to fail.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm/mach-realview/include/mach/system.h |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-realview/include/mach/system.h b/arch/arm/mach-realview/include/mach/system.h
> > index a30f2e3..6657ff2 100644
> > --- a/arch/arm/mach-realview/include/mach/system.h
> > +++ b/arch/arm/mach-realview/include/mach/system.h
> > @@ -44,6 +44,7 @@ static inline void arch_reset(char mode, const char *cmd)
> >  	 */
> >  	if (realview_reset)
> >  		realview_reset(mode);
> > +	dsb();
> 
> Wouldn't it be better to do this globally.

I'd rather leave it in the arch-specific code since otherwise it feels like
we're leaking the actual reset implementation into the caller. Plus it's not
entirely clear that there's a one-size-fits-all solution here.

Cheers,

Will
