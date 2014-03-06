From: msalter@redhat.com (Mark Salter)
Date: Thu, 06 Mar 2014 16:25:10 -0500
Subject: [PATCH 2/5] mm: create generic early_ioremap() support
In-Reply-To: <20140305142953.669fd030495e802b2e03879c@linux-foundation.org>
References: <1393963738-9210-1-git-send-email-msalter@redhat.com>
 <1393963738-9210-3-git-send-email-msalter@redhat.com>
 <20140305142953.669fd030495e802b2e03879c@linux-foundation.org>
Message-ID: <1394141110.5094.37.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-03-05 at 14:29 -0800, Andrew Morton wrote:
> On Tue,  4 Mar 2014 15:08:55 -0500 Mark Salter <msalter@redhat.com> wrote:
> 
> > This patch creates a generic implementation of early_ioremap() support
> > based on the existing x86 implementation. early_ioremp() is useful for
> > early boot code which needs to temporarily map I/O or memory regions
> > before normal mapping functions such as ioremap() are available.
> > 
> > Some architectures have optional MMU. In the no-MMU case, the remap
> > functions simply return the passed in physical address and the unmap
> > functions do nothing.
> > 
> >
> > ....
> >
> > --- /dev/null
> > +++ b/mm/early_ioremap.c
> > @@ -0,0 +1,271 @@
> > +/*
> > + * Provide common bits of early_ioremap() support for architectures needing
> > + * temporary mappings during boot before ioremap() is available.
> > + *
> > + * This is mostly a direct copy of the x86 early_ioremap implementation.
> > + *
> > + * (C) Copyright 1995 1996, 2014 Linus Torvalds
> > + *
> > + */
> 
> I suppose one should include linux/kernel.h.

Okay.

> 
> > +#include <linux/init.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/mm.h>
> > +#include <linux/vmalloc.h>
> > +#include <asm/fixmap.h>
> > +
> > +#ifdef CONFIG_MMU
> > +static int early_ioremap_debug __initdata;
> > +
> > +static int __init early_ioremap_debug_setup(char *str)
> > +{
> > +	early_ioremap_debug = 1;
> > +
> > +	return 0;
> > +}
> > +early_param("early_ioremap_debug", early_ioremap_debug_setup);
> 
> Should be documented somewhere.  Documentation/kernel-parameters.txt?

Okay.

> 
> > +static int after_paging_init __initdata;
> > +
> > +void __init __attribute__((weak)) early_ioremap_shutdown(void)
> 
> __weak
> 
> Do __init and __weak work together?  They should, but I don't recall
> seeing it.

Yes. Will use __weak here and clean up the uses of WARN/WARN_ON
as noted.

Thanks.
