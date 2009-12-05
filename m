From: ospite@studenti.unina.it (Antonio Ospite)
Date: Sat, 5 Dec 2009 11:57:54 +0100
Subject: [BUG] pxa27x_udc: possible recursive locking detected in pxa_ep_queue
Message-ID: <20091205115754.7e1dc0fd.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've run into this recently, I get it with 2.6.32 (plus some code for
the EZX platform) especially using ROOT_NFS over usblan. It looks like
I can also trigger it regularly by connecting and disconnecting usb
cable repeatedly while the kernel on the pxa system is loading
(in a _non_ ROOT_NFS scenario).

=============================================
[ INFO: possible recursive locking detected ]
2.6.32-ezx200912031127 #3
---------------------------------------------
portmap/579 is trying to acquire lock:
 (&ep->lock){-.....}, at: [<c019c640>] pxa_ep_queue+0x78/0x2ec

but task is already holding lock:
 (&ep->lock){-.....}, at: [<c019c640>] pxa_ep_queue+0x78/0x2ec

other info that might help us debug this:
2 locks held by portmap/579:
 #0:  (uids_mutex){+.+...}, at: [<c004e8c8>] alloc_uid+0x28/0x140
 #1:  (&ep->lock){-.....}, at: [<c019c640>] pxa_ep_queue+0x78/0x2ec

stack backtrace:
[<c002febc>] (unwind_backtrace+0x0/0xe0) from [<c0068484>] (validate_chain+0x5b0/0xdd8)
[<c0068484>] (validate_chain+0x5b0/0xdd8) from [<c00694ec>] (__lock_acquire+0x840/0x918)
[<c00694ec>] (__lock_acquire+0x840/0x918) from [<c006a49c>] (lock_acquire+0x60/0x74)
[<c006a49c>] (lock_acquire+0x60/0x74) from [<c02a4c6c>] (_spin_lock_irqsave+0x4c/0x60)
[<c02a4c6c>] (_spin_lock_irqsave+0x4c/0x60) from [<c019c640>] (pxa_ep_queue+0x78/0x2ec)
[<c019c640>] (pxa_ep_queue+0x78/0x2ec) from [<c019d450>] (rx_submit+0xd0/0x144)
[<c019d450>] (rx_submit+0xd0/0x144) from [<c019b63c>] (req_done+0x30/0x38)
[<c019b63c>] (req_done+0x30/0x38) from [<c019b900>] (handle_ep+0x218/0x228)
[<c019b900>] (handle_ep+0x218/0x228) from [<c019c84c>] (pxa_ep_queue+0x284/0x2ec)
[<c019c84c>] (pxa_ep_queue+0x284/0x2ec) from [<c019d450>] (rx_submit+0xd0/0x144)
[<c019d450>] (rx_submit+0xd0/0x144) from [<c019b63c>] (req_done+0x30/0x38)
[<c019b63c>] (req_done+0x30/0x38) from [<c019b900>] (handle_ep+0x218/0x228)
[<c019b900>] (handle_ep+0x218/0x228) from [<c019c240>] (pxa_udc_irq+0x74c/0x80c)
[<c019c240>] (pxa_udc_irq+0x74c/0x80c) from [<c0075ccc>] (handle_IRQ_event+0x28/0xf8)
[<c0075ccc>] (handle_IRQ_event+0x28/0xf8) from [<c0077f98>] (handle_level_irq+0x118/0x130)
[<c0077f98>] (handle_level_irq+0x118/0x130) from [<c0029070>] (asm_do_IRQ+0x70/0x94)
[<c0029070>] (asm_do_IRQ+0x70/0x94) from [<c0029ad0>] (__irq_svc+0x50/0xe0)
Exception stack(0xccad7f10 to 0xccad7f58)
7f00:                                     00000001 cc8ed5d0 00000110 20000013
7f20: c03aa88c 00000001 00000001 00000000 c03aa3d8 ccad6000 00000000 bef51c54
7f40: ccad6000 ccad7f58 c0066e08 c02a4934 20000013 ffffffff
[<c0029ad0>] (__irq_svc+0x50/0xe0) from [<c02a4934>] (_spin_unlock_irq+0x30/0x58)
[<c02a4934>] (_spin_unlock_irq+0x30/0x58) from [<c004e8e8>] (alloc_uid+0x48/0x140)
[<c004e8e8>] (alloc_uid+0x48/0x140) from [<c00527c0>] (set_user+0x28/0x9c)
[<c00527c0>] (set_user+0x28/0x9c) from [<c005426c>] (sys_setuid+0x58/0xc4)
[<c005426c>] (sys_setuid+0x58/0xc4) from [<c0029fc0>] (ret_fast_syscall+0x0/0x34)
BUG: spinlock lockup on CPU#0, portmap/579, c03c1d98
[<c002febc>] (unwind_backtrace+0x0/0xe0) from [<c013ebf4>] (_raw_spin_lock+0xe8/0x124)
[<c013ebf4>] (_raw_spin_lock+0xe8/0x124) from [<c02a4c74>] (_spin_lock_irqsave+0x54/0x60)
[<c02a4c74>] (_spin_lock_irqsave+0x54/0x60) from [<c019c640>] (pxa_ep_queue+0x78/0x2ec)
[<c019c640>] (pxa_ep_queue+0x78/0x2ec) from [<c019d450>] (rx_submit+0xd0/0x144)
[<c019d450>] (rx_submit+0xd0/0x144) from [<c019b63c>] (req_done+0x30/0x38)
[<c019b63c>] (req_done+0x30/0x38) from [<c019b900>] (handle_ep+0x218/0x228)
[<c019b900>] (handle_ep+0x218/0x228) from [<c019c84c>] (pxa_ep_queue+0x284/0x2ec)
[<c019c84c>] (pxa_ep_queue+0x284/0x2ec) from [<c019d450>] (rx_submit+0xd0/0x144)
[<c019d450>] (rx_submit+0xd0/0x144) from [<c019b63c>] (req_done+0x30/0x38)
[<c019b63c>] (req_done+0x30/0x38) from [<c019b900>] (handle_ep+0x218/0x228)
[<c019b900>] (handle_ep+0x218/0x228) from [<c019c240>] (pxa_udc_irq+0x74c/0x80c)
[<c019c240>] (pxa_udc_irq+0x74c/0x80c) from [<c0075ccc>] (handle_IRQ_event+0x28/0xf8)
[<c0075ccc>] (handle_IRQ_event+0x28/0xf8) from [<c0077f98>] (handle_level_irq+0x118/0x130)

Regards,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091205/d0c4afbd/attachment.sig>
