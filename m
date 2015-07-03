From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 3 Jul 2015 10:53:12 -0400
Subject: [PATCH 4/4] hvc_dcc: disable user-space access to DCC
In-Reply-To: <55947F1C.3020904@codeaurora.org>
References: <1435699387-32591-1-git-send-email-timur@codeaurora.org>
 <1435699387-32591-4-git-send-email-timur@codeaurora.org>
 <55947F1C.3020904@codeaurora.org>
Message-ID: <830CD79F-C263-4C3B-A27F-77A4DA55236F@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Jul 1, 2015, at 8:00 PM, Stephen Boyd wrote:

>> 
>> #include <asm/barrier.h>
>> +#include <asm/hardware/cp14.h>
> 
> That's new.

And no one else is using it either.

>> 
>> +
>> +static inline void __dcc_initialize(void)
>> +{
>> +	u32 val;
>> +
>> +	/* Disable user-space access to DCC */
>> +	val = MRC14(0, c0, c1, 0);
>> +	val |= 1 << 12; /* DSCR[Comms] */
>> +	MCR14(val, 0, c0, c1, 0);
>> +}
> 
> Nitpick: We do raw cp14 accesses for other functions in this file, so it
> would be nice to be consistent throughout.

I agree, but I didn't want to expand the scope of this patch beyond what it's supposed to do.

>> 
>> +static inline void __dcc_initialize(void)
>> +{
>> +	u32 val;
>> +
>> +	/* Disable user-space access to DCC */
>> +	asm ("mrs %0, mdscr_el1\n"
> 
> shouldn't this be volatile?

Well, I figured it wasn't important exactly why these instructions are executed, since it just disables user-space.  I usually get chewed out by someone if I add volatile where it's not needed, so I didn't add it this time.

> 
>> +		"	orr %0, %0, #4096\n" /* Set the TDCC bit */
> 
> arm64 has some #defines in debug-monitors.h which we should probably
> extend to have this bit as a #define too.

Hmmm, the only thing I see in debug_monitors.h that seems applicable are the mdscr_write() and mdscr_read() functions, which seem to overlap cp14.h.
