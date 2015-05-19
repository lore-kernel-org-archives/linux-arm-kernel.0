From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 May 2015 23:55:12 +0200
Subject: [PATCH] ARM: v7 setup function should invalidate L1 cache
In-Reply-To: <6452458.LAJUB33YSi@phil>
References: <E1Yuk8W-0001tC-IK@rmk-PC.arm.linux.org.uk>
 <6452458.LAJUB33YSi@phil>
Message-ID: <2080993.BUNZpO9uLL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 May 2015 23:44:58 Heiko Stuebner wrote:
> 
> Michael Niewoehner tested this on a rk3188 (Cortex-A9) and wrote in [0]
> > Tested-by: Michael Niewoehner <mniewoeh@stud.hs-offenburg.de>
> > 
> > Tested on Radxa Rock Pro with RK3188.
> > The kernel panics on reboot I had before and also a kernel BUG when running
> > "memtester 1900M" went away and the rock seems to run stable now.
> 

We should probably create a separate fix for that and add it to the stable
kernels then. I would suggest something like the untested patch below,
which takes advantage of the fact that we already have separate assignments
for the start_secondary function pointer for A9 and A17.

	Arnd

diff --git a/arch/arm/mach-rockchip/headsmp.S b/arch/arm/mach-rockchip/headsmp.S
index 46c22dedf632..ae0077e8fe98 100644
--- a/arch/arm/mach-rockchip/headsmp.S
+++ b/arch/arm/mach-rockchip/headsmp.S
@@ -16,9 +16,6 @@
 #include <linux/init.h>
 
 ENTRY(rockchip_secondary_startup)
-	mrc	p15, 0, r0, c0, c0, 0	@ read main ID register
-	ldr	r1, =0x00000c09		@ Cortex-A9 primary part number
-	teq	r0, r1
 	beq	v7_invalidate_l1
 	b	secondary_startup
 ENDPROC(rockchip_secondary_startup)
diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
index 5b4ca3c3c879..5f46724cca2f 100644
--- a/arch/arm/mach-rockchip/platsmp.c
+++ b/arch/arm/mach-rockchip/platsmp.c
@@ -149,8 +149,7 @@ static int __cpuinit rockchip_boot_secondary(unsigned int cpu,
 		 * sram_base_addr + 8: start address for pc
 		 * */
 		udelay(10);
-		writel(virt_to_phys(rockchip_secondary_startup),
-			sram_base_addr + 8);
+		writel(virt_to_phys(secondary_startup), sram_base_addr + 8);
 		writel(0xDEADBEAF, sram_base_addr + 4);
 		dsb_sev();
 	}
