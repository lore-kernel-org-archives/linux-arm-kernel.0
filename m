From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 05 Oct 2010 20:36:47 -0700
Subject: [PATCH 3/3] [ARM] Implement a timer based __delay() loop
In-Reply-To: <1286300338.18791.26.camel@c-dwalke-linux.qualcomm.com>
References: <1285644827-6846-1-git-send-email-sboyd@codeaurora.org>	
	<1285644827-6846-4-git-send-email-sboyd@codeaurora.org>
	<1286300338.18791.26.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <4CABEECF.9080009@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 On 10/05/2010 10:38 AM, Daniel Walker wrote:
>>  
>> +#ifdef ARCH_HAS_READ_CURRENT_TIMER
>> +/*
>> + * Assuming read_current_timer() is monotonically increasing
>> + * across calls.
> You should add more comments here. You assuming that it's monotonic over
> a 2000us (2ms) period .. I'm not sure this is a good assumption this
> timer may not be monotonically increasing all the time, what happens
> then?

Ok I'll add that it shouldn't wrap more than once within 2000us (or
should I say 5ms since mdelay uses udelay?). Is that what you're saying
by it not being monotonically increasing? If a timer isn't increasing
the tick count it's broken and this call will loop forever. If the timer
wraps, we'll be safe due to unsigned maths as long as it wraps only once.

>> +void read_current_timer_delay_loop(unsigned long loops)
>> +{
>> +	unsigned long bclock, now;
>> +
>> +	read_current_timer(&bclock);
>> +	do {
>> +		read_current_timer(&now);
>> +	} while ((now - bclock) < loops);
> Have you looked at time_before()/time_after() ?

Nope. Wouldn't that require an addition though to make it work? I'd
rather just leave it like it is.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
