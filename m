From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Aug 2011 08:52:16 +0100
Subject: [PATCH 03/10] ARM: io: ecard: move ioaddr() inside __ecard_address
In-Reply-To: <20110817075104.GC1006@n2100.arm.linux.org.uk>
References: <20110817075104.GC1006@n2100.arm.linux.org.uk>
Message-ID: <E1QtavA-0007Mp-Eh@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/ecard.h |    1 -
 arch/arm/kernel/ecard.c      |   11 ++++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/ecard.h b/arch/arm/include/asm/ecard.h
index 29f2610..eaea146 100644
--- a/arch/arm/include/asm/ecard.h
+++ b/arch/arm/include/asm/ecard.h
@@ -161,7 +161,6 @@ struct expansion_card {
 
 	/* Private internal data */
 	const char		*card_desc;	/* Card description		*/
-	CONST unsigned int	podaddr;	/* Base Linux address for card	*/
 	CONST loader_t		loader;		/* loader program */
 	u64			dma_mask;
 };
diff --git a/arch/arm/kernel/ecard.c b/arch/arm/kernel/ecard.c
index d165001..920f1a3 100644
--- a/arch/arm/kernel/ecard.c
+++ b/arch/arm/kernel/ecard.c
@@ -678,13 +678,13 @@ static int __init ecard_probeirqhw(void)
 #define IO_EC_MEMC8_BASE 0
 #endif
 
-static unsigned int __ecard_address(ecard_t *ec, card_type_t type, card_speed_t speed)
+static void __iomem *__ecard_address(ecard_t *ec, card_type_t type, card_speed_t speed)
 {
 	unsigned long address = 0;
 	int slot = ec->slot_no;
 
 	if (ec->slot_no == 8)
-		return IO_EC_MEMC8_BASE;
+		return (void __iomem *)ioaddr(IO_EC_MEMC8_BASE);
 
 	ectcr &= ~(1 << slot);
 
@@ -719,7 +719,7 @@ static unsigned int __ecard_address(ecard_t *ec, card_type_t type, card_speed_t
 #ifdef IOMD_ECTCR
 	iomd_writeb(ectcr, IOMD_ECTCR);
 #endif
-	return address;
+	return (void __iomem *)(address ? ioaddr(address) : NULL);
 }
 
 static int ecard_prints(struct seq_file *m, ecard_t *ec)
@@ -990,6 +990,7 @@ ecard_probe(int slot, card_type_t type)
 	ecard_t **ecp;
 	ecard_t *ec;
 	struct ex_ecid cid;
+	void __iomem *addr;
 	int i, rc;
 
 	ec = ecard_alloc_card(type, slot);
@@ -999,7 +1000,7 @@ ecard_probe(int slot, card_type_t type)
 	}
 
 	rc = -ENODEV;
-	if ((ec->podaddr = __ecard_address(ec, type, ECARD_SYNC)) == 0)
+	if ((addr = __ecard_address(ec, type, ECARD_SYNC)) == NULL)
 		goto nodev;
 
 	cid.r_zero = 1;
@@ -1019,7 +1020,7 @@ ecard_probe(int slot, card_type_t type)
 	ec->cid.fiqmask = cid.r_fiqmask;
 	ec->cid.fiqoff  = ecard_gets24(cid.r_fiqoff);
 	ec->fiqaddr	=
-	ec->irqaddr	= (void __iomem *)ioaddr(ec->podaddr);
+	ec->irqaddr	= addr;
 
 	if (ec->cid.is) {
 		ec->irqmask = ec->cid.irqmask;
-- 
1.7.4.4
