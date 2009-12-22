From: ospite@studenti.unina.it (Antonio Ospite)
Date: Wed, 23 Dec 2009 00:53:13 +0100
Subject: [BUG] pxa27x_udc: possible recursive locking detected in
	pxa_ep_queue
In-Reply-To: <87ocltsda3.fsf@free.fr>
References: <20091205115754.7e1dc0fd.ospite@studenti.unina.it>
	<87fx7guuzg.fsf@free.fr>
	<20091212173140.f9ac2a7b.ospite@studenti.unina.it>
	<87ocltsda3.fsf@free.fr>
Message-ID: <20091223005313.13ba5061.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 20 Dec 2009 19:36:52 +0100
Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> Antonio Ospite <ospite@studenti.unina.it> writes:
>
[...]
> > =================================
> > [ INFO: inconsistent lock state ]
> > 2.6.32-ezxdev #45
> > ---------------------------------
> <snip>
> 
> Hi Antonio,
> 
> I tried to trigger the same message, to no avail. Even after activating spinlock
> debugging and plugging/unplugging like a mad man, nothing ...
> Well, I must rely on your testing I'm afraid. Could you test this patch ? I
> rebased my tree on v2.6.32 so you will have no git-am complaint.
>

With your latest patch on top of 2.6.32 I get the "possible recursive
locking" message at the *first* cable unplug/plug cycle, I am appending
it here, the log is partial because I dumped it from RAM and something
was lost.

=============================================
[ INFO: possible recursive locking detected ]
2.6.32-ezxdev #5
---------------------------------------------
swapper/0 is trying to acquire lock:
 (&ep->lock){-.....}, at: [<c019c6e0>] pxa_ep_queue+0x78/0x300

but task is already holding lock:
 (&ep->lock){-.....}, at: [<c019c158>] pxa_udc_irq+0x43c/0x7fc

other info that might help us debug this:
1 lock held by swapper/0:
 #0:  (&ep->lock){-.....}, at: [<c019c158>] pxa_udc_irq+0x43c/0x7fc

stack backtrace:
[<c002febc>] (unwind_backtrace+0x0/0xe0) from [<c0068484>] (validate_chain+0x5b0/0xdd8)
[<c0068484>] (validate_chain+0x5b0/0xdd8) from [<c00694ec>] (__lock_acquire+0x840/0x918)
[<c00694ec>] (__lock_acquire+0x840/0x918) from [<c006a49c>] (lock_acquire+0x60/0x74)
[<c006a49c>] (lock_acquire+0x60/0x74) from [<c02a4d24>] (_spin_lock_irqsave+0x4c/0x60)
[<c02a4d24>] (_spin_lock_irqsave+0x4c/0x60) from [<c019c6e0>] (pxa_ep_queue+0x78/0x300)
[<c019c6e0>] (pxa_ep_queue+0x78/0x300) from [<c019f348>] (composite_setup+0x764/0x7b0)
[<c019f348>] (composite_setup+0x764/0x7b0) from [<c019c29c>] (pxa_udc_irq+0x580/0x7fc)
[<c019c29c>] (pxa_udc_irq+0x580/0x7fc) from [<c0075ccc>] (handle_IRQ_event+0x28/0xf8)
[<c0075ccc>] (handle_IRQ_event+0x28/0xf8) from [<c0077f98>] (handle_level_irq+0x118/0x130)
[<c0077f98>] (handle_level_irq+0x118/0x130) from [<c0029070>] (asm_do_IRQ+0x70/0x94)
[<c0029070>] (asm_do_IRQ+0x70/0x94) from [<c0029ad0>] (__irq_svc+0x50/0xe0)
Exception stack(0xc039ff78 to 0xc039ffc0)
ff60:                                                       00000001 00000004
ff80: 00000001 20000013 c039e000 c03a217c c03cd568 c03a2170 a0024e98 69054117
ffa0: a0024d60 00000000 c039ff10 c039ffc0 c0066f7c c002b618 20000013 ffffffff
[<c0029ad0>] (__irq_svc+0x50/0xe0) from [<c002b618>] (default_idle+0x30/0x38)
[<c002b618>] (default_idle+0x30/0x38) from [<c002b4f4>] (cpu_idle+0x64/0xc0)
[<c002b4f4>] (cpu_idle+0x64/0xc0) from [<c0008aac>] (start_kernel+0x31c/0x38c)
[<c0008aac>] (start_kernel+0x31c/0x38c) from [<a0008034>] (0xa0008034)
BUG: spinlock lockup on CPU#0, swapper/0, c03c19d0
[<c002febc>] (unwind_backtrace+0x0/0xe0) from [<c013ebf4>] (_raw_spin_lock+0xe8/0x124)
[<c013ebf4>] (_raw_spin_lock+0xe8/0x124) from [<c02a4d2c>] (_spin_lock_irqsave+0x54/0x60)
[<c02a4d2c>] (_spin_lock_irqsave+0x54/0x60) from [<c019c6e0>] (pxa_ep_queue+0x78/0x300)
[<c019c6e0>] (pxa_ep_queue+0x78/0x300) from [<c019f348>] (composite_setup+0x764/0x7b0)
           ] (composite_setup+0x764/0x7b0) from [<c019c29c>] (pxa_udc_irq+0x580/0x7fc)
[<c019c29c>] (pxa_udc_irq+0x580/0x7fc) from [<c0075ccc>] (handle_IRQ_event+0x28/0xf8)
[<c0075ccc>] (handle_IRQ_event+0x28/0xf8) from [<c0077f98>] (handle_level_irq+0x118/0x130)
...

Could any furher info about my platform be useful to find out why you can't
reproduce the issue?

Thanks for your time.

All the best,
   Antonio

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091223/cc831f9d/attachment.sig>
