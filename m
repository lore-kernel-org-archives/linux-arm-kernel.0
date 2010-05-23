From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 23 May 2010 15:13:01 +0100
Subject: [RESEND PATCH] ARM: fix 'unannotated irqs-on' lockdep warning
In-Reply-To: <AANLkTikRp0EHxshKYq39p18ymoRNAtyHrNm3yq6A49-r@mail.gmail.com>
References: <1274615328-27953-1-git-send-email-tom.leiming@gmail.com>
	<20100523123801.GC950@n2100.arm.linux.org.uk>
	<AANLkTikRp0EHxshKYq39p18ymoRNAtyHrNm3yq6A49-r@mail.gmail.com>
Message-ID: <20100523141300.GD950@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 23, 2010 at 09:44:20PM +0800, Ming Lei wrote:
> 2010/5/23 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> >> ?ENTRY(ret_to_user)
> >> ?ret_slow_syscall:
> >> - ? ? disable_irq ? ? ? ? ? ? ? ? ? ? ? ? ? ? @ disable interrupts
> >> + ? ? disable_irq_notrace ? ? ? ? ? ? ? ? ? ? ? ? ? ? @ disable interrupts
> >
> > I think this one does need to be traced - the pending work functions are
> > all C code which could call back into lockdep.
> 
> If there are pending works, schedule will be called to give cpu to it,
> I wonder why the work function to be scheduled will be run with irq
> disabled. Seems we should enable irq again before calling schedule,
> not sure.

No.  I'm talking about things like do_notify_resume().

I think the above should be left as-is, so that as far as lockdep is
concerned, IRQs are off while userspace runs.  What happens between
returning to userspace and re-entering the kernel has no bearing what
so ever on lockdep.
