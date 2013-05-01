From: athorlton@sgi.com (Alex Thorlton)
Date: Wed, 1 May 2013 17:05:10 -0500
Subject: Kernel panic on boot in tick_do_broadcast
Message-ID: <51819196.50804@sgi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

Robin Holt and I have been hitting a kernel panic on boot and have 
narrowed the problem down to commit ID 
26517f3e99248668315aee9460dcea21628cdd7f.  The stack trace trace is 
attached.  We were hoping you might be able to point us towards some 
possible causes of the issue.

Thanks for your time!

Alex
-------------- next part --------------
[    2.451373] smpboot: Booting Node   0, Processors  #1 #2 #3 #4 #5 #6 #7 OK
[    2.555983] smpboot: Booting Node   1, Processors  #8 #9 #10 #11 #12 #13
[    2.724264] BUG: unable to handle kernel NULL pointer dereference at 0000000000000048
[    2.733234] IP: [<ffffffff810ac0c3>] tick_do_broadcast+0x63/0xa0
[    2.739957] PGD 0
[    2.742209] Oops: 0000 [#1] SMP
[    2.745833] Modules linked in:
[    2.749248] CPU 0
[    2.751300] Pid: 1, comm: swapper/0 Not tainted 3.9.0-rc2.el7-medusa-00005-gf7dce82 #19 SGI UV2000/ROMLEY
[    2.762188] RIP: 0010:[<ffffffff810ac0c3>]  [<ffffffff810ac0c3>] tick_do_broadcast+0x63/0xa0
[    2.771623] RSP: 0000:ffff880fc1c03d10  EFLAGS: 00010002
[    2.777552] RAX: 0000000000000000 RBX: 000000000000d940 RCX: ffff880fc1826000
[    2.785518] RDX: 000000000000000d RSI: 0000000000000100 RDI: ffff880fc1826000
[    2.793485] RBP: ffff880fc1c03d20 R08: 0000000000000004 R09: 0000000000002000
[    2.801452] R10: 0000000000000001 R11: 00000000000003fd R12: ffff880fc1826000
[    2.809418] R13: 0000000000000000 R14: ffff880fbb51dd28 R15: 0000000000000000
[    2.817386] FS:  0000000000000000(0000) GS:ffff880fc1c00000(0000) knlGS:0000000000000000
[    2.826420] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.832833] CR2: 0000000000000048 CR3: 0000000001b01000 CR4: 00000000000407f0
[    2.840800] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    2.848767] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[    2.856734] Process swapper/0 (pid: 1, threadinfo ffff880fbb51c000, task ffff880fbb520000)
[    2.865960] Stack:
[    2.868202]  ffff880fc1818000 ffffffff81b12300 ffff880fc1c03d30 ffffffff810ac271
[    2.876502]  ffff880fc1c03d50 ffffffff810ac294 ffff880fc1818000 ffffffff81b08a40
[    2.884804]  ffff880fc1c03d60 ffffffff81004d65 ffff880fc1c03db0 ffffffff810e58a4
[    2.893105] Call Trace:
[    2.895833]  <IRQ>
[    2.897979]  [<ffffffff810ac271>] tick_do_periodic_broadcast+0x41/0x50
[    2.905486]  [<ffffffff810ac294>] tick_handle_periodic_broadcast+0x14/0x50
[    2.913164]  [<ffffffff81004d65>] timer_interrupt+0x15/0x20
[    2.919387]  [<ffffffff810e58a4>] handle_irq_event_percpu+0x84/0x1e0
[    2.926481]  [<ffffffff810e5a42>] handle_irq_event+0x42/0x70
[    2.932798]  [<ffffffff810e9225>] handle_edge_irq+0x65/0x130
[    2.939115]  [<ffffffff8100455e>] handle_irq+0x5e/0x150
[    2.944950]  [<ffffffff81059c23>] ? irq_enter+0x53/0x90
[    2.950785]  [<ffffffff8179f6c0>] do_IRQ+0x60/0xe0
[    2.956137]  [<ffffffff817959aa>] common_interrupt+0x6a/0x6a
[    2.962454]  [<ffffffff81059d00>] ? __do_softirq+0xa0/0x240
[    2.968675]  [<ffffffff81059cb1>] ? __do_softirq+0x51/0x240
[    2.974895]  [<ffffffff81059fb5>] irq_exit+0xc5/0xd0
[    2.980438]  [<ffffffff8179f7ae>] smp_apic_timer_interrupt+0x6e/0x99
[    2.987532]  [<ffffffff8179ea3a>] apic_timer_interrupt+0x6a/0x70
[    2.994238]  <EOI>
[    2.996383]  [<ffffffff8178d38d>] ? native_cpu_up+0x115/0x1ae
[    3.003009]  [<ffffffff8178f29d>] _cpu_up+0x120/0x161
[    3.008650]  [<ffffffff8178f345>] cpu_up+0x67/0x6b
[    3.014000]  [<ffffffff81c4f4d0>] smp_init+0x68/0x97
[    3.019545]  [<ffffffff81c31a55>] kernel_init_freeable+0x203/0x291
[    3.026438]  [<ffffffff81784280>] ? rest_init+0x80/0x80
[    3.032271]  [<ffffffff8178428e>] kernel_init+0xe/0x180
[    3.038104]  [<ffffffff8179dd5c>] ret_from_fork+0x7c/0xb0
[    3.044131]  [<ffffffff81784280>] ? rest_init+0x80/0x80
[    3.049963] Code: 85 c0 75 2a 48 63 35 05 5a b6 00 4c 89 e7 48 c7 c3 40 d9 00 00 e8 4e 14 35 00 89 c0 4c 89 e7 48 8b 04 c5 20 5d c0 81 48 8b 04 18 <ff> 50 48 48 8b 1c 24 4c 8b 64 24 08 c9 c3 0f 1f 80 00 00 00 00
[    3.071674] RIP  [<ffffffff810ac0c3>] tick_do_broadcast+0x63/0xa0
[    3.078489]  RSP <ffff880fc1c03d10>
[    3.082381] CR2: 0000000000000048
[    3.086085] ---[ end trace 30d634de49f3b984 ]---
[    3.091238] Kernel panic - not syncing: Fatal exception in interrupt
[    4.135664] Shutting down cpus with NMI
