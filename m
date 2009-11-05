From: maz@misterjones.org (Marc Zyngier)
Date: Thu, 5 Nov 2009 08:10:10 +0100
Subject: [PATCH] Fix PXA-27x/3xx interrupts when CONFIG_PXA_HAVE_ISA_IRQS=y
In-Reply-To: <f17812d70911041914u534cbd50s4fb57f0b77fcca9c@mail.gmail.com>
References: <20091103210439.2a6c1f20@taxman.wild-wind.fr.eu.org>
	<771cded00911031827m34f36dc7r1bc7e1096bb98690@mail.gmail.com>
	<f17812d70911031920t706d9909w3750a2eb9b1d958@mail.gmail.com>
	<771cded00911041911qded36d3sf9ce4384e1ad80b6@mail.gmail.com>
	<f17812d70911041914u534cbd50s4fb57f0b77fcca9c@mail.gmail.com>
Message-ID: <20091105081010.53bb9284@taxman.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 5 Nov 2009 11:14:33 +0800
Eric Miao <eric.y.miao@gmail.com> wrote:

Eric,

> Could you please check without that #ifdef .. #endif it still works
> fine since my assmption is PXA_IRQ() has taken that into account.

Indeed, PXA_IRQ() knows about PXA_HAVE_ISA_IRQ, and we can
unconditionally have this fix.

Please find below the updated patch.

	M.

>From 50390cb82a10921b91a25f5908fdcacdf624017c Mon Sep 17 00:00:00 2001
From: Marc Zyngier <maz@taxman.wild-wind.fr.eu.org>
Date: Tue, 3 Nov 2009 20:35:19 +0100
Subject: [PATCH] Fix pxa27x/3xx interrupts when CONFIG_PXA_HAVE_ISA_IRQS=y

Commit d2c37068429b29d6549cf3486fc84b836689e122 ([ARM] pxa:
initialize default interrupt priority and use ICHP for IRQ handling)
broke ISA interrupt support on pxa27x/3xx.

In such a case, PXA_IRQ(0) != 0, and the IRQ number computed from
ICHP must be offset by PXA_IRQ(0).

Tested on an Arcom Zeus (pxa270), with both CONFIG_PXA_HAVE_ISA_IRQS
enabled and disabled.

Signed-off-by: Marc Zyngier <maz@misterjones.org>
---
 arch/arm/mach-pxa/include/mach/entry-macro.S |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/entry-macro.S b/arch/arm/mach-pxa/include/mach/entry-macro.S
index 2418806..a73bc86 100644
--- a/arch/arm/mach-pxa/include/mach/entry-macro.S
+++ b/arch/arm/mach-pxa/include/mach/entry-macro.S
@@ -46,5 +46,6 @@
 		beq	1001f
 		bic	\irqstat, \irqstat, #0x80000000
 		mov	\irqnr, \irqstat, lsr #16
+		add	\irqnr, \irqnr, #(PXA_IRQ(0))
 1001:
 		.endm
-- 
1.6.0.4


-- 
I'm the slime oozin' out from your TV set...
