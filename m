From: anup@brainfault.org (Anup Patel)
Date: Thu, 8 Jan 2015 09:32:44 +0530
Subject: [RFC PATCH 0/6] ARM64: KVM: PMU infrastructure support
In-Reply-To: <CAAhSdy32-MsRORQ9j3YfH4Fn7xCEEFV5O7D43sYbXZCsF4VgaQ@mail.gmail.com>
References: <CAMJs5B8VqS2-3dhSX+PBaQruzyXiYwaYRQ7vvWEMrHbvbjn+9A@mail.gmail.com>
 <CAAhSdy3iyMpXLh1Qq-TqZ-1W368kG0Oz9iE2McnJkYbA9ZaNPg@mail.gmail.com>
 <20141119152952.GB9776@lvm>
 <CAAhSdy2rQf-26SjeEspcc+LgwmhDr+QeYOOSyOUApF+0-8WdeA@mail.gmail.com>
 <20141121095922.GR19598@cbox>
 <CAAhSdy37W-iK2QznzVtwvZx427xDmm3kGEzN7KdOhvXvBuwwQQ@mail.gmail.com>
 <20141121114950.GB3401@cbox>
 <CAAhSdy3-+5T0sOEGHLtHbPQJ+3hXdZxL=695dq7PJ2J0qmVbTg@mail.gmail.com>
 <20141124143753.GO3401@cbox>
 <CAAhSdy0+Z8o6dx=Bq+Ep7ybQpTpj+QNJm4oJbKa8yCM7WS8oxg@mail.gmail.com>
 <20141125134239.GI31297@cbox>
 <CAAhSdy32G+-BVQk-=dWjfM1S-cytGavp4qq942m=3y7HUudguw@mail.gmail.com>
 <5476FFAF.2010601@arm.com>
 <CAAhSdy3US4H9DZLDmwawR6D22GUpQ8H5NqrZ8XvYJjhsnPzzRQ@mail.gmail.com>
 <547705BF.5040609@arm.com>
 <CAAhSdy32-MsRORQ9j3YfH4Fn7xCEEFV5O7D43sYbXZCsF4VgaQ@mail.gmail.com>
Message-ID: <CAAhSdy1V4qwMsiXK6HHw-HMd6kXMNnRvY4oL5jK-qsPB4MK3pA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 30, 2014 at 11:19 AM, Anup Patel <anup@brainfault.org> wrote:
> (dropping previous conversation for easy reading)
>
> Hi Marc/Christoffer,
>
> I tried implementing PMU context-switch via C code
> in EL1 mode and in atomic context with irqs disabled.
> The context switch itself works perfectly fine but
> irq forwarding is not clean for PMU irq.
>
> I found another issue that is GIC only samples irq
> lines if they are enabled. This means for using
> irq forwarding we will need to ensure that host PMU
> irq is enabled.  The arch_timer code does this by
> doing request_irq() for host virtual timer interrupt.
> For PMU, we can either enable/disable host PMU
> irq in context switch or we need to do have shared
> irq handler between kvm pmu and host kernel pmu.
>
> I have rethinked about our discussion so far. I
> understand that we need KVM PMU virtualization
> to meet following criteria:
> 1. No modification in host PMU driver
> 2. No modification in guest PMU driver
> 3. No mask/unmask dance for sharing host PMU irq
> 4. Clean way to avoid infinite VM exits due to
> PMU interrupt
>
> I have discovered new approach which is as follows:
> 1. Context switch PMU in atomic context (i.e. local_irq_disable())
> 2. Ensure that host PMU irq is disabled when entering guest
> mode and re-enable host PMU irq when exiting guest mode if
> it was enabled previously. This is to avoid infinite VM exits
> due to PMU interrupt because as-per new approach we
> don't mask the PMU irq via PMINTENSET_EL1 register.
> 3. Inject virtual PMU irq at time of entering guest mode if PMU
> overflow register is non-zero (i.e. PMOVSSET_EL0) in atomic
> context (i.e. local_irq_disable()).
>
> The only limitation of this new approach is that virtual PMU irq
> is injected at time of entering guest mode. This means guest
> will receive virtual PMU  interrupt with little delay after actual
> interrupt occurred. The PMU interrupts are only overflow events
> and generally not used in any timing critical applications. If we
> can live with this limitation then this can be a good approach
> for KVM PMU virtualization.
>
> Regards,
> Anup

Hi Marc/Christoffer,

Ping??

Regards,
Anup
