From: ospite@studenti.unina.it (Antonio Ospite)
Date: Sat, 12 Dec 2009 17:31:40 +0100
Subject: [BUG] pxa27x_udc: possible recursive locking detected in
	pxa_ep_queue
In-Reply-To: <87fx7guuzg.fsf@free.fr>
References: <20091205115754.7e1dc0fd.ospite@studenti.unina.it>
	<87fx7guuzg.fsf@free.fr>
Message-ID: <20091212173140.f9ac2a7b.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 12 Dec 2009 15:28:51 +0100
Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> Antonio Ospite <ospite@studenti.unina.it> writes:
> 
> > Hi,
> >
> > I've run into this recently, I get it with 2.6.32 (plus some code for
> > the EZX platform) especially using ROOT_NFS over usblan. It looks like
> > I can also trigger it regularly by connecting and disconnecting usb
> > cable repeatedly while the kernel on the pxa system is loading
> > (in a _non_ ROOT_NFS scenario).
> 
> Hi Antonio,
> 
> Could I ask you to try that patch please. I can't trigger the deadlock on my
> hardware, and I'd like some confirmation before I submit that one. Notice that
> the patch deals with all endpoints excepting control endpoint (ie. USB EP0), but
> that's not what matters now.
> 
> If you can give me some feedback, I would appreciate.
>

Patch does not apply cleanly on top of 2.6.32: Hunk #13 FAILED at 2102.
This is in handle_ep(), you have this snippet:
	/* some code below uses registers not available for ep0 */
 	BUG_ON(is_ep0(ep));

which is not in the code I have, I rebased the patch, and tested it,
tho.

I only tested the patch in one of my previous scenarios: the insanely repeated
connect-disconnect manoeuvre, and I am hitting another problem, log appended
below. Note that usblan is working even after I get this message.

=================================
[ INFO: inconsistent lock state ]
2.6.32-ezxdev #45
---------------------------------
inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
swapper/0 [HC0[0]:SC1[2]:HE1:SE0] takes:
 (&dev->req_lock){?.-...}, at: [<c019e5c4>] tx_complete+0x68/0x100
{IN-HARDIRQ-W} state was registered at:
  [<c00692a0>] __lock_acquire+0x5f4/0x918
  [<c006a49c>] lock_acquire+0x60/0x74
  [<c02a4b94>] _spin_lock+0x40/0x50
  [<c019d6b0>] gether_connect+0x7c/0x180
  [<c019e9f8>] geth_set_alt+0x34/0x40
  [<c019f0a0>] composite_setup+0x538/0x7b0
  [<c019be3c>] pxa_udc_irq+0x160/0x7dc
  [<c0075ccc>] handle_IRQ_event+0x28/0xf8
  [<c0077f98>] handle_level_irq+0x118/0x130
  [<c0029070>] asm_do_IRQ+0x70/0x94
  [<c0029ad0>] __irq_svc+0x50/0xe0
  [<c002b618>] default_idle+0x30/0x38
  [<c002b4f4>] cpu_idle+0x64/0xc0
  [<c0008aac>] start_kernel+0x31c/0x38c
  [<a0008034>] 0xa0008034
irq event stamp: 52984
hardirqs last  enabled at (52984): [<c02a49d4>] _spin_unlock_irqrestore+0x40/0x74
hardirqs last disabled at (52983): [<c02a4c78>] _spin_lock_irqsave+0x20/0x60
softirqs last  enabled at (52128): [<c0049274>] irq_exit+0x50/0xa4
softirqs last disabled at (52963): [<c0049274>] irq_exit+0x50/0xa4

other info that might help us debug this:
3 locks held by swapper/0:
 #0:  (&n->timer){+.-...}, at: [<c004d7e4>] run_timer_softirq+0x144/0x264
 #1:  (rcu_read_lock){.+.+..}, at: [<c020cad8>] dev_queue_xmit+0x110/0x430
 #2:  (_xmit_ETHER#2){+.-...}, at: [<c0219d0c>] sch_direct_xmit+0x40/0x1a4

