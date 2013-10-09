From: Jiada_Wang@mentor.com (Wang, Jiada (ESD))
Date: Wed, 9 Oct 2013 06:10:29 +0000
Subject: BUG: imx6: scheduling-while-atomic bug detected with commit: 8ba9580
Message-ID: <857E9EDCA6C0904DB3357321AA9123EB625007EA@NA-MBX-01.mgc.mentorg.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn and Lucas

  The following scheduling-while-atomic bug was detected in our kernel as well as v3.11.0-rc5 vanilla

[    3.421817] BUG: scheduling while atomic: kworker/u:0/6/0x00000002
[    3.421825] 4 locks held by kworker/u:0/6:
[    3.421857]  #0:  (events_unbound){.+.+.+}, at: [<80042028>] process_one_work+0x20c/0x668
[    3.421878]  #1:  ((&entry->work)){+.+.+.}, at: [<80042028>] process_one_work+0x20c/0x668
[    3.421901]  #2:  (&(&host->lock)->rlock){......}, at: [<802fe084>] sdhci_do_set_ios+0x24/0x6a8
[    3.421923]  #3:  (prepare_lock){+.+...}, at: [<803116f8>] clk_get_rate+0x1c/0x5c
[    3.421932] Modules linked in:
[    3.421936] irq event stamp: 640
[    3.421948] hardirqs last  enabled at (639): [<800412a4>] __cancel_work_timer+0x94/0xd0
[    3.421964] hardirqs last disabled at (640): [<8041579c>] _raw_spin_lock_irqsave+0x24/0x60
[    3.421980] softirqs last  enabled at (378): [<8002abc0>] __do_softirq+0x368/0x3f8
[    3.421992] softirqs last disabled at (373): [<8002b00c>] irq_exit+0x5c/0xb0
[    3.421998] Backtrace: 
[    3.422025] [<80011aa0>] (dump_backtrace+0x0/0x10c) from [<8040dbd4>] (dump_stack+0x18/0x1c)
[    3.422044]  r6:b40bfbf8 r5:81392b80 r4:b40a2e40 r3:b40a2e40
[    3.422058] [<8040dbbc>] (dump_stack+0x0/0x1c) from [<8040e49c>] (__schedule_bug+0x64/0x78)
[    3.422072] [<8040e438>] (__schedule_bug+0x0/0x78) from [<8041424c>] (__schedule+0x68/0x7f8)
[    3.422083]  r4:b40a2e40 r3:00000002
[    3.422094] [<804141e4>] (__schedule+0x0/0x7f8) from [<80414b6c>] (schedule+0x84/0x88)
[    3.422106] [<80414ae8>] (schedule+0x0/0x88) from [<80414e38>] (schedule_preempt_disabled+0x18/0x24)
[    3.422120] [<80414e20>] (schedule_preempt_disabled+0x0/0x24) from [<80413478>] (mutex_lock_nested+0x220/0x3c0)
[    3.422134] [<80413258>] (mutex_lock_nested+0x0/0x3c0) from [<803116f8>] (clk_get_rate+0x1c/0x5c)
[    3.422148] [<803116dc>] (clk_get_rate+0x0/0x5c) from [<80302a74>] (esdhc_pltfm_set_clock+0x1c/0x200)
[    3.422158]  r4:b405e400 r3:80302a58
[    3.422171] [<80302a58>] (esdhc_pltfm_set_clock+0x0/0x200) from [<802fd3d4>] (sdhci_set_clock+0x4c/0x31c)
[    3.422183] [<802fd388>] (sdhci_set_clock+0x0/0x31c) from [<802fe174>] (sdhci_do_set_ios+0x114/0x6a8)
[    3.422194] [<802fe060>] (sdhci_do_set_ios+0x0/0x6a8) from [<802fe730>] (sdhci_set_ios+0x28/0x34)
[    3.422213] [<802fe708>] (sdhci_set_ios+0x0/0x34) from [<802efa6c>] (mmc_power_up+0xb8/0xc4)
[    3.422224]  r5:b405e2ac r4:b405e000
[    3.422239] [<802ef9b4>] (mmc_power_up+0x0/0xc4) from [<802f06b4>] (mmc_start_host+0x30/0x44)
[    3.422255]  r7:b405e4b4 r6:00000000 r5:00000000 r4:b405e000
[    3.422267] [<802f0684>] (mmc_start_host+0x0/0x44) from [<802f0fd8>] (mmc_add_host+0x58/0x6c)
[    3.422277]  r5:00000000 r4:b405e000
[    3.422289] [<802f0f80>] (mmc_add_host+0x0/0x6c) from [<802ff188>] (sdhci_add_host+0x9f8/0xb88)
[    3.422299]  r5:b405e000 r4:b405e400
[    3.422313] [<802fe790>] (sdhci_add_host+0x0/0xb88) from [<80303dd8>] (sdhci_esdhc_imx_probe_wrapper+0x5c4/0x6a4)
[    3.422334]  r8:b4128400 r7:b4128410 r6:00002801 r5:b4394110 r4:b405e400
[    3.422356] [<80303814>] (sdhci_esdhc_imx_probe_wrapper+0x0/0x6a4) from [<8004fe34>] (async_run_entry_fn+0xf0/0x20c)
[    3.422370] [<8004fd44>] (async_run_entry_fn+0x0/0x20c) from [<8004219c>] (process_one_work+0x380/0x668)
[    3.422393]  r9:00000089 r8:00000000 r7:b4004600 r6:8064ca40 r5:b4391e08
[    3.422393] r4:b4081200
[    3.422406] [<80041e1c>] (process_one_work+0x0/0x668) from [<800428e0>] (worker_thread+0x290/0x3a8)
[    3.422423] [<80042650>] (worker_thread+0x0/0x3a8) from [<800476b0>] (kthread+0xb4/0xc0)
[    3.422439] [<800475fc>] (kthread+0x0/0xc0) from [<8000d970>] (ret_from_fork+0x14/0x24)
[    3.422455]  r7:00000000 r6:00000000 r5:800475fc r4:b409de58

The scheduling-while-atomic bug is due to clk_get_rate() trying to lock a mutex while a spinlock is being held by sdhci_do_set_ios().
The sequence is:
sdhci_do_set_ios()
  spin_lock_irqsave(&host->lock, flags);
  sdhci_set_clock(host, ios->clock);
    esdhc_pltfm_set_clock(host, clock); /* called via host->ops->set_clock */
      esdhc_set_clock(host, clock, clk_get_rate(pltfm_host->clk));
The locking violation occurs when clk_get_rate tries to lock a mutex.

The esdhc_pltfm_set_clock() routine was introduced in commit: 
8ba9580 mmc: sdhci-esdhc: calculate sdclk divider from controller clock

Would you please have a look at this issue?

Thanks,
Jiada
