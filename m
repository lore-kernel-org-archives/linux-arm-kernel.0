From: cdall@linaro.org (Christoffer Dall)
Date: Wed, 30 Aug 2017 13:58:01 +0200
Subject: [PATCH v3 57/59] KVM: arm/arm64: GICv4: Theory of operations
In-Reply-To: <d11d78be-409a-f015-b610-626fc7dccb02@arm.com>
References: <20170731172637.29355-1-marc.zyngier@arm.com>
 <20170731172637.29355-58-marc.zyngier@arm.com>
 <20170828181813.GD24649@cbox>
 <d11d78be-409a-f015-b610-626fc7dccb02@arm.com>
Message-ID: <20170830115801.GG24522@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 30, 2017 at 12:30:02PM +0100, Marc Zyngier wrote:
> On 28/08/17 19:18, Christoffer Dall wrote:
> > On Mon, Jul 31, 2017 at 06:26:35PM +0100, Marc Zyngier wrote:
> >> Yet another braindump so I can free some cells...
> >>
> >> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> >> ---
> >>  virt/kvm/arm/vgic/vgic-v4.c | 68 +++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 68 insertions(+)
> >>
> >> diff --git a/virt/kvm/arm/vgic/vgic-v4.c b/virt/kvm/arm/vgic/vgic-v4.c
> >> index 0a8deefbcf1c..0c002d2be620 100644
> >> --- a/virt/kvm/arm/vgic/vgic-v4.c
> >> +++ b/virt/kvm/arm/vgic/vgic-v4.c
> >> @@ -22,6 +22,74 @@
> >>  
> >>  #include "vgic.h"
> >>  
> >> +/*
> >> + * How KVM uses GICv4 (insert rude comments here):
> >> + *
> >> + * The vgic-v4 layer acts as a bridge between several entities:
> >> + * - The GICv4 ITS representation offered by the ITS driver
> >> + * - VFIO, which is in charge of the PCI endpoint
> >> + * - The virtual ITS, which is the only thing the guest sees
> >> + *
> >> + * The configuration of VLPIs is triggered by a callback from VFIO,
> >> + * instructing KVM that a PCI device has been configured to deliver
> >> + * MSIs to a vITS.
> >> + *
> >> + * kvm_vgic_v4_set_forwarding() is thus called with the routing entry,
> >> + * and this is used to find the corresponding vITS data structures
> >> + * (ITS instance, device, event and irq) using a process that is
> >> + * extremely similar to the injection of an MSI.
> >> + *
> >> + * At this stage, we can link the guest's view of an LPI (uniquely
> >> + * identified by the routing entry) and the host irq, using the GICv4
> >> + * driver mapping operation. Should the mapping succeed, we've then
> >> + * successfully upgraded the guest's LPI to a VLPI. We can then start
> >> + * with updating GICv4's view of the property table and generating an
> >> + * INValidation in order to kickstart the delivery of this VLPI to the
> >> + * guest directly, without software intervention. Well, almost.
> >> + *
> >> + * When the PCI endpoint is deconfigured, this operation is reversed
> >> + * with VFIO calling kvm_vgic_v4_unset_forwarding().
> >> + *
> >> + * Once the VLPI has been mapped, it needs to follow any change the
> >> + * guest performs on its LPI through the vITS. For that, a number of
> >> + * command handlers have hooks to communicate these changes to the HW:
> >> + * - Any invalidation triggers a call to its_prop_update_vlpi()
> >> + * - The INT command results in a irq_set_irqchip_state(), which
> >> + *   generates an INT on the corresponding VLPI.
> >> + * - The CLEAR command results in a irq_set_irqchip_state(), which
> >> + *   generates an CLEAR on the corresponding VLPI.
> >> + * - DISCARD translates into an unmap, similar to a call to
> >> + *   kvm_vgic_v4_unset_forwarding().
> > 
> > So is VFIO notified of this or does it still think the IRQ is
> > forwarded?  Or does it not care, and it's state maintained by the irq
> > subsystem?
> 
> VFIO shouldn't care. The whole forward/bypass looks pretty stateless,
> and VFIO will happily inject the interrupt if it gets remapped, as its
> own interrupt handlers are still live.
> 
> >> + * - MOVI is translated by an update of the existing mapping, changing
> >> + *   the target vcpu, resulting in a VMOVI being generated.
> >> + * - MOVALL is translated by a string of mapping updates (similar to
> >> + *   the handling of MOVI). MOVALL is horrible.
> >> + *
> >> + * Note that a DISCARD/MAPTI sequence emitted from the guest without
> >> + * reprogramming the PCI endpoint after MAPTI does not result in a
> >> + * VLPI being mapped, as there is no callback from VFIO (the guest
> >> + * will get the interrupt via the normal SW injection). Fixing this is
> >> + * not trivial, and requires some horrible messing with the VFIO
> >> + * internals. Not fun. Don't do that.
> > 
> > Is there not a quick way to check with VFIO or the irq subsystem if this
> > interrupt can be forwarded and attempt that when handling the MAPTI in
> > the vTIS, or does this break in horrible ways?
> 
> The problem we have here is that we need to map a purely virtual
> interrupt to a Linux IRQ. VFIO does that job by using the offset of the
> guest write into the MSI-X table and finding which MSI descriptor is
> associated with this entry, giving us the corresponding interrupt.
> 
> We could keep track of the previous mappings we've been given, use that
> as a hint for the new mapping, and be able to revert it should the guest
> update the MSI on the endpoint. It feels pretty involved for something
> that is pretty theoretical right now, but I'm happy to try it...
> 

I understand the problem now, and I think we should leave it alone until
someone comes along and shows us a performance problem with some guest
and driver that does this.


Thanks,
-Christoffer
