From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 21 Sep 2016 11:10:21 +0100
Subject: [PATCH 2/4] ARM: tegra: nyan: Use external control for bq24735
 charger
In-Reply-To: <1474444619.1239.13.camel@paulk.fr>
References: <20160828173246.32621-1-contact@paulk.fr>
 <20160828173246.32621-2-contact@paulk.fr>
 <00697eef-0b36-1ff5-9c7a-43c1b53b52bc@nvidia.com>
 <1474394567.1215.14.camel@paulk.fr>
 <90828c8d-e46d-0956-d6b3-e88fc90f3049@nvidia.com>
 <1474444619.1239.13.camel@paulk.fr>
Message-ID: <baca958f-1db6-b9f2-ce94-c523f21d6769@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 21/09/16 08:56, Paul Kocialkowski wrote:

...

> Sure, this is exported at: /sys/class/power_supply/bq24735 at 5-0009
> Also, note that the power-supply next branch[2] has some more fixes for the
> bq24735 driver.

I tested the bq24735 on next-20160919 without any of your changes and 
when connecting or disconnecting the charger I see the following panic.
Do you see this?

Jon

/ # [   30.120384] Unable to handle kernel NULL pointer dereference at virtual address 00000004
[   30.128489] pgd = c0004000
[   30.131187] [00000004] *pgd=00000000
[   30.134759] Internal error: Oops: 17 [#1] PREEMPT SMP ARM
[   30.140141] Modules linked in:
[   30.143192] CPU: 1 PID: 71 Comm: kworker/1:1 Not tainted 4.8.0-rc6-next-20160919-00002-gbc9771827865-dirty #574
[   30.153254] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[   30.159509] Workqueue: events power_supply_changed_work
[   30.164723] task: ee19f880 task.stack: ee1a0000
[   30.169239] PC is at sbs_external_power_changed+0x50/0x5c
[   30.174624] LR is at mod_timer+0x194/0x270
[   30.178705] pc : [<c05b0c58>]    lr : [<c017cda0>]    psr: 60000113
[   30.178705] sp : ee1a1eb8  ip : 80000000  fp : ee8e3680
[   30.190155] r10: eef98580  r9 : 00000000  r8 : 00000000
[   30.195363] r7 : ee303000  r6 : c05afef8  r5 : ee3e03f8  r4 : ee3e03d0
[   30.201872] r3 : 00000000  r2 : 00000000  r1 : 40000193  r0 : 00000001
[   30.208382] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   30.215497] Control: 10c5387d  Table: adcf006a  DAC: 00000051
[   30.221226] Process kworker/1:1 (pid: 71, stack limit = 0xee1a0210)
[   30.227474] Stack: (0xee1a1eb8 to 0xee1a2000)
[   30.231816] 1ea0:                                                       edc0bc00 ee303000
[   30.239973] 1ec0: c05afef8 c05aff2c edc0bc20 c045ec1c eef95c80 eef95c80 00000001 eea82d5c
[   30.248136] 1ee0: edc0bd98 00000000 ee3031c0 ee303218 c0eab740 c05afcc4 ee8e3680 ee3031c0
[   30.256296] 1f00: eef9b800 00000000 eef98580 c0135824 eef98598 c0e02100 eef98580 ee8e3698
[   30.264453] 1f20: 00000008 eef98598 c0e02100 ee1a0000 eef98580 c0135a74 ee840f80 ee8e3680
[   30.272610] 1f40: c0135a3c 00000000 ee840f80 ee8e3680 c0135a3c 00000000 00000000 00000000
[   30.280766] 1f60: 00000000 c013af18 00000000 00000000 00000000 ee8e3680 00000000 00000000
[   30.288922] 1f80: ee1a1f80 ee1a1f80 00000000 00000000 ee1a1f90 ee1a1f90 ee1a1fac ee840f80
[   30.297078] 1fa0: c013ae3c 00000000 00000000 c01078b8 00000000 00000000 00000000 00000000
[   30.305234] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   30.313389] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[   30.321555] [<c05b0c58>] (sbs_external_power_changed) from [<c05aff2c>] (__power_supply_changed_work+0x34/0x3c)
[   30.331623] [<c05aff2c>] (__power_supply_changed_work) from [<c045ec1c>] (class_for_each_device+0x4c/0xb4)
[   30.341254] [<c045ec1c>] (class_for_each_device) from [<c05afcc4>] (power_supply_changed_work+0x5c/0xb0)
[   30.350713] [<c05afcc4>] (power_supply_changed_work) from [<c0135824>] (process_one_work+0x124/0x33c)
[   30.359912] [<c0135824>] (process_one_work) from [<c0135a74>] (worker_thread+0x38/0x4d4)
[   30.367983] [<c0135a74>] (worker_thread) from [<c013af18>] (kthread+0xdc/0xf4)
[   30.375187] [<c013af18>] (kthread) from [<c01078b8>] (ret_from_fork+0x14/0x3c)
[   30.382391] Code: e5911000 e3a00004 ebee0b88 e5943008 (e5933004) 
[   30.388504] ---[ end trace 083d55597e9a2254 ]---
[   30.393140] Unable to handle kernel paging request at virtual address ffffffec
[   30.400342] pgd = c0004000
[   30.403038] [ffffffec] *pgd=afffd861, *pte=00000000, *ppte=00000000
[   30.409309] Internal error: Oops: 37 [#2] PREEMPT SMP ARM
[   30.414690] Modules linked in:
[   30.417738] CPU: 1 PID: 71 Comm: kworker/1:1 Tainted: G      D         4.8.0-rc6-next-20160919-00002-gbc9771827865-dirty #574
[   30.429013] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[   30.435265] task: ee19f880 task.stack: ee1a0000
[   30.439782] PC is at kthread_data+0x4/0xc
[   30.443779] LR is at wq_worker_sleeping+0x8/0xc8
[   30.448381] pc : [<c013b8a8>]    lr : [<c01366e0>]    psr: 20000193
[   30.448381] sp : ee1a1c58  ip : eef98f28  fp : ee1a1cb4
[   30.459836] r10: eef98a00  r9 : c0e5f000  r8 : c0d9ea00
[   30.465048] r7 : ee19fcc8  r6 : c0e02e08  r5 : ee19f880  r4 : eef98a00
[   30.471556] r3 : 00000000  r2 : 00000020  r1 : 00000000  r0 : ee19f880
[   30.478066] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   30.485268] Control: 10c5387d  Table: adcf006a  DAC: 00000051
[   30.490998] Process kworker/1:1 (pid: 71, stack limit = 0xee1a0210)
[   30.497247] Stack: (0xee1a1c58 to 0xee1a2000)
[   30.501590] 1c40:                                                       eef98a00 c0833a68
[   30.509747] 1c60: 00000001 ee117a44 c0d99280 a0000193 00000000 c0833d4c 00000001 ee117a44
[   30.517904] 1c80: 00000000 ee117540 ee19f880 c01faf3c 00000000 ee1a0000 ee1a18ec 00000001
[   30.526060] 1ca0: ee1a1cc8 ee19fc40 c05b0c5c 00000001 ee1a1cc4 c0833d4c ee19f880 ee1a18ec
[   30.534217] 1cc0: ee85d3c0 c012277c ee1a1cc8 ee1a1cc8 00000000 c0e5e2c4 c0e07638 ee1a1e68
[   30.542374] 1ce0: 60000113 0000000b c05b0c5c 00000001 c05b0c5a c010b6f8 ee1a0210 0000000b
[   30.550530] 1d00: c0e07638 ee1a0000 bf000000 00000008 65000000 31313935 20303030 30613365
[   30.558687] 1d20: 34303030 65626520 38623065 35652038 30333439 28203830 33393565 34303033
[   30.566843] 1d40: 00002029 c01b63c4 c0004000 00000004 ee1a1e68 00000017 00000000 00000017
[   30.575000] 1d60: 00000004 eef98580 ee8e3680 c011a424 00000004 c0115c20 ee19f880 00000000
[   30.583156] 1d80: ee19f900 ee2ecd80 ee19f880 c014a55c c014a460 ee19f880 eef98a00 00000000
[   30.591312] 1da0: a0000193 c0e07efc 00000017 c0115888 00000004 ee1a1e68 ee1a0000 eef98580
[   30.599469] 1dc0: ee8e3680 c01012ac 1514622a 00000000 ee19f900 c0149578 eef98a00 ee19f900
[   30.607626] 1de0: 00000001 00000000 eef98a38 00000000 000043e1 c014e11c ee2ecd00 ee19f900
[   30.615781] 1e00: 00000010 00000000 00000006 00000000 00000000 edc45440 c0d992c4 00000000
[   30.623938] 1e20: 00000001 00000000 00000000 00000001 00004b4e 00000000 00000001 c0e5f000
[   30.632095] 1e40: 00000000 00000000 ee19f900 ee19f900 c05b0c58 60000113 ffffffff ee1a1e9c
[   30.640251] 1e60: 00000000 c010bd78 00000001 40000193 00000000 00000000 ee3e03d0 ee3e03f8
[   30.648408] 1e80: c05afef8 ee303000 00000000 00000000 eef98580 ee8e3680 80000000 ee1a1eb8
[   30.656566] 1ea0: c017cda0 c05b0c58 60000113 ffffffff 00000051 00000000 edc0bc00 ee303000
[   30.664722] 1ec0: c05afef8 c05aff2c edc0bc20 c045ec1c eef95c80 eef95c80 00000001 eea82d5c
[   30.672886] 1ee0: edc0bd98 00000000 ee3031c0 ee303218 c0eab740 c05afcc4 ee8e3680 ee3031c0
[   30.681045] 1f00: eef9b800 00000000 eef98580 c0135824 eef98598 c0e02100 eef98580 ee8e3698
[   30.689202] 1f20: 00000008 eef98598 c0e02100 ee1a0000 eef98580 c0135a74 ee840f80 ee8e3680
[   30.697358] 1f40: c0135a3c 00000000 ee840f80 ee8e3680 c0135a3c 00000000 00000000 00000000
[   30.705515] 1f60: 00000000 c013af18 00000000 00000000 00000000 ee8e3680 00000000 00000000
[   30.713672] 1f80: ee1a1f80 ee1a1f80 00000001 00010001 ee1a1f90 ee1a1f90 ee1a1fac ee840f80
[   30.721827] 1fa0: c013ae3c 00000000 00000000 c01078b8 00000000 00000000 00000000 00000000
[   30.729983] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   30.738140] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[   30.746304] [<c013b8a8>] (kthread_data) from [<c01366e0>] (wq_worker_sleeping+0x8/0xc8)
[   30.754292] [<c01366e0>] (wq_worker_sleeping) from [<c0833a68>] (__schedule+0x45c/0x6f0)
[   30.762364] [<c0833a68>] (__schedule) from [<c0833d4c>] (schedule+0x50/0xb4)
[   30.769394] [<c0833d4c>] (schedule) from [<c012277c>] (do_exit+0x6e8/0xa90)
[   30.776340] [<c012277c>] (do_exit) from [<c010b6f8>] (die+0x470/0x488)
[   30.782853] [<c010b6f8>] (die) from [<c011a424>] (__do_kernel_fault.part.0+0x64/0x1e4)
[   30.790751] [<c011a424>] (__do_kernel_fault.part.0) from [<c0115c20>] (do_page_fault+0x398/0x3a4)
[   30.799601] [<c0115c20>] (do_page_fault) from [<c01012ac>] (do_DataAbort+0x38/0xb8)
[   30.807238] [<c01012ac>] (do_DataAbort) from [<c010bd78>] (__dabt_svc+0x58/0x80)
[   30.814613] Exception stack(0xee1a1e68 to 0xee1a1eb0)
[   30.819650] 1e60:                   00000001 40000193 00000000 00000000 ee3e03d0 ee3e03f8
[   30.827807] 1e80: c05afef8 ee303000 00000000 00000000 eef98580 ee8e3680 80000000 ee1a1eb8
[   30.835962] 1ea0: c017cda0 c05b0c58 60000113 ffffffff
[   30.841002] [<c010bd78>] (__dabt_svc) from [<c05b0c58>] (sbs_external_power_changed+0x50/0x5c)
[   30.849593] [<c05b0c58>] (sbs_external_power_changed) from [<c05aff2c>] (__power_supply_changed_work+0x34/0x3c)
[   30.859660] [<c05aff2c>] (__power_supply_changed_work) from [<c045ec1c>] (class_for_each_device+0x4c/0xb4)
[   30.869291] [<c045ec1c>] (class_for_each_device) from [<c05afcc4>] (power_supply_changed_work+0x5c/0xb0)
[   30.878762] [<c05afcc4>] (power_supply_changed_work) from [<c0135824>] (process_one_work+0x124/0x33c)
[   30.887963] [<c0135824>] (process_one_work) from [<c0135a74>] (worker_thread+0x38/0x4d4)
[   30.896034] [<c0135a74>] (worker_thread) from [<c013af18>] (kthread+0xdc/0xf4)
[   30.903240] [<c013af18>] (kthread) from [<c01078b8>] (ret_from_fork+0x14/0x3c)
[   30.910443] Code: e34c00a4 ebff90d2 eafffff2 e5903418 (e5130014) 
[   30.916520] ---[ end trace 083d55597e9a2255 ]---
[   30.921122] Fixing recursive fault but reboot is needed!


-- 
nvpublic
