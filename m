From: slash.tmp@free.fr (Mason)
Date: Thu, 8 Oct 2015 19:38:53 +0200
Subject: [PATCH v4] twd: Don't set CLOCK_EVT_FEAT_C3STOP unconditionally
In-Reply-To: <20151008171616.GG7275@leverpostej>
References: <56123BD0.8010005@sigmadesigns.com>
 <56124035.6080107@sigmadesigns.com>
 <CACRpkdbWRU3UH6aJnqdcuzdh_-sE7ryhs0vBTUbbRDcJ7PWXLw@mail.gmail.com>
 <561247DF.1000308@sigmadesigns.com> <20151005103539.GC19064@leverpostej>
 <5612649C.5020401@sigmadesigns.com> <20151008171616.GG7275@leverpostej>
Message-ID: <5616AA2D.2070101@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2015 19:16, Mark Rutland wrote:
> On Mon, Oct 05, 2015 at 01:53:00PM +0200, Marc Gonzalez wrote:
>> In 5388a6b266 ("ARM: SMP: Always enable clock event broadcast support")
>> Russell noted that "the TWD local timers are unable to wake up the CPU
>> when it is placed into a low power mode".
>>
>> However, some platforms do not stop the TWD block in low-power mode,
>> and can thus use the TWD timer in one-shot mode, without setting up
>> a broadcast device.
>>
>> Make the driver check for the "twd-never-stops" boolean property,
>> and set the CLOCK_EVT_FEAT_C3STOP flag accordingly.
>>
>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>> ---
>>  Documentation/devicetree/bindings/arm/twd.txt | 4 ++++
>>  arch/arm/kernel/smp_twd.c                     | 5 ++++-
>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/twd.txt b/Documentation/devicetree/bindings/arm/twd.txt
>> index 75b8610939fa..700a517b000e 100644
>> --- a/Documentation/devicetree/bindings/arm/twd.txt
>> +++ b/Documentation/devicetree/bindings/arm/twd.txt
>> @@ -19,6 +19,10 @@ interrupts.
>>  - reg : Specify the base address and the size of the TWD timer
>>  	register window.
>>  
>> +Optional
>> +- twd-never-stops : boolean property. If present, TWD timers are expected
>> +  to keep generating interrupts, even when the CPU is in low-power mode.
> 
> Sorry for the last minute bikeshed, but it would be better if we could
> align this with the ARM generic timer binding, both in naming and
> description:
> 
>  - always-on : a boolean property. If present, the timer is powered through an
>    always-on power domain, therefore it never loses context.

No problemo. Too bad I didn't think to copy that description
in the first place!

> Otherwise this looks ok. If you can respin with the above wording, and
> s/twd-never-stops/always-on/ in the patch, you can add:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Wouldn't you feel like going all-in and Signing-off? ;-)

One last nit (see below).

>> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
>> index e8f6d241881f..79298d4fb41f 100644
>> --- a/arch/arm/kernel/smp_twd.c
>> +++ b/arch/arm/kernel/smp_twd.c
>> @@ -33,6 +33,7 @@ static unsigned long twd_timer_rate;
>>  static DEFINE_PER_CPU(bool, percpu_setup_called);
>>  
>>  static struct clock_event_device __percpu *twd_evt;
>> +static int feat_c3stop;
>>  static int twd_ppi;
>>  
>>  static void twd_set_mode(enum clock_event_mode mode,
>> @@ -293,7 +294,7 @@ static void twd_timer_setup(void)
>>  
>>  	clk->name = "local_timer";
>>  	clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
>> -			CLOCK_EVT_FEAT_C3STOP;
>> +			feat_c3stop;
>>  	clk->rating = 350;
>>  	clk->set_mode = twd_set_mode;
>>  	clk->set_next_event = twd_set_next_event;
>> @@ -345,6 +346,8 @@ static int __init twd_local_timer_common_register(struct device_node *np)
>>  		goto out_irq;
>>  
>>  	twd_get_clock(np);
>> +	if (!of_property_read_bool(np, "twd-never-stops"))
>> +		feat_c3stop = CLOCK_EVT_FEAT_C3STOP;

Is it possible that twd_local_timer_common_register() would be
called more than once?

twd_local_timer_register() guards against multiple invocations,
but twd_local_timer_of_register() doesn't (but maybe there is
some guarantee from OF, or it's invalid to have multiple
"arm,cortex-a9-twd-timer" strings in the DT).

Regards.
