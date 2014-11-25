From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 25 Nov 2014 11:19:23 +0100
Subject: [PATCH v4 2/3] KVM: arm: add irqfd support
In-Reply-To: <54735FF6.9000008@linaro.org>
References: <1416765420-12057-1-git-send-email-eric.auger@linaro.org>
 <1416765420-12057-3-git-send-email-eric.auger@linaro.org>
 <20141124100040.GJ3401@cbox> <5473104D.7000305@linaro.org>
 <CAMJs5B9SZXjaJVuCSpvmMH0f7PvutDBEudjy=BeXsFy-WeKEqA@mail.gmail.com>
 <54735FF6.9000008@linaro.org>
Message-ID: <20141125101923.GA31297@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Re-adding cc list]

On Mon, Nov 24, 2014 at 05:42:30PM +0100, Eric Auger wrote:
> On 11/24/2014 04:47 PM, Christoffer Dall wrote:
> > On Mon, Nov 24, 2014 at 12:02 PM, Eric Auger <eric.auger@linaro.org> wrote:
> >> On 11/24/2014 11:00 AM, Christoffer Dall wrote:
> >>> On Sun, Nov 23, 2014 at 06:56:59PM +0100, Eric Auger wrote:
> >>>> This patch enables irqfd on arm.
> >>>>
> >>>> Both irqfd and resamplefd are supported. Injection is implemented
> >>>> in vgic.c without routing.
> >>>>
> >>>> This patch enables CONFIG_HAVE_KVM_EVENTFD and CONFIG_HAVE_KVM_IRQFD.
> >>>>
> >>>> KVM_CAP_IRQFD is now advertised. KVM_CAP_IRQFD_RESAMPLE capability
> >>>> automatically is advertised as soon as CONFIG_HAVE_KVM_IRQFD is set.
> >>>>
> >>>> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> >>>>
> >>>> ---

[...]

> >>>> +int kvm_set_irq(struct kvm *kvm, int irq_source_id,
> >>>> +            u32 irq, int level, bool line_status)
> >>>> +{
> >>>> +    unsigned int spi = irq + VGIC_NR_PRIVATE_IRQS;
> >>>> +
> >>>> +    kvm_debug("irqfd sets vIRQ %d to %d\n", irq, level);
> >>>> +
> >>>> +    if (likely(vgic_initialized(kvm))) {
> >>>> +            if (spi > kvm->arch.vgic.nr_irqs)
> >>>> +                    return -EINVAL;
> >>>> +            return kvm_vgic_inject_irq(kvm, 0, spi, level);
> >>>> +    } else if (level && kvm_irq_has_notifier(kvm, 0, irq)) {
> >>>> +            /*
> >>>> +             * any IRQ injected before vgic readiness is
> >>>> +             * ignored and the notifier, if any, is called
> >>>> +             * immediately as if the virtual IRQ were completed
> >>>> +             * by the guest
> >>>> +             */
> >>>> +            kvm_notify_acked_irq(kvm, 0, irq);
> >>>> +            return -EAGAIN;
> >>>
> >>> This looks fishy, I don't fully understand which case you're catering
> >>> towards here (the comment is hard to understand), but my gut feeling is
> >>> that you should back out (probably with an error) if the vgic is not
> >>> initialized when calling this function.  Setting up the routing in the
> >>> first place should probably error out if the vgic is not available.
> >> The issue is related to integration with QEMU and VFIO.
> >> Currently VFIO signaling (we tell VFIO to signal the eventfd on a
> >> peculiar physical IRQ) and irqfd setup (we tell KVM/IRQFD to handle
> >> previous eventfd when triggered and inject a GSI) are done by QEMU
> >> *before* the first vcpu run. so before VGIC is ready.
> >>
> >> Both are done in a so called QEMU machine init done notifier. It could
> >> be done in a QEMU reset notifier but I guess the problem would be the
> >> same. and I think the same at which QEMU initializes it is correct.
> >>
> >> As soon as both VFIO signaling and irqfd are setup, virtual IRQ are
> >> likely to be injected and this is what happens on some circumstances.
> >> This happens on the 2d QEMU run after killing the 1st QEMU session. For
> >> some reason I guess the HW device - in my case the xgmac - was released
> >> in such a way the IRQ wire was not reset. So as soon as VFIO driver
> >> calls request_irq, the IRQ hits.
> >>
> >> I tried to change that this xgmac driver behavior but I must acknowledge
> >> that for the time beeing I failed. I will continue investigating that.
> >>
> >> Indeed I might be fixing the issue at the wrong place. But anyway this
> >> relies on the fact the assigned device driver toggled down the IRQ
> >> properly when releasing. At the time the signaling is setup we have not
> >> entered yet any driver reset code.
> >>
> > I see, it's because of the quirky way we initialize the vgic at time
> > of running the first CPU, so user space can't really hook into the
> > sweet spot after initializing the vgic but just before actually
> > running guest code.
> 
> Yes currently irqfd generic code has no way to test if the virtual
> interrupt controller is "ready" (KVM__IRQFD -> kvm_irqfd_assign )
> because I guess other archs don't have the problem.
> > 
> > Could it be that we simply need to let user space init the vgic after
> > creating all its vcpus and only then allow setting up the irqfd?
> 
> I start VFIO signaling and setup KVM_IRQFD in a QEMU machine init done
> notifier. the vgic init then must happen before then.

have all the vcpus that QEMU wants to create, been created by then?

> 
> Currently the VGIC KVM device has group/attributes that allow to set
> registers (vgic_attr_regs_access) and *partially* init the state
> (vgic_init_maps). Enhancing that we could indeed force the vgic init
> earlier.
> 

We would probably add a new attribute to the vgic device api if we were
to go down that road.

> > 
> > Alternatively we can refactor the whole thing so that we don't mess
> > with the pending state etc. directly in the vgic_update_irq function,
> > but just sets the level state (or remember that there was an edge,
> > hummm, maybe not) and later propagate this to the vcpus in
> > compute_pending_for_cpu().
> 
> yes we could indeed record a level info very early and not do anything
> with it until the vgic is ready. This would oblige to init the level
> bitmap yet in another earlier stage.

there's an unsolved problem that you may not have created all your data
structures or know how many IRQs you have at this point, right?

> > 
> > What you're doing here is to continously ack and re-request the irq
> > from the vfio driver until you are ready to receive it, is that right?
> yes I unmask the IRQ so that it can hit again (it was deactivated by the
> host and masked the VFIO platform driver). If I don't call the notifier
> it will remain masked and never hit again.
> 
Don't you simply loose the interrupt for edge-triggered interrupts then?

-Christoffer
