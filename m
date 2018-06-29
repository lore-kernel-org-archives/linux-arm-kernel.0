From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 29 Jun 2018 11:12:44 +0100
Subject: [PATCH 0/4] KVM: arm/arm64: vgic: Virtual interrupt grouping
 support
In-Reply-To: <20180629092816.GE8441@e113682-lin.lund.arm.com>
References: <20180624221103.15055-1-christoffer.dall@arm.com>
 <CAFEAcA_C6Voh_6Ljj9--cbo14X_uWTOekM30dU=Rp9CtZK-6ow@mail.gmail.com>
 <20180625101347.GF8004@C02W217FHV2R.local>
 <20180625115603.GG8004@C02W217FHV2R.local>
 <86h8lmyn28.wl-marc.zyngier@arm.com>
 <20180629092816.GE8441@e113682-lin.lund.arm.com>
Message-ID: <86d0w9zysj.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Jun 2018 10:28:16 +0100,
Christoffer Dall <christoffer.dall@arm.com> wrote:
> 
> On Fri, Jun 29, 2018 at 10:11:27AM +0100, Marc Zyngier wrote:
> > On Mon, 25 Jun 2018 12:56:03 +0100,
> > Christoffer Dall <christoffer.dall@arm.com> wrote:
> > > 
> > > On Mon, Jun 25, 2018 at 12:13:47PM +0200, Christoffer Dall wrote:
> > > > On Mon, Jun 25, 2018 at 10:52:41AM +0100, Peter Maydell wrote:
> > > > Interesting.  For GICv2, I think this will actually break, and the
> > > > migrated Linux guest won't see any interrupts anymore (Linux only sets
> > > > bit 0 in GICD_CTLR).  For GICv3, everything stays group 1 unless the
> > > > guest is specifically trying to configure group 0 for something.
> > > > 
> > > > I suppose this means we need to let userspace request
> > > > ARCH_COMPLIANT_GICV2 and otherwise ignore userspace writes to IGROUPR?
> > > > 
> > > Alternatively, we could deny (fail) migration where the
> > > GICD_IIDR.Revision does not match the source, and just let userspace fix
> > > things up.  Thoughts?
> > 
> > That's exactly the kind of thing I had in mind when I suggested to
> > bump up the IIDR. It allows us to push the knowledge of the quirks to
> > both the guest and userspace, instead of adding more esoteric API
> > features.
> > 
> 
> The problem with that is that upgrading the kernel (but not QEMU) on
> your destination machine now breaks migration.  Is that acceptable?

Each time we add a new sysreg, we do break migration as well (in the
other direction though), and I'm not sure we can do much about it
(that's a QEMU policy, and not the kernel's).

What we could do is to allow IIDR to be written from userspace, and
pick one behaviour or the other. This would allow compatibility in the
forward direction, at least, and we have the ITS as a precedent for
this behaviour.

Thanks,

	M.

-- 
Jazz is not dead, it just smell funny.
