From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 29 Jan 2015 16:57:17 +0100
Subject: [PATCH v3 3/5] KVM: ARM VGIC add kvm_io_bus_ frontend
In-Reply-To: <54C7CE7A.200@arm.com>
References: <20150124115815.11052.20755.stgit@i3820>
 <20150124115947.11052.73994.stgit@i3820> <54C79339.3070800@arm.com>
 <CADDJ2=Mtc57F9pdMVPD8UfsOkkuEhDpe_txXiYJVAFtzigQgDQ@mail.gmail.com>
 <54C7CA2D.7060700@linaro.org> <54C7CE7A.200@arm.com>
Message-ID: <20150129155717.GA12396@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 05:44:26PM +0000, Andre Przywara wrote:
> Hi,
> 
> On 27/01/15 17:26, Eric Auger wrote:
> > On 01/27/2015 05:51 PM, Nikolay Nikolaev wrote:
> >> Hi Andre,
> >>
> >> On Tue, Jan 27, 2015 at 3:31 PM, Andre Przywara <andre.przywara@arm.com> wrote:
> >>>
> >>> Hi Nikolay,
> >>>
> >>> On 24/01/15 11:59, Nikolay Nikolaev wrote:
> >>>> In io_mem_abort remove the call to vgic_handle_mmio. The target is to have
> >>>> a single MMIO handling path - that is through the kvm_io_bus_ API.
> >>>>
> >>>> Register a kvm_io_device in kvm_vgic_init on the whole vGIC MMIO region.
> >>>> Both read and write calls are redirected to vgic_io_dev_access where
> >>>> kvm_exit_mmio is composed to pass it to vm_ops.handle_mmio.
> >>>>
> >>>>
> >>>> Signed-off-by: Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>
> >>>> ---
> >>>>  arch/arm/kvm/mmio.c    |    3 -
> >>>>  include/kvm/arm_vgic.h |    3 -
> >>>>  virt/kvm/arm/vgic.c    |  123 ++++++++++++++++++++++++++++++++++++++++++++----
> >>>>  3 files changed, 114 insertions(+), 15 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
> >>>> index d852137..8dc2fde 100644
> >>>> --- a/arch/arm/kvm/mmio.c
> >>>> +++ b/arch/arm/kvm/mmio.c
> >>>> @@ -230,9 +230,6 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
> >>>>                              fault_ipa, 0);
> >>>>       }
> >>>>
> >>>> -     if (vgic_handle_mmio(vcpu, run, &mmio))
> >>>> -             return 1;
> >>>> -
> >>>
> >>> Why is this (whole patch) actually needed? Is that just to make it nicer
> >>> by pulling everything under one umbrella?
> >>
> >>
> >> It started from this mail form Christofer:
> >> https://lkml.org/lkml/2014/3/28/403
> > Hi Nikolay, Andre,
> > 
> > I also understood that the target was to handle all kernel mmio through
> > the same API, hence the first patch. This patch shows that at least for
> > GICv2 it was doable without upheavals in vgic code and it also serves
> > ioeventd which is good. Andre do you think the price to pay to integrate
> > missing redistributors and forthcoming components is too high?
> 
> Hopefully not, actually I reckon that moving the "upper level" MMIO
> dispatching out of vgic.c and letting the specific VGIC models register
> what they need themselves (in their -emul.c files) sounds quite promising.
> But this particular patch does not serve this purpose:
> a) we replace two lines with a bunch of more layered code
> b) we copy the MMIOed data to convert between the interfaces
> c) we miss GICv3 emulation
> 
> So this needs to be addressed in a more general way (which maybe I will
> give a try). That being sad I don't see why we would need to do this
> right now and hold back ioeventfd by this rather orthogonal issue.
> 
> Christoffer, what's your take on this?
> 
Well, I'd like to not special-case the vgic handling function just
because we want to get this in sooner.

The fact that this is conflicting with gicv3 that just got in and that
we're at -rc6 now, makes me think it's probably too late to do proper
testing and review of this before queuing it, so why not fix it right
instead of saying "we'll fix this later" and never get to it...

-Christoffer
