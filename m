From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 03 Jun 2013 14:11:59 -0700
Subject: [PATCHv2 4/6] sched_clock: Add support for >32 bit sched_clock
In-Reply-To: <20130603093938.GG18614@n2100.arm.linux.org.uk>
References: <1370155183-31421-1-git-send-email-sboyd@codeaurora.org>
 <1370155183-31421-5-git-send-email-sboyd@codeaurora.org>
 <20130603093938.GG18614@n2100.arm.linux.org.uk>
Message-ID: <51AD069F.1060308@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/13 02:39, Russell King - ARM Linux wrote:
> On Sat, Jun 01, 2013 at 11:39:41PM -0700, Stephen Boyd wrote:
>> +static unsigned long long notrace sched_clock_64(void)
>> +{
>> +	u64 cyc = read_sched_clock_64() - cd.epoch_ns;
>> +	return cyc * cd.mult;
> So, the use of cd.mult implies that the return value from
> read_sched_clock_64() is not nanoseconds but something else.  But then
> we subtract it from the nanoseconds epoch - which has to be nanoseconds
> because you simply return that when suspended.

You're right, it is confusing and broken. I was thinking we may need a
union for epoch_ns but I will try to make it always nanoseconds and see
if that makes the code clearer.

>
>> +}
>> +
>> +void __init
>> +setup_sched_clock_64(u64 (*read)(void), int bits, unsigned long rate)
>> +{
>> +	if (cd.rate > rate)
>> +		return;
>> +
>> +	BUG_ON(bits <= 32);
>> +	WARN_ON(!irqs_disabled());
>> +	read_sched_clock_64 = read;
>> +	sched_clock_func = sched_clock_64;
>> +	cd.rate = rate;
>> +	cd.mult = NSEC_PER_SEC / rate;
> Here, you don't check that the (2^bits) * mult results in a wrap of the
> resulting 64-bit number, which is a _basic_ requirement for sched_clock
> (hence all the code for <=32bit clocks, otherwise we wouldn't need this
> complexity in the first place.)

Ok I will use clocks_calc_mult_shift() here.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
