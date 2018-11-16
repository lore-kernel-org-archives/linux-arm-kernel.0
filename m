From: valdis.kletnieks@vt.edu (valdis.kletnieks at vt.edu)
Date: Fri, 16 Nov 2018 13:31:51 -0500
Subject: [ARM64] Printing IRQ stack usage information
In-Reply-To: <CAOuPNLiX0zhxiRAx03YjVU6cocwWbgY9naxeYPRKmT+3PoGhRw@mail.gmail.com>
References: <CAOuPNLiLj9be5iUdpUiLqiTge-xYY_v4_VLs-ah2_PygG7vxdg@mail.gmail.com>
 <28496.1542300549@turing-police.cc.vt.edu>
 <CAOuPNLj8wj=tPJo8L3oS7o8iTQcyhZ0W-GH6xmP_GsG4r7YdAQ@mail.gmail.com>
 <49219.1542367988@turing-police.cc.vt.edu>
 <CAOuPNLg4tM6Cw8Yf9rdpkBOU=+Fh654yFQeAhJf1y88Gb3MAew@mail.gmail.com>
 <5997.1542386778@turing-police.cc.vt.edu>
 <CAOuPNLiX0zhxiRAx03YjVU6cocwWbgY9naxeYPRKmT+3PoGhRw@mail.gmail.com>
Message-ID: <15703.1542393111@turing-police.cc.vt.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Nov 2018 23:13:48 +0530, Pintu Agarwal said:
> On Fri, Nov 16, 2018 at 10:16 PM <valdis.kletnieks@vt.edu> wrote:

> > Congrats. You just re-invented DEBUG_STACK_USAGE, which just keeps a high-water mark
> > for stack usage.
>
> So, you mean to say, my implementation is good enough to get the
> irq_stack usage, from the interrupt handler ?

No - your code doesn't keep a high-water mark (which should probably be
hooked into the IRQ exit code.

> But my concern is that if I dump it from irq handler, I will get
> information only for the current cpu.
> How do I store and get the information for all the cpu from the boot time ?

Make the high-water mark a per-cpu variable.

> From where do I call my dump_irq_stack_info() [some where during the
> entry/exit part of the irq handler], so that I could dump information
> for all the handler at boot time itself ?

No, you don't do a dump-stack during entry/exit.  You just maintain a high-water
value in the exit, and then you create a /proc/something or similar that when
read does a 'foreach CPU do print_high_water_irq'.

> Like I would to capture these information:
> - What was the name of the handler ?
> - Which cpu was executing it ?
> - How much irq stack (max value, same like high water mark) were used
> at that time ?

First, do the easy part and find out if you even *care* once you see actual
numbers.  If your IRQ stack is 8K but you never use more than 2500 bytes,
do you *really* care about the name of the handler anymore?

Also, see the code for /proc/interrupts to see how it keeps track of the
interrupts per CPU - maybe all you need to do is change each entry from
a 'count' to 'count, highwater'.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 486 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181116/1040e3c1/attachment.sig>
