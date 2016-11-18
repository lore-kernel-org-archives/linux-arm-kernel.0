From: slash.tmp@free.fr (Mason)
Date: Fri, 18 Nov 2016 13:24:53 +0100
Subject: [PATCH] arm: spin one more cycle in timer-based delays
In-Reply-To: <20161118120630.GJ13470@arm.com>
References: <582B0F61.6030903@free.fr> <20161118120630.GJ13470@arm.com>
Message-ID: <582EF315.2060707@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/11/2016 13:06, Will Deacon wrote:

> On Tue, Nov 15, 2016 at 02:36:33PM +0100, Mason wrote:
>
>> When polling a tick counter in a busy loop, one might sample the
>> counter just *before* it is updated, and then again just *after*
>> it is updated. In that case, while mathematically v2-v1 equals 1,
>> only epsilon has really passed.
>>
>> So, if a caller requests an N-cycle delay, we spin until v2-v1
>> is strictly greater than N to avoid these random corner cases.
>>
>> Signed-off-by: Mason <slash.tmp@free.fr>
>> ---
>>  arch/arm/lib/delay.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
>> index 69aad80a3af4..3f1cd15ca102 100644
>> --- a/arch/arm/lib/delay.c
>> +++ b/arch/arm/lib/delay.c
>> @@ -60,7 +60,7 @@ static void __timer_delay(unsigned long cycles)
>>  {
>>  	cycles_t start = get_cycles();
>>  
>> -	while ((get_cycles() - start) < cycles)
>> +	while ((get_cycles() - start) <= cycles)
>>  		cpu_relax();
>>  }
> 
> I thought a bit about this last night. It is well known that the delay
> routines are not guaranteed to be accurate, and I don't *think* that's
> limited to over-spinning, so arguably this isn't a bug. However, taking
> the approach that "drivers should figure it out" is also unhelpful,
> because the frequency of the underlying counter isn't generally known
> and so drivers can't simply adjust the delay parameter.
> 
> If you want to go ahead with this change, I do think that you should fix
> the other architectures for consistency (particularly arm64, which is
> likely to share drivers with arch/arm/). However, given that I don't
> think you've seen a failure in practice, it might be a hard sell to get
> the patches picked up, especially given the deliberately vague guarantees
> offered by the delay loop.

Hello Will,

Thanks for the in-depth analysis.

This is, conceptually, the first patch in a 2-patch series, and perhaps
the intent would have been clearer had I posted the series, along with
full rationale in the cover letter. I'll do that next week, so everyone
can judge with all the information in hand.

Regards.
