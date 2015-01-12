From: anup@brainfault.org (Anup Patel)
Date: Mon, 12 Jan 2015 09:49:13 +0530
Subject: [RFC PATCH 0/6] ARM64: KVM: PMU infrastructure support
In-Reply-To: <20150111191131.GC3868@cbox>
References: <20141121114950.GB3401@cbox>
 <CAAhSdy3-+5T0sOEGHLtHbPQJ+3hXdZxL=695dq7PJ2J0qmVbTg@mail.gmail.com>
 <20141124143753.GO3401@cbox>
 <CAAhSdy0+Z8o6dx=Bq+Ep7ybQpTpj+QNJm4oJbKa8yCM7WS8oxg@mail.gmail.com>
 <20141125134239.GI31297@cbox>
 <CAAhSdy32G+-BVQk-=dWjfM1S-cytGavp4qq942m=3y7HUudguw@mail.gmail.com>
 <5476FFAF.2010601@arm.com>
 <CAAhSdy3US4H9DZLDmwawR6D22GUpQ8H5NqrZ8XvYJjhsnPzzRQ@mail.gmail.com>
 <547705BF.5040609@arm.com>
 <CAAhSdy32-MsRORQ9j3YfH4Fn7xCEEFV5O7D43sYbXZCsF4VgaQ@mail.gmail.com>
 <20150111191131.GC3868@cbox>
Message-ID: <CAAhSdy0FjX0TfkzThkmCz0k=mbnhJiE7tHU=jYUTFpxgDZZXeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 12:41 AM, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> On Tue, Dec 30, 2014 at 11:19:13AM +0530, Anup Patel wrote:
>> (dropping previous conversation for easy reading)
>>
>> Hi Marc/Christoffer,
>>
>> I tried implementing PMU context-switch via C code
>> in EL1 mode and in atomic context with irqs disabled.
>> The context switch itself works perfectly fine but
>> irq forwarding is not clean for PMU irq.
>>
>> I found another issue that is GIC only samples irq
>> lines if they are enabled. This means for using
>> irq forwarding we will need to ensure that host PMU
>> irq is enabled.  The arch_timer code does this by
>> doing request_irq() for host virtual timer interrupt.
>> For PMU, we can either enable/disable host PMU
>> irq in context switch or we need to do have shared
>> irq handler between kvm pmu and host kernel pmu.
>
> could we simply require the host PMU driver to request the IRQ and have
> the driver inject the corresponding IRQ to the VM via a mechanism
> similar to VFIO using an eventfd and irqfds etc.?

Currently, the host PMU driver does request_irq() only when
there is some event to be monitored. This means host will do
request_irq() only when we run perf application on host
user space.

Initially, I though that we could simply pass IRQF_SHARED
for request_irq() in host PMU driver and do the same for
reqest_irq() in KVM PMU code but the PMU irq can be
SPI or PPI. If the PMU irq is SPI then IRQF_SHARED
flag would fine but if its PPI then we have no way to
set IRQF_SHARED flag because request_percpu_irq()
does not have irq flags parameter.

>
> (I haven't quite thought through if there's a way for the host PMU
> driver to distinguish between an IRQ for itself and one for the guest,
> though).
>
> It does feel like we will need some sort of communication/coordination
> between the host PMU driver and KVM...
>
>>
>> I have rethinked about our discussion so far. I
>> understand that we need KVM PMU virtualization
>> to meet following criteria:
>> 1. No modification in host PMU driver
>
> is this really a strict requirement?  one of the advantages of KVM
> should be that the rest of the kernel should be supportive of KVM.

I guess so because host PMU driver should not do things
differently for host and guest. I think this the reason why
we discarded the mask/unmask PMU irq approach which
I had implemented in RFC v1.

>
>> 2. No modification in guest PMU driver
>> 3. No mask/unmask dance for sharing host PMU irq
>> 4. Clean way to avoid infinite VM exits due to
>> PMU interrupt
>>
>> I have discovered new approach which is as follows:
>> 1. Context switch PMU in atomic context (i.e. local_irq_disable())
>> 2. Ensure that host PMU irq is disabled when entering guest
>> mode and re-enable host PMU irq when exiting guest mode if
>> it was enabled previously.
>
> How does this look like software-engineering wise?  Would you be looking
> up the IRQ number from the DT in the KVM code again?  How does KVM then
> synchronize with the host PMU driver so they're not both requesting the
> same IRQ at the same time?

We only lookup host PMU irq numbers from DT at HYP init time.

During context switch we know the host PMU irq number for
current host CPU so we can get state of host PMU irq in
context switch code.

If we go by the shard irq handler approach then both KVM
and host PMU driver will do request_irq() on same host
PMU irq. In other words, there is no virtual PMU irq provided
by HW for guest.

>
>> This is to avoid infinite VM exits
>> due to PMU interrupt because as-per new approach we
>> don't mask the PMU irq via PMINTENSET_EL1 register.
>> 3. Inject virtual PMU irq at time of entering guest mode if PMU
>> overflow register is non-zero (i.e. PMOVSSET_EL0) in atomic
>> context (i.e. local_irq_disable()).
>>
>> The only limitation of this new approach is that virtual PMU irq
>> is injected at time of entering guest mode. This means guest
>> will receive virtual PMU  interrupt with little delay after actual
>> interrupt occurred.
>
> it may never receive it in the case of a tickless configuration AFAICT,
> so this doesn't sound like the right approach.

I think irrespective to any approach we take, we need a mechanism
to have shared irq handlers in KVM PMU and host PMU driver for
both PPI and SPI.

>
>> The PMU interrupts are only overflow events
>> and generally not used in any timing critical applications. If we
>> can live with this limitation then this can be a good approach
>> for KVM PMU virtualization.
>>
> Thanks,
> -Christoffer

Regards,
Anup
