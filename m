From: yegor_sub1@visionsystems.de (Yegor Yefremov)
Date: Thu, 15 Oct 2009 11:44:26 +0200
Subject: [at91sam9g45] Network crash
In-Reply-To: <20091014090641.GA18013@n2100.arm.linux.org.uk>
References: <4AD58FFB.50204@visionsystems.de>
	<20091014090641.GA18013@n2100.arm.linux.org.uk>
Message-ID: <4AD6EEFA.8000606@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This doesn't make sense - the backtrace values do not appear in the stack
> dump, plus the backtrace is missing from the oops (its generated from the
> panic() itself.
> 
> What's more is that the backtrace itself is wrong (Catalin?) because it's
> duplicating the information - the first function reference per line is
> supposed to be where we entered the function, but I guess EABI can't
> give that to us.
> 
> Moreover, it seems to be a thumb based kernel, which I guess means that
> you can't enable frame pointers to get a better backtrace, especially one
> which reveals the path to the faulting instruction itself.
> 
> No idea how to debug this I'm afraid.  The only suggestion I can come
> up with is to use some kind of hardware tracing tool to monitor the
> processor instruction fetches and produce a log from that.  Maybe
> Catalin can provide other hints on how to debug T2 code.

Russell, thank you for the quick answer. I made some further tests to be sure it is not a regression from "official" 2.6.27 kernel. After flashing NAND with the initial image from http://www.linux4sam.org/ I could reproduce the crash with nuttcp. See following crash dumps:

Dump 1:

root at at91sam:~$ nuttcp -t -T5m 192.168.1.90
nuttcp-t: Info: attempting to switch to deprecated "classic" mode
nuttcp-t: Info: will use less reliable transmitter side statistics
Unable to handle kernel paging request at virtual address e89da8f0
pgd = c3f04000
[e89da8f0] *pgd=00000000
Internal error: Oops: 5 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.27 #1)
PC is at __kmalloc+0x28/0xd0
LR is at __alloc_skb+0x50/0xf0
pc : [<c007eee0>]    lr : [<c01eb09c>]    psr: 20000013
sp : c3f0bc20  ip : c3f0bc40  fp : c3f0bc3c
r10: 0000017d  r9 : c03350c0  r8 : 00000000
r7 : 00000020  r6 : 00000060  r5 : 00000020  r4 : c383dd40
r3 : 00000073  r2 : 0000014c  r1 : 00000020  r0 : e89da8f0
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005317f  Table: 73f04000  DAC: 00000015
Process nuttcp (pid: 3209, stack limit = 0xc3f0a268)
Stack: (0xc3f0bc20 to 0xc3f0c000)
bc20: c383dd40 00000020 00000060 c3807d40 c3f0bc64 c3f0bc40 c01eb09c c007eec8
bc40: 00000000 0000017d 00000002 c38cf398 00000042 c38cf360 c3f0bc74 c3f0bc68
bc60: c01eb424 c01eb05c c3f0bcb4 c3f0bc78 c014b2cc c01eb414 c021ebd4 00000040
bc80: 00000000 00000040 00000000 c38cf398 00000040 c0323ec0 c03350ac 0000012c
bca0: c03350c0 ffffe258 c3f0bce4 c3f0bcb8 c01f24fc c014b0f8 c383dd40 c0323ecc
bcc0: 00000001 c0323ec0 0000000a 00000001 c0326624 00000000 c3f0bd14 c3f0bce8
bce0: c00425c4 c01f24a8 c383dd40 60000013 c3ed8d00 00000000 7fffffff c3f0bdec
bd00: c3f0a000 c3f0bd6c c3f0bd2c c3f0bd18 c004266c c004256c fefff000 00000000
bd20: c3f0bd44 c3f0bd30 c0042c04 c0042630 00000000 00000000 c3f0bd64 c3f0bd48
bd40: c01e6898 c0042b88 00000660 00000000 c3f0a000 c3ed8d00 c3f0bda4 c3f0bd68
bd60: c01ed63c c01e681c c3ed8d00 00000000 c38680e0 c0051048 c358d61c c358d61c
bd80: 000005a8 c3ed8d00 c3f0dce0 00000000 00000000 0003a878 c3f0be1c c3f0bda8
bda0: c0213900 c01ed4ec c3f0bde8 c3dd2c34 c3ed8d00 c3ed8d6c 00000000 00000001
bdc0: c3f0be04 c3f0bf20 00000000 00000000 000005a8 000005a8 000024e0 00000000
bde0: c3f0a000 0000db20 00000000 7fffffff c3dd2c34 c3f0be90 00000000 c3d59140
be00: c3f0bf20 00000001 c3f0a000 fffffdee c3f0be84 c3f0be20 c01e3bfc c0213010
be20: c383dec0 c03354f8 c383dec0 00010000 c358d600 00000000 00000000 c3f0be40
be40: 00000000 00000000 c3f0bf20 00000001 00000000 00000000 00000000 c3f0be90
be60: c02087c0 c3f0be90 c3d59140 c3f0be90 c3f0bf20 c3f0bf78 c3f0bf4c c3f0be88
be80: c0081be4 c01e3b30 00000000 00000000 c033516c c38cf000 00000000 00000001
bea0: ffffffff c3d59140 00000000 00000000 00000000 00000000 c38680e0 00000013
bec0: 00000000 00000000 00000067 c38680e0 c0051048 c3f0bed4 c3f0bed4 0000000c
bee0: 00000000 00000000 c3f0be20 c3d9b108 00000000 c0323ec0 00010000 c3f0bf08
bf00: c01eb000 c01ea89c c0124d38 c3d9b108 c3f0bf34 00000000 00000000 c358d724
bf20: 0002cd58 00010000 c3d59140 0002cd58 c3f0bf78 00010000 c0028d68 00000000
bf40: c3f0bf74 c3f0bf50 c00824e8 c0081b38 00000000 00000019 00000000 00000000
bf60: c3d59140 00000004 c3f0bfa4 c3f0bf78 c0082988 c0082428 00000000 00000000
bf80: c3f0bfac 00000000 c0028058 72a2ad64 418fbaff 00000001 00000000 c3f0bfa8
bfa0: c0028bc0 c0082954 72a2ad64 418fbaff 00000004 0002cd58 00010000 00000000
bfc0: 72a2ad64 418fbaff 00000001 00000004 00025dc8 0002517c 00025f44 00025ef8
bfe0: bebd77d0 bebd77a8 0000b79c 400cf5ac 60000010 00000004 703be031 703be431
Backtrace:
[<c007eeb8>] (__kmalloc+0x0/0xd0) from [<c01eb09c>] (__alloc_skb+0x50/0xf0)
 r7:c3807d40 r6:00000060 r5:00000020 r4:c383dd40
[<c01eb04c>] (__alloc_skb+0x0/0xf0) from [<c01eb424>] (dev_alloc_skb+0x20/0x44)
 r8:c38cf360 r7:00000042 r6:c38cf398 r5:00000002 r4:0000017d
[<c01eb404>] (dev_alloc_skb+0x0/0x44) from [<c014b2cc>] (macb_poll+0x1e4/0x3ec)
[<c014b0e8>] (macb_poll+0x0/0x3ec) from [<c01f24fc>] (net_rx_action+0x64/0x1b0)
[<c01f2498>] (net_rx_action+0x0/0x1b0) from [<c00425c4>] (__do_softirq+0x68/0xc4)
[<c004255c>] (__do_softirq+0x0/0xc4) from [<c004266c>] (do_softirq+0x4c/0x58)
[<c0042620>] (do_softirq+0x0/0x58) from [<c0042c04>] (local_bh_enable+0x8c/0xac)
 r4:00000000
[<c0042b78>] (local_bh_enable+0x0/0xac) from [<c01e6898>] (release_sock+0x8c/0x90)
 r4:00000000
[<c01e680c>] (release_sock+0x0/0x90) from [<c01ed63c>] (sk_stream_wait_memory+0x160/0x230)
 r6:c3ed8d00 r5:c3f0a000 r4:00000000
[<c01ed4dc>] (sk_stream_wait_memory+0x0/0x230) from [<c0213900>] (tcp_sendmsg+0x900/0xb48)
[<c0213000>] (tcp_sendmsg+0x0/0xb48) from [<c01e3bfc>] (sock_aio_write+0xdc/0xe4)
[<c01e3b20>] (sock_aio_write+0x0/0xe4) from [<c0081be4>] (do_sync_write+0xbc/0x10c)
 r8:c3f0bf78 r7:c3f0bf20 r6:c3f0be90 r5:c3d59140 r4:c3f0be90
[<c0081b28>] (do_sync_write+0x0/0x10c) from [<c00824e8>] (vfs_write+0xd0/0x148)
[<c0082418>] (vfs_write+0x0/0x148) from [<c0082988>] (sys_write+0x44/0x70)
 r7:00000004 r6:c3d59140 r5:00000000 r4:00000000
[<c0082944>] (sys_write+0x0/0x70) from [<c0028bc0>] (ret_fast_syscall+0x0/0x2c)
 r6:00000001 r5:418fbaff r4:72a2ad64
Code: 159f00ac 1a000001 ea000008 e280000c (e5903000)
Kernel panic - not syncing: Fatal exception in interrupt

Dump 2:

Unable to handle kernel NULL pointer dereference at virtual address 00000008
pgd = c3bf8000
[00000008] *pgd=73e97031, *pte=00000000, *ppte=00000000
Internal error: Oops: 817 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.27 #1)
PC is at netif_receive_skb+0x220/0x284
LR is at macb_poll+0x2f8/0x3ec
pc : [<c01f03d4>]    lr : [<c014b3e0>]    psr: 60000013
sp : c3e95c30  ip : 00000000  fp : c3e95c5c
r10: 00000000  r9 : 00000080  r8 : c0335184
r7 : 00000008  r6 : c38cf000  r5 : c031bf40  r4 : c3d74f00
r3 : 00000008  r2 : 00000000  r1 : c031bf58  r0 : c3d74f00
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005317f  Table: 73bf8000  DAC: 00000015
Process nuttcp (pid: 3572, stack limit = 0xc3e94268)
Stack: (0xc3e95c30 to 0xc3e96000)
5c20:                                     c3e95c5c c3e95c40 0000003a c3d74f00
5c40: c38cf398 00000042 c38cf360 0000003a c3e95c9c c3e95c60 c014b3e0 c01f01c4
5c60: 60000013 00000040 00000001 0000003f 00000000 c38cf398 00000040 c0323ec0
5c80: c03350ac 0000012c c03350c0 ffffe1a5 c3e95ccc c3e95ca0 c01f24fc c014b0f8
5ca0: c021cad4 c0323ecc 00000001 c0323ec0 0000000a 00000001 c0326624 00000000
5cc0: c3e95cfc c3e95cd0 c00425c4 c01f24a8 c3e95d0c 60000013 c3e28d00 00000000
5ce0: 7fffffff c3e95dec c3e94000 c3e95d6c c3e95d14 c3e95d00 c004266c c004256c
5d00: c3e95d44 00000001 c3e95d2c c3e95d18 c0042c04 c0042630 fefff000 00000001
5d20: c3e95d44 c3e95d30 c0254464 c0042b88 00000000 00000000 c3e95d64 c3e95d48
5d40: c01e685c c0254424 00000660 00000000 c3e94000 c3e28d00 c3e95da4 c3e95d68
5d60: c01ed63c c01e681c c3e28d00 00000000 c38683e0 c0051048 c35b549c c35b549c
5d80: 000005a8 c3e28d00 c3da0200 00000000 00000000 00031138 c3e95e1c c3e95da8
5da0: c0213900 c01ed4ec c3e95de8 c01eafb4 c3e28d00 c3e28d6c 00000000 00000001
5dc0: c01f2024 c3e95f20 00000000 00000000 000005a8 000005a8 0000bc20 c00424d4
5de0: c3e94000 000043e0 00000000 7fffffff c3e95f20 c3e95e90 00000000 c382a820
5e00: c3e95f20 00000001 c3e94000 fffffdee c3e95e84 c3e95e20 c01e3bfc c0213010
5e20: c3af6ce0 ffffffff fefff000 00010000 c35b5480 c3e95e94 00000000 c3e95e40
5e40: 00000000 00000000 c3e95f20 00000001 00000000 00000000 00000000 c3e95e90
5e60: 00000000 c3e95e90 c382a820 c3e95e90 c3e95f20 c3e95f78 c3e95f4c c3e95e88
5e80: c0081be4 c01e3b30 00000000 00000000 00000001 c3826168 00000000 00000001
5ea0: ffffffff c382a820 00000000 00000000 00000000 00000000 c38683e0 c00424d4
5ec0: 00000000 00000000 c0308b70 c38683e0 c0051048 c3e95ed4 c3e95ed4 00000000
5ee0: 00000000 00000000 c3e95e20 c004256c c3e95f1c c3e95f00 00010000 c00428c4
5f00: c0042614 ffffffff fefff000 00000019 c3e95f74 c3e95f20 c0028834 c0028010
5f20: 0002cd58 00010000 c382a820 0002cd58 c3e95f78 00010000 c0028d68 00000000
5f40: c3e95f74 c3e95f50 c00824e8 c0081b38 00000000 c3e95f68 00000000 00000000
5f60: c382a820 00000004 c3e95fa4 c3e95f78 c0082988 c0082428 00000000 00000000
5f80: 00000001 00000000 60000010 ac58aab9 41808380 00000001 00000000 c3e95fa8
5fa0: c0028bc0 c0082954 ac58aab9 41808380 00000004 0002cd58 00010000 00000000
5fc0: ac58aab9 41808380 00000001 00000004 00025dc8 0002517c 00025f44 00025ef8
5fe0: be98b7d0 be98b7a8 0000b79c 400cf5ac 60000010 00000004 00000000 00000000
Backtrace:
[<c01f01b4>] (netif_receive_skb+0x0/0x284) from [<c014b3e0>] (macb_poll+0x2f8/0x3ec)
[<c014b0e8>] (macb_poll+0x0/0x3ec) from [<c01f24fc>] (net_rx_action+0x64/0x1b0)
[<c01f2498>] (net_rx_action+0x0/0x1b0) from [<c00425c4>] (__do_softirq+0x68/0xc4)
[<c004255c>] (__do_softirq+0x0/0xc4) from [<c004266c>] (do_softirq+0x4c/0x58)
[<c0042620>] (do_softirq+0x0/0x58) from [<c0042c04>] (local_bh_enable+0x8c/0xac)
 r4:00000001
[<c0042b78>] (local_bh_enable+0x0/0xac) from [<c0254464>] (cond_resched_softirq+0x50/0x74)
 r4:00000001
[<c0254414>] (cond_resched_softirq+0x0/0x74) from [<c01e685c>] (release_sock+0x50/0x90)
 r4:00000000
[<c01e680c>] (release_sock+0x0/0x90) from [<c01ed63c>] (sk_stream_wait_memory+0x160/0x230)
 r6:c3e28d00 r5:c3e94000 r4:00000000
[<c01ed4dc>] (sk_stream_wait_memory+0x0/0x230) from [<c0213900>] (tcp_sendmsg+0x900/0xb48)
[<c0213000>] (tcp_sendmsg+0x0/0xb48) from [<c01e3bfc>] (sock_aio_write+0xdc/0xe4)
[<c01e3b20>] (sock_aio_write+0x0/0xe4) from [<c0081be4>] (do_sync_write+0xbc/0x10c)
 r8:c3e95f78 r7:c3e95f20 r6:c3e95e90 r5:c382a820 r4:c3e95e90
[<c0081b28>] (do_sync_write+0x0/0x10c) from [<c00824e8>] (vfs_write+0xd0/0x148)
[<c0082418>] (vfs_write+0x0/0x148) from [<c0082988>] (sys_write+0x44/0x70)
 r7:00000004 r6:c382a820 r5:00000000 r4:00000000
[<c0082944>] (sys_write+0x0/0x70) from [<c0028bc0>] (ret_fast_syscall+0x0/0x2c)
 r6:00000001 r5:41808380 r4:ac58aab9
Code: e5941018 e1a03006 e1a0e00f e59cf008 (e1a0c005)
Kernel panic - not syncing: Fatal exception in interrupt

I got the second dump twice. I also tried to disable DMA i.e. not compiling HDDMA driver in 2.6.32, but it doesn't help.

Nicolas, can you reproduce the crash on at91sam9g45-ekes?

Regards,
Yegor
