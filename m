From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Aug 2011 08:52:56 +0100
Subject: [PATCH 05/10] ARM: io: RiscPC: make EASI_BASE a void iomem pointer
In-Reply-To: <20110817075104.GC1006@n2100.arm.linux.org.uk>
References: <20110817075104.GC1006@n2100.arm.linux.org.uk>
Message-ID: <E1Qtavo-0007Mx-LJ@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/ecard.c                   |    2 +-
 arch/arm/mach-rpc/include/mach/hardware.h |    4 ++--
 arch/arm/mach-rpc/riscpc.c                |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/ecard.c b/arch/arm/kernel/ecard.c
index 3e84f66..4dd0eda 100644
--- a/arch/arm/kernel/ecard.c
+++ b/arch/arm/kernel/ecard.c
@@ -237,7 +237,7 @@ static void ecard_init_pgtables(struct mm_struct *mm)
 
 	memcpy(dst_pgd, src_pgd, sizeof(pgd_t) * (IO_SIZE / PGDIR_SIZE));
 
-	src_pgd = pgd_offset(mm, EASI_BASE);
+	src_pgd = pgd_offset(mm, (unsigned long)EASI_BASE);
 	dst_pgd = pgd_offset(mm, EASI_START);
 
 	memcpy(dst_pgd, src_pgd, sizeof(pgd_t) * (EASI_SIZE / PGDIR_SIZE));
diff --git a/arch/arm/mach-rpc/include/mach/hardware.h b/arch/arm/mach-rpc/include/mach/hardware.h
index 4177766..050d63c 100644
--- a/arch/arm/mach-rpc/include/mach/hardware.h
+++ b/arch/arm/mach-rpc/include/mach/hardware.h
@@ -36,7 +36,7 @@
 
 #define EASI_SIZE		0x08000000	/* EASI I/O */
 #define EASI_START		0x08000000
-#define EASI_BASE		0xe5000000
+#define EASI_BASE		IOMEM(0xe5000000)
 
 #define IO_START		0x03000000	/* I/O */
 #define IO_SIZE			0x01000000
@@ -51,7 +51,7 @@
 /*
  * IO Addresses
  */
-#define ECARD_EASI_BASE		(IO_BASE + 0x05000000)
+#define ECARD_EASI_BASE		(EASI_BASE)
 #define VIDC_BASE		(IO_BASE + 0x00400000)
 #define EXPMASK_BASE		(IO_BASE + 0x00360000)
 #define ECARD_IOC4_BASE		(IO_BASE + 0x00270000)
diff --git a/arch/arm/mach-rpc/riscpc.c b/arch/arm/mach-rpc/riscpc.c
index 580b3c7..1e0e60d 100644
--- a/arch/arm/mach-rpc/riscpc.c
+++ b/arch/arm/mach-rpc/riscpc.c
@@ -74,7 +74,7 @@ static struct map_desc rpc_io_desc[] __initdata = {
 		.length		= 	IO_SIZE	 ,
 		.type		= MT_DEVICE
 	}, {	/* EASI space	*/
-		.virtual	= EASI_BASE,
+		.virtual	= (unsigned long)EASI_BASE,
 		.pfn		= __phys_to_pfn(EASI_START),
 		.length		= EASI_SIZE,
 		.type		= MT_DEVICE
-- 
1.7.4.4
