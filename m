From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 10 Nov 2011 09:43:08 +0000
Subject: [PATCH 1/2] ARM: EXYNOS4: convert MCT to percpu interrupt API
In-Reply-To: <CAJ0PZbQG6Gse8RNfrhqLyQgUemcBDK5-XM7J_wX6jyP28bZ3zQ@mail.gmail.com>
References: <1320255049-12447-1-git-send-email-marc.zyngier@arm.com>
 <1320255049-12447-2-git-send-email-marc.zyngier@arm.com>
 <CAJ0PZbQG6Gse8RNfrhqLyQgUemcBDK5-XM7J_wX6jyP28bZ3zQ@mail.gmail.com>
Message-ID: <4EBB9CAC.4030000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/11 02:40, MyungJoo Ham wrote:
> On Thu, Nov 3, 2011 at 2:30 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> MCT recently gained per cpu interrupts, and missed the fact that
>> ARM has moved to a genirq based implementation.
>>
>> This patch converts the driver to the new API.
>>
>> Boot tested on Origen.
>>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> There is one concern regarding the CONFIG_LOCAL_TIMER.
> 
> []
>>  #endif /* CONFIG_LOCAL_TIMERS */
>>
>>  static void __init exynos4_timer_resources(void)
>> @@ -438,6 +442,16 @@ static void __init exynos4_timer_resources(void)
>>        mct_clk = clk_get(NULL, "xtal");
>>
>>        clk_rate = clk_get_rate(mct_clk);
>> +
>> +       if (mct_int_type == MCT_INT_PPI) {
>> +               int err;
>> +
>> +               err = request_percpu_irq(IRQ_MCT_LOCALTIMER,
>> +                                        exynos4_mct_tick_isr, "MCT",
>> +                                        &percpu_mct_tick);
>> +               WARN(err, "MCT: can't request IRQ %d (%d)\n",
>> +                    IRQ_MCT_LOCALTIMER, err);
>> +       }
>>  }
>>
> 
> You've added exynos4_mct_tick_isr, which is defined in
> CONFIG_LOCAL_TIMER section, in the place that is compiled without
> CONFIG_LOCAL_TIMER.
> I guess we are going to stop supporting LOCAL_TIMER in Exynos later
> and this could be a problem with it.

Yup, this is a problem. It probably means we need to #ifdef that chink
as well. I'm not sure I get your remark about not supporting LOCAL_TIMER
though. Are you planning to move away from the LOCAL_TIMER infrastructure?

If that's the case, you might as well know that my pet plan is to get
rid of the LOCAL_TIMER option altogether, and move to a model where each
timer driver is (sort of) autonomous, instead of being driven by the SMP
code.

	M.
-- 
Jazz is not dead. It just smells funny...
