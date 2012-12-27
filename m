From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 27 Dec 2012 13:24:39 -0800
Subject: [PATCH] dma: mv_xor: remove minimal offload length threshold
In-Reply-To: <1356636037-22948-1-git-send-email-lkundrak@v3.sk>
References: <1356636037-22948-1-git-send-email-lkundrak@v3.sk>
Message-ID: <20121227212439.GA3211@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 27, 2012 at 08:20:37PM +0100, Lubomir Rintel wrote:
> This fatally confuses dma_async_memcpy_buf_to_pg which thinks it signals an out
> of memory condition and retries indefinitelly, causing a soft lockup. The
> threshold does not seem to be enforced by hardware (couldn't find anything like
> that in a datasheet) and things seems to work fine without it. If there's a
> performance penalty, it probably should be dealt with in dmaengine.
> 
> The following crash (with too small skb structure being dma_memcpy()'d) is
> reprodcibly triggered by an accept() quickly followed by a read():
> http://v3.sk/~lkundrak/so-beautiful/crasher.pl
> 
> BUG: soft lockup - CPU#0 stuck for 23s! [perl:715]
> Modules linked in:
> Pid: 715, comm:                 perl
> CPU: 0    Not tainted  (3.6.7-2.fc18.armv5tel.kirkwood #1)
> PC is at mv_xor_prep_dma_memcpy+0x14/0x168
> LR is at dma_async_memcpy_pg_to_pg+0x100/0x1dc
> sp : df197ce0  ip : c023816c  fp : 00000000
> r10: c09a6720  r9 : 0000012a  r8 : 115d7000
> r7 : ddd4f57c  r6 : ddd4f57c  r5 : ddd4f4a8  r4 : 00000034
> r3 : 00000034  r2 : 115d7000  r1 : 116b912a  r0 : ddd4f57c
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 0005397f  Table: 1f218000  DAC: 00000015
> [<c000edac>] (unwind_backtrace+0x0/0x124) from [<c0074ce4>] (watchdog_timer_fn+0xf0/0x144)
> [<c0074ce4>] (watchdog_timer_fn+0xf0/0x144) from [<c003aa10>] (__run_hrtimer+0xb0/0x1d4)
> [<c003aa10>] (__run_hrtimer+0xb0/0x1d4) from [<c003b224>] (hrtimer_interrupt+0x104/0x250)
> [<c003b224>] (hrtimer_interrupt+0x104/0x250) from [<c0016024>] (orion_timer_interrupt+0x24/0x34)
> [<c0016024>] (orion_timer_interrupt+0x24/0x34) from [<c0075470>] (handle_irq_event_percpu+0x38/0x23c)
> [<c0075470>] (handle_irq_event_percpu+0x38/0x23c) from [<c00756a4>] (handle_irq_event+0x30/0x40)
> [<c00756a4>] (handle_irq_event+0x30/0x40) from [<c0077cd4>] (handle_level_irq+0xcc/0xdc)
> [<c0077cd4>] (handle_level_irq+0xcc/0xdc) from [<c0074e9c>] (generic_handle_irq+0x28/0x38)
> [<c0074e9c>] (generic_handle_irq+0x28/0x38) from [<c0009b64>] (handle_IRQ+0x68/0x8c)
> [<c0009b64>] (handle_IRQ+0x68/0x8c) from [<c0444794>] (__irq_svc+0x34/0x78)
> [<c0444794>] (__irq_svc+0x34/0x78) from [<c0238180>] (mv_xor_prep_dma_memcpy+0x14/0x168)
> [<c0238180>] (mv_xor_prep_dma_memcpy+0x14/0x168) from [<c0236010>] (dma_async_memcpy_pg_to_pg+0x100/0x1dc)
> [<c0236010>] (dma_async_memcpy_pg_to_pg+0x100/0x1dc) from [<c0237594>] (dma_memcpy_pg_to_iovec+0xf0/0x180)
> [<c0237594>] (dma_memcpy_pg_to_iovec+0xf0/0x180) from [<c03832f8>] (dma_skb_copy_datagram_iovec+0x100/0x1d4)
> [<c03832f8>] (dma_skb_copy_datagram_iovec+0x100/0x1d4) from [<c03a9950>] (tcp_recvmsg+0x630/0xac0)
> [<c03a9950>] (tcp_recvmsg+0x630/0xac0) from [<c03c8dd8>] (inet_recvmsg+0x48/0x5c)
> [<c03c8dd8>] (inet_recvmsg+0x48/0x5c) from [<c035ba54>] (sock_aio_read+0x100/0x120)
> [<c035ba54>] (sock_aio_read+0x100/0x120) from [<c00e53e0>] (do_sync_read+0x98/0xd4)
> [<c00e53e0>] (do_sync_read+0x98/0xd4) from [<c00e5d54>] (vfs_read+0xb4/0x184)
> [<c00e5d54>] (vfs_read+0xb4/0x184) from [<c00e5e60>] (sys_read+0x3c/0x70)
> [<c00e5e60>] (sys_read+0x3c/0x70) from [<c0008c60>] (ret_fast_syscall+0x0/0x2c)
> Kernel panic - not syncing: softlockup: hung tasks
> [<c000edac>] (unwind_backtrace+0x0/0x124) from [<c043e0ac>] (panic+0x80/0x1e0)
> [<c043e0ac>] (panic+0x80/0x1e0) from [<c0074d08>] (watchdog_timer_fn+0x114/0x144)
> [<c0074d08>] (watchdog_timer_fn+0x114/0x144) from [<c003aa10>] (__run_hrtimer+0xb0/0x1d4)
> [<c003aa10>] (__run_hrtimer+0xb0/0x1d4) from [<c003b224>] (hrtimer_interrupt+0x104/0x250)
> [<c003b224>] (hrtimer_interrupt+0x104/0x250) from [<c0016024>] (orion_timer_interrupt+0x24/0x34)
> [<c0016024>] (orion_timer_interrupt+0x24/0x34) from [<c0075470>] (handle_irq_event_percpu+0x38/0x23c)
> [<c0075470>] (handle_irq_event_percpu+0x38/0x23c) from [<c00756a4>] (handle_irq_event+0x30/0x40)
> [<c00756a4>] (handle_irq_event+0x30/0x40) from [<c0077cd4>] (handle_level_irq+0xcc/0xdc)
> [<c0077cd4>] (handle_level_irq+0xcc/0xdc) from [<c0074e9c>] (generic_handle_irq+0x28/0x38)
> [<c0074e9c>] (generic_handle_irq+0x28/0x38) from [<c0009b64>] (handle_IRQ+0x68/0x8c)
> [<c0009b64>] (handle_IRQ+0x68/0x8c) from [<c0444794>] (__irq_svc+0x34/0x78)
> [<c0444794>] (__irq_svc+0x34/0x78) from [<c0238180>] (mv_xor_prep_dma_memcpy+0x14/0x168)
> [<c0238180>] (mv_xor_prep_dma_memcpy+0x14/0x168) from [<c0236010>] (dma_async_memcpy_pg_to_pg+0x100/0x1dc)
> [<c0236010>] (dma_async_memcpy_pg_to_pg+0x100/0x1dc) from [<c0237594>] (dma_memcpy_pg_to_iovec+0xf0/0x180)
> [<c0237594>] (dma_memcpy_pg_to_iovec+0xf0/0x180) from [<c03832f8>] (dma_skb_copy_datagram_iovec+0x100/0x1d4)
> [<c03832f8>] (dma_skb_copy_datagram_iovec+0x100/0x1d4) from [<c03a9950>] (tcp_recvmsg+0x630/0xac0)
> [<c03a9950>] (tcp_recvmsg+0x630/0xac0) from [<c03c8dd8>] (inet_recvmsg+0x48/0x5c)
> [<c03c8dd8>] (inet_recvmsg+0x48/0x5c) from [<c035ba54>] (sock_aio_read+0x100/0x120)
> [<c035ba54>] (sock_aio_read+0x100/0x120) from [<c00e53e0>] (do_sync_read+0x98/0xd4)
> [<c00e53e0>] (do_sync_read+0x98/0xd4) from [<c00e5d54>] (vfs_read+0xb4/0x184)
> [<c00e5d54>] (vfs_read+0xb4/0x184) from [<c00e5e60>] (sys_read+0x3c/0x70)
> [<c00e5e60>] (sys_read+0x3c/0x70) from [<c0008c60>] (ret_fast_syscall+0x0/0x2c)
> Rebooting in 1 seconds..
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/dma/mv_xor.c |    7 -------
>  drivers/dma/mv_xor.h |    1 -
>  2 files changed, 0 insertions(+), 8 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
