From: slash.tmp@free.fr (Mason)
Date: Fri, 2 Oct 2015 20:00:03 +0200
Subject: [PATCH] arm-soc: Add Sigma Designs Tango4 port
In-Reply-To: <yw1xfv1tky6m.fsf@unicorn.mansr.com>
References: <560EAA7C.3070302@free.fr> <yw1xoaghl099.fsf@unicorn.mansr.com>
 <560EB1EC.3020403@free.fr> <yw1xfv1tky6m.fsf@unicorn.mansr.com>
Message-ID: <560EC623.4030300@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2015 18:55, M?ns Rullg?rd wrote:

> Mason writes:
> 
>>>> +		uart0 {
>>>> +			compatible = "ralink,rt2880-uart";
>>>> +			reg = <0x10700 0x100>;
>>>> +			clock-frequency = <7372800>;
>>>> +			reg-shift = <2>;
>>>> +/*			fifo-size = <16>; BROKEN */
>>>
>>> Either fix whatever is broken or drop that line.
>>
>> I can't leave TODO reminders in the platform Kconfig [and DT files]?
> 
> Never mind, I've sent a patch fixing the problem.

That's great news. Although back-porting to 3.14 is looking
more and more time-consuming. (But that's my problem.)

The question of comments in Kconfig and DT files still stands.
(No need to state your position again.)

>>>> +		intc: intc at e000 {
>>>> +			compatible = "sigma,tango-intc";
>>>
>>> Why do you insist on using other names than the ones I've been using for
>>> months?  Just want to leave your own mark on the code?
>>
>> You're using "sigma,smp8640-intc".
>> The SMP8640 is a Tango3 (MIPS-based) platform.
>> It makes no sense to have references to Tango3 in tango4.dtsi
>> Aside from the CPU difference, Tango3 and Tango4 have a lot in common though.
> 
> It's commonplace to refer to peripherals by the earliest (supported)
> chip using them.  This avoids naming conflicts if a future chip uses a
> different component.  Some bits are incompatible even between different
> devices in the tango3 family.

I'm confused. I like the way ARM did it in smp-twd.c

CLOCKSOURCE_OF_DECLARE(arm_twd_a9, "arm,cortex-a9-twd-timer", twd_local_timer_of_register);
CLOCKSOURCE_OF_DECLARE(arm_twd_a5, "arm,cortex-a5-twd-timer", twd_local_timer_of_register);
CLOCKSOURCE_OF_DECLARE(arm_twd_11mp, "arm,arm11mp-twd-timer", twd_local_timer_of_register);

They have several definitions for the different supported platforms.

They have several versions of the GIC:

IRQCHIP_DECLARE(gic_400, "arm,gic-400", gic_of_init);
IRQCHIP_DECLARE(arm11mp_gic, "arm,arm11mp-gic", gic_of_init);
IRQCHIP_DECLARE(arm1176jzf_dc_gic, "arm,arm1176jzf-devchip-gic", gic_of_init);
IRQCHIP_DECLARE(cortex_a15_gic, "arm,cortex-a15-gic", gic_of_init);
IRQCHIP_DECLARE(cortex_a9_gic, "arm,cortex-a9-gic", gic_of_init);
IRQCHIP_DECLARE(cortex_a7_gic, "arm,cortex-a7-gic", gic_of_init);
IRQCHIP_DECLARE(msm_8660_qgic, "qcom,msm-8660-qgic", gic_of_init);
IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);
IRQCHIP_DECLARE(gic_v3, "arm,gic-v3", gic_of_init);

For example, I know the interrupt controller was changed for Tango5.

So I was planning on using:

"sigma,tango-intc" for Tango3/Tango4
"sigma,tango-intc-v2" for Tango5

Would you change your code to accommodate this nomenclature? 

Regards.
