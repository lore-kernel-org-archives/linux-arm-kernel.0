From: jaz@semihalf.com (Grzegorz Jaszczyk)
Date: Fri, 2 Mar 2018 13:59:27 +0100
Subject: [PATCH] arm64: kdump: fix interrupt handling done during
 machine_crash_shutdown
In-Reply-To: <20180302120556.xujh3hoy44y7ouz7@lakrids.cambridge.arm.com>
References: <1519837260-30662-1-git-send-email-jaz@semihalf.com>
 <20180228171647.6t4dabntujcb5kon@lakrids.cambridge.arm.com>
 <ba0c6804-51a3-f36e-a67e-20ce84961451@arm.com>
 <CAH76GKO8oYVN+H4pvd6NTGc0u8AD7JMSJCYEJzNtdsAJm5L_9w@mail.gmail.com>
 <20180302120556.xujh3hoy44y7ouz7@lakrids.cambridge.arm.com>
Message-ID: <CAH76GKNw=irEY8BjhkaMnKm5m6AeCz8ZN67vrWSC6ByBmMMh8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-03-02 13:05 GMT+01:00 Mark Rutland <mark.rutland@arm.com>:
> On Fri, Mar 02, 2018 at 12:56:24PM +0100, Grzegorz Jaszczyk wrote:
>> Thank you for your feedback. I probably over-interpreted some of the
>> documentation paragraph to justify (probably) buggy behavior that I am
>> seeing. Regardless of correctness of this patch I will appreciate if
>> you could help understanding this issue.
>>
>> First the whole story: I was debugging why the crashdump kernel hangs
>> in v. early stage, when the kdump was triggered from the
>> ARM_SBSA_WATCHDOG interrupt handler, while everything worked fine when
>> it was triggered from the process context. Finally It occurred that it
>> is because the crashdump kernel doesn't get any timer interrupt. I
>> also notice that this problem doesn't occur when the gic is configured
>> to work in EOImode == 1. In such circumstances, the write to
>> GIC_CPU_EOI in gic_handle_irq is causing priority drop to idle, and
>> therefore when the crashdump kernel starts, the timer interrupt is
>> able to preempt still active watchdog interrupt (I know that this
>> interrupt shouldn't be active after irq_set_irqchip_state but for some
>> reason it seems to not do the job correctly).
>
> Do you have a way to reproduce the problem?
>
> Is there an easy way to cause the watchdog to trigger a kdump as above,
> e.g. via LKDTM?

You can reproduce this problem by:
- enabling CONFIG_ARM_SBSA_WATCHDOG in your kernel
- passing via command-line: sbsa_gwdt.action=1 sbsa_gwdt.timeout=170
- then load/prepare crasdump kernel (I am doing it via kexec tool)
- echo 1 > /dev/watchdog

and after 170s the watchdog interrupt will hit triggering panic and
the whole kexec machinery will run. The sbsa_gwdt.timeout can't be too
small since it is also used for reset:
|----timeout-----(panic)----timeout-----reset.
If it is too small the crasdump kernel will not have enough time to start.

It is also reproducible with different interrupts, e.g. for test I put
the panic to i2c interrupt handler and it was behaving the same.

To use gic with EOImode == 0 mode, you can fulfill some of
gic_check_eoimode ( irqchip/irq-gic.c) conditions or just for test
"return false;" in this function.


> I think you just mean GICv2 here. GICv2m is an MSI controller, and
> shouldn't interact with the SBSA watchdog's SPI.

Yes of course, I just wanted to mention that it has MSI controller.

Thank you,
Grzegorz
