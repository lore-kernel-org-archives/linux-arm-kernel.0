From: eric.auger@linaro.org (Eric Auger)
Date: Wed, 26 Nov 2014 14:00:44 +0100
Subject: [PATCH v4 2/3] KVM: arm: add irqfd support
In-Reply-To: <20141126113137.GD27070@cbox>
References: <1416765420-12057-1-git-send-email-eric.auger@linaro.org>
 <1416765420-12057-3-git-send-email-eric.auger@linaro.org>
 <20141124100040.GJ3401@cbox> <5473104D.7000305@linaro.org>
 <CAMJs5B9SZXjaJVuCSpvmMH0f7PvutDBEudjy=BeXsFy-WeKEqA@mail.gmail.com>
 <54735FF6.9000008@linaro.org> <20141125101923.GA31297@cbox>
 <5474803F.4000408@linaro.org> <20141126113137.GD27070@cbox>
Message-ID: <5475CEFC.4000102@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2014 12:31 PM, Christoffer Dall wrote:
> On Tue, Nov 25, 2014 at 02:12:31PM +0100, Eric Auger wrote:
>> On 11/25/2014 11:19 AM, Christoffer Dall wrote:
>>> [Re-adding cc list]
>>>
>>> On Mon, Nov 24, 2014 at 05:42:30PM +0100, Eric Auger wrote:
>>>> On 11/24/2014 04:47 PM, Christoffer Dall wrote:
>>>>> On Mon, Nov 24, 2014 at 12:02 PM, Eric Auger <eric.auger@linaro.org> wrote:
>>>>>> On 11/24/2014 11:00 AM, Christoffer Dall wrote:
>>>>>>> On Sun, Nov 23, 2014 at 06:56:59PM +0100, Eric Auger wrote:
>>>>>>>> This patch enables irqfd on arm.
>>>>>>>>
>>>>>>>> Both irqfd and resamplefd are supported. Injection is implemented
>>>>>>>> in vgic.c without routing.
>>>>>>>>
>>>>>>>> This patch enables CONFIG_HAVE_KVM_EVENTFD and CONFIG_HAVE_KVM_IRQFD.
>>>>>>>>
>>>>>>>> KVM_CAP_IRQFD is now advertised. KVM_CAP_IRQFD_RESAMPLE capability
>>>>>>>> automatically is advertised as soon as CONFIG_HAVE_KVM_IRQFD is set.
>>>>>>>>
>>>>>>>> Signed-off-by: Eric Auger <eric.auger@linaro.org>
>>>>>>>>
>>>>>>>> ---
>>>
>>> [...]
>>>
>>>>>>>> +int kvm_set_irq(struct kvm *kvm, int irq_source_id,
>>>>>>>> +            u32 irq, int level, bool line_status)
>>>>>>>> +{
>>>>>>>> +    unsigned int spi = irq + VGIC_NR_PRIVATE_IRQS;
>>>>>>>> +
>>>>>>>> +    kvm_debug("irqfd sets vIRQ %d to %d\n", irq, level);
>>>>>>>> +
>>>>>>>> +    if (likely(vgic_initialized(kvm))) {
>>>>>>>> +            if (spi > kvm->arch.vgic.nr_irqs)
>>>>>>>> +                    return -EINVAL;
>>>>>>>> +            return kvm_vgic_inject_irq(kvm, 0, spi, level);
>>>>>>>> +    } else if (level && kvm_irq_has_notifier(kvm, 0, irq)) {
>>>>>>>> +            /*
>>>>>>>> +             * any IRQ injected before vgic readiness is
>>>>>>>> +             * ignored and the notifier, if any, is called
>>>>>>>> +             * immediately as if the virtual IRQ were completed
>>>>>>>> +             * by the guest
>>>>>>>> +             */
>>>>>>>> +            kvm_notify_acked_irq(kvm, 0, irq);
>>>>>>>> +            return -EAGAIN;
>>>>>>>
>>>>>>> This looks fishy, I don't fully understand which case you're catering
>>>>>>> towards here (the comment is hard to understand), but my gut feeling is
>>>>>>> that you should back out (probably with an error) if the vgic is not
>>>>>>> initialized when calling this function.  Setting up the routing in the
>>>>>>> first place should probably error out if the vgic is not available.
>>>>>> The issue is related to integration with QEMU and VFIO.
>>>>>> Currently VFIO signaling (we tell VFIO to signal the eventfd on a
>>>>>> peculiar physical IRQ) and irqfd setup (we tell KVM/IRQFD to handle
>>>>>> previous eventfd when triggered and inject a GSI) are done by QEMU
>>>>>> *before* the first vcpu run. so before VGIC is ready.
>>>>>>
>>>>>> Both are done in a so called QEMU machine init done notifier. It could
>>>>>> be done in a QEMU reset notifier but I guess the problem would be the
>>>>>> same. and I think the same at which QEMU initializes it is correct.
>>>>>>
>>>>>> As soon as both VFIO signaling and irqfd are setup, virtual IRQ are
>>>>>> likely to be injected and this is what happens on some circumstances.
>>>>>> This happens on the 2d QEMU run after killing the 1st QEMU session. For
>>>>>> some reason I guess the HW device - in my case the xgmac - was released
>>>>>> in such a way the IRQ wire was not reset. So as soon as VFIO driver
>>>>>> calls request_irq, the IRQ hits.
>>>>>>
>>>>>> I tried to change that this xgmac driver behavior but I must acknowledge
>>>>>> that for the time beeing I failed. I will continue investigating that.
>>>>>>
>>>>>> Indeed I might be fixing the issue at the wrong place. But anyway this
>>>>>> relies on the fact the assigned device driver toggled down the IRQ
>>>>>> properly when releasing. At the time the signaling is setup we have not
>>>>>> entered yet any driver reset code.
>>>>>>
>>>>> I see, it's because of the quirky way we initialize the vgic at time
>>>>> of running the first CPU, so user space can't really hook into the
>>>>> sweet spot after initializing the vgic but just before actually
>>>>> running guest code.
>>>>
>>>> Yes currently irqfd generic code has no way to test if the virtual
>>>> interrupt controller is "ready" (KVM__IRQFD -> kvm_irqfd_assign )
>>>> because I guess other archs don't have the problem.
>>>>>
>>>>> Could it be that we simply need to let user space init the vgic after
>>>>> creating all its vcpus and only then allow setting up the irqfd?
>>>>
>>>> I start VFIO signaling and setup KVM_IRQFD in a QEMU machine init done
>>>> notifier. the vgic init then must happen before then.
>>>
>>> have all the vcpus that QEMU wants to create, been created by then?
>> Hi Christoffer,
>>
>> My understanding of QEMU start sequence is as follows:
>> at machine init, CPU realize function is called for each CPU
>> (target-arm/cpu.c arm_cpu_realizefn)
>> qemu_init_vcpu (cpus.c) > qemu_kvm_start_vcpu (cpus.c) > launch VCPU
>> thread (qemu_kvm_cpu_thread_fn) > kvm_init_vcpu
>> kvm_init_vcpu does the while (1) loop issuing KVM_RUN ioctl if *cpu_can_run*
>>
>> cpu_can_run returns true when vm_start is called
>> (resume_all_vcpus>cpu_resume)
>>
>> QEMU machine init done or reset callbacks happen after machine init and
>> before vm_start.
>>
>> The actual vgic "readiness" is set in the first vcpu run, ie on the
>> vm_start.
>>
>> vgic instantiation in virt machine file is done after cpu_instantiation.
>> We could force vgic init at that time, in the gic realize fn
>> (kvm_arm_gic_realize)?. All vcpus are instantiated: nr_vcpus and nr_irqs
>> are known. Also base addresses are known.
>>
>>>
>>>>
>>>> Currently the VGIC KVM device has group/attributes that allow to set
>>>> registers (vgic_attr_regs_access) and *partially* init the state
>>>> (vgic_init_maps). Enhancing that we could indeed force the vgic init
>>>> earlier.
>>>>
>>>
>>> We would probably add a new attribute to the vgic device api if we were
>>> to go down that road.
>> yes
>>>
>>>>>
>>>>> Alternatively we can refactor the whole thing so that we don't mess
>>>>> with the pending state etc. directly in the vgic_update_irq function,
>>>>> but just sets the level state (or remember that there was an edge,
>>>>> hummm, maybe not) and later propagate this to the vcpus in
>>>>> compute_pending_for_cpu().
>>>>
>>>> yes we could indeed record a level info very early and not do anything
>>>> with it until the vgic is ready. This would oblige to init the level
>>>> bitmap yet in another earlier stage.
>>>
>>> there's an unsolved problem that you may not have created all your data
>>> structures or know how many IRQs you have at this point, right?
>> yes that's correct, at that time we do not know the nr_irqs.
>>>
>>>>>
>>>>> What you're doing here is to continously ack and re-request the irq
>>>>> from the vfio driver until you are ready to receive it, is that right?
>>>> yes I unmask the IRQ so that it can hit again (it was deactivated by the
>>>> host and masked the VFIO platform driver). If I don't call the notifier
>>>> it will remain masked and never hit again.
>>>>
>>> Don't you simply loose the interrupt for edge-triggered interrupts then?
>> yes we do. Even for level-sensitive, we loose them!
> 
> for level-sensitive you can ack the interrupt and it will fire again, so
> you'll eventually notify your guest.  For edge-triggered interrupts,
> your current code will ack it, it will not fire again, the guest will
> never know it hit, and everything may stop.
> 
>>
>> But I think the core of the problem is why those IRQs do hit! And I now
>> realize I did not have a good representation of what happens on the ctrl
>> C of QEMU. the xgmac driver remove function is not called at all I guess
>> (explaining why when hacking it to clear IRQ and disable IRQ it did not
>> change anything :-( /me/ stupid). So the HW is left free running. Might
>> happen a XGMAC IRQ was high at that time. When VFIO driver is released,
>> it does not change the state of the XGMAC HW but this calls free_irq of
>> the physical IRQ. When QEMU reloads the VFIO driver on the second time
>> and call request_irq, it re-enables the IRQ at VGIC and XGMAC IRQ hit.
>>
>> The problem we observe relates to the lack of proper reset of the device
>> - old discussion we had with Alex in Feb! -.
>>
>> Those IRQ relate to the HW state of the last QEMU session. It may be
>> acceptable to ignore them until the guest duly resets the device.
>> handling the IRQ in the new QEMU session may be wrong as well. Some
>> devices might not understand why they get a functional IRQ while they
>> are not even initialized!
>>
>> The other alternative is to implement some device dependent reset on
>> host kernel side, some kind of kernel hook to the vfio driver but here
>> it is another rough path ...
>>
> 
> I can't see how reset ties into this specific problem.
> 
> To summarize, I think you need to find a way to not enable irqfd for an
> interrupt before the vgic is ready, and when the vgic is ready,
> (regardless of the guest is running or not, or if the device is reset or
> not) then you can always accept an incoming interrupt and the guest will
> see it when it enables the interrupt and its gic (the vgic that is).
Well,

- in that case I need to touch the generic part of irqfd.c and add a
arch hook to test the virtual interrupt controller state.
- then the problem is moved to QEMU. How to detect when to setup VFIO
signaling + IRQFD? ideally it would be simpler to force the VGIC
initialization before the actual vm_start, after instantiation of the
KVM device? Requires addition of an attribute for that at KVM device. In
case we keep the current initialization model (on first vcpu run), I
need to use some timer (?).
- somehow this is not only a problem of irqfd but rather a problem of
VFIO. When you do not use irqfd and handle the eventfd on user-side you
also inject virtual IRQs in the vgic. I think the scheduling model of
QEMU make it work but isn't it by chance?

Best Regards

Eric


> 
> Taking a step back, this seems like the obvious approach, because
> a hardware GIC implementation also doesn't say "hey, my CPUs aren't up
> yet, so I'm going to return an error to your raised CPU line and/or
> defer crazy stuff".  The signal is just going to set the interrupt
> pending on the distributor, and we need to make sure that whenever we
> enable this stuff, we follow those semantics.
> 
> -Christoffer
> 
