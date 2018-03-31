From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 31 Mar 2018 13:49:23 +0200 (CEST)
Subject: btbcm: possible circular locking dependency linux-next-20180327
Message-ID: <1287361811.42067.1522496963924@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

i build linux-next-20180327 with bcm2835_defconfig, but additionally enabled the following settings:

CONFIG_SMP=y
CONFIG_PREEMPT=y
CONFIG_PROVE_LOCKING=y

If i boot my RPi Zero W, then i will get the following output during hci_uart probe:

[   42.245521] ======================================================
[   42.265953] WARNING: possible circular locking dependency detected
[   42.286527] 4.16.0-rc7-next-20180327+ #2 Tainted: G         C
[   42.307153] ------------------------------------------------------
[   42.327529] kworker/u2:1/31 is trying to acquire lock:
[   42.346819]  (bcm_device_lock){+.+.}, at: [<bf07b028>] bcm_recv+0xa4/0x10c [hci_uart]
[   42.369028]
               but task is already holding lock:
[   42.402020]  (&buf->lock){+.+.}, at: [<c04ad460>] flush_to_ldisc+0x2c/0xc0
[   42.422713]
               which lock already depends on the new lock.

[   42.471181]
               the existing dependency chain (in reverse order) is:
[   42.505116]
               -> #3 (&buf->lock){+.+.}:
[   42.536142]        __763608]        __ldsem_down_write_nested+0x4c/0x280
[   42.780869]        ldsem_down_write+0x3c/0x48
[   42.797163]        tty_ldisc_lock+0x20/0x44
[   42.813230]        tty_init_dev+0xd8/0x1b0
[   42.829130]        tty_open+0x30c/0x32c
[   42.844633]        chrdev_open+0x154/0x170
[   42.860303]        do_dentry_open.constprop.4+0x2a8/0x320
[   42.877260]        vfs_open+0x78/0x7c
[   42.892198]        path_openat+0xc14/0xde0
[   42.907367]        do_filp_open+0x40/0x8c
[   42.922270]        do_sys_open+0x114/0x1c4
[   42.937142]        kernel_init_freeable+0x12c/0x1e0
[   42.952797]        kernel_init+0x18/0x120
[   42.967461]        ret_from_fork+0x14/0x20
[   42.982195]          (null)
[   42.995444]
               -> #1 (&tty->legacy_mutex){+.+.}:
[   43.022015]        __mutex_lock+0x70/0x9b4
[   43.036665]        mutex_lock_nested+0x2c/0x34
[   43.051661]        tty_lock+0x5c/0x6c
[   43.065808]        tty_init_dev+0x4c/0x1b0
[   43.080298]        ttyport_open+0x34/0x14c
[   43.094701]        serdev_device_open+0x34/0x40
[   43.109685]        bcm_open+0x9c/0x190 [hci_uart]
[   43.124862]        hci_uart_register_device+0x48/0x228 [hci_uart]
[   43.141536]        bcm_serdev_probe+0xac/0xcc [hci_uart]
[   43.157381]        serdev_drv_probe+0x20/0x24
[   43.172165]        driver_probe_device+0x2d4/0x46c
[   43.187363]        __driver_attach+0x98/0x108
[   43.202081]        bus_for_each_dev+0x68/0x8c
[   43.216802]        driver_attach+0x28/0x30
[   43.231232]        driver_attach_async+0x20/0x58
[   43.246142]        async_run_entry_fn+0x98/0x1a0
[   43.261105]        process_one_work+0x3c8/0x76c
[   43.276054]        worker_thread+0x2b0/0x43c
[   43.290632]        kthread+0x158/0x174
[   43.304530]        ret_from_fork+0x14/0x20
[   43.318693]          (null)
[   43.331378]
               -> #0 (bcm_device_lock){+.+.}:
