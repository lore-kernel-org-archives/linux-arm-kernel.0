From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 05 May 2014 15:44:30 -0700
Subject: [PATCH 1/3] arm64: adjust el0_sync so that a function can be
 called
In-Reply-To: <20140429094211.GC17007@arm.com> (Catalin Marinas's message of
 "Tue, 29 Apr 2014 10:42:11 +0100")
References: <1398627854-9617-1-git-send-email-larry.bassel@linaro.org>
 <1398627854-9617-2-git-send-email-larry.bassel@linaro.org>
 <20140429094211.GC17007@arm.com>
Message-ID: <7hsionc0c1.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+ Mark R. since we looked at this together a little at ELC]

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Sun, Apr 27, 2014 at 08:44:12PM +0100, Larry Bassel wrote:
>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>> index 39ac630..eda7755 100644
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
> [...]
>> @@ -421,28 +421,30 @@ el0_da:
>>  	/*
>>  	 * Data abort handling
>>  	 */
>> -	mrs	x0, far_el1
>> -	bic	x0, x0, #(0xff << 56)
>>  	disable_step x1
>>  	isb
>>  	enable_dbg
>>  	// enable interrupts before calling the main handler
>>  	enable_irq
>> +	mrs	x0, far_el1
>> +	bic	x0, x0, #(0xff << 56)
>>  	mov	x1, x25
>>  	mov	x2, sp

>>  	b	do_mem_abort
>
> Reading the far_el1 after enable_dbg and enable_irq is racy, we can no
> longer guarantee its value in the original data abort context.

Catalin, can you confirm x26 would be a safe place to stash far_el1 and
then restore it after ct_user_exit.  Something like this (which seems to
work for me):

el0_da:
        /*                                                                                                                                                    * Data abort handling                                                                                                                                */
        mrs     x26, far_el1
        disable_step x1
        isb
        enable_dbg
        // enable interrupts before calling the main handler                                                                                          
        enable_irq
        ct_user_exit
        mov     x0, x26
        bic     x0, x0, #(0xff << 56)
        mov     x1, x25
        mov     x2, sp
        adr     lr, ret_from_exception
        b       do_mem_abort

Kevin
