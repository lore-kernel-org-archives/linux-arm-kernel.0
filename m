From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 30 Apr 2013 10:53:55 +0200
Subject: [RFC/PATCH v2 2/2] drivers: dma-contiguous: add initialization
 from device tree
In-Reply-To: <CAO1A-8DiZoMVGcjOqK6VYP5Qito55i=gsKApQM=LGbQVx3iCwg@mail.gmail.com>
References: <1365679330-2514-1-git-send-email-m.szyprowski@samsung.com>
 <1365679330-2514-3-git-send-email-m.szyprowski@samsung.com>
 <CAO1A-8DiZoMVGcjOqK6VYP5Qito55i=gsKApQM=LGbQVx3iCwg@mail.gmail.com>
Message-ID: <517F86A3.6040104@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 4/29/2013 11:21 PM, Marc C wrote:
> >  /**
> >   * dma_contiguous_reserve() - reserve area(s) for contiguous memory handling
> >   * @limit: End address of the reserved memory (optional, 0 for any).
> > @@ -149,6 +200,10 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
> >
> >         pr_debug("%s(limit %08lx)\n", __func__, (unsigned long)limit);
> >
> > +#ifdef CONFIG_OF
> > +       of_scan_flat_dt(cma_fdt_scan, NULL);
> > +#endif
> > +
>
> What is your expectation with the contention between default region
> setup via the kernel config (CONFIG_CMA_SIZE_SEL_*) and via the DT?
> Could the call to 'of_scan_flat_dt()' be done before the setup of the
> kernel config early regions, followed by a return code check
> 'fail-over' scheme, or were you intending for the default region
> setups to be mutually-exclusive?

In the proposed patch the default/global cma region setup from device tree
had higher priority than kernel command line parameter and .config saved 
values,
but now as I think of this, it looks that it would make more sense to 
have the
following priority for setting up the default cma region:

1. kernel cmd line - if not available, then use:
2. device tree - if not available, then use:
3. kernel compiled .config

I will update this in the next version of the CMA DT patches.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
