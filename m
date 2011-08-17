From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Aug 2011 08:52:36 +0100
Subject: [PATCH 04/10] ARM: io: ecard: remove ioaddr() from ecard.c
In-Reply-To: <20110817075104.GC1006@n2100.arm.linux.org.uk>
References: <20110817075104.GC1006@n2100.arm.linux.org.uk>
Message-ID: <E1QtavU-0007Mt-I0@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove ioaddr() usage from ecard.c, updating (and renaming) the
constants in RiscPC's hardware.h to contain the proper translation.
As this gets rid of the last ioaddr() usage, kill that too.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/ecard.c                   |   29 +++++++++--------------------
 arch/arm/mach-rpc/include/mach/hardware.h |   11 +++++------
 arch/arm/mach-rpc/include/mach/io.h       |    3 ---
 3 files changed, 14 insertions(+), 29 deletions(-)

diff --git a/arch/arm/kernel/ecard.c b/arch/arm/kernel/ecard.c
index 920f1a3..3e84f66 100644
--- a/arch/arm/kernel/ecard.c
+++ b/arch/arm/kernel/ecard.c
@@ -674,44 +674,37 @@ static int __init ecard_probeirqhw(void)
 #define ecard_probeirqhw() (0)
 #endif
 
-#ifndef IO_EC_MEMC8_BASE
-#define IO_EC_MEMC8_BASE 0
-#endif
-
 static void __iomem *__ecard_address(ecard_t *ec, card_type_t type, card_speed_t speed)
 {
-	unsigned long address = 0;
+	void __iomem *address = NULL;
 	int slot = ec->slot_no;
 
 	if (ec->slot_no == 8)
-		return (void __iomem *)ioaddr(IO_EC_MEMC8_BASE);
+		return ECARD_MEMC8_BASE;
 
 	ectcr &= ~(1 << slot);
 
 	switch (type) {
 	case ECARD_MEMC:
 		if (slot < 4)
-			address = IO_EC_MEMC_BASE + (slot << 12);
+			address = ECARD_MEMC_BASE + (slot << 14);
 		break;
 
 	case ECARD_IOC:
 		if (slot < 4)
-			address = IO_EC_IOC_BASE + (slot << 12);
-#ifdef IO_EC_IOC4_BASE
+			address = ECARD_IOC_BASE + (slot << 14);
 		else
-			address = IO_EC_IOC4_BASE + ((slot - 4) << 12);
-#endif
+			address = ECARD_IOC4_BASE + ((slot - 4) << 14);
 		if (address)
-			address +=  speed << 17;
+			address += speed << 19;
 		break;
 
-#ifdef IO_EC_EASI_BASE
 	case ECARD_EASI:
-		address = IO_EC_EASI_BASE + (slot << 22);
+		address = ECARD_EASI_BASE + (slot << 24);
 		if (speed == ECARD_FAST)
 			ectcr |= 1 << slot;
 		break;
-#endif
+
 	default:
 		break;
 	}
@@ -719,7 +712,7 @@ static void __iomem *__ecard_address(ecard_t *ec, card_type_t type, card_speed_t
 #ifdef IOMD_ECTCR
 	iomd_writeb(ectcr, IOMD_ECTCR);
 #endif
-	return (void __iomem *)(address ? ioaddr(address) : NULL);
+	return address;
 }
 
 static int ecard_prints(struct seq_file *m, ecard_t *ec)
@@ -1049,10 +1042,8 @@ ecard_probe(int slot, card_type_t type)
 		set_irq_flags(ec->irq, IRQF_VALID);
 	}
 
-#ifdef IO_EC_MEMC8_BASE
 	if (slot == 8)
 		ec->irq = 11;
-#endif
 #ifdef CONFIG_ARCH_RPC
 	/* On RiscPC, only first two slots have DMA capability */
 	if (slot < 2)
@@ -1098,9 +1089,7 @@ static int __init ecard_init(void)
 			ecard_probe(slot, ECARD_IOC);
 	}
 
-#ifdef IO_EC_MEMC8_BASE
 	ecard_probe(8, ECARD_IOC);
-#endif
 
 	irqhw = ecard_probeirqhw();
 
diff --git a/arch/arm/mach-rpc/include/mach/hardware.h b/arch/arm/mach-rpc/include/mach/hardware.h
index 822b810..4177766 100644
--- a/arch/arm/mach-rpc/include/mach/hardware.h
+++ b/arch/arm/mach-rpc/include/mach/hardware.h
@@ -51,21 +51,20 @@
 /*
  * IO Addresses
  */
+#define ECARD_EASI_BASE		(IO_BASE + 0x05000000)
 #define VIDC_BASE		(IO_BASE + 0x00400000)
 #define EXPMASK_BASE		(IO_BASE + 0x00360000)
+#define ECARD_IOC4_BASE		(IO_BASE + 0x00270000)
+#define ECARD_IOC_BASE		(IO_BASE + 0x00240000)
 #define IOMD_BASE		(IO_BASE + 0x00200000)
 #define IOC_BASE		(IO_BASE + 0x00200000)
+#define ECARD_MEMC8_BASE	(IO_BASE + 0x0002b000)
 #define FLOPPYDMA_BASE		(IO_BASE + 0x0002a000)
 #define PCIO_BASE		(IO_BASE + 0x00010000)
+#define ECARD_MEMC_BASE		(IO_BASE + 0x00000000)
 
 #define vidc_writel(val)	__raw_writel(val, VIDC_BASE)
 
-#define IO_EC_EASI_BASE		0x81400000
-#define IO_EC_IOC4_BASE		0x8009c000
-#define IO_EC_IOC_BASE		0x80090000
-#define IO_EC_MEMC8_BASE	0x8000ac00
-#define IO_EC_MEMC_BASE		0x80000000
-
 #define NETSLOT_BASE		0x0302b000
 #define NETSLOT_SIZE		0x00001000
 
diff --git a/arch/arm/mach-rpc/include/mach/io.h b/arch/arm/mach-rpc/include/mach/io.h
index 20da7f4..dd706ff 100644
--- a/arch/arm/mach-rpc/include/mach/io.h
+++ b/arch/arm/mach-rpc/include/mach/io.h
@@ -196,9 +196,6 @@ DECLARE_IO(int,l,"")
 #define outw(v,p)	(__builtin_constant_p((p)) ? __outwc(v,p) : __outw(v,p))
 #define outl(v,p)	(__builtin_constant_p((p)) ? __outlc(v,p) : __outl(v,p))
 
-/* the following macro is deprecated */
-#define ioaddr(port)	((unsigned long)__ioaddr((port)))
-
 #define insb(p,d,l)	__raw_readsb(__ioaddr(p),d,l)
 #define insw(p,d,l)	__raw_readsw(__ioaddr(p),d,l)
 
-- 
1.7.4.4
