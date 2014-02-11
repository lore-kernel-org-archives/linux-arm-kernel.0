From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 11 Feb 2014 16:13:43 +0000
Subject: [RFC PATCH V2 4/4] arm64: mm: implement get_user_pages_fast
In-Reply-To: <20140211154859.GG3748@arm.com>
References: <1391703531-12845-1-git-send-email-steve.capper@linaro.org>
 <1391703531-12845-5-git-send-email-steve.capper@linaro.org>
 <20140211154859.GG3748@arm.com>
Message-ID: <20140211161342.GB16371@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 03:48:59PM +0000, Catalin Marinas wrote:
> On Thu, Feb 06, 2014 at 04:18:51PM +0000, Steve Capper wrote:
> > An implementation of get_user_pages_fast for arm64. It is based on the
> > arm implementation (it has the added ability to walk huge puds) which
> > is loosely on the PowerPC implementation. We disable interrupts in the
> > walker to prevent the call_rcu_sched pagetable freeing code from
> > running under us.
> > 
> > We also explicitly fire an IPI in the Transparent HugePage splitting
> > case to prevent splits from interfering with the fast_gup walker.
> > As THP splits are relatively rare, this should not have a noticable
> > overhead.
> > 
> > Signed-off-by: Steve Capper <steve.capper@linaro.org>
> > ---
> >  arch/arm64/include/asm/pgtable.h |   4 +
> >  arch/arm64/mm/Makefile           |   2 +-
> >  arch/arm64/mm/gup.c              | 297 +++++++++++++++++++++++++++++++++++++++
> 
> Why don't you make a generic gup.c implementation and let architectures
> select it? I don't see much arm64-specific code in here.

Certainly ARM and ARM64 will happily share the code and other
architectures use basically the same technique in most places so could
probably make use of a tweaked version.

I'll generalise gup.c in the next revision of this series.

Cheers,
-- 
Steve
