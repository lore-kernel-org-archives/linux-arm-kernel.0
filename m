From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 20 Jul 2015 21:37:26 +0200
Subject: [PATCH 1/3] clocksource: atmel-st: Remove irq handler when clock
 event is unused
In-Reply-To: <alpine.DEB.2.11.1507201103550.18576@nanos>
References: <1437161608-26782-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1437161608-26782-2-git-send-email-alexandre.belloni@free-electrons.com>
 <alpine.DEB.2.11.1507180942360.18576@nanos>
 <20150718222308.GA30489@piout.net>
 <alpine.DEB.2.11.1507201103550.18576@nanos>
Message-ID: <20150720193726.GJ15539@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/07/2015 at 11:04:30 +0200, Thomas Gleixner wrote :
> That's why I used setup/remove_irq() in the stale RT changes.
> 

Hum, actually, you hit the same thing with setup/remove_irq (and I'm not sure
to follow why):

BUG: sleeping function called from invalid context at mm/slab.c:2863
in_atomic(): 1, irqs_disabled(): 128, pid: 596, name: sh
CPU: 0 PID: 596 Comm: sh Tainted: G        W       4.1.0-rc4+ #122
Hardware name: Atmel AT91RM9200
[<c000ebd4>] (unwind_backtrace) from [<c000ca64>] (show_stack+0x10/0x14)
[<c000ca64>] (show_stack) from [<c008a0c8>] (__kmalloc+0x38/0x104)
[<c008a0c8>] (__kmalloc) from [<c00d8770>] (__proc_create+0x11c/0x194)
[<c00d8770>] (__proc_create) from [<c00d8b44>] (proc_mkdir_data+0x30/0x9c)
[<c00d8b44>] (proc_mkdir_data) from [<c0042a00>] (register_handler_proc+0xfc/0x10c)
[<c0042a00>] (register_handler_proc) from [<c003f0b0>] (__setup_irq+0x438/0x518)
[<c003f0b0>] (__setup_irq) from [<c003f1e8>] (setup_irq+0x58/0x84)
[<c003f1e8>] (setup_irq) from [<c02de298>] (atmel_st_request_irq+0x4c/0x84)
[<c02de298>] (atmel_st_request_irq) from [<c02de338>] (clkevt32k_set_periodic+0x14/0x54)
[<c02de338>] (clkevt32k_set_periodic) from [<c00509a0>] (clockevents_switch_state+0x1c/0x58)
[<c00509a0>] (clockevents_switch_state) from [<c0050584>] (__clockevents_unbind+0xb8/0xfc)
[<c0050584>] (__clockevents_unbind) from [<c0054954>] (smp_call_function_single+0x34/0x44)
[<c0054954>] (smp_call_function_single) from [<c00506b0>] (sysfs_unbind_tick_dev+0xe8/0x114)
[<c00506b0>] (sysfs_unbind_tick_dev) from [<c00e1748>] (kernfs_fop_write+0x118/0x174)
[<c00e1748>] (kernfs_fop_write) from [<c008df00>] (__vfs_write+0x24/0xdc)
[<c008df00>] (__vfs_write) from [<c008e5f8>] (vfs_write+0xa4/0x128)
[<c008e5f8>] (vfs_write) from [<c008ecf4>] (SyS_write+0x40/0x78)
[<c008ecf4>] (SyS_write) from [<c000a240>] (ret_fast_syscall+0x0/0x30)


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