stack backtrace:
[<c002febc>] (unwind_backtrace+0x0/0xe0) from [<c006677c>] (print_usage_bug+0x168/0x1ac)
[<c006677c>] (print_usage_bug+0x168/0x1ac) from [<c0066af8>] (mark_lock+0x338/0x5f0)
[<c0066af8>] (mark_lock+0x338/0x5f0) from [<c0069324>] (__lock_acquire+0x678/0x918)
[<c0069324>] (__lock_acquire+0x678/0x918) from [<c006a49c>] (lock_acquire+0x60/0x74)
[<c006a49c>] (lock_acquire+0x60/0x74) from [<c02a4b94>] (_spin_lock+0x40/0x50)
[<c02a4b94>] (_spin_lock+0x40/0x50) from [<c019e5c4>] (tx_complete+0x68/0x100)
[<c019e5c4>] (tx_complete+0x68/0x100) from [<c019b670>] (req_done+0x30/0x38)
[<c019b670>] (req_done+0x30/0x38) from [<c019b944>] (handle_ep+0x234/0x278)
[<c019b944>] (handle_ep+0x234/0x278) from [<c019c894>] (pxa_ep_queue+0x28c/0x2e4)
[<c019c894>] (pxa_ep_queue+0x28c/0x2e4) from [<c019e270>] (eth_start_xmit+0x1fc/0x2c8)
[<c019e270>] (eth_start_xmit+0x1fc/0x2c8) from [<c02098fc>] (dev_hard_start_xmit+0x264/0x334)
[<c02098fc>] (dev_hard_start_xmit+0x264/0x334) from [<c0219d38>] (sch_direct_xmit+0x6c/0x1a4)
[<c0219d38>] (sch_direct_xmit+0x6c/0x1a4) from [<c020cc04>] (dev_queue_xmit+0x23c/0x430)
[<c020cc04>] (dev_queue_xmit+0x23c/0x430) from [<c024b29c>] (arp_solicit+0x200/0x230)
[<c024b29c>] (arp_solicit+0x200/0x230) from [<c0213cd4>] (neigh_timer_handler+0x294/0x318)
[<c0213cd4>] (neigh_timer_handler+0x294/0x318) from [<c004d860>] (run_timer_softirq+0x1c0/0x264)
[<c004d860>] (run_timer_softirq+0x1c0/0x264) from [<c0048e6c>] (__do_softirq+0x9c/0x14c)
[<c0048e6c>] (__do_softirq+0x9c/0x14c) from [<c0049274>] (irq_exit+0x50/0xa4)
[<c0049274>] (irq_exit+0x50/0xa4) from [<c0029074>] (asm_do_IRQ+0x74/0x94)
[<c0029074>] (asm_do_IRQ+0x74/0x94) from [<c0029ad0>] (__irq_svc+0x50/0xe0)
Exception stack(0xc039ff78 to 0xc039ffc0)
ff60:                                                       00000001 00000004
ff80: 00000001 20000013 c039e000 c03a217c c03cd568 c03a2170 a0024e98 69054117
ffa0: a0024d60 00000000 c039fef8 c039ffc0 c0066f7c c002b618 20000013 ffffffff
[<c0029ad0>] (__irq_svc+0x50/0xe0) from [<c002b618>] (default_idle+0x30/0x38)
[<c002b618>] (default_idle+0x30/0x38) from [<c002b4f4>] (cpu_idle+0x64/0xc0)
[<c002b4f4>] (cpu_idle+0x64/0xc0) from [<c0008aac>] (start_kernel+0x31c/0x38c)
[<c0008aac>] (start_kernel+0x31c/0x38c) from [<a0008034>] (0xa0008034)

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091212/651ca2fe/attachment.sig>
