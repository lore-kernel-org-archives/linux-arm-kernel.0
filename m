From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 22 Jun 2015 08:16:43 -0500
Subject: [PATCH] ARM64: TTY: hvc_dcc: Add support for ARM64 dcc
In-Reply-To: <20150622131228.GE1583@arm.com>
References: <1434751734-2178-1-git-send-email-timur@codeaurora.org>
 <20150622131228.GE1583@arm.com>
Message-ID: <55880ABB.6030304@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon wrote:
> On Fri, Jun 19, 2015 at 11:08:54PM +0100, Timur Tabi wrote:
>> From: Abhimanyu Kapur <abhimany@codeaurora.org>
>>
>> Add support for debug communications channel based
>> hvc console for arm64 cpus.
>
> I still think we should be disabling userspace access to the DCC if the
> kernel is using it as its console.

I don't disagree, I just don't know how to do that.

>> + * A call to __dcc_getchar() or __dcc_putchar() is typically followed by
>> + * a call to __dcc_getstatus().  We want to make sure that the CPU does
>> + * not speculative read the DCC status before executing the read or write
>> + * instruction.  That's what the ISBs are for.
>> + *
>> + * The 'volatile' ensures that the compiler does not cache the status bits,
>> + * and instead reads the DCC register every time.
>> + */
>
> Missing header guards.

Will fix.

>> +#include <asm/barrier.h>
>> +
>> +static inline u32 __dcc_getstatus(void)
>> +{
>> +	u32 __ret;
>> +
>> +	asm volatile("mrs %0, mdccsr_el0" : "=r" (__ret)
>> +			: : "cc");
>
> You don't need the "cc" clobber.

Will fix.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
