From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 14 Feb 2012 10:52:27 -0800
Subject: [PATCH] Optimize multi-CPU tlb flushing a little more
In-Reply-To: <20110823110602.GG19622@n2100.arm.linux.org.uk>
References: <20110823110602.GG19622@n2100.arm.linux.org.uk>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF178FACB5D5@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote at Tuesday, August 23, 2011 5:06 AM:
> The compiler does not conditionalize the assembly instructions for
> the tlb operations, which leads to sub-optimal code being generated
> when building a kernel for multiple CPUs.
> 
> We can tweak things fairly simply as the code fragment below shows:
> 
>     17f8:       e3120001        tst     r2, #1  ; 0x1
> ...
>     1800:       0a000000        beq     1808 <handle_pte_fault+0x194>
>     1804:       ee061f10        mcr     15, 0, r1, cr6, cr0, {0}
>     1808:       e3120004        tst     r2, #4  ; 0x4
>     180c:       0a000000        beq     1814 <handle_pte_fault+0x1a0>
>     1810:       ee081f36        mcr     15, 0, r1, cr8, cr6, {1}
> becomes:
>     17f0:       e3120001        tst     r2, #1  ; 0x1
>     17f4:       1e063f10        mcrne   15, 0, r3, cr6, cr0, {0}
>     17f8:       e3120004        tst     r2, #4  ; 0x4
>     17fc:       1e083f36        mcrne   15, 0, r3, cr8, cr6, {1}

Russell,

This change causes Tegra to fail to boot, starting with next-20120209.
The spew is shown below. I tested 10 times and got the same failure,
then reverted this patch and tested another 10 times without a failure.
I've eliminated other factors such as SD card, board, and compiler.

Is there a bug in the patch, or is it exposing some pre-existing bug in
the Tegra code?

Thanks.

