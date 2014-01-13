From: klightspeed@killerwolves.net (Ben Peddell)
Date: Tue, 14 Jan 2014 07:08:30 +1000
Subject: [PATCH] ARM: Fix incorrect FDT initrd parameter override
In-Reply-To: <20140113152851.GF19878@titan.lakedaemon.net>
References: <0a923e$51mtvt@icp-osb-irony-out9.iinet.net.au>
 <20140113152851.GF19878@titan.lakedaemon.net>
Message-ID: <52D455CE.6090306@killerwolves.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch submitted with requested changes.

On Mon, 13 Jan 2014 at 10:28:51 AM -0500, Jason Cooper wrote:
>> +	initrd_start = initrd_end = 0;
> 
> This line shouldn't be necessary.  Both are reset in the following hunk
> below your change:
> 

if (phys_initrd_size &&
    !memblock_is_region_memory(phys_initrd_start, phys_initrd_size)) {
	pr_err("INITRD: 0x%08llx+0x%08lx is not a memory region - disabling initrd\n",
	       (u64)phys_initrd_start, phys_initrd_size);
	phys_initrd_start = phys_initrd_size = 0;
}
if (phys_initrd_size &&
    memblock_is_region_reserved(phys_initrd_start, phys_initrd_size)) {
	pr_err("INITRD: 0x%08llx+0x%08lx overlaps in-use memory region - disabling initrd\n",
	       (u64)phys_initrd_start, phys_initrd_size);
	phys_initrd_start = phys_initrd_size = 0;
}

> if (phys_initrd_size) {
> 	memblock_reserve(phys_initrd_start, phys_initrd_size);
> 
> 	/* Now convert initrd to virtual addresses */
> 	initrd_start = __phys_to_virt(phys_initrd_start);
> 	initrd_end = initrd_start + phys_initrd_size;
> }

Please note that above this a check is made to ensure that
phys_initrd_start and phys_initrd_size are valid, and they are zeroed
if they are not valid.  Therefore if phys_initrd_start or 
phys_initrd_size are invalid, then initrd_start and initrd_end are not
reset.

This means that if the initrd= address is not present or is invalid
then the FDT address will be used anyway as initrd_start and 
initrd_end will not have been zeroed, and if that is invalid the
kernel will OOPS in unpack_to_rootfs():

[    0.000000] INITRD: 0xf8280040+0x000f993c is not a memory region - disabling initrd
...
[    1.316588] Trying to unpack rootfs image as initramfs...
[    1.322063] Unable to handle kernel paging request at virtual address b8280040
[    1.329334] pgd = c0004000
[    1.332118] [b8280040] *pgd=00000000
[    1.335766] Internal error: Oops: 5 [#1] ARM
[    1.340098] Modules linked in:
[    1.343232] CPU: 0 PID: 1 Comm: swapper Not tainted 3.13.0-rc7-ds211j+ #2
[    1.350072] task: c7839bc0 ti: c783a000 task.ti: c783a000
[    1.355529] PC is at unpack_to_rootfs+0xa8/0x2b0
[    1.360206] LR is at unpack_to_rootfs+0x44/0x2b0
[    1.364883] pc : [<c047c998>]    lr : [<c047c934>]    psr: 20000053
[    1.364883] sp : c783be40  ip : 000008d8  fp : 00000000
[    1.376474] r10: 00000000  r9 : 00000068  r8 : c047d020
[    1.381755] r7 : c049d068  r6 : b8280040  r5 : 000f993c  r4 : c049d068
[    1.388329] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : c7924000
[    1.394905] Flags: nzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
[    1.402343] Control: 0005397f  Table: 00004000  DAC: 00000017
[    1.408140] Process swapper (pid: 1, stack limit = 0xc783a1c0)
[    1.414024] Stack: (0xc783be40 to 0xc783c000)
[    1.418446] be40: 00000000 c04a34fc c04d3f00 c047d020 00000000 00000000 c04d3f4c c0343368
[    1.426671] be60: c03f85f6 c04d3f50 00000000 c04a34fc c04d3f00 c047d020 00000068 c04d3f50
[    1.434897] be80: c04d3f4c c047d074 ffffffff 00000000 c04c1b5c c04fffc4 c04c1b5c c049023c
[    1.443121] bea0: 00000068 00000000 c783a038 c0343368 c041909f c783becc 00000020 c783becc
[    1.451346] bec0: 00000000 c049031c c041909f 00000000 00000020 00000005 c049bbc8 c04a34fc
[    1.459572] bee0: c04d3f00 c047d020 00000068 00000000 c783a038 c000869c c782b6a0 c00d89c0
[    1.467797] bf00: c782b700 c782b6a0 00000000 c782b6a0 c034c50c c04f7914 00000000 c00d8c5c
[    1.476023] bf20: 00000068 c060edf7 00000000 c0031dc8 60000053 c0457d84 c0457704 00000068
[    1.484247] bf40: 00000005 00000005 00000001 00000005 c049bbc8 c04a34fc c04d3f00 c04d3f00
[    1.492473] bf60: 00000068 c049bbd8 00000000 c047ab14 00000005 00000005 c047a478 c002f124
[    1.500697] bf80: 00000000 00000000 00000000 c0340fb4 00000000 00000000 00000000 00000000
[    1.508923] bfa0: 00000000 c0340fbc 00000000 c000e050 00000000 00000000 00000000 00000000
[    1.517147] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.525373] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[    1.533606] [<c047c998>] (unpack_to_rootfs+0xa8/0x2b0) from [<c047d074>] (populate_rootfs+0x54/0x224)
[    1.542873] [<c047d074>] (populate_rootfs+0x54/0x224) from [<c000869c>] (do_one_initcall+0x94/0x13c)
[    1.552055] [<c000869c>] (do_one_initcall+0x94/0x13c) from [<c047ab14>] (kernel_init_freeable+0xf8/0x1b8)
[    1.561671] [<c047ab14>] (kernel_init_freeable+0xf8/0x1b8) from [<c0340fbc>] (kernel_init+0x8/0x100)
[    1.570852] [<c0340fbc>] (kernel_init+0x8/0x100) from [<c000e050>] (ret_from_fork+0x14/0x24)
[    1.579339] Code: 1a000056 e3550000 0a000054 e1c7a1d0 (e5d63000)
[    1.585525] ---[ end trace 4e31448959d8cde7 ]---
[    1.590212] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b


-- 
Ben Peddell
IT Support Bowen, Collinsville and Proserpine Catholic schools
http://klightspeed.killerwolves.net/
