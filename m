From: jonathanh@nvidia.com (Jon Hunter)
Date: Thu, 9 Nov 2017 22:54:14 +0000
Subject: next/master boot: 273 boots: 63 failed, 209 passed with 1
 untried/unknown (next-20171106)
In-Reply-To: <2038e32a-de4a-a683-462e-555e991a2111@nvidia.com>
References: <5a0055f1.85a8500a.98d54.a4e4@mx.google.com>
 <20171106191713.d7jqg2b6zqchythw@sirena.co.uk>
 <d8e21d87-776b-beff-62af-34e5ad1febc3@nvidia.com>
 <20171107105501.7x74gdqzhr7uulp2@sirena.org.uk>
 <a384e96c-27c7-782b-75b9-7525714f5831@collabora.com>
 <613bcd63-a215-acbe-9150-c1495f7604f6@collabora.com>
 <5740b853-4898-2ebc-f67d-0808d1b44c36@nvidia.com>
 <ab2ee0a8-6584-7436-ca1b-4f1b521279b0@collabora.com>
 <7cdfa633-d9c6-881a-ae5f-f94f7e6413ee@nvidia.com>
 <5f064e65-ee29-179b-8102-984d12d24d9d@collabora.com>
 <15792a16-6b57-a6ad-92dc-0ffaba0354db@nvidia.com>
 <1eb4e14f-4728-d4f7-95a6-0a6308760d7a@collabora.com>
 <CAK8P3a3iiSgutnHFU7PoLGQyObgyAreQOOtrDhjijoMU5wZ1Eg@mail.gmail.com>
 <18ef379f-0c23-0cbf-4228-30d5c46c690f@nvidia.com>
 <bfed6e80-44a7-6e96-c6a6-bc9793a1937a@collabora.com>
 <2038e32a-de4a-a683-462e-555e991a2111@nvidia.com>
Message-ID: <64b117d3-b2ad-037a-b034-78ef1510fbb4@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 09/11/17 21:45, Jon Hunter wrote:
> 
> On 09/11/17 19:03, Guillaume Tucker wrote:
> ...
> 
>> Alright, so here's all the results I got all based on
>> next-20171109 and running on tegra124-nyan-big:
>>
>> ? * plain multi_v7_defconfig, passes:
>> ??? https://lava.collabora.co.uk/scheduler/job/981295
>>
>> ? * CONFIG_MODULES disabled, fails:
>> ??? https://lava.collabora.co.uk/scheduler/job/981342
>>
>> ? * CONFIG_MODULES and CONFIG_DRM_NOUVEAU disabled, also fails:
>> ??? https://lava.collabora.co.uk/scheduler/job/981343
> 
> This is the crash in the EC driver that I mentioned before. You need to
> add the fix for the EC driver to avoid this BUG_ON.
> 
> I was able to bisect this manually dancing around the various bugs and
> it points to this commit ...
> 
> commit 7313cfa4f6e30384fa04083698d1e865cf812a6a
> Author: Ben Skeggs <bskeggs@redhat.com>
> Date:   Wed Nov 1 03:56:19 2017 +1000
> 
>     drm/nouveau/bar: move bar1 initialisation into its own function
> 
> 
> Unfortunately, I cannot revert cleanly on top of next-20171109 and so I
> cannot confirm.
> 
> Ben, we are seeing a hang on Tegra when booting with CONFIG_DRM_NOUVEAU
> enabled. Apart from the above bisect result, I don't have much else to
> go on at the moment. Let me know if you have any thoughts or anything to
> test.

Here is part of the crash dump I see ...

