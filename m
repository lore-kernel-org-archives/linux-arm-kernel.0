From: hyok.choi@samsung.com (Hyok S. Choi)
Date: Fri, 01 Feb 2013 20:10:05 +0900
Subject: [PATCH 3/6] ARM: mm: fix numerous hideous errors in proc-arm740.S
In-Reply-To: <1359556069-28289-4-git-send-email-will.deacon@arm.com>
References: <1359556069-28289-1-git-send-email-will.deacon@arm.com>
 <1359556069-28289-4-git-send-email-will.deacon@arm.com>
Message-ID: <0c4201ce006c$b091dba0$11b592e0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hmm, in previous years, for arm7xx platforms, boot up was not done by
typical bootloaders.
I've read the code and seems good to me to add "Acked-by".

Hyok

-----Original Message-----
From: Will Deacon [mailto:will.deacon at arm.com] 
Sent: Wednesday, January 30, 2013 11:28 PM
To: linux-arm-kernel at lists.infradead.org
Cc: Will Deacon; Hyok S. Choi
Subject: [PATCH 3/6] ARM: mm: fix numerous hideous errors in proc-arm740.S

The setup code in proc-arm740.S is completely broken and, as far as I can
tell, always has been. I was >this< close to ripping it out, when a 740t
core-tile materialised in the office, so I've had a crack at fixing things
up:

	- Fix the ram/flash area calculations so that we actually set
	  the condition flags before testing them...
	- Fix the proc_info structure so that __cpu_io_mmu_flags are
	  defined as 0, placing the __cpu_flush pointer at the correct
	  offset
	- Re-number the registers used during __arm740_setup so that
	  we don't clobber the machine ID et al
	- Advertise Thumb support via the hwcaps, since 740T is the only
	  740 implementation.

Cc: Hyok S. Choi <hyok.choi@samsung.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/proc-arm740.S | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mm/proc-arm740.S b/arch/arm/mm/proc-arm740.S index
2088234..fde2d2a 100644
--- a/arch/arm/mm/proc-arm740.S
+++ b/arch/arm/mm/proc-arm740.S
@@ -77,24 +77,27 @@ __arm740_setup:
 	mcr	p15, 0, r0, c6,	c0		@ set area 0, default
 
 	ldr	r0, =(CONFIG_DRAM_BASE & 0xFFFFF000) @ base[31:12] of RAM
-	ldr	r1, =(CONFIG_DRAM_SIZE >> 12)	@ size of RAM (must be >=
4KB)
-	mov	r2, #10				@ 11 is the minimum (4KB)
-1:	add	r2, r2, #1			@ area size *= 2
-	mov	r1, r1, lsr #1
+	ldr	r3, =(CONFIG_DRAM_SIZE >> 12)	@ size of RAM (must be >=
4KB)
+	mov	r4, #10				@ 11 is the minimum (4KB)
+1:	add	r4, r4, #1			@ area size *= 2
+	movs	r3, r3, lsr #1
 	bne	1b				@ count not zero r-shift
-	orr	r0, r0, r2, lsl #1		@ the area register value
+	orr	r0, r0, r4, lsl #1		@ the area register value
 	orr	r0, r0, #1			@ set enable bit
 	mcr	p15, 0, r0, c6,	c1		@ set area 1, RAM
 
 	ldr	r0, =(CONFIG_FLASH_MEM_BASE & 0xFFFFF000) @ base[31:12] of
FLASH
-	ldr	r1, =(CONFIG_FLASH_SIZE >> 12)	@ size of FLASH (must be >=
4KB)
-	mov	r2, #10				@ 11 is the minimum (4KB)
-1:	add	r2, r2, #1			@ area size *= 2
-	mov	r1, r1, lsr #1
+	ldr	r3, =(CONFIG_FLASH_SIZE >> 12)	@ size of FLASH (must be >=
4KB)
+	cmp	r3, #0
+	moveq	r0, #0
+	beq	2f
+	mov	r4, #10				@ 11 is the minimum (4KB)
+1:	add	r4, r4, #1			@ area size *= 2
+	movs	r3, r3, lsr #1
 	bne	1b				@ count not zero r-shift
-	orr	r0, r0, r2, lsl #1		@ the area register value
+	orr	r0, r0, r4, lsl #1		@ the area register value
 	orr	r0, r0, #1			@ set enable bit
-	mcr	p15, 0, r0, c6,	c2		@ set area 2, ROM/FLASH
+2:	mcr	p15, 0, r0, c6,	c2		@ set area 2, ROM/FLASH
 
 	mov	r0, #0x06
 	mcr	p15, 0, r0, c2, c0		@ Region 1&2 cacheable
@@ -137,10 +140,11 @@ __arm740_proc_info:
 	.long	0x41807400
 	.long	0xfffffff0
 	.long	0
+	.long	0
 	b	__arm740_setup
 	.long	cpu_arch_name
 	.long	cpu_elf_name
-	.long	HWCAP_SWP | HWCAP_HALF | HWCAP_26BIT
+	.long	HWCAP_SWP | HWCAP_HALF | HWCAP_THUMB | HWCAP_26BIT
 	.long	cpu_arm740_name
 	.long	arm740_processor_functions
 	.long	0
--
1.8.0