[    3.179569] VFS: Mounted root (ext3 filesystem) readonly on device 179:1.
[    3.187189] Freeing init memory: 140K
[    3.191124] kjournald starting.  Commit interval 5 seconds
[    3.227325] ------------[ cut here ]------------
[    3.232026] WARNING: at kernel/mutex.c:314 __mutex_unlock_slowpath+0x60/0x14c()
[    3.239355] Modules linked in:
[    3.242627] [<c0013d80>] (unwind_backtrace+0x0/0x120) from [<c002519c>] (warn_slowpath_common+0x4c/0x64)
[    3.252164] [<c002519c>] (warn_slowpath_common+0x4c/0x64) from [<c00251cc>] (warn_slowpath_null+0x18/0x1c)
[    3.261882] [<c00251cc>] (warn_slowpath_null+0x18/0x1c) from [<c02e3c40>] (__mutex_unlock_slowpath+0x60/0x14c)
[    3.271942] [<c02e3c40>] (__mutex_unlock_slowpath+0x60/0x14c) from [<c0095ff0>] (expand_downwards+0xc0/0xc8)
[    3.282111] [<c0095ff0>] (expand_downwards+0xc0/0xc8) from [<c00ac910>] (setup_arg_pages+0x1a0/0x1d4)
[    3.291412] [<c00ac910>] (setup_arg_pages+0x1a0/0x1d4) from [<c00e3d84>] (load_elf_binary+0x3d8/0xaa0)
[    3.300781] [<c00e3d84>] (load_elf_binary+0x3d8/0xaa0) from [<c00abbd0>] (search_binary_handler+0x84/0x274)
[    3.310580] [<c00abbd0>] (search_binary_handler+0x84/0x274) from [<c00ad5a0>] (do_execve_common+0x190/0x2a8)
[    3.320511] [<c00ad5a0>] (do_execve_common+0x190/0x2a8) from [<c00ad6c0>] (do_execve+0x8/0xc)
[    3.329113] [<c00ad6c0>] (do_execve+0x8/0xc) from [<c0011084>] (kernel_execve+0x38/0x80)
[    3.337258] [<c0011084>] (kernel_execve+0x38/0x80) from [<c0008630>] (init_post+0x80/0xc4)
[    3.345588] [<c0008630>] (init_post+0x80/0xc4) from [<c040497c>] (kernel_init+0x16c/0x1b0)
[    3.353878] ---[ end trace 6d8d467ddbc23912 ]---
[    3.358918] ------------[ cut here ]------------
[    3.363570] kernel BUG at include/linux/pagemap.h:134!
[    3.368734] Internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP ARM
[    3.376144] Modules linked in:
[    3.379242] CPU: 0    Tainted: G        W     (3.3.0-rc2-next-20120209+ #1)
[    3.386259] PC is at find_get_page+0x68/0xf4
[    3.390556] LR is at find_get_page+0x2c/0xf4
[    3.394857] pc : [<c0077fe4>]    lr : [<c0077fa8>]    psr: 20000013
[    3.394877] sp : df82dc50  ip : 00000000  fp : 00000000
[    3.406375] r10: 00000000  r9 : df46def0  r8 : df46dd70
[    3.411621] r7 : c06c75bc  r6 : 000280ff  r5 : df46def4  r4 : df82c000
[    3.418171] r3 : 07ffff00  r2 : 00000001  r1 : 000280ff  r0 : df40e564
[    3.424725] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[    3.431886] Control: 10c5387d  Table: 1fa6404a  DAC: 00000015
[    3.437653] Process init (pid: 1, stack limit = 0xdf82c2f0)
[    3.443247] Stack: (0xdf82dc50 to 0xdf82e000)
[    3.447633] dc40:                                     000280ff 00000000 df46de10 000280ff
[    3.455850] dc60: df46dd70 c00cb60c df40f4f8 00000000 00000000 00001000 00000000 c00cb774
[    3.464066] dc80: ffffffff df40f4f8 00000000 c06c75bc 000280ff 00000000 df46dd70 00000000
[    3.472282] dca0: 000280ff 00000000 00000fff c00cbcd0 00001000 00000003 000280ff 00001000
[    3.480499] dcc0: df46dd70 c06c75bc 00000000 c00ceb5c 00001000 00001000 00000005 c00cbcd0
[    3.488715] dce0: 00001000 00091c00 000280ff 000280ff 00000000 00001000 df46dd70 dfa11400
[    3.496931] dd00: df410560 df82dd5c 000280ff 00000000 dfa10200 00000005 c0ba50a0 c00f8dc8
[    3.505148] dd20: 00001000 c00bb8ec df410560 df4105a8 c0b94210 df410560 df4104b0 dfa10000
[    3.513362] dd40: 00000000 00000001 df82de0c df46fc78 00000001 c00fa404 00000000 00000000
[    3.521577] dd60: 00000c00 00000005 df46cb68 0000a14d df46cb68 df46fc08 00000000 00000001
[    3.529795] dd80: df46fc78 c00ff43c df46fc08 c0426060 df46cb68 df46fc08 df82de90 c00afe0c
[    3.538013] dda0: df82de90 df82de04 df469a88 c00b1c8c df813f00 df82ddf0 00001000 c0089ce0
[    3.546232] ddc0: df804f00 df82de90 df82c000 c0385677 c0385678 0024a603 df82ddf0 0000002f
[    3.554449] dde0: df82c000 c00b1f68 df804f00 df8e0a18 0024a603 00000003 c0385673 80000013
[    3.562667] de00: c00a82c8 c00a489c c0447d6c df46fc08 df8267b0 df82de90 c02eda00 c0385672
[    3.570884] de20: ffffff9c df82c000 00000000 df82df60 df82c000 c00b3768 df82de5c df800200
[    3.579102] de40: df807ec0 c00a3094 df800200 dfa41740 c00e43d8 df800200 df807ec0 00000000
[    3.587318] de60: c00e43d8 c02eda00 00000001 ffffff9c df82de90 c0385672 00000000 df82df60
[    3.595536] de80: df82c000 c00b3b04 00000041 c00e43d8 df813f00 df469a88 000176fc 000176fc
[    3.603751] dea0: df804a80 df813f00 df469a88 df46fc08 00000011 00000002 00000001 00000000
[    3.611968] dec0: 000000d0 c00a3e2c df804a80 df8f8898 c0042c60 df804a80 000000d0 60000013
[    3.620185] dee0: c0042c60 00020020 00000000 df8e0a20 c0385672 c044afe8 c044b070 dfa06980
[    3.628401] df00: 00000000 c00ac4cc c0385672 00000000 00000012 c0385672 c044afe8 c044b070
[    3.636618] df20: dfa06980 c00ad4d8 c0385672 00000000 c044b070 df82df60 c044afe8 c0385672
[    3.644834] df40: c044b070 0000005f c0425148 c0404180 00000000 c00ad6c0 df82df60 c0011084
[    3.653044] df60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    3.661253] df80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    3.669469] dfa0: 00000000 00000000 c047d4c0 c047d4c0 c04202a0 c0420280 c047d4c0 c0008638
[    3.677684] dfc0: c047d4c0 c040497c 00000007 00000007 c0404180 00000000 00000000 c0404810
[    3.685897] dfe0: c000ee6c 00000013 00000000 00000000 00000000 c000ee6c 00000000 00000000
[    3.694164] [<c0077fe4>] (find_get_page+0x68/0xf4) from [<c00cb60c>] (__find_get_block_slow+0x3c/0x158)
[    3.703625] [<c00cb60c>] (__find_get_block_slow+0x3c/0x158) from [<c00cbcd0>] (__find_get_block+0x34/0x50)
[    3.713335] [<c00cbcd0>] (__find_get_block+0x34/0x50) from [<c00ceb5c>] (__getblk_slow+0xb0/0x160)
[    3.722361] [<c00ceb5c>] (__getblk_slow+0xb0/0x160) from [<c00f8dc8>] (__ext3_get_inode_loc+0xd8/0x310)
[    3.731814] [<c00f8dc8>] (__ext3_get_inode_loc+0xd8/0x310) from [<c00fa404>] (ext3_iget+0x40/0x3c8)
[    3.740918] [<c00fa404>] (ext3_iget+0x40/0x3c8) from [<c00ff43c>] (ext3_lookup+0x7c/0xcc)
[    3.749156] [<c00ff43c>] (ext3_lookup+0x7c/0xcc) from [<c00afe0c>] (d_alloc_and_lookup+0x44/0x60)
[    3.758084] [<c00afe0c>] (d_alloc_and_lookup+0x44/0x60) from [<c00b1c8c>] (do_lookup+0x1f4/0x314)
[    3.767010] [<c00b1c8c>] (do_lookup+0x1f4/0x314) from [<c00b1f68>] (link_path_walk+0x1bc/0x7a8)
[    3.775760] [<c00b1f68>] (link_path_walk+0x1bc/0x7a8) from [<c00b3768>] (path_openat+0x9c/0x354)
[    3.784598] [<c00b3768>] (path_openat+0x9c/0x354) from [<c00b3b04>] (do_filp_open+0x30/0x7c)
[    3.793099] [<c00b3b04>] (do_filp_open+0x30/0x7c) from [<c00ac4cc>] (open_exec+0x18/0xe8)
[    3.801328] [<c00ac4cc>] (open_exec+0x18/0xe8) from [<c00ad4d8>] (do_execve_common+0xc8/0x2a8)
[    3.809982] [<c00ad4d8>] (do_execve_common+0xc8/0x2a8) from [<c00ad6c0>] (do_execve+0x8/0xc)
[    3.818484] [<c00ad6c0>] (do_execve+0x8/0xc) from [<c0011084>] (kernel_execve+0x38/0x80)
[    3.826626] [<c0011084>] (kernel_execve+0x38/0x80) from [<c0008638>] (init_post+0x88/0xc4)
[    3.834948] [<c0008638>] (init_post+0x88/0xc4) from [<c040497c>] (kernel_init+0x16c/0x1b0)
[    3.843252] Code: e3c3333e e3c330ff e3530000 0a000000 (e7f001f2) 
[    3.852770] ---[ end trace 6d8d467ddbc23913 ]---
[    3.857378] Kernel panic - not syncing: Fatal exception in interrupt

-- 
nvpublic
