From: mst@redhat.com (Michael S. Tsirkin)
Date: Mon, 4 Jan 2016 22:12:47 +0200
Subject: [PATCH v2 17/32] arm: define __smp_xxx
In-Reply-To: <20160104133658.GY6344@twins.programming.kicks-ass.net>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-18-git-send-email-mst@redhat.com>
 <20160102112438.GU8644@n2100.arm.linux.org.uk>
 <20160103110158-mutt-send-email-mst@redhat.com>
 <20160104133658.GY6344@twins.programming.kicks-ass.net>
Message-ID: <20160104220938-mutt-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 02:36:58PM +0100, Peter Zijlstra wrote:
> On Sun, Jan 03, 2016 at 11:12:44AM +0200, Michael S. Tsirkin wrote:
> > On Sat, Jan 02, 2016 at 11:24:38AM +0000, Russell King - ARM Linux wrote:
> 
> > > My only concern is that it gives people an additional handle onto a
> > > "new" set of barriers - just because they're prefixed with __*
> > > unfortunately doesn't stop anyone from using it (been there with
> > > other arch stuff before.)
> > > 
> > > I wonder whether we should consider making the smp memory barriers
> > > inline functions, so these __smp_xxx() variants can be undef'd
> > > afterwards, thereby preventing drivers getting their hands on these
> > > new macros?
> > 
> > That'd be tricky to do cleanly since asm-generic depends on
> > ifndef to add generic variants where needed.
> > 
> > But it would be possible to add a checkpatch test for this.
> 
> Wasn't the whole purpose of these things for 'drivers' (namely
> virtio/xen hypervisor interaction) to use these?

My take out from discussion with you was that virtualization is probably
the only valid use-case.  So at David Miller's suggestion there's a
patch later in the series that adds virt_xxxx wrappers and these are
then used by virtio xen and later maybe others.

> And I suppose most of virtio would actually be modules, so you cannot do
> what I did with preempt_enable_no_resched() either.
> 
> But yes, it would be good to limit the use of these things.

Right so the trick is checkpatch warns about use of
__smp_xxx and hopefully people are not crazy enough
to use virt_xxx variants for non-virtual drivers.

-- 
MST
