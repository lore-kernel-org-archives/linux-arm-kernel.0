From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 21 Dec 2014 11:25:29 +0100
Subject: [PATCH v6] ARM: zImage: add support for ARMv7-M
In-Reply-To: <cfd1c941b379d2e47b0a8d1469161179@agner.ch>
References: <1418806573-14897-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <cfd1c941b379d2e47b0a8d1469161179@agner.ch>
Message-ID: <20141221102529.GI10857@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Stefan,

On Sat, Dec 20, 2014 at 02:33:16PM +0100, Stefan Agner wrote:
> > This patch is only compile tested as I don't have a machine with enough
> > RAM to run a non-XIP kernel, so Tested-by tags are welcome.
> Tried the patch on Vybrid's M4 CPU. Since the M4 has full access to the
> DDR3 RAM, it is even possible to use AUTO_ZRELADDR for both CPU's: The
> Colibri VF61 has 256MB of RAM: A5 relocates to 0x80008000, M4 to
> 0x88008000. 
Ok, let me summarize what I understood, please correct me if I'm wrong.
You have 256 MiB of RAM at address 0x80000000 (same address for
both cpus), the A5 uses [0x80000000-0x87ffffff], the M4 uses
[0x88000000-0x8fffffff]. To boot the M4 

> The uncompressing stage seems to work fine, however it seems I hit a
> different bug which is triggered by using the zImage: Freeing the memory
> location used by the compressed image seems to fail:
Does booting an Image work? Does it help to 

I don't understand much about all that memory management, but I guess it
would help if you add bootmem_debug to the kernel parameters.

> Uncompressing Linux... done, booting the kernel.
> Booting Linux on physical CPU 0x0
> Linux version 3.18.0-10889-ga84c884 (ags at trochilidae) (gcc version 4.8.3
> 20140401 (prerelease) (Linaro GCC 4.8-2014.04) ) #377 Sat Dec 20
> 14:08:07 CET 2014
> CPU: ARMv7-M [410fc241] revision 1 (ARMv7M), cr=00000000
> CPU: unknown data cache, unknown instruction cache
> Machine model: VF610 Cortex-M4
> bootconsole [earlycon0] enabled
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
> 12192
> Kernel command line: console=ttyLP2,115200 ihash_entries=64
> dhash_entries=64 earlyprintk clk_ignore_unused init=/linuxrc rw
> PID hash table entries: 256 (order: -2, 1024 bytes)
> Dentry cache hash table entries: 64 (order: -4, 256 bytes)
> Inode-cache hash table entries: 64 (order: -4, 256 bytes)
> BUG: Bad page state in process swapper  pfn:8c000
> page:8f020000 count:0 mapcount:0 mapping:da2fe79e index:0x6e563b3a
> flags:
> 0x4248e05f(locked|error|referenced|uptodate|dirty|active|writeback|head|tail|swapbacked)
> page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
> bad because of flags:
> flags: 0x2041(locked|active|writeback)
> CPU: 0 PID: 0 Comm: swapper Not tainted 3.18.0-10889-ga84c884 #377
> Hardware name: Freescale Vybrid VF610 (Device Tree)
> [<8800b129>] (unwind_backtrace) from [<8800a53f>] (show_stack+0xb/0xc)
> [<8800a53f>] (show_stack) from [<8803a40d>] (bad_page+0x85/0xb8)
> [<8803a40d>] (bad_page) from [<8803a4e9>] (free_pages_prepare+0xa9/0xac)
> [<8803a4e9>] (free_pages_prepare) from [<8803b2ed>]
> (__free_pages_ok+0x19/0x260)
> [<8803b2ed>] (__free_pages_ok) from [<881978db>]
> (free_all_bootmem+0xaf/0xf8)
> [<881978db>] (free_all_bootmem) from [<8819201d>] (mem_init+0xb5/0x1c8)
> [<8819201d>] (mem_init) from [<8818f5af>] (start_kernel+0x17b/0x2c0)
> [<8818f5af>] (start_kernel) from [<08008023>] (0x8008023)
> 
> 
> My loaders output, zImage has been loaded to the region in question
> (0x8f000080...)

> # ./m4boot zImage initramfs.cpio.lzo vf610m4-colibri.dtb
> zImage: 1103944 bytes loaded
> initramfs.cpio.lzo: 1632028 bytes loaded
> vf610m4-colibri.dtb: 9911 bytes loaded
> vf610m4bootldr: 128 bytes copied to 0x8f000000 through 0x8f000080
> zImage: 1103944 bytes copied to 0x8f000080 through 0x8f10d8c8
This is a bad location because this overlaps with the final image
location. So the zImage is relocated which might overwrite something.
I would expect a different failure then, but still, can you try to put
the zImage to a different position, say 0x88408000?

> initramfs.cpio.lzo: 1632028 bytes copied to 0x8d000000 through
> 0x8d18e71c
> vf610m4-colibri.dtb: 9979 bytes copied to 0x8fff0000 through 0x8fff26fb
> Entry point set to 0x0f000001
What is "Entry point" here?

> Argument set to 0x8fff0000
> Cortex-M4 started...
> 
> 
> Virtual kernel memory layout:
>     vector  : 0x00000000 - 0x00001000   (   4 kB)
>     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
>     vmalloc : 0x00000000 - 0xffffffff   (4095 MB)
>     lowmem  : 0x88000000 - 0x8f000000   ( 112 MB)
>       .text : 0x88008000 - 0x8818acfc   (1548 kB)
>       .init : 0x8818b000 - 0x8819e000   (  76 kB)
>       .data : 0x8819e000 - 0x881b2900   (  83 kB)
>        .bss : 0x881b2900 - 0x881dc210   ( 167 kB)
You got memory map that from a boot without zImage?

> I used CONFIG_SET_MEM_PARAM and configured the RAM at those fixed
> values:
> CONFIG_DRAM_BASE=0x88000000                                             
>                                 
> CONFIG_DRAM_SIZE=0x08000000
This looks correct.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
