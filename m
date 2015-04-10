From: slash.tmp@free.fr (Mason)
Date: Fri, 10 Apr 2015 16:53:10 +0200
Subject: Guarantee udelay(N) spins at least N microseconds
In-Reply-To: <20150410114253.GA18645@1wt.eu>
References: <5527B331.5000205@free.fr> <20150410114253.GA18645@1wt.eu>
Message-ID: <5527E3D6.1010608@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Willy,

On 10/04/2015 13:42, Willy Tarreau wrote:
> Hi,
>
> On Fri, Apr 10, 2015 at 01:25:37PM +0200, Mason wrote:
>> Hello everyone,
>>
>> This is take 2 of my tiny delay.c patch
>>
>> Problem statement
>>
>> When converting microseconds to timer cycles in __timer_udelay() and
>> __timer_const_udelay(), the result is rounded down(*), which means the
>> system will not spin as long as requested (specifically, between
>> epsilon and 1 cycle shorter).
>>
>> If I understand correctly, most drivers expect udelay(N) to spin for
>> at least N ?s. Is that correct? In that use case, spinning less might
>> introduce subtle heisenbugs.
>>
>>
>> Typical example
>>
>> timer->freq = 90 kHz && HZ = 100
>> (thus UDELAY_MULT = 107374 && ticks_per_jiffy = 900)
>>
>> udelay(10) => __timer_const_udelay(10*107374)
>>             => __timer_delay((1073740*900) >> 30)
>>             => __timer_delay(0)
>>
>> So udelay(10) resolves to no delay at all.
>>
>>
>> (*) 2^41 / 10^6 = 2199023,255552
>> 2199023 < 2^41 / 10^6
>> UDELAY_MULT = 2199023*HZ / 2^11 < 2^30*HZ / 10^6
>>
>> cycles = N * UDELAY_MULT * freq/HZ / 2^30
>>         < N * 2^30*HZ / 10^6 * freq/HZ / 2^30
>>         < N / 10^6 * freq
>>
>>
>> Proposed fix
>>
>> Since results are always rounded down, all we need is to increment
>> the result by 1 to round it up.
>>
>> Would someone ACK the patch below?
>>
>> Regards.
>>
>>
>> Patch against 4.0-rc4
>>
>> diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
>> index 312d43e..3cfbd07 100644
>> --- a/arch/arm/lib/delay.c
>> +++ b/arch/arm/lib/delay.c
>> @@ -66,7 +66,7 @@ static void __timer_const_udelay(unsigned long xloops)
>>   {
>>          unsigned long long loops = xloops;
>>          loops *= arm_delay_ops.ticks_per_jiffy;
>> -       __timer_delay(loops >> UDELAY_SHIFT);
>> +       __timer_delay((loops >> UDELAY_SHIFT) + 1);
>>   }
>
> If loops is a multiple of 2 ^ UDELAY_SHIFT, then your result is too
> high by one. The proper way to round by excess is the following :
>
>      __timer_delay((loops + (1 << UDELAY_SHIFT) - 1) >> UDELAY_SHIFT);
>
> That way it does +1 for every value of loop not an exact multiple
> of 2^UDELAY_SHIFT.

The important thing to realize is that xloops is already rounded down,
because we use 2199023 as an approximation of 2^41 / 10^6.

Thus, even when 'loops' is a multiple of 2^30, we'll want to round up.

Illustration

timer->freq = 100*2^20 && HZ = 100
(thus UDELAY_MULT = 107374 && ticks_per_jiffy = 2^20)

Suppose udelay(512)
so we want to spin for 512 / 10^6 * 100*2^20 = 53687,0912 cycles
i.e. 53688 cycles if we round up.

loops = 512 * 107374 * 2^20 = 53687 * 2^30

If we just add (2^30-1) before shifting by 30, the result comes out
to 53687, but (loops >> 30) + 1 is closer to what we really want.

One might argue that the difference between 53687 and 53688 is
lost in the noise and thus irrelevant. I can agree with that.

Which is why I chose the simpler

   __timer_delay((loops >> UDELAY_SHIFT) + 1);

over

   __timer_delay((loops + (1 << UDELAY_SHIFT) - 1) >> UDELAY_SHIFT);


Do you disagree with this logic?

Regards.
