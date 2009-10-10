From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 9 Oct 2009 20:38:46 -0400
Subject: 2.6.32-rc3/sparsemem: kernel BUG at mm/bootmem.c:243
In-Reply-To: <4ACFC458.7080307@techworks.ie>
References: <4ACFC458.7080307@techworks.ie>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB7E33@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, October 09, 2009 4:17 PM, Christian Gagneraud wrote:
> Hi,
> 
> I've rebased my tree to 2.6.32-rc3, and apply the patch for sparsemem
> support (ts72xx) + the fix in mm/Kconfig, and now the kernel refuse to
> boot. Any hint is greatly appreciated

I'm not the best one to interpret the log but you are hitting a BUG()
in __free() (mm/bootmem.c).

To start with are the ATAGS describing your memory being propery passed
by the bootloader?

Try applying this patch to see what the kernel thinks your memory
actually is.  On my ep9307 system I get:

CPU: ARM920T [41129200] revision 0 (ARMv4T), cr=c0007177
CPU: VIVT data cache, VIVT instruction cache
Machine: Vision Engraving Systems EP9307 SoM
arm_add_memory: start:0xc0000000 size:0x2000000 node:0
arm_add_memory: start:0xc4000000 size:0x2000000 node:0
Memory policy: ECC disabled, Data cache writeback
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16192
Kernel command line: root=/dev/ram console=ttyAM2 video=ep93xx-fb:640x480-16 at 60
PID hash table entries: 256 (order: 8, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 32MB 32MB = 64MB total

This is with flatmem not sparsemem.  I have 64MB total with 32MB at 0xc0000000
and 32MB at 0xc4000000.

Regards,
Hartley

---

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index c6c57b6..1c3d665 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -410,6 +410,8 @@ static int __init arm_add_memory(unsigned long start, unsigned long size)
 		return -EINVAL;
 
 	meminfo.nr_banks++;
+	printk("%s: start:%#lx size:%#lx node:%d\n",
+		__func__, bank->start, bank->size, bank->node);
 	return 0;
 }
  
