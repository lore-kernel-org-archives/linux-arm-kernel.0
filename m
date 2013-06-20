From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Jun 2013 19:38:18 +0100
Subject: [PATCH 3/5] ARM: KVM: make sure maintainance operation complete
 before world switch
In-Reply-To: <20130620182847.GD4563@lvm>
References: <1371648006-8036-1-git-send-email-marc.zyngier@arm.com>
 <1371648006-8036-4-git-send-email-marc.zyngier@arm.com>
 <20130620001820.GJ7870@lvm> <51C2B9A2.1020401@arm.com>
 <20130620171409.GB4563@lvm>
 <20130620181525.GC25734@mudshark.cambridge.arm.com>
 <20130620182847.GD4563@lvm>
Message-ID: <20130620183818.GD25734@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 07:28:47PM +0100, Christoffer Dall wrote:
> On Thu, Jun 20, 2013 at 07:15:25PM +0100, Will Deacon wrote:
> > On Thu, Jun 20, 2013 at 06:14:09PM +0100, Christoffer Dall wrote:
> > > ok, I was trying to think about how it would break, and if a guest needs
> > > a TLB invalidation to be visisble by other CPUs it would have to have a
> > > dsb/isb itself after the operation, and that would eventually be
> > > executed once the VCPU was rescheduled, but potentially on another CPU,
> > > but then I wonder if the PCPU migration on the host wouldn't take care
> > > of it?
> > 
> > Actually, it's worse than both of you think :)
> > 
> > The dsb *must* be executed on the same physical CPU as the TLB invalidation.
> > The same virtual CPU isn't enough, which is all that is guaranteed by the
> > guest. If you don't have a dsb on your vcpu migration path, then you need
> > something here.
> > 
> > The same thing applies to cache maintenance operations.
> > 
> But are we not sure that a dsb will happen anywhere in the kernel if a
> process is migrated to a different core?

Yes, we have a dsb when we unlock the runqueue for a CPU. That's why Linux
doesn't crash and burn usually. If vcpu migration always goes through the
usual scheduling paths, then you don't have a problem.

Will