[   43.356310]        lock_acquire+0x228/0x298
[   43.370173]        __mutex_lock+0x70/0x9b4
[   43.383785]        mutex_lock_nested+0x2c/0x34
[   43.397711]        bcm_recv+0xa4/0x10c [hci_uart]
[   43.411957]        hci_uart_receive_buf+0x68/0x84 [hci_uart]
[   43.427034]        ttyport_receive_buf+0x6c/0xe4
[   43.440958]        flush_to_ldisc+0xa0/0xc0
[   43.454321]        process_one_work+0x3c8/0x76c
[   43.468099]        worker_thread+0x2b0/0x43c
[   43.481666]        kthread+0x158/0x174
[   43.494633]        ret_from_fork+0x14/0x20
[   43.507831]          (null)
[   43.519665]
               other info that might help us debug this:

[   43.554302] Chain exists of:
                 bcm_device_lock --> &tty->ldisc_sem --> &buf->lock

[   43.591776]  Possible unsafe locking scenario:

[   43.615986]        CPU0                    CPU1
[   43.629708]        ----                    ----
[   43.643463]   lock(&buf->lock);
[   43.655748]                                lock(&tty->ldisc_sem);
[   43.671197]                                lock(&buf->lock);
[   43.686220]   lock(bcm_device_lock);
[   43.699078]
                *** DEADLOCK ***

[   43.731942] 3 locks held by kworker/u2:1/31:
[   43.745364]  #0:  ((wq_completion)"events_unbound"){+.+.}, at: [<c013fb3c>] process_one_work+0x1e0/0x76c
[   43.764636]  #1:  ((work_completion)(&buf->work)){+.+.}, at: [<c013fb3c>] process_one_work+0x1e0/0x76c
[   43.783902]  #2:  (&buf->lock){+.+.}, at: [<c04ad460>] flush_to_ldisc+0x2c/0xc0
[   43.801205]
               stack backtrace:
[   43.824860] CPU: 0 PID: 31 Comm: kworker/u2:1 Tainted: G         C        4.16.0-rc7-next-20180327+ #2
[   43.844393] Hardware name: BCM2835
[   43.857885] Workqueue: events_unbound flush_to_ldisc
[   43.873103] [<c01118f4>] (unwind_backtrace) from [<c010da50>] (show_stack+0x20/0x24)
[   43.891391] [<c010da50>] (show_stack) from [<c08f3590>] (dump_stack+0xa4/0xe0)
[   43.909283] [<c08f3590>] (dump_stack) from [<c017d4e0>] (print_circular_bug.constprop.20+0x1dc/0x2d8)
[   43.929391] [<c017d4e0>] (print_circular_bug.constprop.20) from [<c017fd30>] (__lock_acquire+0xf00/0x172c)
[   43.950197] [<c017fd30>] (__lock_acquire) from [<c0180ff8>] (lock_acquire+0x228/0x298)
[   43.969314] [<c0180ff8>] (lock_acquire) from [<c0909a40>] (__mutex_lock+0x70/0x9b4)
[   43.988308] [<c0909a40>] (__mutex_lock) from [<c090a3b0>] (mutex_lock_nested+0x2c/0x34)
[   44.007837] [<c090a3b0>] (mutex_lock_nested) from [<bf07b028>] (bcm_recv+0xa4/0x10c [hci_uart])
[   44.028328] [<bf07b028>] (bcm_recv [hci_uart]) from [<bf079bf8>] (hci_uart_receive_buf+0x68/0x84 [hci_uart])
[   44.050162] [<bf079bf8>] (hci_uart_receive_buf [hci_uart]) from [<c04cf928>] (ttyport_receive_buf+0x6c/0xe4)
[   44.072188] [<c04cf928>] (ttyport_receive_buf) from [<c04ad4d4>] (flush_to_ldisc+0xa0/0xc0)
[   44.092841] [<c04ad4d4>] (flush_to_ldisc) from [<c013fd24>] (process_one_work+0x3c8/0x76c)
[   44.113440] [<c013fd24>] (process_one_work) from [<c01414d0>] (worker_thread+0x2b0/0x43c)
[   44.134095] [<c01414d0>] (worker_thread) from [<c0146fa4>] (kthread+0x158/0x174)
[   44.153985] [<c0146fa4>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
[   44.173718] Exception stack(0xd8fcdfb0 to 0xd8fcdff8)
[   44.191211] dfa0:                                     00000000 00000000 00000000 00000000
[   44.212185] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   44.233216] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
