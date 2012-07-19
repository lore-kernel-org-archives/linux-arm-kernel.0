From: jonathan.austin@arm.com (Jonathan Austin)
Date: Thu, 19 Jul 2012 16:19:52 +0100
Subject: [PATCH v2 2/2] ARM: delay: allow timer-based delay implementation
 to be selected
In-Reply-To: <20120718175233.GB16928@mudshark.cambridge.arm.com>
References: <20120712084432.GA2816@mudshark.cambridge.arm.com>
 <4FFE9A69.3060301@renesas.com> <4FFEFDE3.5000403@codeaurora.org>
 <4FFF8509.2050302@renesas.com>
 <20120713085746.GA18079@mudshark.cambridge.arm.com>
 <CAMQu2gwPm_Y1as6dc4S-f9OEOZA32CCNKv_07MB+U7T4OS6qXg@mail.gmail.com>
 <20120713111337.GH18079@mudshark.cambridge.arm.com>
 <5004D78E.4050606@renesas.com>
 <CAMQu2gx9EU4GZ634RKiwD+sg0MoO-FAqc-pPU+HkryX8rXVBjA@mail.gmail.com>
 <5005176C.6050904@renesas.com>
 <20120718175233.GB16928@mudshark.cambridge.arm.com>
Message-ID: <50082598.5090706@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On 18/07/12 18:52, Will Deacon wrote:

> Hello,
> On Tue, Jul 17, 2012 at 08:42:36AM +0100, Shinya Kuribayashi wrote:
>> On 7/17/2012 3:11 PM, Shilimkar, Santosh wrote:
>>> Looks like you have a working patch for the clock detection. Will
>>> you able to post that patch so that this long pending calibration
>>> for secondary CPUs gets optimized.
>>
>> Something like this should work (not even build tested, can be applied
>> on top of Will's v2 patchset):
> 
> [...]
> 
>> And change your ->timer() func (called via time_init) to make use of it:
>>
>>         unsigned long freq;
>>
>>         /* For UP/SMP systems */
>>         freq = get_CPU_frequency();
>>         calibrate_delay_early(freq);
>>
>> #ifdef CONFIG_SMP
>>         /* For SMP systems */
>>         freq = get_Timer_frequency();
>>         init_current_timer_delay(freq);
>> #endif
> 
> Since this seems to be gaining some traction on platforms without the
> architected timers, Jonny and I have put together a simple registration
> mechanism for the delay timer to avoid people calling init_current_timer_delay
> (and defining the global read_current_timer symbol).


We should probably also ignore and additional registration calls, not just
those made after the delay loop has been calibrated...

Something like the patch below should do the trick.

Jonny

-----8<------

diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
index 1b51570..fff305b 100644
--- a/arch/arm/lib/delay.c
+++ b/arch/arm/lib/delay.c
@@ -72,8 +72,9 @@ void __init register_current_timer_delay(struct delay_timer *timer)
                arm_delay_ops.delay             = __timer_delay;
                arm_delay_ops.const_udelay      = __timer_const_udelay;
                arm_delay_ops.udelay            = __timer_udelay;
+               delay_calibrated                = true;
        } else {
-               pr_info("Ignoring late registration of read_current_timer delay\n");
+               pr_info("Ignoring duplicate/late registration of read_current_timer delay\n");
        }
 }
 
