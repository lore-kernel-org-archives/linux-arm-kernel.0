From: ynorov@caviumnetworks.com (Yury Norov)
Date: Mon, 17 Jul 2017 18:51:47 +0300
Subject: [PATCH 08/20] thread: move thread bits accessors to separated file
In-Reply-To: <mvma8432jsx.fsf@suse.de>
References: <20170619155003.13218-1-ynorov@caviumnetworks.com>
 <20170619155003.13218-9-ynorov@caviumnetworks.com>
 <mvma8432jsx.fsf@suse.de>
Message-ID: <20170717155147.7s3qi2uduiz5ozon@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 17, 2017 at 04:57:02PM +0200, Andreas Schwab wrote:
> On Jun 19 2017, Yury Norov <ynorov@caviumnetworks.com> wrote:
> 
> > diff --git a/include/linux/thread_bits.h b/include/linux/thread_bits.h
> > new file mode 100644
> > index 000000000000..87354331bc7b
> > --- /dev/null
> > +++ b/include/linux/thread_bits.h
> > @@ -0,0 +1,63 @@
> > +/* thread_bits.h: common low-level thread bits accessors */
> > +
> > +#ifndef _LINUX_THREAD_BITS_H
> > +#define _LINUX_THREAD_BITS_H
> > +
> > +#ifndef __ASSEMBLY__
> > +
> > +#include <linux/bitops.h>
> > +#include <asm/thread_info.h>
> > +
> > +#ifdef CONFIG_THREAD_INFO_IN_TASK
> > +/*
> > + * For CONFIG_THREAD_INFO_IN_TASK kernels we need <asm/current.h> for the
> > + * definition of current, but for !CONFIG_THREAD_INFO_IN_TASK kernels,
> > + * including <asm/current.h> can cause a circular dependency on some platforms.
> > + */
> > +#include <asm/current.h>
> > +#define current_thread_info() ((struct thread_info *)current)
> > +#endif
> 
> This is duplicate.
> 
> > diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
> > index d7d3ea637dd0..c40a89357329 100644
> > --- a/include/linux/thread_info.h
> > +++ b/include/linux/thread_info.h
> > @@ -7,9 +7,21 @@
> >  #ifndef _LINUX_THREAD_INFO_H
> >  #define _LINUX_THREAD_INFO_H
> >  
> > +/*
> > + * For per-arch arch_within_stack_frames() implementations, defined in
> > + * asm/thread_info.h.
> > + */
> > +enum {
> > +	BAD_STACK = -1,
> > +	NOT_STACK = 0,
> > +	GOOD_FRAME,
> > +	GOOD_STACK,
> > +};
> > +
> 
> That should be kept after the includes.

Thanks, will fix.
