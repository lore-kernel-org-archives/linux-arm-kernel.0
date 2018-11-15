From: pintu.ping@gmail.com (Pintu Agarwal)
Date: Thu, 15 Nov 2018 18:52:39 +0530
Subject: [ARM64] Printing IRQ stack usage information
Message-ID: <CAOuPNLiLj9be5iUdpUiLqiTge-xYY_v4_VLs-ah2_PygG7vxdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I have a requirement in printing irq stack usage information for each cpu.
I am using the following:
Linux Kernel: 4.9.x
Board: hikey620 (arm64, armv8 with 8 cores)
Platform: Ubuntu 14 debian

As a vague idea, I tried to implement like this:
-------------------------------------------------------------
static int dump_irq_stack_info(void)
{
        int cpu, actual;
        unsigned long irq_stack_ptr;
        //unsigned long sp, sp1;
        unsigned long stack_start;
        unsigned long used;

        actual = IRQ_STACK_SIZE;
        used = 0;
        pr_info("CPU UNUSED-STACK ACTUAL-STACK\n");
        //seq_printf(m, "CPU UNUSED-STACK ACTUAL-STACK\n");
        for_each_present_cpu(cpu) {
                irq_stack_ptr = IRQ_STACK_PTR(cpu);
                //sp1 = current_stack_pointer;
                //sp = IRQ_STACK_TO_TASK_STACK(irq_stack_ptr);
                stack_start = (unsigned long)per_cpu(irq_stack, cpu);
                used = irq_stack_ptr - stack_start;
                pr_info("%2d %10lu %10d\n", cpu, used, actual);
                //seq_printf(m, "%2d %10lu %10d\n", cpu, used, actual);
        }

        return 0;
}
-------------------------------------------------------------
Currently, when I tested this (as a proc interface), I got the below output:
CPU    UNUSED-STACK    ACTUAL-STACK
 0         16368                     16384
 1         16368                     16384
 2         16368                     16384
 3         16368                     16384
 4         16368                     16384
 5         16368                     16384
 6         16368                     16384
 7         16368                     16384
-------------------------------------------------------------

But, I have some doubts:
1) I am not sure if my implementation is in right direction, or the
logic is totally wrong.
2) Is there better way to perform the similar objective?
3) How should I test it to get the different usage values for unused stack ?
    Can I get these values by implementing a sample interrupt handler,
and printing information from there?

If this works, then I want to use it as part of dump_backtrace() function.

If anybody have done a similar thing in past, or have some ideas to
share, please help me.

Note: This is required only for our internal debugging purpose.


Regards,
Pintu