[    2.288134] nouveau 57000000.gpu: NVIDIA GK20A (0ea000a1)
[    2.293610] nouveau 57000000.gpu: imem: using IOMMU
[    2.298536] nouveau 57000000.gpu: Direct firmware load for nvidia/gk20a/fecs_inst.bin failed with error -2
[    2.308239] nouveau 57000000.gpu: Direct firmware load for nouveau/nvea_fuc409c failed with error -2
[    2.317417] nouveau 57000000.gpu: Direct firmware load for nouveau/fuc409c failed with error -2
[    2.326107] nouveau 57000000.gpu: gr: failed to load fuc409c
[    2.385011] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[    2.393116] pgd = c0204000
[    2.395814] [00000000] *pgd=00000000
[    2.399393] Internal error: Oops: 80000005 [#1] SMP ARM
[    2.404613] Modules linked in:
[    2.405018] elan_i2c 1-0015: invalid report id data (ff)
[    2.412973] CPU: 1 PID: 53 Comm: kworker/1:1 Not tainted 4.14.0-rc7-01211-g7313cfa4f6e3-dirty #129
[    2.421911] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[    2.428174] Workqueue: events deferred_probe_work_func
[    2.433308] task: ee33f200 task.stack: ee470000
[    2.437829] PC is at 0x0
[    2.440355] LR is at nvkm_bar_init+0x3c/0x44
[    2.444617] pc : [<00000000>]    lr : [<c08379d4>]    psr: 20000113
[    2.450869] sp : ee471bc0  ip : 00000000  fp : 00000000
[    2.456083] r10: 00244500  r9 : 00000010  r8 : ee127f04
[    2.461294] r7 : 00000000  r6 : 00244500  r5 : ee127f00  r4 : ee127f04
[    2.467808] r3 : 00000000  r2 : 0001b9c0  r1 : a0000113  r0 : ee127f00
[    2.474326] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    2.481446] Control: 10c5387d  Table: 8020406a  DAC: 00000051
[    2.487184] Process kworker/1:1 (pid: 53, stack limit = 0xee470220)
[    2.493441] Stack: (0xee471bc0 to 0xee472000)
[    2.497787] 1bc0: c0837998 8de4c78d 00000000 c0834c1c 00000000 ed186008 8de4c78d 00000000
[    2.505951] 1be0: 00000010 00000000 00239467 00000000 ed186008 00000000 83126e97 c089084c
[    2.514117] 1c00: 8aebf123 00000000 ed186008 ed186034 8d4fdf3b 83126e97 ed166180 00238f7a
[    2.522277] 1c20: 00000000 c0895314 8ae877d0 00000000 8d4fdf3b c0833268 ee33f280 00000000
[    2.530441] 1c40: 00000000 00000000 ed166118 ed186e00 00000002 ed186e00 ed166138 c0831d28
[    2.538606] 1c60: 00000009 ee33f280 eef9b000 eef9b000 ed186e48 c117d8a4 ed186e68 c0dde690
[    2.546771] 1c80: c117d8a4 ed166180 c082fd4c 00000000 00000000 00000080 00000000 c089532c
[    2.554938] 1ca0: 00000000 00000000 00000000 00000000 ee145050 00000000 ee145050 00000000
[    2.563104] 1cc0: ed186e00 ed186e00 00000000 00000000 00000000 00000000 00000000 ed186e00
[    2.571263] 1ce0: ed166100 ee14505c ed186e00 00000048 00000002 c0831ff0 00000000 00000000
[    2.579426] 1d00: 00000000 00000000 ee145000 ee145000 ee145000 ee145000 ee14505c 00000000
[    2.587591] 1d20: ee145000 00000080 ee471da0 00000000 00000048 c082ee08 ee14505c ee145000
[    2.595756] 1d40: 00000080 ed166100 ee145050 c082f400 00000000 ed166138 ffffffff ee145050
[    2.603922] 1d60: ffffffff ee145000 ee145000 00000000 ee13fc00 c1803a60 c17ae514 c082f690
[    2.612082] 1d80: 00000010 ee145050 ffffffff c08db5b8 00000010 ee145050 ee145000 ee03d508
[    2.620245] 1da0: 00000000 00000000 ffffffff ffffffff ee13fc00 ee13fc00 00000000 00000000
[    2.628410] 1dc0: c1803b58 ee145000 ed1671c0 c08db7f0 00000002 ee131f00 00000000 00000000
[    2.636576] 1de0: ee131f00 c04c0658 ee1314e0 00000001 ee133c40 0000000d ee1314e0 ee131a20
[    2.644741] 1e00: ed1671c0 ee1314e0 00000001 ee131f00 0000000d ee13fc00 00000000 00000000
[    2.652906] 1e20: c1803b58 00000000 0000000d ed1671c0 c17ae514 c0804d88 00000001 00000001
[    2.661065] 1e40: ffffffff ffffffff ee471e6c ee471e6c 00000000 ee13fc00 c1761c5c 00000000
[    2.669228] 1e60: c1761c5c c08dd00c ee256a10 ed186008 fffffffe ee256a10 fffffdfb c097bb48
[    2.677394] 1e80: c097baf8 ee256a10 c1803d7c c1803d80 00000000 c097a27c 00000000 ee471ed0
[    2.685558] 1ea0: c097a40c 00000001 c1764d20 c1803d7c c17bb520 c097888c ee0ab46c ee6472b8
[    2.693725] 1ec0: ee256a10 ee256a44 c1764d78 c0979fbc ee256a10 00000001 ee33f200 ee11db00
[    2.701884] 1ee0: ee256a10 c1764d78 c1764d04 c0979600 ee11db00 c1764d28 ee256a10 c09799f4
[    2.710047] 1f00: ee11db00 c1764d28 eef9ac00 c1602d00 eef9dc00 00000000 00000000 c035af14
[    2.718212] 1f20: c0de1848 2da4a000 eefac000 ee11db00 ee11db18 eef9ac18 c1602d00 c17ae051
[    2.726378] 1f40: ee11db18 00000001 00000008 c035b224 eef9dcf5 ee11db00 eef9ac00 c035b454
[    2.734543] 1f60: ee0edee0 ee20c180 00000000 ee20c180 00000000 ee0b1780 ee20c19c ee11db00
[    2.742708] 1f80: ee0edee0 c035b234 00000000 c03606f4 ee0b1780 c03605d4 00000000 00000000
[    2.750867] 1fa0: 00000000 00000000 00000000 c03082b0 00000000 00000000 00000000 00000000
[    2.759030] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    2.767195] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[    2.775372] [<c08379d4>] (nvkm_bar_init) from [<c0834c1c>] (nvkm_subdev_init+0x210/0x3c8)
[    2.783548] [<c0834c1c>] (nvkm_subdev_init) from [<c089084c>] (nvkm_device_init+0x2d8/0x410)
[    2.791970] [<c089084c>] (nvkm_device_init) from [<c0895314>] (nvkm_udevice_init+0x44/0x5c)
[    2.800316] [<c0895314>] (nvkm_udevice_init) from [<c0833268>] (nvkm_object_init+0xa4/0x284)
[    2.808751] [<c0833268>] (nvkm_object_init) from [<c0831d28>] (nvkm_ioctl_new+0x13c/0x234)
[    2.817011] [<c0831d28>] (nvkm_ioctl_new) from [<c0831ff0>] (nvkm_ioctl+0x140/0x210)
[    2.824751] [<c0831ff0>] (nvkm_ioctl) from [<c082ee08>] (nvif_object_ioctl+0x60/0x80)
[    2.832566] [<c082ee08>] (nvif_object_ioctl) from [<c082f400>] (nvif_object_init+0xc0/0x11c)
[    2.840998] [<c082f400>] (nvif_object_init) from [<c082f690>] (nvif_device_init+0x1c/0x48)
[    2.849258] [<c082f690>] (nvif_device_init) from [<c08db5b8>] (nouveau_cli_init+0x11c/0x18c)
[    2.857689] [<c08db5b8>] (nouveau_cli_init) from [<c08db7f0>] (nouveau_drm_load+0x40/0x7fc)
[    2.866039] [<c08db7f0>] (nouveau_drm_load) from [<c0804d88>] (drm_dev_register+0x134/0x1c8)
[    2.874474] [<c0804d88>] (drm_dev_register) from [<c08dd00c>] (nouveau_platform_probe+0x44/0x68)
[    2.883255] [<c08dd00c>] (nouveau_platform_probe) from [<c097bb48>] (platform_drv_probe+0x50/0xb0)
[    2.892197] [<c097bb48>] (platform_drv_probe) from [<c097a27c>] (driver_probe_device+0x238/0x2e4)
[    2.901062] [<c097a27c>] (driver_probe_device) from [<c097888c>] (bus_for_each_drv+0x44/0x8c)
[    2.909583] [<c097888c>] (bus_for_each_drv) from [<c0979fbc>] (__device_attach+0x9c/0x100)
[    2.917843] [<c0979fbc>] (__device_attach) from [<c0979600>] (bus_probe_device+0x84/0x8c)
[    2.926017] [<c0979600>] (bus_probe_device) from [<c09799f4>] (deferred_probe_work_func+0x30/0x130)
[    2.935060] [<c09799f4>] (deferred_probe_work_func) from [<c035af14>] (process_one_work+0x144/0x42c)
[    2.944187] [<c035af14>] (process_one_work) from [<c035b224>] (process_scheduled_works+0x28/0x38)
[    2.953055] [<c035b224>] (process_scheduled_works) from [<c035b454>] (worker_thread+0x220/0x4d8)
[    2.961823] [<c035b454>] (worker_thread) from [<c03606f4>] (kthread+0x120/0x158)
[    2.969215] [<c03606f4>] (kthread) from [<c03082b0>] (ret_from_fork+0x14/0x24)
[    2.976428] Code: bad PC value
[    2.979509] ---[ end trace f8fe338d0a6f1753 ]---

-- 
nvpublic
