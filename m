From: john.tobias.ph@gmail.com (John Tobias)
Date: Wed, 8 Jan 2014 14:19:15 -0800
Subject: *** DEADLOCK ***
Message-ID: <CACUGKYP1gcmYbOX8S9PaQV0jePeryiU-e5QwyS72FkDb7m-V3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong,

I used your patches to fix hardirq-unsafe and didn't see the said
messages anymore when I repeatedly booting my board.

But, I saw another DEADLOCK  (see below) if I enable my wifi.

Regards,

john


[   24.554647] =================================
[   24.559021] [ INFO: inconsistent lock state ]
[   24.563401] 3.13.0-rc1 #47 Tainted: G           O
[   24.568122] ---------------------------------
[   24.572497] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
[   24.578528] kworker/u2:1/13 [HC0[0]:SC0[0]:HE1:SE1] takes:
[   24.584029]  (&(&host->lock)->rlock){?.-...}, at: [<8032d8d4>]
sdhci_execute_tuning+0x48/0x70c
[   24.592776] {IN-HARDIRQ-W} state was registered at:
[   24.597669]   [<8004d940>] mark_lock+0x1b0/0x784
[   24.602339]   [<8004f080>] __lock_acquire+0xb74/0x1cd0
[   24.607518]   [<800509ac>] lock_acquire+0x70/0x84
[   24.612262]   [<8050d928>] _raw_spin_lock+0x38/0x48
[   24.617188]   [<8032e754>] sdhci_irq+0x20/0xbe0
[   24.621761]   [<8005963c>] handle_irq_event_percpu+0x3c/0x1a0
[   24.627549]   [<800597e4>] handle_irq_event+0x44/0x64
[   24.632638]   [<8005c214>] handle_fasteoi_irq+0x84/0x14c
[   24.637993]   [<80058e24>] generic_handle_irq+0x34/0x44
[   24.643258]   [<8000f8a8>] handle_IRQ+0x40/0x8c
[   24.647835]   [<80008578>] gic_handle_irq+0x34/0x5c
[   24.652752]   [<80013204>] __irq_svc+0x44/0x58
[   24.657242]   [<80251534>] pin_get_from_name+0x58/0x80
[   24.662429]   [<802536e0>] pinconf_map_to_setting+0x70/0xb0
[   24.668050]   [<80250cb8>] pinctrl_get+0x238/0x46c
[   24.672880]   [<80250f20>] devm_pinctrl_get+0x34/0x70
[   24.677972]   [<802a6610>] pinctrl_bind_pins+0x34/0x200
[   24.683245]   [<802913d8>] driver_probe_device+0x88/0x390
[   24.688691]   [<802917c8>] __driver_attach+0x9c/0xa0
[   24.693695]   [<8028f604>] bus_for_each_dev+0x68/0x9c
[   24.698789]   [<80290e58>] driver_attach+0x24/0x28
[   24.703621]   [<80290a58>] bus_add_driver+0x164/0x220
[   24.708712]   [<80291e54>] driver_register+0x80/0x100
[   24.713802]   [<802930dc>] __platform_driver_register+0x5c/0x64
[   24.719767]   [<806bba98>] sdhci_esdhc_imx_driver_init+0x18/0x20
[   24.725817]   [<80008818>] do_one_initcall+0xe4/0x190
[   24.730907]   [<806a1c38>] kernel_init_freeable+0x12c/0x1cc
[   24.736530]   [<80502dc0>] kernel_init+0x10/0x128
[   24.741283]   [<8000f068>] ret_from_fork+0x14/0x2c
[   24.746122] irq event stamp: 45121
[   24.749539] hardirqs last  enabled at (45121): [<8050dbb8>]
_raw_spin_unlock_irqrestore+0x38/0x4c
[   24.758457] hardirqs last disabled at (45120): [<8050da34>]
_raw_spin_lock_irqsave+0x24/0x5c
[   24.766939] softirqs last  enabled at (45112): [<80025264>]
__do_softirq+0x1c8/0x278
[   24.774723] softirqs last disabled at (45101): [<80025700>]
irq_exit+0xc0/0x108
[   24.782072]
[   24.782072] other info that might help us debug this:
[   24.788620]  Possible unsafe locking scenario:
[   24.788620]
[   24.794556]        CPU0
[   24.797016]        ----
[   24.799474]   lock(&(&host->lock)->rlock);
[   24.803624]   <Interrupt>
[   24.806255]     lock(&(&host->lock)->rlock);
[   24.810576]
[   24.810576]  *** DEADLOCK ***
[   24.810576]
[   24.816521] 2 locks held by kworker/u2:1/13:
[   24.820803]  #0:  (kmmcd){.+.+.+}, at: [<80036adc>]
process_one_work+0x124/0x44c
[   24.828333]  #1:  ((&(&host->detect)->work)){+.+.+.}, at:
[<80036adc>] process_one_work+0x124/0x44c
[   24.837503]
[   24.837503] stack backtrace:
[   24.841889] CPU: 0 PID: 13 Comm: kworker/u2:1 Tainted: G
O 3.13.0-rc1 #47
[   24.849578] Workqueue: kmmcd mmc_rescan
[   24.853448] Backtrace:
[   24.855958] [<80012444>] (dump_backtrace+0x0/0x110) from
[<80012714>] (show_stack+0x18/0x1c)
[   24.864412]  r6:00000000 r5:807c4b24 r4:bf867200 r3:bf867200
[   24.870192] [<800126fc>] (show_stack+0x0/0x1c) from [<80507598>]
(dump_stack+0x24/0x28)
[   24.878235] [<80507574>] (dump_stack+0x0/0x28) from [<80505744>]
(print_usage_bug.part.34+0x2b0/0x2bc)
[   24.887578] [<80505494>] (print_usage_bug.part.34+0x0/0x2bc) from
[<8004d9d4>] (mark_lock+0x244/0x784)
[   24.896900]  r8:807c4b24 r7:806e1908 r6:bf867200 r5:bf867670 r4:00000002
[   24.903739] [<8004d790>] (mark_lock+0x0/0x784) from [<8004eb0c>]
(__lock_acquire+0x600/0x1cd0)
[   24.912383] [<8004e50c>] (__lock_acquire+0x0/0x1cd0) from
[<800509ac>] (lock_acquire+0x70/0x84)
[   24.921113] [<8005093c>] (lock_acquire+0x0/0x84) from [<8050d928>]
(_raw_spin_lock+0x38/0x48)
[   24.929652]  r7:00000004 r6:00000005 r5:bfbec000 r4:bf9e6c70
[   24.935439] [<8050d8f0>] (_raw_spin_lock+0x0/0x48) from
[<8032d8d4>] (sdhci_execute_tuning+0x48/0x70c)
[   24.944761]  r4:bf9e6800
[   24.947349] [<8032d88c>] (sdhci_execute_tuning+0x0/0x70c) from
[<80322f50>] (mmc_sdio_init_card+0xa3c/0xadc)
[   24.957207] [<80322514>] (mmc_sdio_init_card+0x0/0xadc) from
[<80323310>] (mmc_attach_sdio+0x80/0x368)
[   24.966549] [<80323290>] (mmc_attach_sdio+0x0/0x368) from
[<8031b968>] (mmc_rescan+0x26c/0x2f0)
[   24.975283] [<8031b6fc>] (mmc_rescan+0x0/0x2f0) from [<80036b58>]
(process_one_work+0x1a0/0x44c)
[   24.984082]  r8:00000000 r7:bf94fea8 r6:bf84e800 r5:bf9e6af8 r4:bf914d80
r3:8031b6fc
[   24.992078] [<800369b8>] (process_one_work+0x0/0x44c) from
[<80037a9c>] (worker_thread+0x124/0x3f8)
[   25.001161] [<80037978>] (worker_thread+0x0/0x3f8) from
[<8003d6cc>] (kthread+0xdc/0xf0)
[   25.009284] [<8003d5f0>] (kthread+0x0/0xf0) from [<8000f068>]
(ret_from_fork+0x14/0x2c)
[   25.017302]  r7:00000000 r6:00000000 r5:8003d5f0 r4:bf92dd00
[   25.065548] mmc1: new ultra high speed SDR50 SDIO card at address 0001
[   25.085698] vendor=0x02DF device=0x9129 class=0 function=1
