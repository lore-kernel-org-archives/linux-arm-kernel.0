From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 24 Oct 2013 17:10:42 +0800
Subject: [RFC PATCH] kernel/kallsyms.c: only show legal kernel symbol
In-Reply-To: <20131024084559.GD16735@n2100.arm.linux.org.uk>
References: <1382498320-26594-1-git-send-email-tom.leiming@gmail.com>
 <87eh7bfoq9.fsf@rustcorp.com.au>
 <20131024084559.GD16735@n2100.arm.linux.org.uk>
Message-ID: <CACVXFVOXhKE3w0658ztum5E5C-TK=wA4A9Gx7Bn2aRKzEt=OZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 4:45 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Oct 24, 2013 at 11:51:18AM +1030, Rusty Russell wrote:
>> Ming Lei <tom.leiming@gmail.com> writes:
>> > Address of non-module kernel symbol should always be located
>> > from CONFIG_PAGE_OFFSET on, so only show these legal kernel
>> > symbols in /proc/kallsyms.
>> >
>> > On ARM, some symbols(see below) may drop in relocatable code, so
>> > perf can't parse kernel symbols any more from /proc/kallsyms, this
>> > patch fixes the problem.
>> >
>> >     00000000 t __vectors_start
>> >     00000020 A cpu_v7_suspend_size
>> >     00001000 t __stubs_start
>> >     00001004 t vector_rst
>> >     00001020 t vector_irq
>> >     000010a0 t vector_dabt
>> >     00001120 t vector_pabt
>> >     000011a0 t vector_und
>> >     00001220 t vector_addrexcptn
>> >     00001224 t vector_fiq
>> >     00001224 T vector_fiq_offset
>> >
>> > The issue can be fixed in scripts/kallsyms.c too, but looks this
>> > approach is easier.
>>
>> This fix looks hacky; if these symbols are not available, don't just
>> remove them from /proc/kallsyms, but don't put them in the kernel at
>> all.
>
> How do you "don't put them in the kernel at all" when they're used by
> the kernel internally as offsets?
>
> If you mean, just get rid of them, shall I just add these as magic
> numbers instead based on the values in this email?  Is that really a
> sane solution?
>
> No, we have to keep these symbols IMHO.

If so, looks we have to hide them to userspace, so the patch
should be OK because the approach is correct and no obvious
side-effect.


Thanks,
-- 
Ming Lei
