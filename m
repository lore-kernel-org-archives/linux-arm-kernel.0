From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 14 May 2014 17:50:35 +0200
Subject: [RFC PATCHv1 1/7] ARM: extend machine_desc with additional flags
In-Reply-To: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1400082641-23871-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Processors implementing hardware I/O coherency rely on certain
SMP-related features to be enabled even on UP configurations: the
write allocate cache policy or the shareable attribute. These
decisions are made very early by the ARM core code, in
build_mem_type_table(), even before the machine specific
->init_early() function has been called.

In order to allow these machines to tell the ARM core code about these
specificities, while still preserving multiplatform support, this
commit extends the machine_desc structure with an additional 'flags'
field, and defines two flags: one that allows the machine to tell the
ARM core code that the cache policy should be write allocate, and
another that tells the ARM core code that the shareable attribute
should be set on page tables.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/include/asm/mach/arch.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 17a3fa2..f2a9b39 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -25,6 +25,10 @@ struct smp_operations;
 #define smp_init_ops(ops) (bool (*)(void))NULL
 #endif
 
+/* Possible flags in struct machine_desc */
+#define MACHINE_NEEDS_CPOLICY_WRITEALLOC BIT(0)
+#define MACHINE_NEEDS_SHAREABLE_PAGES    BIT(1)
+
 struct machine_desc {
 	unsigned int		nr;		/* architecture number	*/
 	const char		*name;		/* architecture name	*/
@@ -46,6 +50,7 @@ struct machine_desc {
 	unsigned char		reserve_lp2 :1;	/* never has lp2	*/
 	enum reboot_mode	reboot_mode;	/* default restart mode	*/
 	struct smp_operations	*smp;		/* SMP operations	*/
+	unsigned long		flags;
 	bool			(*smp_init)(void);
 	void			(*fixup)(struct tag *, char **,
 					 struct meminfo *);
-- 
1.9.3
