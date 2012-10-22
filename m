From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 22 Oct 2012 12:21:16 +0530
Subject: [PATCH v2] ARM: SMP_TWD: make setup()/stop() reentrant
In-Reply-To: <20121022051319.GA19107@S2101-09.ap.freescale.net>
References: <1350640589-31821-1-git-send-email-linus.walleij@linaro.org>
 <20121022051319.GA19107@S2101-09.ap.freescale.net>
Message-ID: <5084ECE4.5020608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

On Monday 22 October 2012 10:43 AM, Shawn Guo wrote:
> On Fri, Oct 19, 2012 at 11:56:29AM +0200, Linus Walleij wrote:
>> This makes the SMP_TWD clock .setup()/.stop() pair reentrant by
>> not re-fetching the clk and re-registering the clock event every
>> time .setup() is called. We also make sure to call the
>> clk_enable()/clk_disable() pair on subsequent calls.
>>
>> As it has been brought to my knowledge that this pair is going
>> to be called from atomic contexts for CPU clusters coming and
>> going, the clk_prepare()/clk_unprepare() calls cannot be called
>> on subsequent .setup()/.stop() iterations.
>>
>> The patch assumes that the code will make sure that
>> twd_set_mode() is called through .set_mode() on the clock
>> event *after* the .setup() call, so that the timer registers
>> are fully re-programmed after a new .setup() cycle.
>>
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> Reported-by: Peter Chen <peter.chen@freescale.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Peter/Shawn: can you please respond with a Tested-by from your
>> system(s) to indicate if this works as expected?
>
> I have seen two problems with the patch.
>
> 1. twd_timer_setup() is called on per-cpu path, and initial_setup_called
>     should be a per-cpu variable.
>
> 2. When secondary cores get off-line, the clockevent devices for
>     the cores will be released.  So when they become online, the
>     clockevent devices should be registered again.
>
> I can only have my system work as expected with the following changes.
>

How about moving twd_get_clock() outside setup and do that in onetime
init code like register etc. Its is pointless to keep doing
re-registration, clock_enable/disable() since you can not really
disable this clock. Remember we added this clock node for CPUFREQ
and it is just CPU clock with an additional fixed divider.

With above, you neither see the sleep while atomic warning nor
there is any need to fiddle with clock node after boot.

Let me know if I have missed any other consideration here.

Regards,
Santosh
