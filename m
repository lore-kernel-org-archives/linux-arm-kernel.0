From: jc@eclis.ch (Jean-Christian de Rivaz)
Date: Tue, 29 Sep 2015 18:02:33 +0200
Subject: Unhandled fault or spinlock lockup suspected ?
Message-ID: <560AB619.2040502@eclis.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I tried the last git linux master on a embedded system that worked with 
a 3.19.0 kernel before. I solved most of the problems caused by the 
kernel upgrade, but every 15 to 20 minutes I get this type of kernel report:

[ 1051.150000] Unhandled fault: page domain fault (0x81b) at 0x00088000
[ 1051.150000] pgd = da078000
[ 1051.150000] [00088000] *pgd=3c7b1831, *pte=2b37d34f, *ppte=2b37d83f
[ 1051.150000] Internal error: : 81b [#1] PREEMPT ARM
[ 1051.150000] Modules linked in: at91_adc brcmfmac brcmutil mkiss ax25 
ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_conntrack_ipv4 
nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack xt_TCPMSS xt_tcpudp 
iptable_filter ip_tables x_tables industrialio_triggered_buffer cdc_acm 
rtc_ab_eoz9_s3 [last unloaded: at91_adc]
[ 1051.150000] CPU: 0 PID: 1177 Comm: dbus-daemon Tainted: G W       
4.3.0-rc3+ #1
[ 1051.150000] Hardware name: Atmel SAMA5
[ 1051.150000] task: deaf07c0 ti: da006000 task.ti: da006000
[ 1051.150000] PC is at memcpy+0x50/0x330
[ 1051.150000] LR is at 0x2c277375
[ 1051.150000] pc : [<c02a64d0>]    lr : [<2c277375>] psr: a0010013
sp : da007c7c  ip : 42442f70  fp : da007cc4
[ 1051.150000] r10: 00000051  r9 : dea2b73d  r8 : 6f746b73
[ 1051.150000] r7 : 65646565  r6 : 72662f67  r5 : 726f2f27  r4 : 3d687461
[ 1051.150000] r3 : 702c2764  r2 : ffffffa5  r1 : dea2b718  r0 : 00088000
[ 1051.150000] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM 
Segment none
[ 1051.150000] Control: 10c53c7d  Table: 3a078059  DAC: 00000051
[ 1051.150000] Process dbus-daemon (pid: 1177, stack limit = 0xda006208)
[ 1051.150000] Stack: (0xda007c7c to 0xda008000)
[ 1051.150000] 7c60: 00000000
[ 1051.150000] 7c80: 00000000 00000000 dea2b73d 00088000 00088045 
c02b3f2c dc7b1220 dc7f1774
[ 1051.150000] 7ca0: da007cc4 da007f54 0000013d da007e48 00000000 
0000013d da007cd4 da007cc8
[ 1051.150000] 7cc0: c02b3fb0 c02b3df4 da007d0c da007cd8 c02b9a54 
c02b3f9c c01354f8 00000001
[ 1051.150000] 7ce0: da007cfc 00000000 0000013d 0000013d da007e04 
0000013d da007f54 de935880
[ 1051.150000] 7d00: da007d44 da007d10 c0449d94 c02b99d0 c0048200 
c05ee87c 00000000 0000013d
[ 1051.150000] 7d20: 00000000 dea8af4c da007e04 dea8b130 dea8aec0 
0000013d da007d5c da007d48
[ 1051.150000] 7d40: c04dbfe0 c0449d30 da007e04 de935880 da007dfc 
da007d60 c04dca50 c04dbfbc
[ 1051.150000] 7d60: 000000c3 c004d370 deaf07f0 c004d378 0000001b 
dea8b050 dea8b130 00000000
[ 1051.150000] 7d80: dea8b104 da007da8 00000000 00000001 00000000 
00000000 00000000 dedd2040
[ 1051.150000] 7da0: 40000040 00000800 00000000 00000000 00000000 
00000000 00000000 0000004c
[ 1051.150000] 7dc0: da007e04 da007dd0 c02b8670 c0124700 da007e48 
da007f4c 00000000 40000040
[ 1051.150000] 7de0: dedd2040 da007e88 bede1858 bede18d0 da007e2c 
da007e00 c04dce68 c04dc5e0
[ 1051.150000] 7e00: c043b9d4 c04dbfb0 dedd2040 da007f4c 00000000 
00000800 40000040 00000000
[ 1051.150000] 7e20: da007e3c da007e30 c0439c9c c04dce2c da007f34 
da007e40 c043bab4 c0439c88
[ 1051.150000] 7e40: 00000000 00000000 00087f08 00000800 00000001 
dc7ea940 00000040 00000000
[ 1051.150000] 7e60: 00000000 00000000 00000001 c05eb3c8 da007e8c 
c043af48 c04dbaa0 dedd2040
[ 1051.150000] 7e80: da007eac da007e90 c043af48 c04dbaac 00000000 
da162c4c da007ebc da007ea8
[ 1051.150000] 7ea0: c0048200 c05ee8b0 deb2f81c 60000013 deb2f7c0 
da007ef8 00000000 c05ee7a0
[ 1051.150000] 7ec0: deb2f814 c05ee7ac da007eec da007ed8 c05ee7ac 
c0046994 deb2f814 c0169828
[ 1051.150000] 7ee0: da007f2c da007ef0 c0169828 c05ec9d0 deb2f7c0 
c013ee4c 0000004c da007f48
[ 1051.150000] 7f00: da007f1c da007f10 c013ee4c bede18d0 dedd2040 
40000000 00000129 c00101a4
[ 1051.150000] 7f20: da006000 00000000 da007f94 da007f38 c043cb5c 
c043ba24 00000000 c00101a4
[ 1051.150000] 7f40: da006000 00000000 fffffff7 00000000 00000000 
00000000 00000000 00000800
[ 1051.150000] 7f60: da007e48 00000001 bede1858 0000004c 40000000 
00000000 c007466c 00000011
[ 1051.150000] 7f80: bede18d0 0007d2dc da007fa4 da007f98 c043cba0 
c043cb1c 00000000 da007fa8
[ 1051.150000] 7fa0: c000ffe0 c043cb94 00000011 bede18d0 00000011 
bede18d0 40000000 0000004c
[ 1051.150000] 7fc0: 00000011 bede18d0 0007d2dc 00000129 00000800 
00000044 00000000 bede1928
[ 1051.150000] 7fe0: 00000000 bede1854 000351b3 b6e449a6 40000030 
00000011 3fffd861 3fffdc61
[ 1051.150000] [<c02a64d0>] (memcpy) from [<c02b3f2c>] 
(__copy_to_user_memcpy+0x144/0x1a8)
[ 1051.150000] [<c02b3f2c>] (__copy_to_user_memcpy) from [<c02b3fb0>] 
(arm_copy_to_user+0x20/0x2c)
[ 1051.150000] [<c02b3fb0>] (arm_copy_to_user) from [<c02b9a54>] 
(copy_to_iter+0x90/0x330)
[ 1051.150000] [<c02b9a54>] (copy_to_iter) from [<c0449d94>] 
(skb_copy_datagram_iter+0x70/0x250)
[ 1051.150000] [<c0449d94>] (skb_copy_datagram_iter) from [<c04dbfe0>] 
(unix_stream_read_actor+0x30/0x3c)
[ 1051.150000] [<c04dbfe0>] (unix_stream_read_actor) from [<c04dca50>] 
(unix_stream_read_generic+0x47c/0x7c0)
[ 1051.150000] [<c04dca50>] (unix_stream_read_generic) from [<c04dce68>] 
(unix_stream_recvmsg+0x48/0x50)
[ 1051.150000] [<c04dce68>] (unix_stream_recvmsg) from [<c0439c9c>] 
(sock_recvmsg+0x20/0x24)
[ 1051.150000] [<c0439c9c>] (sock_recvmsg) from [<c043bab4>] 
(___sys_recvmsg+0x9c/0x178)
[ 1051.150000] [<c043bab4>] (___sys_recvmsg) from [<c043cb5c>] 
(__sys_recvmsg+0x4c/0x78)
[ 1051.150000] [<c043cb5c>] (__sys_recvmsg) from [<c043cba0>] 
(SyS_recvmsg+0x18/0x1c)
[ 1051.150000] [<c043cba0>] (SyS_recvmsg) from [<c000ffe0>] 
(ret_fast_syscall+0x0/0x3c)
[ 1051.150000] Code: f5d1f05c f5d1f07c e8b151f8 e2522020 (e8a051f8)
[ 1051.150000] ---[ end trace 8cd5fc6da1af601e ]---
[ 1051.150000] note: dbus-daemon[1177] exited with preempt_count 1
[ 1051.150000] BUG: spinlock lockup suspected on CPU#0, dbus-daemon/1177
[ 1051.150000]  lock: 0xdc7f1774, .magic: dead4ead, .owner: 
dbus-daemon/1177, .owner_cpu: 0
[ 1051.150000] CPU: 0 PID: 1177 Comm: dbus-daemon Tainted: G      D 
W       4.3.0-rc3+ #1
[ 1051.150000] Hardware name: Atmel SAMA5
[ 1051.150000] [<c001601c>] (unwind_backtrace) from [<c0013a2c>] 
(show_stack+0x20/0x24)
[ 1051.150000] [<c0013a2c>] (show_stack) from [<c02a7730>] 
(dump_stack+0x20/0x28)
[ 1051.150000] [<c02a7730>] (dump_stack) from [<c00d7838>] 
(spin_dump+0x88/0x9c)
[ 1051.150000] [<c00d7838>] (spin_dump) from [<c0059054>] 
(do_raw_spin_lock+0x118/0x15c)
[ 1051.150000] [<c0059054>] (do_raw_spin_lock) from [<c05ee87c>] 
(_raw_spin_lock+0x28/0x2c)
[ 1051.150000] [<c05ee87c>] (_raw_spin_lock) from [<c01031c0>] 
(unmap_single_vma+0x174/0x594)
[ 1051.150000] [<c01031c0>] (unmap_single_vma) from [<c0103e84>] 
(unmap_vmas+0x64/0x78)
[ 1051.150000] [<c0103e84>] (unmap_vmas) from [<c010a730>] 
(exit_mmap+0xe8/0x224)
[ 1051.150000] [<c010a730>] (exit_mmap) from [<c0021b0c>] (mmput+0x48/0xdc)
[ 1051.150000] [<c0021b0c>] (mmput) from [<c0026044>] (do_exit+0x25c/0x938)
[ 1051.150000] [<c0026044>] (do_exit) from [<c0013ca4>] (die+0x274/0x2a8)
[ 1051.150000] [<c0013ca4>] (die) from [<c0013d00>] 
(arm_notify_die+0x28/0x60)
[ 1051.150000] [<c0013d00>] (arm_notify_die) from [<c00092e4>] 
(do_DataAbort+0xb4/0xc4)
[ 1051.150000] [<c00092e4>] (do_DataAbort) from [<c05eed60>] 
(__dabt_svc+0x40/0x60)
[ 1051.150000] Exception stack(0xda007c28 to 0xda007c70)
[ 1051.150000] 7c20:                   00088000 dea2b718 ffffffa5 
702c2764 3d687461 726f2f27
[ 1051.150000] 7c40: 72662f67 65646565 6f746b73 dea2b73d 00000051 
da007cc4 42442f70 da007c7c
[ 1051.150000] 7c60: 2c277375 c02a64d0 a0010013 ffffffff
[ 1051.150000] [<c05eed60>] (__dabt_svc) from [<c02a64d0>] 
(memcpy+0x50/0x330)
[ 1051.150000] [<c02a64d0>] (memcpy) from [<c02b3f2c>] 
(__copy_to_user_memcpy+0x144/0x1a8)
[ 1051.150000] [<c02b3f2c>] (__copy_to_user_memcpy) from [<c02b3fb0>] 
(arm_copy_to_user+0x20/0x2c)
[ 1051.150000] [<c02b3fb0>] (arm_copy_to_user) from [<c02b9a54>] 
(copy_to_iter+0x90/0x330)
[ 1051.150000] [<c02b9a54>] (copy_to_iter) from [<c0449d94>] 
(skb_copy_datagram_iter+0x70/0x250)
[ 1051.150000] [<c0449d94>] (skb_copy_datagram_iter) from [<c04dbfe0>] 
(unix_stream_read_actor+0x30/0x3c)
[ 1051.150000] [<c04dbfe0>] (unix_stream_read_actor) from [<c04dca50>] 
(unix_stream_read_generic+0x47c/0x7c0)
[ 1051.150000] [<c04dca50>] (unix_stream_read_generic) from [<c04dce68>] 
(unix_stream_recvmsg+0x48/0x50)
[ 1051.150000] [<c04dce68>] (unix_stream_recvmsg) from [<c0439c9c>] 
(sock_recvmsg+0x20/0x24)
[ 1051.150000] [<c0439c9c>] (sock_recvmsg) from [<c043bab4>] 
(___sys_recvmsg+0x9c/0x178)
[ 1051.150000] [<c043bab4>] (___sys_recvmsg) from [<c043cb5c>] 
(__sys_recvmsg+0x4c/0x78)
[ 1051.150000] [<c043cb5c>] (__sys_recvmsg) from [<c043cba0>] 
(SyS_recvmsg+0x18/0x1c)
[ 1051.150000] [<c043cba0>] (SyS_recvmsg) from [<c000ffe0>] 
(ret_fast_syscall+0x0/0x3c)

Only the trace related to the user space process change between the 
reports. For example:

[ 3247.380000] note: NetworkManager[2148] exited with preempt_count 1
[ 3252.700000] BUG: spinlock lockup suspected on CPU#0, NetworkManager/2148
[ 3252.710000]  lock: 0xdc7f1cb4, .magic: dead4ead, .owner: 
NetworkManager/2148, .owner_cpu: 0
[ 3252.720000] CPU: 0 PID: 2148 Comm: NetworkManager Tainted: G D 
W       4.3.0-rc3+ #1
[ 3252.720000] Hardware name: Atmel SAMA5
[ 3252.730000] [<c001601c>] (unwind_backtrace) from [<c0013a2c>] 
(show_stack+0x20/0x24)
[ 3252.730000] [<c0013a2c>] (show_stack) from [<c02a7730>] 
(dump_stack+0x20/0x28)
[ 3252.740000] [<c02a7730>] (dump_stack) from [<c00d7838>] 
(spin_dump+0x88/0x9c)
[ 3252.750000] [<c00d7838>] (spin_dump) from [<c0059054>] 
(do_raw_spin_lock+0x118/0x15c)
[ 3252.750000] [<c0059054>] (do_raw_spin_lock) from [<c05ee87c>] 
(_raw_spin_lock+0x28/0x2c)
[ 3252.760000] [<c05ee87c>] (_raw_spin_lock) from [<c0100a88>] 
(follow_page_mask+0xb8/0x3a0)
[ 3252.770000] [<c0100a88>] (follow_page_mask) from [<c0100e08>] 
(__get_user_pages+0x98/0x4a0)
[ 3252.770000] [<c0100e08>] (__get_user_pages) from [<c0101570>] 
(get_user_pages_unlocked+0x144/0x1e0)
[ 3252.780000] [<c0101570>] (get_user_pages_unlocked) from [<c00f4464>] 
(get_user_pages_fast+0x50/0x58)
[ 3252.790000] [<c00f4464>] (get_user_pages_fast) from [<c0081cfc>] 
(get_futex_key+0x80/0x240)
[ 3252.800000] [<c0081cfc>] (get_futex_key) from [<c0082bdc>] 
(futex_wake+0x50/0x148)
[ 3252.800000] [<c0082bdc>] (futex_wake) from [<c008447c>] 
(do_futex+0x100/0xba8)
[ 3252.810000] [<c008447c>] (do_futex) from [<c0084fc4>] 
(SyS_futex+0xa0/0x19c)
[ 3252.810000] [<c0084fc4>] (SyS_futex) from [<c0021d34>] 
(mm_release+0xf4/0x124)
[ 3252.820000] [<c0021d34>] (mm_release) from [<c0025f08>] 
(do_exit+0x120/0x938)
[ 3252.830000] [<c0025f08>] (do_exit) from [<c0013ca4>] (die+0x274/0x2a8)
[ 3252.830000] [<c0013ca4>] (die) from [<c0013d00>] 
(arm_notify_die+0x28/0x60)
[ 3252.840000] [<c0013d00>] (arm_notify_die) from [<c00092e4>] 
(do_DataAbort+0xb4/0xc4)
[ 3252.840000] [<c00092e4>] (do_DataAbort) from [<c05eed60>] 
(__dabt_svc+0x40/0x60)

The kernel trace and exception stack are always the same.

I am completely lost, as the panic don't seem to be related to anything 
specific to this embedded system. I would greatly appreciate any hint 
about where to look.

Best Regards,
Jean-Christian de Rivaz
