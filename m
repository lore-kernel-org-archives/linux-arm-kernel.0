From: cdall@linaro.org (Christoffer Dall)
Date: Mon, 13 Nov 2017 12:29:46 +0100
Subject: [PATCH v4 00/21] SError rework + RAS&IESB for firmware first
 support
In-Reply-To: <5A049B20.6000501@arm.com>
References: <20171019145807.23251-1-james.morse@arm.com>
 <5A049B20.6000501@arm.com>
Message-ID: <20171113112946.GK14144@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 09, 2017 at 06:14:56PM +0000, James Morse wrote:
> Hi guys,
> 
> On 19/10/17 15:57, James Morse wrote:
> > Known issues:
> [...]
> >  * KVM-Migration: VDISR_EL2 is exposed to userspace as DISR_EL1, but how should
> >    HCR_EL2.VSE or VSESR_EL2 be migrated when the guest has an SError pending but
> >    hasn't taken it yet...?
> 
> I've been trying to work out how this pending-SError-migration could work.
> 
> If HCR_EL2.VSE is set then the guest will take a virtual SError when it next
> unmasks SError. Today this doesn't get migrated, but only KVM sets this bit as
> an attempt to kill the guest.
> 
> This will be more of a problem with GengDongjiu's SError CAP for triggering
> guest SError from user-space, which will also allow the VSESR_EL2 to be
> specified. (this register becomes the guest ESR_EL1 when the virtual SError is
> taken and is used to emulate firmware-first's NOTIFY_SEI and eventually
> kernel-first RAS). These errors are likely to be handled by the guest.
> 
> 
> We don't want to expose VSESR_EL2 to user-space, and for migration it isn't
> enough as a value of '0' doesn't tell us if HCR_EL2.VSE is set.
> 
> To get out of this corner: why not declare pending-SError-migration an invalid
> thing to do?

To answer that question we'd have to know if that is generally a valid
thing to require.  How will higher level tools in the stack deal with
this (e.g. libvirt, and OpenStack).  Is it really valid to tell them
"nope, can't migrate right now".  I'm thinking if you have a failing
host and want to signal some error to the guest, that's probably a
really good time to migrate your mission-critical VM away to a different
host, and being told, "sorry, cannot do this" would be painful.  I'm
cc'ing Drew for his insight into libvirt and how this is done on x86,
but I'm not really crazy about this idea.

> 
> We can give Qemu a way to query if a virtual SError is (still) pending. Qemu
> would need to check this on each vcpu after migration, just before it throws the
> switch and the guest runs on the new host. This way the VSESR_EL2 value doesn't
> need migrating at all.
> 
> In the ideal world, Qemu could re-inject the last SError it triggered if there
> is still one pending when it migrates... but because KVM injects errors too, it
> would need to block migration until this flag is cleared.

I don't understand your conclusion here.

If QEMU can query the virtual SError pending state, it can also inject
that before running the VM after a restore, and we should have preserved
the same state.

> KVM can promise this doesn't change unless you run the vcpu, so provided the
> vcpu actually takes the SError at some point this thing can still be migrated.
> 
> This does make the VSE machinery hidden unmigratable state in KVM, which is nasty.

Yes, nasty.

> 
> Can anyone suggest a better way?
> 

I'm thinking this is analogous to migrating a VM that uses an irqchip in
userspace and has set the IRQ or FIQ lines using KVM_IRQ_LINE.  My
feeling is that this is also not supported today.

My suggestion would be to add some set of VCPU exception state,
potentially as flags, which can be migrated along with the VM, or at
least used by userspace to query the state of the VM, if there exists a
reliable mechanism to restore the state again without any side effects.

I think we have to comb through Documentation/virtual/kvm/api.txt to see
if we can reuse anything, and if not, add something.  We could also
consider adding something to Documentation/virtual/kvm/devices/vcpu.txt,
where I think we have a large number space to use from.

Hope this helps?

-Christoffer
