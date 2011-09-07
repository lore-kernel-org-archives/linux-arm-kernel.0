From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 7 Sep 2011 15:28:21 +0100
Subject: [PATCH] ARM: alignment: setup alignment handler earlier
In-Reply-To: <yw1xy5y0cvah.fsf@unicorn.mansr.com>
References: <87ehzstr07.fsf@vostro.fn.ogness.net>
	<yw1xy5y0cvah.fsf@unicorn.mansr.com>
Message-ID: <CAHkRjk7M__rtJ0cLWT65uC_trff6LtRQhY1qeii+2_gL24_+Hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/7 M?ns Rullg?rd <mans@mansr.com>:
> John Ogness <john.ogness@linutronix.de> writes:
>
>> From 6f3f381800367127dc6430d9b9fa9bd6fc6d8ed0 Mon Sep 17 00:00:00 2001
>> From: John Ogness <john.ogness@linutronix.de>
>>
>> The alignment exception handler is setup fairly late in
>> the boot process (fs_initcall). However, with newer gcc
>> versions and the compiler option -fconserve-stack, code
>> accessing unaligned data is generated in functions that
>> are called earlier, for example pcpu_dump_alloc_info().
>
> This is a gcc bug and should not be worked around like this. ?There was
> another patch[1] to disable -fconserve-stack on ARM due to this broken
> behaviour. ?This patch was the outcome of a rather lengthy discussion[2].
>
> [1] http://article.gmane.org/gmane.linux.kernel/1148272
> [2] http://thread.gmane.org/gmane.linux.ports.arm.kernel/117863

I got some feedback from the gcc guys here in ARM (but then I went on
holiday and forgot about this). They convinced me that there isn't any
gcc bug, it is behaving correctly. Even with -fconserve-stack, the
variables on the stack are naturally aligned as expected (ints to
32-bit boundary etc.) The unaligned access happens when gcc populates
a char[9] string on the stack - see the pcpu_dump_alloc_info()
function. Since unaligned accesses are on by default, gcc generates
some unaligned STR to populate the string on the stack. This looks
like a perfectly valid behaviour.

>> This results in unhandled alignment exceptions during
>> boot. By setting up the exception handler sooner, we
>> reduce the window where a compiler may generate code
>> accessing unaligned data.
>
> I will also restate my opinion that enabling strict alignment checking
> on ARMv6 and later is *wrong* in the first place.

That's probably the solution.

-- 
Catalin
