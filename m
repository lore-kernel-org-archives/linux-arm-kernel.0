From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 01 Sep 2011 13:49:19 +0100
Subject: [PATCH 03/11] ARM: pm: some ARMv7 requires a dsb in resume to ensure
	correctness
In-Reply-To: <20110901124752.GE29729@n2100.arm.linux.org.uk>
References: <20110901124752.GE29729@n2100.arm.linux.org.uk>
Message-ID: <E1Qz6hr-00078J-2k@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a dsb after the isb to ensure that the previous writes to the
CP15 registers take effect before we enable the MMU.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/proc-v7.S |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index dec72ee..a773f4e 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -255,6 +255,7 @@ ENTRY(cpu_v7_do_resume)
 	mcr	p15, 0, r4, c10, c2, 0	@ write PRRR
 	mcr	p15, 0, r5, c10, c2, 1	@ write NMRR
 	isb
+	dsb
 	mov	r0, r9			@ control register
 	mov	r2, r7, lsr #14		@ get TTB0 base
 	mov	r2, r2, lsl #14
-- 
1.7.4.4
