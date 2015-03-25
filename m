From: mtosatti@redhat.com (Marcelo Tosatti)
Date: Wed, 25 Mar 2015 18:59:40 -0300
Subject: [PATCH v2 06/12] KVM: mark kvm->buses as empty once they were
 destroyed
In-Reply-To: <5512EBB9.2050304@arm.com>
References: <1427126309-11223-1-git-send-email-andre.przywara@arm.com>
 <1427126309-11223-7-git-send-email-andre.przywara@arm.com>
 <5512EBB9.2050304@arm.com>
Message-ID: <20150325215940.GE3649@amt.cnet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 25, 2015 at 05:09:13PM +0000, Marc Zyngier wrote:
> On 23/03/15 15:58, Andre Przywara wrote:
> > In kvm_destroy_vm() we call kvm_io_bus_destroy() pretty early,
> > especially before calling kvm_arch_destroy_vm(). To avoid
> > unregistering devices from the already destroyed bus, let's mark
> > the bus with NULL to let other users know it has been destroyed
> > already.
> > This avoids a crash on a VM shutdown with the VGIC using the
> > kvm_io_bus later (the unregistering is in there to be able to roll
> > back a faulting init).
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> That seems sensible, but I don't see why nobody else hits that. What are
> we doing differently?

It should be valid to call kvm_io_bus_unregister_dev after
kvm_io_bus_destroy.

Are you patching it to handle NULL kvm->buses[bus_idx] ?

> Otherwise,
> 
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Paolo, Marcelo, can we have your Ack on this?
> 
> Thanks,
