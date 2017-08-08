From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 8 Aug 2017 17:10:51 +0100
Subject: [PATCHv2 1/7] arm64: Add ASM_BUG()
In-Reply-To: <20170808155853.ropux7lxk6rgbd2r@armageddon.cambridge.arm.com>
References: <1501093110-3844-1-git-send-email-mark.rutland@arm.com>
 <1501093110-3844-2-git-send-email-mark.rutland@arm.com>
 <20170808153112.GF19207@leverpostej>
 <20170808155853.ropux7lxk6rgbd2r@armageddon.cambridge.arm.com>
Message-ID: <20170808161050.GH19207@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 08, 2017 at 04:58:53PM +0100, Catalin Marinas wrote:
> On Tue, Aug 08, 2017 at 04:31:12PM +0100, Mark Rutland wrote:
> > On Wed, Jul 26, 2017 at 07:18:24PM +0100, Mark Rutland wrote:
> > > +#define __BUG_ENTRY(flags) 				\
> > > +		.pushsection __bug_table,"a";		\
> > > +		.align 2;				\
> > > +	0:	.long 1f - 0b;				\
> > > +_BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
> > > +		.short flags; 				\
> > > +		.popsection;				\
> > > +	1:
> > > +#else
> > > +#define __BUG_ENTRY(flags)
> > > +#endif
> > > +
> > > +#define ASM_BUG_FLAGS(flags)				\
> > > +	__BUG_ENTRY(0)					\
> > > +	brk	BUG_BRK_IMM
> > 
> > I accidentally dropped the flags here, which turns all WARN*s into BUGs.
> > 
> > I've fixed this up to pass the flags to __BUG_ENTRY(). I've pushed out
> > updated arm64/exception-stack and arm64/vmap-stack branches.
> 
> I'll pull arm64/exception-stack into for-next/core (I haven't got to the
> vmap-stack series yet).

If you could hold off for a day, I'd like to make one final change and prevent
use of the final record's LR value, where FP is NULL, since that LR isn't
meaningful, and makes the backtrace look weird:

[ 2785.650646] [<ffff000008082cb0>] el0_svc_naked+0x24/0x28
[ 2785.656016] [<0000ffffaf717554>] 0xffffaf717554

Otherwise, I can do that as a fixup.

Thanks,
Mark.
