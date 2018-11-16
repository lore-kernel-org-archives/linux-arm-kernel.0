From: pintu.ping@gmail.com (Pintu Agarwal)
Date: Fri, 16 Nov 2018 11:44:36 +0530
Subject: [ARM64] Printing IRQ stack usage information
In-Reply-To: <28496.1542300549@turing-police.cc.vt.edu>
References: <CAOuPNLiLj9be5iUdpUiLqiTge-xYY_v4_VLs-ah2_PygG7vxdg@mail.gmail.com>
 <28496.1542300549@turing-police.cc.vt.edu>
Message-ID: <CAOuPNLj8wj=tPJo8L3oS7o8iTQcyhZ0W-GH6xmP_GsG4r7YdAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Nov 2018, 10:19 pm <valdis.kletnieks@vt.edu wrote:
>
> On Thu, 15 Nov 2018 18:52:39 +0530, Pintu Agarwal said:
>
> > Currently, when I tested this (as a proc interface), I got the below output:
> > CPU    UNUSED-STACK    ACTUAL-STACK
> >  0         16368                     16384
>
> > 3) How should I test it to get the different usage values for unused stack ?
> >     Can I get these values by implementing a sample interrupt handler,
> > and printing information from there?
>
> Hint 1:  If you're in a state where seq_printf() is legal, how many IRQ's are
> on this processor's IRQ stack?
>
> Hint 2:  What are the chances that some other CPU is currently in an IRQ?
> (run 'top' and look for what percent of time that's happening)
>
> Hint 3: what are the chances that the value of irq_stack_ptr is already stale
> by the time seq_printf() finishes running?
>
> Hint 4: what happens to the validity of your output if you get rescheduled
> in the middle of that for_each loop?
>
> (In other words, this code is terribly racy and is probably not going to answer
> whatever debugging question you were working on..

Okay. Thanks so much for your hints.
Yes, I understand that this code is horribly ugly and bad.
But this is only to understand if the below logic is fine to get the
irq stack usage:
{{{
        for_each_present_cpu(cpu) {
                irq_stack_ptr = IRQ_STACK_PTR(cpu);
                //unsigned long sp = current_stack_pointer;

                stack_start = (unsigned long)per_cpu(irq_stack, cpu);
                free_stack = irq_stack_ptr - stack_start;
                seq_printf(m, "%2d %10lu %10d\n", cpu, free_stack, actual);
        }
}}}
Of course, final plan is not the proc entry, but to find a relevant
place to invoke it, probably during boot time, or during backtrace.

> If your question is "Did one
> of the CPUs blow out its IRQ stack (or come close to doing so)?" there's better
> approaches.
>
Yes, exactly, this is what the main intention.
If you have any better idea about this approach, please refer me.
It will be of great help.

Thank You!

>
