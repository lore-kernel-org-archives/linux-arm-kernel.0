From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue,  9 Nov 2010 21:27:16 +0800
Subject: [PATCH 4/8] ARM: pxa: update to read ICHP
In-Reply-To: <1289309240-21687-3-git-send-email-haojian.zhuang@marvell.com>
References: <1289309240-21687-1-git-send-email-haojian.zhuang@marvell.com>
	<1289309240-21687-2-git-send-email-haojian.zhuang@marvell.com>
	<1289309240-21687-3-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1289309240-21687-4-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ICHP records the highest priority interrupt occured. In PXA27x/PXA3xx, we
can read ICHP via cooprocessor. In PJ4, we can only read ICHP via bus
register. So use the same method to read ICHP via bus register.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/include/mach/entry-macro.S |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/entry-macro.S b/arch/arm/mach-pxa/include/mach/entry-macro.S
index a73bc86..91457dd 100644
--- a/arch/arm/mach-pxa/include/mach/entry-macro.S
+++ b/arch/arm/mach-pxa/include/mach/entry-macro.S
@@ -41,11 +41,15 @@
 		b	1001f
 1002:
 		@ Core Generation 2 (PXA27x) or Core Generation 3 (PXA3xx)
-		mrc	p6, 0, \irqstat, c5, c0, 0	@ ICHP
+		@ or Core PJ4
+		mov	\base, #io_p2v(0x40000000)	@ IIR Ctl = 0x40d00000
+		add	\base, \base, #0x00d00000
+		ldr	\irqstat, [\base, #0x18]	@ ICHP offset
 		tst	\irqstat, #0x80000000
 		beq	1001f
 		bic	\irqstat, \irqstat, #0x80000000
 		mov	\irqnr, \irqstat, lsr #16
 		add	\irqnr, \irqnr, #(PXA_IRQ(0))
+
 1001:
 		.endm
-- 
1.5.6.5
