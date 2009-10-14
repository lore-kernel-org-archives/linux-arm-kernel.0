From: cgagneraud@techworks.ie (Christian Gagneraud)
Date: Wed, 14 Oct 2009 20:45:17 +0100
Subject: ts72xx: rc4 doesn't boot anymore
In-Reply-To: <4AD5121D.4070309@techworks.ie>
References: <4AD5121D.4070309@techworks.ie>
Message-ID: <4AD62A4D.1010206@techworks.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Christian Gagneraud wrote:
> Hi all,
> 
> I really don't understand what's happenning, nothing has changed on my 
> side (same board, same bootloader), rc2 was booting OK, rc3 didn't boot 
> unless I pass on the command line the config for half of my memory 
> (mem=8M at 0x0 mem=8M at 16M mem=8M at 64M mem=8M at 80M). Now with rc4 it's even 
> worth, the kernel complains about bad configuration page, detects 16MB 
> of memory and ignore any mem= command line params (this board has 8 
> nodes of 8MB each).
> 
> Below is the trace of the crash, I've added some debug printk, 
> especially concerning the atags (attached is my hack of 
> arch/arm/kernel/setup.c and another patch i need to get the board 
> booting (I know it's bad))
> 
> Unless I'm missing something, the rc2 was booting OK, I'm sure.

I finally manage to find what was the problem, it's all about my 
.config. I'm using 2 kind of config, a minimal one that just allow me 
to boot, mount root and do the tests I want to do, and a fat config 
with lot of stuff.

So it came that when I activate CONFIG_KEXEC even without 
CONFIG_ATAGS_PROC, my atags are overwritten, if I disable 
CONFIG_KEXEC, then everything _seems_ to be fine (ATAGS should be OK 
as I get my RAM correctly detected).

I first started to look at the kexec code hoping to spot the bug! :)
But to be honnest, I quickly gave up. What's surprising is that the 
kexec code is not spread all around the place and that kexec is 
actually a system call, so there shouldn't be so much code executed at 
boot time.

Other interesting stuff:
- using my fat config with KEXEC: ATAGS screwed up
- using my fat config without KEXEC: ATAGS OK
- using my minimal config with KEXEC: ATAGS OK
- using my minimal config without KEXEC: ATAGS OK

If some people are interesting in chasing this bug and want other 
people to run tests, I'm willing to help.


Chris.


> 
> Any help greatly appreciate.
> 
> Regards,
> Chris
> 
> <5>Linux version 2.6.32-rc4 (cgagneraud at archeopterix.techworks.local) 
> (gcc version 4.3.3 (Sourcery G++ Lite 2009q1-203) ) #15 Wed Oct 14 
> 00:16:32 IST 2009
> CPU: ARM920T [41129200] revision 0 (ARMv4T), cr=40007177
> CPU: VIVT data cache, VIVT instruction cache
> Machine: Technologic Systems TS-72xx SBC
> tags:
> c0000100: 0x00000080
> c0000104: 0x00000200
> c0000108: 0x00000400
> c000010c: 0x00000000
> c0000110: 0x00000000
> c0000114: 0x00000000
> c0000118: 0x00000000
> c000011c: 0x00000000
> c0000120: 0x00000000
> c0000124: 0x00000000
> c0000128: 0x00000000
> c000012c: 0x00000000
> c0000130: 0x00000000
> c0000134: 0x00000000
> c0000138: 0x00000000
> c000013c: 0x00000000
> c0000140: 0x00000000
> c0000144: 0x00000000
> c0000148: 0x00000000
> c000014c: 0x00000000
> c0000150: 0x00000000
> <4>Warning: bad configuration page, trying to continue
> arm_add_memory: start: 0x0, size: 0x1000000 => bank = { start:0x0 
> size:0x1000000 node:0 }
> tags:
> c001fc70: 0x00000005
> c001fc74: 0x54410001
> c001fc78: 0x00000001
> c001fc7c: 0x00001000
> c001fc80: 0x000000FF
> c001fc84: 0x00000004
> c001fc88: 0x54410002
> c001fc8c: 0x01000000
> c001fc90: 0x00000000
> c001fc94: 0x00000000
> c001fc98: 0x00000000
> c001fc9c: 0x00000000
> c001fca0: 0x00000000
> c001fca4: 0x00000000
> c001fca8: 0x00000000
> c001fcac: 0x00000000
> c001fcb0: 0x00000000
> c001fcb4: 0x00000000
> c001fcb8: 0x00000000
> c001fcbc: 0x00000000
> c001fcc0: 0x00000000
> Memory policy: ECC disabled, Data cache writeback
> <7>On node 0 totalpages: 4096
> <7>  Normal zone: 32 pages used for memmap
> <7>  Normal zone: 0 pages reserved
> <7>  Normal zone: 4064 pages, LIFO batch:0
> Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4064
> <5>Kernel command line:  debug
> <6>PID hash table entries: 64 (order: -4, 256 bytes)
> <6>Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
> <6>Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
> <6>Memory: 16MB = 16MB total
> <5>Memory: 11988KB available (3636K code, 388K data, 104K init, 0K highmem)
> <6>Hierarchical RCU implementation.
> <6>NR_IRQS:120
> <6>VIC @fefb0000: id 0x00041190, vendor 0x41
> <6>VIC @fefc0000: id 0x00041190, vendor 0x41
> Console: colour dummy device 80x30
> <6>console [tty0] enabled
> <6>Calibrating delay loop... <1>Unable to handle kernel NULL pointer 
> dereference at virtual address 00000040
> <1>pgd = c0004000
> <1>[00000040] *pgd=00000000
> <0>Internal error: Oops: 5 [#1]
> <0>last sysfs file:
> <d>Modules linked in:
> CPU: 0    Not tainted  (2.6.32-rc4 #15)
> PC is at update_wall_time+0xa4/0x960
> LR is at do_timer+0x24/0x30
> pc : [<c005bc54>]    lr : [<c004baa0>]    psr: a00000d3
> sp : c03c3e70  ip : c0407f50  fp : 00000000
> r10: 0001d9bc  r9 : 41129200  r8 : 00000000
> r7 : 3b9aca00  r6 : 00000000  r5 : 3b9aca00  r4 : 00000040
> r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : 00000000
> Flags: NzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
> Control: 4000717f  Table: 00004000  DAC: 00000017
> <0>Process swapper (pid: 0, stack limit = 0xc03c2270)
> <0>Stack: (0xc03c3e70 to 0xc03c4000)
> <0>3e60:                                     00000000 33300000 00000000 
> 000200d0
> <0>3e80: 00000000 00000000 00000000 00000010 000000d0 00000000 c0c02630 
> c0c02628
> <0>3ea0: 00000000 c0c08000 a0000053 00000000 00000000 00000000 c0c00300 
> c040bec0
> <0>3ec0: 00000000 00000000 00000000 00000000 00000000 c03e6a04 c03c7cd4 
> c035986c
> <0>3ee0: c0359889 ffff8ad1 00000000 fed10fff 00000004 0001d9f0 41129200 
> 0001d9bc
> <0>3f00: 00000000 c004baa0 c0407f78 00002665 fed10fff c0026800 c03e600c 
> 00002665
> <0>3f20: fed10fff c002cca4 c03c6260 00000000 00000000 c00680e4 c03c9d5c 
> 00000004
> <0>3f40: 00000000 c03c8f10 0001d9f0 c0069c7c 00000004 c03d893c 00000000 
> c002203c
> <0>3f60: ffffffff fefb0001 40000000 c0022ae4 00002000 00000000 ffff8ad0 
> ffff8ad0
> <0>3f80: c040b384 c03c59c0 c03c8f10 c03c8f10 0001d9f0 41129200 0001d9bc 
> 00000000
> <0>3fa0: 00000000 c03c3fb8 c001c71c c001c738 60000053 ffffffff c040b384 
> c03e5c40
> <0>3fc0: c001fc9c c03c5b58 0001d9f0 41129200 0001d9bc c0008a5c c0008608 
> 00000000
> <0>3fe0: 00000000 c001fca0 00000000 40007175 c03e5f50 00008038 00000000 
> 00000000
> [<c005bc54>] (update_wall_time+0xa4/0x960) from [<c004baa0>] 
> (do_timer+0x24/0x30)
> [<c004baa0>] (do_timer+0x24/0x30) from [<c0026800>] (timer_tick+0xb4/0xfc)
> [<c0026800>] (timer_tick+0xb4/0xfc) from [<c002cca4>] 
> (ep93xx_timer_interrupt+0x44/0x6c)
> [<c002cca4>] (ep93xx_timer_interrupt+0x44/0x6c) from [<c00680e4>] 
> (handle_IRQ_event+0x58/0x128)
> [<c00680e4>] (handle_IRQ_event+0x58/0x128) from [<c0069c7c>] 
> (handle_level_irq+0x70/0xfc)
> [<c0069c7c>] (handle_level_irq+0x70/0xfc) from [<c002203c>] 
> (asm_do_IRQ+0x3c/0x84)
> [<c002203c>] (asm_do_IRQ+0x3c/0x84) from [<c0022ae4>] (__irq_svc+0x24/0xc0)
> Exception stack(0xc03c3f70 to 0xc03c3fb8)
> 3f60:                                     00002000 00000000 ffff8ad0 
> ffff8ad0
> 3f80: c040b384 c03c59c0 c03c8f10 c03c8f10 0001d9f0 41129200 0001d9bc 
> 00000000
> 3fa0: 00000000 c03c3fb8 c001c71c c001c738 60000053 ffffffff
> [<c0022ae4>] (__irq_svc+0x24/0xc0) from [<c001c738>] 
> (calibrate_delay+0x58/0x160)
> [<c001c738>] (calibrate_delay+0x58/0x160) from [<c0008a5c>] 
> (start_kernel+0x1a8/0x25c)
> [<c0008a5c>] (start_kernel+0x1a8/0x25c) from [<00008038>] (0x8038)
> <0>Code: e8920006 e59d003c e1a05817 e2804040 (e8940018)
> <4>---[ end trace 1b75b31a2719ed1c ]---
> <0>Kernel panic - not syncing: Fatal exception in interrupt
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
