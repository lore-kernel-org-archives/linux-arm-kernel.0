From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Sun, 15 Jan 2017 17:17:50 +0530
Subject: [PATCH RFC 2/2] ARM: nommu: remap exception base address to RAM
In-Reply-To: <20170107171339.GA5044@afzalpc>
References: <20161211131028.3019-1-afzal.mohd.ma@gmail.com>
 <20161211131255.3221-1-afzal.mohd.ma@gmail.com>
 <20161213100226.GW14217@n2100.armlinux.org.uk>
 <20170107171339.GA5044@afzalpc>
Message-ID: <20170115114750.GA5456@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jan 07, 2017 at 10:43:39PM +0530, Afzal Mohammed wrote:
> On Tue, Dec 13, 2016 at 10:02:26AM +0000, Russell King - ARM Linux wrote:

> > Also, if the region setup for the vectors was moved as well, it would
> > then be possible to check the ID registers to determine whether this
> > is supported, and make the decision where to locate the vectors base
> > more dynamically.
> 
> This would affect Cortex-R's, which is a bit concerning due to lack of
> those platforms with me, let me try to get it right.

QEMU too doesn't seem to provide a Cortex-R target

> Seems translating __setup_mpu() altogether to C

afaics, a kind of C translation is already present as
mpu_setup_region() in arch/arm/mm/nommu.c that takes care of
MPU_RAM_REGION only. And that seems to be a kind of redundant as it is
also done in asm at __setup_mpu(). Git blames asm & C to consecutive
commits, that makes me a little shaky about the conclusion on it being
redundant.

> & installing at a later, but suitable place might be better.

But looks like enabling MPU can't be moved to C & that would
necessitate keeping at least some portion of__setu_mpu() in asm.

Instead, moving region setup only for vectors to C as Russell
suggested at first would have to be done.

A kind of diff at the end is in my mind, with additional changes to
handle the similar during secondary cpu bringup too.

Thinking of invoking mpu_setup() from secondary_start_kernel() in
arch/arm/kernel/smp.c, with mpu_setup() being slightly modified to
avoid storing region details again when invoked by secondary cpu's.

Vladimir, once changes are done after a revisit, i would need your
help to test on Cortex-R.

As an aside, wasn't aware of the fact that Cortex-R supports SMP
Linux, had thought that, of !MMU one's, only Blackfin & J2 had it.


> Also !MMU Kernel could boot on 3 ARM v7-A platforms - AM335x Beagle
> Bone (A8), AM437x IDK (A9) & Vybrid VF610 (on A5 core, note that it
> has M4 core too)

Talking about Cortex-M, AMx3's too have it, to be specific M3, but
they are not Linux-able unlike the one in VF610.

Regards
afzal

--->8---

diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index e0565d73e49e..f8ac79b6136d 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -249,20 +249,6 @@ ENTRY(__setup_mpu)
 	setup_region r0, r5, r6, MPU_INSTR_SIDE @ 0x0, BG region, enabled
 2:	isb
 
-	/* Vectors region */
-	set_region_nr r0, #MPU_VECTORS_REGION
-	isb
-	/* Shared, inaccessible to PL0, rw PL1 */
-	mov	r0, #CONFIG_VECTORS_BASE	@ Cover from VECTORS_BASE
-	ldr	r5,=(MPU_AP_PL1RW_PL0NA | MPU_RGN_NORMAL)
-	/* Writing N to bits 5:1 (RSR_SZ) --> region size 2^N+1 */
-	mov	r6, #(((2 * PAGE_SHIFT - 1) << MPU_RSR_SZ) | 1 << MPU_RSR_EN)
-
-	setup_region r0, r5, r6, MPU_DATA_SIDE	@ VECTORS_BASE, PL0 NA, enabled
-	beq	3f				@ Memory-map not unified
-	setup_region r0, r5, r6, MPU_INSTR_SIDE	@ VECTORS_BASE, PL0 NA, enabled
-3:	isb
-
 	/* Enable the MPU */
 	mrc	p15, 0, r0, c1, c0, 0		@ Read SCTLR
 	bic     r0, r0, #CR_BR			@ Disable the 'default mem-map'
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index e82056df0635..7fe8906322d5 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -269,12 +269,19 @@ void __init mpu_setup(void)
 					ilog2(memblock.memory.regions[0].size),
 					MPU_AP_PL1RW_PL0RW | MPU_RGN_NORMAL);
 	if (region_err) {
-		panic("MPU region initialization failure! %d", region_err);
+		panic("MPU RAM region initialization failure! %d", region_err);
 	} else {
-		pr_info("Using ARMv7 PMSA Compliant MPU. "
-			 "Region independence: %s, Max regions: %d\n",
-			mpu_iside_independent() ? "Yes" : "No",
-			mpu_max_regions());
+		region_err = mpu_setup_region(MPU_VECTORS_REGION, vectors_base,
+					ilog2(memblock.memory.regions[0].size),
+					MPU_AP_PL1RW_PL0NA | MPU_RGN_NORMAL);
+		if (region_err) {
+			panic("MPU VECTOR region initialization failure! %d",
+			      region_err);
+		} else {
+			pr_info("Using ARMv7 PMSA Compliant MPU. "
+				"Region independence: %s, Max regions: %d\n",
+				mpu_iside_independent() ? "Yes" : "No",
+				mpu_max_regions());
 	}
 }
 #else
