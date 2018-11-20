From: pintu.ping@gmail.com (Pintu Agarwal)
Date: Tue, 20 Nov 2018 18:21:33 +0530
Subject: [ARM64] Printing IRQ stack usage information
In-Reply-To: <CAOuPNLiJmtXft6g63oATMrrrcd3jQGCfxsAzXLx8Kz=_zsR4Kg@mail.gmail.com>
References: <CAOuPNLiLj9be5iUdpUiLqiTge-xYY_v4_VLs-ah2_PygG7vxdg@mail.gmail.com>
 <28496.1542300549@turing-police.cc.vt.edu>
 <CAOuPNLj8wj=tPJo8L3oS7o8iTQcyhZ0W-GH6xmP_GsG4r7YdAQ@mail.gmail.com>
 <49219.1542367988@turing-police.cc.vt.edu>
 <CAOuPNLg4tM6Cw8Yf9rdpkBOU=+Fh654yFQeAhJf1y88Gb3MAew@mail.gmail.com>
 <5997.1542386778@turing-police.cc.vt.edu>
 <CAOuPNLiX0zhxiRAx03YjVU6cocwWbgY9naxeYPRKmT+3PoGhRw@mail.gmail.com>
 <15703.1542393111@turing-police.cc.vt.edu>
 <CAOuPNLiJmtXft6g63oATMrrrcd3jQGCfxsAzXLx8Kz=_zsR4Kg@mail.gmail.com>
Message-ID: <CAOuPNLgGuomqaQVtj=1O8tYV_Bq8cqf5HqCxJ-LSGeQOVffnzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 17, 2018 at 6:36 PM Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> On Sat, Nov 17, 2018 at 12:02 AM <valdis.kletnieks@vt.edu> wrote:
> >
> > > But my concern is that if I dump it from irq handler, I will get
> > > information only for the current cpu.
> > > How do I store and get the information for all the cpu from the boot time ?
> >
> > Make the high-water mark a per-cpu variable.
> >
> > > From where do I call my dump_irq_stack_info() [some where during the
> > > entry/exit part of the irq handler], so that I could dump information
> > > for all the handler at boot time itself ?
> >
> > No, you don't do a dump-stack during entry/exit.  You just maintain a high-water
> > value in the exit,
>
> Which is the right place to keep track of this
> high-water-irq-stack-usage (per_cpu)
> in arch/arm64/* ?
>

I tried to create a per-cpu irq_stack_usage variable like this in :
arch/arm64/include/asm/hardirq.h
+DECLARE_PER_CPU(unsigned int, irq_stack_usage);

But, I could not figure out, from where to fill these variable for irq
stack usage.
+ sp = current_stack_pointer;
+ if (on_irq_stack(sp, cpu)) {
+         stack_start = (unsigned long)per_cpu(irq_stack, cpu);
+         last_usage = per_cpu(irq_stack_usage, cpu);
+         curr_usage = sp - stack_start;
+         pr_info("cpu:%d : sp: %lu, stack_start: %lu, usage: %lu\n",
cpu, sp, stack_start, (sp - stack_start));
+         if (curr_usage > last_usage)
+                 per_cpu(irq_stack_usage, cpu) = curr_usage;
+ }

Which is the best place to invoke this ?
I have the following option:
1. kernel/softirq.c => __do_softirq()
2. arch/arm64/kernel/smp.c => handle_IPI()
3. kernel/softirq.c => irq_exit()
4. ???

Please let me know.

Thank You!
Pintu
