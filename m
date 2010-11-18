From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 18 Nov 2010 08:56:38 +0100
Subject: [PATCH] nomadik: prevent sched_clock() wraparound v3
In-Reply-To: <AANLkTikk3aiUBbjf6YeXNQqymVmsYfgU4dVmQ2RsSOXx@mail.gmail.com>
References: <1290001517-17010-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTikk3aiUBbjf6YeXNQqymVmsYfgU4dVmQ2RsSOXx@mail.gmail.com>
Message-ID: <AANLkTik4_JB+KpUp9wEDpkASujDnYX16zJzdu0TvbTj4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hm I wonder why this mail doesn't show up on linux-arm-kernel... Probably
too many CC.

2010/11/17 Rabin Vincent <rabin@rab.in>:
> On Wed, Nov 17, 2010 at 7:15 PM, Linus Walleij
>> + ? ? ? /* Find the apropriate mult and shift factors */
>> + ? ? ? clocks_calc_mult_shift(&sched_mult, &sched_shift,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?rate, NSEC_PER_SEC, SCHED_CLOCK_MIN_WRAP);
>> + ? ? ? /* We need to multiply by atleast 2 to get rid of bit 63 */
>> + ? ? ? BUG_ON(sched_mult < 2);
>
> No, you want to multiply by an even number, not "atleast 2". ?Please
> also drop the "cycles &= 0x7FFFFFFFFFFFFFFFLLU" in sched_clock().

Ayeah, the Orion trick, that's better what was I thinking of..

>> + ? ? ? /* Let's see what we get, take max counter and scale it */
>> + ? ? ? days = 0xFFFFFFFFFFFFFFFFLLU >> sched_shift;
>> + ? ? ? do_div(days, rate);
>> + ? ? ? do_div(days, (3600*24));
>> +
>> + ? ? ? pr_debug("sched_clock: using %d bits @ %lu Hz wrap in %lu days\n",
>> + ? ? ? ? ? ? ? (64 - sched_shift), rate, (unsigned long) days);
>
> This days calculation is wrong because you need to divide by
> NSECS_PER_SEC, not rate.

Yes thanks, I was trying to be clever leaving out sched_mult but it doesn't
loose bits properly. I replaced it with:

days = (0xFFFFFFFFFFFFFFFFLLU * sched_mult) >> sched_shift;
do_div(days, NSEC_PER_SEC);
do_div(days, (3600*24));

And it yields:
sched_clock: using 55 bits @ 8333125 Hz wrap in 416 days

Which is what is to be expected. (I requested a minimum of 365 days)

Thanks a lot Rabin I'll fire off v4...

Yours,
Linus Walleij
