From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 21 Dec 2015 14:50:28 +0000
Subject: [Qemu-devel] [Xen-devel] new barrier type for paravirt (was Re:
 [PATCH] virtio_ring: use smp_store_mb)
In-Reply-To: <5677D8D5.7080700@citrix.com>
References: <1450347932-16325-1-git-send-email-mst@redhat.com>
 <20151217105238.GA6375@twins.programming.kicks-ass.net>
 <20151217131554-mutt-send-email-mst@redhat.com>
 <20151217135726.GA6344@twins.programming.kicks-ass.net>
 <20151217161124-mutt-send-email-mst@redhat.com>
 <20151217143910.GD6344@twins.programming.kicks-ass.net>
 <20151220105146-mutt-send-email-mst@redhat.com> <5677D8D5.7080700@citrix.com>
Message-ID: <alpine.DEB.2.02.1512211139150.17516@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Dec 2015, David Vrabel wrote:
> On 20/12/15 09:25, Michael S. Tsirkin wrote:
> > 
> > I noticed that drivers/xen/xenbus/xenbus_comms.c uses
> > full memory barriers to communicate with the other side.
> > For example:
> > 
> >                 /* Must write data /after/ reading the consumer index.  * */
> >                 mb();
> > 
> >                 memcpy(dst, data, avail);
> >                 data += avail;
> >                 len -= avail;
> >         
> >                 /* Other side must not see new producer until data is * there. */
> >                 wmb();
> >                 intf->req_prod += avail;
> >                 
> >                 /* Implies mb(): other side will see the updated producer. */
> >                 notify_remote_via_evtchn(xen_store_evtchn);
> > 
> > To me, it looks like for guests compiled with CONFIG_SMP, smp_wmb and smp_mb
> > would be sufficient, so mb() and wmb() here are only needed if
> > a non-SMP guest runs on an SMP host.
> > 
> > Is my analysis correct?
> 
> For x86, yes.
> 
> For arm/arm64 I think so, but would prefer one of the Xen arm
> maintainers to confirm.  In particular, whether inner-shareable barriers
> are sufficient for memory shared with the hypervisor.

inner-shareable barriers are certainly OK. In this case there would be
also a switch from dsb to dmb barriers, which I also think should be OK.

What about all the mb() and wmb() in RING_PUSH_REQUESTS and
RING_PUSH_RESPONSES in include/xen/interface/io/ring.h ?


> > So what I'm suggesting is something like the below patch,
> > except instead of using virtio directly, a new set of barriers
> > that behaves identically for SMP and non-SMP guests will be introduced.
> > 
> > And of course the weak barriers flag is not needed for Xen -
> > that's a virtio only thing.
> > 
> > For example:
> > 
> > smp_pv_wmb()
> > smp_pv_rmb()
> > smp_pv_mb()
> 
> The smp_ prefix doesn't make a lot of sense to me here since these
> barriers are going to be the same whether the kernel is SMP or not.
