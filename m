From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 7 Sep 2011 17:43:12 +0100
Subject: [PATCH] ARM: alignment: setup alignment handler earlier
In-Reply-To: <20110907162857.GB2327@n2100.arm.linux.org.uk>
References: <87ehzstr07.fsf@vostro.fn.ogness.net>
	<20110907144016.GA30719@e102109-lin.cambridge.arm.com>
	<20110907162857.GB2327@n2100.arm.linux.org.uk>
Message-ID: <CAHkRjk4CQAMb5GdGxKY3oASQYA6a3w0dCNXbD3pF4NFKgmPfQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 September 2011 17:28, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Sep 07, 2011 at 03:40:16PM +0100, Catalin Marinas wrote:
>> On Wed, Sep 07, 2011 at 02:35:04PM +0100, John Ogness wrote:
>> > From 6f3f381800367127dc6430d9b9fa9bd6fc6d8ed0 Mon Sep 17 00:00:00 2001
>> > From: John Ogness <john.ogness@linutronix.de>
>> >
>> > The alignment exception handler is setup fairly late in
>> > the boot process (fs_initcall). However, with newer gcc
>> > versions and the compiler option -fconserve-stack, code
>> > accessing unaligned data is generated in functions that
>> > are called earlier, for example pcpu_dump_alloc_info().
>> > This results in unhandled alignment exceptions during
>> > boot. By setting up the exception handler sooner, we
>> > reduce the window where a compiler may generate code
>> > accessing unaligned data.
>>
>> While this reduces the window and fixes this particular case, it still
>> doesn't solve the problem. We never know when some unaligned access
>> would be generated for some earlier code.
>
> Is the problem even solvable? ?There are instructions on ARMv6+ which
> always produce an alignment fault (eg, ldrd) irrespective of strict
> alignment checking.

We can just hope that the compiler isn't that bad as to generate
unaligned accesses with those instructions that are known to fault.
That's what I would consider a compiler bug.

-- 
Catalin
