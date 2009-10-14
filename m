From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 13 Oct 2009 20:51:11 -0400
Subject: ts72xx: rc4 doesn't boot anymore
In-Reply-To: <4AD5121D.4070309@techworks.ie>
References: <4AD5121D.4070309@techworks.ie>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB8086@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tuesday, October 13, 2009 4:50 PM, Christian Gagneraud wrote:
> Hi all,
> 
> I really don't understand what's happenning, nothing has changed on my 
> side (same board, same bootloader), rc2 was booting OK, rc3 didn't 
> boot unless I pass on the command line the config for half of my 
> memory (mem=8M at 0x0 mem=8M at 16M mem=8M at 64M mem=8M at 80M). Now with rc4 
> it's even worth, the kernel complains about bad configuration page, 
> detects 16MB of memory and ignore any mem= command line params (this 
> board has 8 nodes of 8MB each).
> 
> Below is the trace of the crash, I've added some debug printk, 
> especially concerning the atags (attached is my hack of 
> arch/arm/kernel/setup.c and another patch i need to get the board 
> booting (I know it's bad))
> 
> Unless I'm missing something, the rc2 was booting OK, I'm sure.
> 
> Any help greatly appreciate.
> 
> Regards,
> Chris

If these are actually your ATAGS they don't make a lot of sense.

> <5>Linux version 2.6.32-rc4 (cgagneraud at archeopterix.techworks.local) 
> (gcc version 4.3.3 (Sourcery G++ Lite 2009q1-203) ) #15 Wed Oct 14 
> 00:16:32 IST 2009
> CPU: ARM920T [41129200] revision 0 (ARMv4T), cr=40007177
> CPU: VIVT data cache, VIVT instruction cache
> Machine: Technologic Systems TS-72xx SBC
> tags:
> c0000100: 0x00000080		<- this indicates that the next tag is 0x80 dwords
> c0000104: 0x00000200		<- this should be a ATAG_* value but it's not valid
> c0000108: 0x00000400		<- this and the next 0x78 dwords should be the data for the tag
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

These tags look ok but they are not at the correct location (.boot_params).
They also only indicate that your system has 1 16MB node.

> c001fc70: 0x00000005		<- size = 0x05
> c001fc74: 0x54410001		<- tag = ATAG_CORE
> c001fc78: 0x00000001		<-   flags /* bit 0 = read-only */
> c001fc7c: 0x00001000		<-   pagesize
> c001fc80: 0x000000FF		<-   rootdev
> c001fc84: 0x00000004		<- size = 0x04
> c001fc88: 0x54410002		<- tag = ATAG_MEM
> c001fc8c: 0x01000000		<-   size = 0x01000000 (16MB)
> c001fc90: 0x00000000		<-   start = 0x00000000
> c001fc94: 0x00000000		<- end of the tag list
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

On my system the tags look like:

c0000100: 0x00000005		<- size = 0x5
c0000104: 0x54410001		<- tag = ATAG_CORE
c0000108: 0x00000000
c000010c: 0x00000000
c0000110: 0x00000000
c0000114: 0x00000004		<- size = 0x4
c0000118: 0x54410002		<- tag = ATAG_MEM
c000011c: 0x02000000		<-   size = 0x02000000 (32MB)
c0000120: 0xc0000000		<-   start = 0xc0000000
c0000124: 0x00000004		<- size = 0x4
c0000128: 0x54410002		<- tag = ATAG_MEM
c000012c: 0x02000000		<-   size = 0x02000000 (32MB)
c0000130: 0xc4000000		<-   start = 0xc4000000
c0000134: 0x00000004		<- size = 0x4
c0000138: 0x54420005		<- tag = ATAG_INITRD2
c000013c: 0xc1000000
c0000140: 0x01000000
c0000144: 0x00000011		<- size = 0x11
c0000148: 0x54410009		<- tag = ATAG_CMDLINE
c000014c: 0x746f6f72
c0000150: 0x65642f3d
c0000154: 0x61722f76
c0000158: 0x6f63206d
c000015c: 0x6c6f736e
c0000160: 0x74743d65
c0000164: 0x324d4179
c0000168: 0x64697620
c000016c: 0x653d6f65
c0000170: 0x78333970
c0000174: 0x62662d78
c0000178: 0x3034363a
c000017c: 0x30383478
c0000180: 0x4036312d
c0000184: 0x00003036
c0000188: 0x00000004		<- size = 0x4
c000018c: 0x54410006		<- tag = ATAG_SERIAL
c0000190: 0x27260017
c0000194: 0x49434100
c0000198: 0x00000003		<- size = 0x3
c000019c: 0x54410007		<- tag = ATAG_REVISION
c00001a0: 0x00000001
c00001a4: 0x00000000		<- end of list

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
> <5>Memory: 11988KB available (3636K code, 388K data, 104K init, 0K 

This correctly identifies your memory based on the ATAGS.  Something is
really screwed up in your system.  Can you go back to 2.6.32-rc1 or -rc2
and verify that they boot correctly?

Regards,
Hartley
