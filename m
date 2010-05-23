From: tom.leiming@gmail.com (Ming Lei)
Date: Sun, 23 May 2010 21:44:20 +0800
Subject: [RESEND PATCH] ARM: fix 'unannotated irqs-on' lockdep warning
In-Reply-To: <20100523123801.GC950@n2100.arm.linux.org.uk>
References: <1274615328-27953-1-git-send-email-tom.leiming@gmail.com>
	<20100523123801.GC950@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikRp0EHxshKYq39p18ymoRNAtyHrNm3yq6A49-r@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/5/23 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>> ?ENTRY(ret_to_user)
>> ?ret_slow_syscall:
>> - ? ? disable_irq ? ? ? ? ? ? ? ? ? ? ? ? ? ? @ disable interrupts
>> + ? ? disable_irq_notrace ? ? ? ? ? ? ? ? ? ? ? ? ? ? @ disable interrupts
>
> I think this one does need to be traced - the pending work functions are
> all C code which could call back into lockdep.

If there are pending works, schedule will be called to give cpu to it, I wonder
why the work function to be scheduled will be run with irq disabled.
Seems we should enable irq again before calling schedule, not sure.

> Also, I'm nervious about applying this patch without seeing more people
> test it.

I test the patch on my beagle board and is OK, and if you don't apply one
patch into your tree, there are few people who may test it since they have to
parse the raw email patch(which is more inconvenient than 'git pull') for test
if they want to do.

Thanks,
-- 
Lei Ming
