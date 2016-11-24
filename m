From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 24 Nov 2016 13:18:39 +0000
Subject: TDA998x crash on HDLCD probe failure
Message-ID: <8281efe7-bac7-8e35-5784-e05cf0dc7eab@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liviu, Russell,

I'd been meaning to try digging into this if it hadn't gone away since I
first noticed it, but I don't really have the time and it still happens
with 4.9-rc and today's -next. Representative splat below, but in
summary what happens is that if the HDLCD fails to probe, the TDA998x
connector seems to get cleaned up twice, resulting in a NULL dereference
the second time. I got as far as sketching out the following flow from a
debug session (on the same 4.8-rc2 kernel), but I don't know nearly
enough to tell which driver is at fault:

hdlcd_drm_bind
-> drm_fbdev_cma_init (fails)
...
-> drm_mode_config_cleanup
   ...
   -> drm_connector_cleanup
-> component_unbind_all
   ...
   -> tda998x_unbind
      -> drm_connector_cleanup (NULL connector)

It's easily reproduced on Juno by booting arm64 defconfig with
CONFIG_CMA_SIZE_MBYTES=1 and a sufficiently large monitor connected to
warrant a >1MB framebuffer.

Robin.

[    4.107349] hdlcd 7ff60000.hdlcd: failed to allocate buffer with size
7680000
[    4.114459] hdlcd 7ff60000.hdlcd: Failed to set initial hw configuration.
[    4.121888] Unable to handle kernel NULL pointer dereference at
virtual address 00000000
[    4.129951] pgd = ffffff80091e0000
[    4.133345] [00000000] *pgd=00000009ffffe003, *pud=00000009ffffe003,
*pmd=0000000000000000
[    4.141613] Internal error: Oops: 96000005 [#1] PREEMPT SMP
[    4.147144] Modules linked in:
[    4.150188] CPU: 0 PID: 122 Comm: kworker/u12:2 Not tainted
4.8.0-rc2+ #989
[    4.157097] Hardware name: ARM Juno development board (r1) (DT)
[    4.162981] Workqueue: deferwq deferred_probe_work_func
[    4.168173] task: ffffffc975d93200 task.stack: ffffffc975dac000
[    4.174055] PC is at drm_connector_cleanup+0x58/0x1c0
[    4.179074] LR is at tda998x_unbind+0x24/0x40
[    4.183401] pc : [<ffffff80084c46f0>] lr : [<ffffff800850414c>]
pstate: 00000045
[    4.190750] sp : ffffffc975dafa10
[    4.194041] x29: ffffffc975dafa10 x28: ffffffc9768152a8
[    4.199325] x27: ffffffc97ff46450 x26: ffffff8008d99000
[    4.204608] x25: dead000000000100 x24: dead000000000200
[    4.209891] x23: ffffffc976bf91e8 x22: 0000000000000000
[    4.215172] x21: ffffffc976bf9170 x20: ffffffc976bf9170
[    4.220454] x19: ffffffc976bf9018 x18: 0000000000000000
[    4.225737] x17: 0000000074ce71ee x16: 000000008ff5d35f
[    4.231019] x15: ffffffc97681e91c x14: ffffffffffffffff
[    4.236301] x13: ffffffc97681e185 x12: 0000000000000038
[    4.241583] x11: 0101010101010101 x10: 0000000000000000
[    4.246866] x9 : 0000000040000000 x8 : 0000000000210d00
[    4.252148] x7 : ffffffc97fea8c00 x6 : 000000000000001b
[    4.257430] x5 : ffffff80084b7b8c x4 : 0000000000000080
[    4.262712] x3 : ffffff8008504128 x2 : ffffffc975df3800
[    4.267993] x1 : 0000000000000000 x0 : 0000000000000000
[    4.273274]
[    4.274759] Process kworker/u12:2 (pid: 122, stack limit =
0xffffffc975dac020)
[    4.281938] Stack: (0xffffffc975dafa10 to 0xffffffc975db0000)
[    4.285576] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[    4.293602] fa00:                                   ffffffc975dafa60
ffffff800850414c
[    4.301386] fa20: ffffffc976bf9018 ffffffc976bf9170 0000000000000000
ffffffc975df3800
[    4.309170] fa40: ffffffc975c1e1a0 ffffffc976b14400 ffffffc976b14410
ffffff8008518784
[    4.316954] fa60: ffffffc975dafa80 ffffff8008507918 ffffffc976bdf080
ffffffffffffffd8
[    4.324737] fa80: ffffffc975dafaa0 ffffff8008507a0c ffffffc975c1e180
ffffffc976b14400
[    4.332521] faa0: ffffffc975dafae0 ffffff80084d5adc ffffffc975df3800
fffffffffffffff4
[    4.340305] fac0: ffffffc976b14410 ffffffc975df3018 ffffffc975df3018
ffffff80084d5ab4
[    4.348089] fae0: ffffffc975dafb30 ffffff8008507b58 ffffffc976bdf080
0000000000000028
[    4.355873] fb00: ffffff8008d3d600 0000000000000001 ffffffc975c1e180
ffffffc976bdf080
[    4.363657] fb20: ffffffc975c1e098 ffffff80084d5428 ffffffc975dafb90
ffffff8008507c50
[    4.371441] fb40: ffffffc975c1e180 ffffff8008d3d5f0 ffffffc976bdf080
ffffffc976b57000
[    4.379225] fb60: ffffff8008d3d000 ffffffc976815000 ffffff8008d926c6
ffffffc976815020
[    4.387009] fb80: ffffffc976815078 ffffffc9768152a8 ffffffc975dafbd0
ffffff8008504b90
[    4.394793] fba0: ffffff8008d3d4e8 ffffffc976b57020 ffffffc976b57004
ffffffc976b57000
[    4.402577] fbc0: ffffff8008504b78 ffffff80086bf8cc ffffffc975dafbe0
ffffff80086bf914
[    4.410360] fbe0: ffffffc975dafc20 ffffff800850d094 ffffffc976b57020
ffffff8008dc4000
[    4.418144] fc00: 0000000000000000 ffffff8008d3d448 0000000000000004
ffffff8008dc4000
[    4.425928] fc20: ffffffc975dafc60 ffffff800850d28c ffffff8008d3d448
ffffffc975dafd00
[    4.433711] fc40: ffffffc976b57020 0000000000000001 ffffffc975e3b400
ffffff800850b114
[    4.441495] fc60: ffffffc975dafc90 ffffff800850b108 0000000000000000
ffffffc975dafd00
[    4.449279] fc80: ffffff800850d1f0 0000000000000001 ffffffc975dafcd0
ffffff800850cd64
[    4.457062] fca0: ffffffc976b57020 ffffffc976b57080 ffffff8008d584f0
ffffffc976b57080
[    4.464846] fcc0: ffffffc976af38d0 ffffffc975c20168 ffffffc975dafd10
ffffff800850d338
[    4.472630] fce0: ffffffc976b57020 ffffffc976b57020 ffffff8008d584f0
ffffff8008d3d000
[    4.480414] fd00: ffffffc976b57020 0000000000000001 ffffffc975dafd20
ffffff800850c124
[    4.488198] fd20: ffffffc975dafd50 ffffff800850c5b0 ffffffc976b57020
ffffff8008d3d848
[    4.495982] fd40: ffffff8008d3d820 ffffff800850c5a8 ffffffc975dafd80
ffffff80080d2998
[    4.503765] fd60: 0000000000000000 ffffffc976bd4500 ffffff8008d3d880
0000000000000000
[    4.511549] fd80: ffffffc975dafdc0 ffffff80080d2c40 ffffffc976bd4500
ffffffc976815000
[    4.519333] fda0: ffffffc976bd4530 ffffffc976815020 ffffff8008ce5000
ffffffc975dac000
[    4.527117] fdc0: ffffffc975dafe20 ffffff80080d8918 ffffffc976bd3880
ffffff8008d9cb08
[    4.534900] fde0: ffffff8008ace5f0 ffffffc976bd4500 ffffff80080d2bf8
0000000000000000
[    4.542683] fe00: 0000000000000000 0000000000000000 0000000000000000
0000000000000000
[    4.550467] fe20: 0000000000000000 ffffff8008082e90 ffffff80080d8848
ffffffc976bd3880
[    4.558250] fe40: 0000000000000000 0000000000000000 0000000000000000
0000d00420000400
[    4.566034] fe60: ffffffc975dafea0 0000000000000000 ffffff80080d8848
ffffffc976bd4500
[    4.573817] fe80: 0000000000000000 0000000000000000 ffffffc975dafe90
ffffffc975dafe90
[    4.581602] fea0: 0000000000000000 ffffff8000000000 ffffffc975dafeb0
ffffffc975dafeb0
[    4.589384] fec0: 0000000000000000 0000000000000000 0000000000000000
0000000000000000
[    4.597168] fee0: 0000000000000000 0000000000000000 0000000000000000
0000000000000000
[    4.604951] ff00: 0000000000000000 0000000000000000 0000000000000000
0000000000000000
[    4.612734] ff20: 0000000000000000 0000000000000000 0000000000000000
0000000000000000
[    4.620517] ff40: 0000000000000000 0000000000000000 0000000000000000
0000000000000000
[    4.628299] ff60: 0000000000000000 0000000000000000 0000000000000000
0000000000000000
[    4.636082] ff80: 0000000000000000 0000000000000000 0000000000000000
0000000000000000
[    4.643865] ffa0: 0000000000000000 0000000000000000 0000000000000000
0000000000000000
[    4.651648] ffc0: 0000000000000000 0000000000000005 0000000000000000
0000000000000000
[    4.659431] ffe0: 0000000000000000 0000000000000000 100a0c0062800800
42200c0000000c00
[    4.667210] Call trace:
[    4.669643] Exception stack(0xffffffc975daf840 to 0xffffffc975daf970)
[    4.676040] f840: ffffffc976bf9018 0000008000000000 ffffffc975dafa10
ffffff80084c46f0
[    4.683823] f860: 0000000000000000 0000000000000000 00000001800f000e
0000000000000001
[    4.691607] f880: ffffffc9769ef2a0 00000001000f000f ffffffbf25da7a00
ffffffc976803100
[    4.699390] f8a0: ffffffc975daf9b0 ffffff80081a899c ffffffc976803100
ffffff80083446b4
[    4.707174] f8c0: ffffffbf25da7a00 ffffffc975dac000 ffffffc9769ef2a0
000000000003c380
[    4.714958] f8e0: 0000000000000000 0000000000000000 ffffffc975df3800
ffffff8008504128
[    4.722741] f900: 0000000000000080 ffffff80084b7b8c 000000000000001b
ffffffc97fea8c00
[    4.730524] f920: 0000000000210d00 0000000040000000 0000000000000000
0101010101010101
[    4.738308] f940: 0000000000000038 ffffffc97681e185 ffffffffffffffff
ffffffc97681e91c
[    4.746090] f960: 000000008ff5d35f 0000000074ce71ee
[    4.750937] [<ffffff80084c46f0>] drm_connector_cleanup+0x58/0x1c0
[    4.756990] [<ffffff800850414c>] tda998x_unbind+0x24/0x40
[    4.762354] [<ffffff8008507918>] component_unbind.isra.4+0x28/0x50
[    4.768492] [<ffffff8008507a0c>] component_unbind_all+0xcc/0xd8
[    4.774373] [<ffffff80084d5adc>] hdlcd_drm_bind+0x234/0x418
[    4.779909] [<ffffff8008507b58>] try_to_bring_up_master+0x140/0x1a0
[    4.786133] [<ffffff8008507c50>] component_add+0x98/0x170
[    4.791496] [<ffffff8008504b90>] tda998x_probe+0x18/0x20
[    4.796774] [<ffffff80086bf914>] i2c_device_probe+0x164/0x258
[    4.802481] [<ffffff800850d094>] driver_probe_device+0x204/0x2b0
[    4.808447] [<ffffff800850d28c>] __device_attach_driver+0x9c/0xf8
[    4.814498] [<ffffff800850b108>] bus_for_each_drv+0x58/0x98
[    4.820033] [<ffffff800850cd64>] __device_attach+0xc4/0x138
[    4.825567] [<ffffff800850d338>] device_initial_probe+0x10/0x18
[    4.831446] [<ffffff800850c124>] bus_probe_device+0x94/0xa0
[    4.836981] [<ffffff800850c5b0>] deferred_probe_work_func+0x78/0xb0
[    4.843207] [<ffffff80080d2998>] process_one_work+0x118/0x378
[    4.848914] [<ffffff80080d2c40>] worker_thread+0x48/0x498
[    4.854276] [<ffffff80080d8918>] kthread+0xd0/0xe8
[    4.859036] [<ffffff8008082e90>] ret_from_fork+0x10/0x40
[    4.864314] Code: f2fbd5b9 f2fbd5b8 f8478ee0 eb17001f (f9400013)
[    4.870472] ---[ end trace a643cfe4ce1d838b ]---
