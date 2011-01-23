From: saeed.bishara@gmail.com (saeed bishara)
Date: Sun, 23 Jan 2011 16:38:01 +0200
Subject: HIGHMEM is broken when working in SMP V6 mode
Message-ID: <AANLkTikjcgRgPd7oLjf0ESxeyC2BHpaaRi8DiMz3b+JQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
I've port 2.6.35 to SMP system that runs in V6 mode, this system
doesn't support TLB operations broadcasting by hw, so it uses IPI
messages for that.  when enabling DEBUG_LOCKDEP, I got the following
error message while booting the system from NFS:


[   24.460000] =================================
[   24.460000] [ INFO: inconsistent lock state ]
[   24.460000] 2.6.35.9 #102
[   24.460000] ---------------------------------
[   24.460000] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
[   24.460000] rc/1370 [HC0[0]:SC0[0]:HE1:SE1] takes:
[   24.460000]  (kmap_lock){+.?...}, at: [<800ffb64>] kmap_high+0x24/0x1ec
[   24.460000] {IN-SOFTIRQ-W} state was registered at:
[   24.460000]   [<800b1f60>] mark_lock+0x26c/0x65c
[   24.460000]   [<800b5614>] __lock_acquire+0x6e4/0xa20
[   24.460000]   [<800b5a40>] lock_acquire+0xf0/0x110
[   24.460000]   [<804bc97c>] _raw_spin_lock_irqsave+0x50/0x64
[   24.460000]   [<800fffec>] kmap_high_get+0x20/0x88
[   24.460000]   [<8003fc40>] __flush_dcache_page+0x4c/0x120
[   24.460000]   [<8003ff64>] flush_dcache_page+0x68/0x88
[   24.460000]   [<8049a710>] xdr_partial_copy_from_skb+0x168/0x1dc
[   24.460000]   [<8049a7f4>] csum_partial_copy_to_xdr+0x70/0x154
[   24.460000]   [<8049d200>] xs_udp_data_ready+0x114/0x234
[   24.460000]   [<80418a44>] sock_queue_rcv_skb+0x200/0x23c
[   24.460000]   [<8044da24>] ip_queue_rcv_skb+0x5c/0x64
[   24.460000]   [<8046b340>] __udp_queue_rcv_skb+0xf4/0x1f0
[   24.460000]   [<8046cd48>] udp_queue_rcv_skb+0x240/0x3e0
[   24.460000]   [<8046d69c>] __udp4_lib_rcv+0x680/0x96c
[   24.460000]   [<8046d9a8>] udp_rcv+0x20/0x28
[   24.460000]   [<80446e8c>] ip_local_deliver+0x1c8/0x354
[   24.460000]   [<80447764>] ip_rcv+0x74c/0x7b8
[   24.460000]   [<80424868>] __netif_receive_skb+0x2a4/0x2f8
[   24.460000]   [<80425558>] netif_receive_skb+0xec/0x114
[   24.460000]   [<80425644>] napi_skb_finish+0x40/0x58
[   24.460000]   [<80425b98>] napi_gro_receive+0x38/0x3c
[   24.460000]   [<8038ecec>] e1000_receive_skb+0x50/0x54
[   24.460000]   [<80393a7c>] e1000_clean_rx_irq+0x20c/0x2d0
[   24.460000]   [<803924bc>] e1000_clean+0x80/0x208
[   24.460000]   [<804288ec>] net_rx_action+0x90/0x1f4
[   24.460000]   [<8008b238>] __do_softirq+0x110/0x20c
[   24.460000]   [<8008b830>] irq_exit+0x60/0x68
[   24.460000]   [<80034094>] asm_do_IRQ+0x94/0xc8
[   24.460000]   [<804bd458>] __irq_svc+0x38/0x120
[   24.460000]   [<804b0af4>] rest_init+0xc0/0xf4
[   24.460000]   [<80008e34>] start_kernel+0x27c/0x2dc
[   24.460000]   [<00008080>] 0x8080
[   24.460000] irq event stamp: 605
[   24.460000] hardirqs last  enabled at (604): [<804bd05c>]
_raw_spin_unlock_irqrestore+0x4c/0x54
[   24.460000] hardirqs last disabled at (605): [<804bc8f4>]
_raw_spin_lock_irq+0x28/0x60
[   24.460000] softirqs last  enabled at (547): [<8049f438>]
rpc_wake_up_next+0x1ac/0x1c0
[   24.460000] softirqs last disabled at (545): [<804bcac0>]
_raw_spin_lock_bh+0x24/0x5c
[   24.460000]
[   24.460000] other info that might help us debug this:
[   24.460000] 2 locks held by rc/1370:
[   24.460000]  #0:  (&p->cred_guard_mutex){+.+.+.}, at: [<8011f988>]
prepare_bprm_creds+0x34/0x68
[   24.460000]  #1:  (kmap_lock){+.?...}, at: [<800ffb64>] kmap_high+0x24/0x1ec
[   24.460000]
[   24.460000] stack backtrace:
[   24.460000] Backtrace:
[   24.460000] [<80038d68>] (dump_backtrace+0x0/0x114) from
[<80038ec0>] (dump_stack+0x20/0x24)
[   24.460000]  r6:c01c5460 r5:805b104c r4:00000001
[   24.460000] [<80038ea0>] (dump_stack+0x0/0x24) from [<800b1cb0>]
(print_usage_bug+0x170/0x1b4)
[   24.460000] [<800b1b40>] (print_usage_bug+0x0/0x1b4) from
[<800b2024>] (mark_lock+0x330/0x65c)
[   24.460000] [<800b1cf4>] (mark_lock+0x0/0x65c) from [<800b23b4>]
(mark_held_locks+0x64/0x8c)
[   24.460000] [<800b2350>] (mark_held_locks+0x0/0x8c) from
[<800b253c>] (trace_hardirqs_on_caller+0x160/0x21c)
[   24.460000]  r8:80baa4b8 r7:80baa4e4 r6:00000000 r5:8008ac24 r4:c01c5460
[   24.460000] [<800b23dc>] (trace_hardirqs_on_caller+0x0/0x21c) from
[<800b260c>] (trace_hardirqs_on+0x14/0x18)
[   24.460000]  r5:c15a1e2c r4:8003a41c
[   24.460000] [<800b25f8>] (trace_hardirqs_on+0x0/0x18) from
[<8008ac24>] (on_each_cpu+0x3c/0x48)
[   24.460000] [<8008abe8>] (on_each_cpu+0x0/0x48) from [<8003a408>]
(flush_tlb_kernel_range+0x4c/0x60)
[   24.460000]  r6:00000000 r5:00000800 r4:81c445cc
[   24.460000] [<8003a3bc>] (flush_tlb_kernel_range+0x0/0x60) from
[<800ffb28>] (flush_all_zero_pkmaps+0xb8/0xd0)
[   24.460000] [<800ffa70>] (flush_all_zero_pkmaps+0x0/0xd0) from
[<800ffbbc>] (kmap_high+0x7c/0x1ec)
[   24.460000] [<800ffb40>] (kmap_high+0x0/0x1ec) from [<80041ce4>]
(kmap+0x58/0x70)
[   24.460000] [<80041c8c>] (kmap+0x0/0x70) from [<8011f218>]
(copy_strings+0x1a4/0x330)
[   24.460000]  r4:c11c1000
[   24.460000] [<8011f074>] (copy_strings+0x0/0x330) from [<8011f3f0>]
(copy_strings_kernel+0x4c/0x84)
[   24.460000] [<8011f3a4>] (copy_strings_kernel+0x0/0x84) from
[<80120c2c>] (do_execve+0x17c/0x2d4)
[   24.460000]  r4:00000080
[   24.460000] [<80120ab0>] (do_execve+0x0/0x2d4) from [<80038700>]
(sys_execve+0x44/0x64)
[   24.460000] [<800386bc>] (sys_execve+0x0/0x64) from [<80034ca0>]
(ret_fast_syscall+0x0/0x3c)
[   24.460000]  r7:0000000b r6:00032580 r5:000325fc r4:00000002
