From: valdis.kletnieks@vt.edu (valdis.kletnieks at vt.edu)
Date: Tue, 20 Nov 2018 14:03:28 -0500
Subject: [ARM64] Printing IRQ stack usage information
In-Reply-To: <CAOuPNLgGuomqaQVtj=1O8tYV_Bq8cqf5HqCxJ-LSGeQOVffnzw@mail.gmail.com>
References: <CAOuPNLiLj9be5iUdpUiLqiTge-xYY_v4_VLs-ah2_PygG7vxdg@mail.gmail.com>
 <28496.1542300549@turing-police.cc.vt.edu>
 <CAOuPNLj8wj=tPJo8L3oS7o8iTQcyhZ0W-GH6xmP_GsG4r7YdAQ@mail.gmail.com>
 <49219.1542367988@turing-police.cc.vt.edu>
 <CAOuPNLg4tM6Cw8Yf9rdpkBOU=+Fh654yFQeAhJf1y88Gb3MAew@mail.gmail.com>
 <5997.1542386778@turing-police.cc.vt.edu>
 <CAOuPNLiX0zhxiRAx03YjVU6cocwWbgY9naxeYPRKmT+3PoGhRw@mail.gmail.com>
 <15703.1542393111@turing-police.cc.vt.edu>
 <CAOuPNLiJmtXft6g63oATMrrrcd3jQGCfxsAzXLx8Kz=_zsR4Kg@mail.gmail.com>
 <CAOuPNLgGuomqaQVtj=1O8tYV_Bq8cqf5HqCxJ-LSGeQOVffnzw@mail.gmail.com>
Message-ID: <38799.1542740608@turing-police.cc.vt.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Nov 2018 18:21:33 +0530, Pintu Agarwal said:

> + sp = current_stack_pointer;
> + if (on_irq_stack(sp, cpu)) {
> +         stack_start = (unsigned long)per_cpu(irq_stack, cpu);
> +         last_usage = per_cpu(irq_stack_usage, cpu);
> +         curr_usage = sp - stack_start;
> +         pr_info("cpu:%d : sp: %lu, stack_start: %lu, usage: %lu\n", cpu, sp, stack_start, (sp - stack_start));
> +         if (curr_usage > last_usage)
> +                 per_cpu(irq_stack_usage, cpu) = curr_usage;
> + }

This code only works if called from the function that uses the deepest
amount of stack, because curr_usage depends on the current stack
pointer.  If some other routine went 2,934 bytes further into the stack
and then returned, you'll never know.

What you want instead is a way to see what the deepest point reached during
the current call, and compare that to the previous low.

How to detect the used stack? Go look at how the code currently
detects how deep the kernel stacks reached. (Hint 1: look at check_stack_usage()
in kernel/exit.c and stack_not_used().  Hint 2: what other support code
is implied by the implementation of stack_not used()?

> Which is the best place to invoke this ?
> I have the following option:
> 1. kernel/softirq.c => __do_softirq()
> 2. arch/arm64/kernel/smp.c => handle_IPI()
> 3. kernel/softirq.c => irq_exit()
> 4. ???

Pondering the above, what other implementations might work? Hint: if
you have a similar irq_stack_not_used() function, do you need any
additional code in *any* of those 4 places?

(And yes, I could just splat out the needed code - but you'd learn nowhere
near as much that way.. :)



-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 486 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181120/9494a71f/attachment.sig>
