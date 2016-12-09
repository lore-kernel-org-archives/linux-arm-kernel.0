From: robert.richter@cavium.com (Robert Richter)
Date: Fri, 9 Dec 2016 15:51:52 +0100
Subject: [PATCH v2] arm64: mm: Fix memmap to be initialized for the
 entire section
In-Reply-To: <bc099ca6-d927-3eb6-438c-291a66ecf5f9@huawei.com>
References: <1480530091-1092-1-git-send-email-rrichter@cavium.com>
 <bc099ca6-d927-3eb6-438c-291a66ecf5f9@huawei.com>
Message-ID: <20161209145152.GA14257@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09.12.16 20:14:24, Yisheng Xie wrote:
> We have merged your patch to 4.9.0-rc8, however we still meet the similar problem
> on our D05 board:

I assume you can reliable trigger the bug. Can you add some debug
messages that show the pfn number, node id, memory range. Also, add to
kernel parameters:

 memblock=debug efi=debug loglevel=8 mminit_loglevel=4

We need the mem layout detected by efi and the memblock regions. This
should be in the full boot log then.

Thanks,

-Robert

> -----------------
> [    5.081971] ------------[ cut here ]------------
> [    5.086668] kernel BUG at mm/page_alloc.c:1863!
> [    5.091281] Internal error: Oops - BUG: 0 [#1] SMP
> [    5.096159] Modules linked in:
> [    5.099265] CPU: 61 PID: 1 Comm: swapper/0 Not tainted 4.9.0-rc8+ #58
> [    5.105822] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 UEFI 16.08 RC1 12/08/2016
> [    5.114860] task: fffffe13f23d7400 task.stack: fffffe13f66f8000
> [    5.120903] PC is at move_freepages+0x170/0x180
> [    5.125514] LR is at move_freepages_block+0xa8/0xb8
> [    5.130479] pc : [<fffffc00081e9588>] lr : [<fffffc00081e9640>] pstate: 200000c5
> [    5.138008] sp : fffffe13f66fb910
> [    5.141375] x29: fffffe13f66fb910 x28: 00000000ffffff80
> [    5.146784] x27: fffffdff800b0000 x26: fffffe13fbf62b90
> [    5.152193] x25: 000000000000000a x24: fffffdff800b0020
> [    5.157598] x23: 0000000000000000 x22: fffffdff800b0000
> [    5.163006] x21: fffffdff800fffc0 x20: fffffe13fbf62680
> [    5.168412] x19: fffffdff80080000 x18: 000000004c4d6d26
> [    5.173820] x17: 0000000000000000 x16: 0000000000000000
> [    5.179226] x15: 000000005c589429 x14: 0000000000000000
> [    5.184634] x13: 0000000000000000 x12: 00000000fe2ce6e0
> [    5.190039] x11: 00000000bb5b525b x10: 00000000bb48417b
> [    5.195446] x9 : 0000000000000068 x8 : 0000000000000000
> [    5.200854] x7 : fffffe13fbff2680 x6 : 0000000000000001
> [    5.206260] x5 : fffffc0008e12328 x4 : 0000000000000000
> [    5.211667] x3 : fffffe13fbf62680 x2 : 0000000000000000
> [    5.217073] x1 : fffffe13fbff2680 x0 : fffffe13fbf62680
> [...]
> [    5.768991] [<fffffc00081e9588>] move_freepages+0x170/0x180
> [    5.774664] [<fffffc00081e9640>] move_freepages_block+0xa8/0xb8
> [    5.780691] [<fffffc00081e9bbc>] __rmqueue+0x494/0x5f0
> [    5.785921] [<fffffc00081eb10c>] get_page_from_freelist+0x5ec/0xb58
> [    5.792302] [<fffffc00081ebc4c>] __alloc_pages_nodemask+0x144/0xd08
> [    5.798687] [<fffffc0008240514>] alloc_page_interleave+0x64/0xc0
> [    5.804801] [<fffffc0008240b20>] alloc_pages_current+0x108/0x168
> [    5.810920] [<fffffc0008c75410>] atomic_pool_init+0x78/0x1cc
> [    5.816680] [<fffffc0008c755a0>] arm64_dma_init+0x3c/0x44
> [    5.822180] [<fffffc0008082d94>] do_one_initcall+0x44/0x138
> [    5.827853] [<fffffc0008c70d54>] kernel_init_freeable+0x1ec/0x28c
> [    5.834060] [<fffffc00088a79f0>] kernel_init+0x18/0x110
> [    5.839378] [<fffffc0008082b30>] ret_from_fork+0x10/0x20
> [    5.844785] Code: 9108a021 9400afc5 d4210000 d503201f (d4210000)
> [    5.851024] ---[ end trace 3382df1ae82057db ]---
