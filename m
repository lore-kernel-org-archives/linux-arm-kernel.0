From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Fri, 27 Jul 2012 10:28:25 +0100
Subject: [Xen-devel] [PATCH 04/24] xen/arm: sync_bitops
In-Reply-To: <20120726163759.GE9222@phenom.dumpdata.com>
References: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
 <1343316846-25860-4-git-send-email-stefano.stabellini@eu.citrix.com>
 <20120726163759.GE9222@phenom.dumpdata.com>
Message-ID: <1343381305.6812.116.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-07-26 at 17:37 +0100, Konrad Rzeszutek Wilk wrote:
> On Thu, Jul 26, 2012 at 04:33:46PM +0100, Stefano Stabellini wrote:
> > sync_bitops functions are equivalent to the SMP implementation of the
> > original functions, independently from CONFIG_SMP being defined.
> 
> So why can't the code be changed to use that? Is it that
> the _set_bit, _clear_bit, etc are not available with !CONFIG_SMP?

_set_bit etc are not SMP safe if !CONFIG_SMP. But under Xen you might be
communicating with a completely external entity who might be on another
CPU (e.g. two uniprocessor guests communicating via event channels and
grant tables). So we need a variant of the bit ops which are SMP safe
even on a UP kernel.

The users are common code and the sync_foo vs foo distinction matters on
some platforms (e.g. x86 where a UP kernel would omit the LOCK prefix
for the normal ones).

> 
> > 
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > ---
> >  arch/arm/include/asm/sync_bitops.h |   17 +++++++++++++++++
> >  1 files changed, 17 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/include/asm/sync_bitops.h
> > 
> > diff --git a/arch/arm/include/asm/sync_bitops.h b/arch/arm/include/asm/sync_bitops.h
> > new file mode 100644
> > index 0000000..d975092903
> > --- /dev/null
> > +++ b/arch/arm/include/asm/sync_bitops.h
> > @@ -0,0 +1,17 @@
> > +#ifndef __ASM_SYNC_BITOPS_H__
> > +#define __ASM_SYNC_BITOPS_H__
> > +
> > +#include <asm/bitops.h>
> > +#include <asm/system.h>
> > +
> > +#define sync_set_bit(nr, p)		_set_bit(nr, p)
> > +#define sync_clear_bit(nr, p)		_clear_bit(nr, p)
> > +#define sync_change_bit(nr, p)		_change_bit(nr, p)
> > +#define sync_test_and_set_bit(nr, p)	_test_and_set_bit(nr, p)
> > +#define sync_test_and_clear_bit(nr, p)	_test_and_clear_bit(nr, p)
> > +#define sync_test_and_change_bit(nr, p)	_test_and_change_bit(nr, p)
> > +#define sync_test_bit(nr, addr)		test_bit(nr, addr)
> > +#define sync_cmpxchg			cmpxchg
> > +
> > +
> > +#endif
> > -- 
> > 1.7.2.5
> > 
> > 
> > _______________________________________________
> > Xen-devel mailing list
> > Xen-devel at lists.xen.org
> > http://lists.xen.org/xen-devel
