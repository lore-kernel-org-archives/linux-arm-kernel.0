From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 27 Jun 2013 15:43:35 +0100
Subject: [PATCH v6 2/5] kernel: missing include in cputime.c
In-Reply-To: <20130627141718.GA10056@gmail.com>
References: <alpine.DEB.2.02.1306271446570.4782@kaball.uk.xensource.com>
 <1372341272-12512-2-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130627141209.GB29209@dyad.programming.kicks-ass.net>
 <20130627141718.GA10056@gmail.com>
Message-ID: <alpine.DEB.2.02.1306271542530.4782@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Jun 2013, Ingo Molnar wrote:
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Thu, Jun 27, 2013 at 02:54:29PM +0100, Stefano Stabellini wrote:
> > > steal_account_process_tick calls paravirt_steal_clock, but paravirt.h is
> > > currently missing amoung the included header files.
> > > Add include asm/paravirt.h ifdef CONFIG_PARAVIRT.
> > > 
> > > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > > CC: mingo at redhat.com
> > > CC: peterz at infradead.org
> > > 
> > > Changes in v5:
> > > - add ifdef CONFIG_PARAVIRT.
> > > ---
> > >  kernel/sched/cputime.c |    4 +++-
> > >  1 files changed, 3 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> > > index cc2dc3ee..317a578 100644
> > > --- a/kernel/sched/cputime.c
> > > +++ b/kernel/sched/cputime.c
> > > @@ -5,7 +5,9 @@
> > >  #include <linux/static_key.h>
> > >  #include <linux/context_tracking.h>
> > >  #include "sched.h"
> > > -
> > > +#ifdef CONFIG_PARAVIRT
> > > +#include <asm/paravirt.h>
> > > +#endif
> > 
> > Why isn't that CONFIG stuff inside the header instead of around it?
> 
> Indeed.
> 
> Once that is fixed then the #ifdef around asm/paravirt.h in 
> kernel/sched/core.c could be removed as well.

Right, that should work.
I'll make the change and resend with an additional patch to remove the
ifdef in kernel/sched/core.c.
