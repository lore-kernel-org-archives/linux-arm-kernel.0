From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 17 Jul 2015 14:06:41 +0100
Subject: [Xen-devel] [PATCH v2 13/20] xen/events: fifo: Make it running
 on 64KB granularity
In-Reply-To: <55A7D955.5090203@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-14-git-send-email-julien.grall@citrix.com>
 <alpine.DEB.2.02.1507161642130.17378@kaball.uk.xensource.com>
 <55A7D955.5090203@citrix.com>
Message-ID: <alpine.DEB.2.02.1507171405210.17378@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Jul 2015, Julien Grall wrote:
> Hi Stefano,
> 
> On 16/07/2015 16:43, Stefano Stabellini wrote:
> > On Thu, 9 Jul 2015, Julien Grall wrote:
> > > Only use the first 4KB of the page to store the events channel info. It
> > > means that we will wast 60KB every time we allocate page for:
> >                        ^ waste
> > 
> > >       * control block: a page is allocating per CPU
> > >       * event array: a page is allocating everytime we need to expand it
> > > 
> > > I think we can reduce the memory waste for the 2 areas by:
> > > 
> > >      * control block: sharing between multiple vCPUs. Although it will
> > >      require some bookkeeping in order to not free the page when the CPU
> > >      goes offline and the other CPUs sharing the page still there
> > > 
> > >      * event array: always extend the array event by 64K (i.e 16 4K
> > >      chunk). That would require more care when we fail to expand the
> > >      event channel.
> > 
> > But this is not implemented in this series, right?
> 
> Yes, it's some ideas to improve the code.
> 
> > 
> > 
> > > Signed-off-by: Julien Grall <julien.grall@citrix.com>
> > > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > > Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > > Cc: David Vrabel <david.vrabel@citrix.com>
> > > ---
> > >   drivers/xen/events/events_base.c | 2 +-
> > >   drivers/xen/events/events_fifo.c | 2 +-
> > >   2 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/xen/events/events_base.c
> > > b/drivers/xen/events/events_base.c
> > > index 96093ae..858d2f6 100644
> > > --- a/drivers/xen/events/events_base.c
> > > +++ b/drivers/xen/events/events_base.c
> > > @@ -40,11 +40,11 @@
> > >   #include <asm/idle.h>
> > >   #include <asm/io_apic.h>
> > >   #include <asm/xen/pci.h>
> > > -#include <xen/page.h>
> > >   #endif
> > >   #include <asm/sync_bitops.h>
> > >   #include <asm/xen/hypercall.h>
> > >   #include <asm/xen/hypervisor.h>
> > > +#include <xen/page.h>
> > > 
> > >   #include <xen/xen.h>
> > >   #include <xen/hvm.h>
> > 
> > Spurious change?
> 
> No, xen/page.h was only included for x86 before. Now, it's included for every
> architecture.
> 
> This is required in order to get XEN_PAGE_SIZE.

Ah, right.

Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
