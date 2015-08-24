From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 24 Aug 2015 13:36:02 +0900
Subject: [PATCH 02/18] ARM: add const qualifier to smp_operations member in
 structures
In-Reply-To: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
References: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1440390978-22796-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The core framework does not modify smp_operations structures.
To clarify it, this commit adds 'const' qualifier to the 'ops'
member of struct of_cpu_method and the 'smp' member of struct
machine_desc.

This change allows each SoC code to add 'const' qualifier to its
smp_operation structure.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/include/asm/mach/arch.h | 2 +-
 arch/arm/include/asm/smp.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index cb3a407..5c1ad11 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -47,7 +47,7 @@ struct machine_desc {
 	unsigned		l2c_aux_val;	/* L2 cache aux value	*/
 	unsigned		l2c_aux_mask;	/* L2 cache aux mask	*/
 	void			(*l2c_write_sec)(unsigned long, unsigned);
-	struct smp_operations	*smp;		/* SMP operations	*/
+	const struct smp_operations	*smp;	/* SMP operations	*/
 	bool			(*smp_init)(void);
 	void			(*fixup)(struct tag *, char **);
 	void			(*dt_fixup)(void);
diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index cd81540..50aff58 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -112,7 +112,7 @@ struct smp_operations {
 
 struct of_cpu_method {
 	const char *method;
-	struct smp_operations *ops;
+	const struct smp_operations *ops;
 };
 
 #define CPU_METHOD_OF_DECLARE(name, _method, _ops)			\
-- 
1.9.1
