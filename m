From: robh@kernel.org (Rob Herring)
Date: Mon, 12 Jan 2015 09:38:52 -0600
Subject: [PATCH] ARM: fix v7M build for !CONFIG_PRINTK
In-Reply-To: <1759104.LDHVCAfBKo@wuerfel>
References: <1421036749-5308-1-git-send-email-robh@kernel.org>
 <1759104.LDHVCAfBKo@wuerfel>
Message-ID: <CAL_JsqJRWK0EiZxD7i2QK2-7ztc4_UL-ro7MeYERwN_WTQjj6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 2:29 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sunday 11 January 2015 22:25:49 Rob Herring wrote:
>>
>>  __invalid_entry:
>>         v7m_exception_entry
>> +#ifdef CONFIG_PRINTK
>>         adr     r0, strerr
>>         mrs     r1, ipsr
>>         mov     r2, lr
>>         bl      printk
>> +#endif
>>         mov     r0, sp
>>         bl      show_regs
>>  1:     b       1b
>>
>
> Should the show_regs call be commented out as well? While
> the function is still there without printk support, I believe
> it doesn't actually do anything.

It does still call unwind_backtrace which still constructs the
backtrace from looking at the disassembly output. That's probably not
too useful unless it is saved to memory that could be examined with a
debugger. One would probably just enable printk at that point though.

Rob
