From: tom.leiming@gmail.com (Ming Lei)
Date: Sun, 23 May 2010 23:07:50 +0800
Subject: [RESEND PATCH] ARM: fix 'unannotated irqs-on' lockdep warning
In-Reply-To: <20100523141300.GD950@n2100.arm.linux.org.uk>
References: <1274615328-27953-1-git-send-email-tom.leiming@gmail.com>
	<20100523123801.GC950@n2100.arm.linux.org.uk>
	<AANLkTikRp0EHxshKYq39p18ymoRNAtyHrNm3yq6A49-r@mail.gmail.com>
	<20100523141300.GD950@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinV9Na9zxYMIfTr893Ynnc0YOk2B6uPKEa9s4R1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/5/23 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Sun, May 23, 2010 at 09:44:20PM +0800, Ming Lei wrote:
>> 2010/5/23 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>> >> ?ENTRY(ret_to_user)
>> >> ?ret_slow_syscall:
>> >> - ? ? disable_irq ? ? ? ? ? ? ? ? ? ? ? ? ? ? @ disable interrupts
>> >> + ? ? disable_irq_notrace ? ? ? ? ? ? ? ? ? ? ? ? ? ? @ disable interrupts
>> >
>> > I think this one does need to be traced - the pending work functions are
>> > all C code which could call back into lockdep.
>>
>> If there are pending works, schedule will be called to give cpu to it,
>> I wonder why the work function to be scheduled will be run with irq
>> disabled. Seems we should enable irq again before calling schedule,
>> not sure.
>
> No. ?I'm talking about things like do_notify_resume().
>
> I think the above should be left as-is, so that as far as lockdep is
> concerned, IRQs are off while userspace runs. ?What happens between
> returning to userspace and re-entering the kernel has no bearing what
> so ever on lockdep.
>

Oh, trace_ret_hardirqs_on has to be added before returning to user-space to
remove the warning, like x86 and mips. If you agree, I'd like to post
a new version
patch.

Thanks,

-- 
Lei Ming
