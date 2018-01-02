From: sudipm.mukherjee@gmail.com (Sudip Mukherjee)
Date: Tue, 2 Jan 2018 11:34:45 +0000
Subject: [PATCH] arch: drop duplicate exports of abort()
In-Reply-To: <20180102103311.706364-1-arnd@arndb.de>
References: <20180102103311.706364-1-arnd@arndb.de>
Message-ID: <20180102113417.GA5078@sudip-tp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Jan 02, 2018 at 11:31:12AM +0100, Arnd Bergmann wrote:
> We now have exports in both architecture code in in common code,
> which causes a link failure when symbol versioning is eanbled, on
> four architectures:
> 
> kernel/exit.o: In function `__crc_abort':
> exit.c:(*ABS*+0xc0e2ec8b): multiple definition of `__crc_abort'
> 
> This removes the four architecture specific exports and only
> leaves the export next to the __weak symbol.

Will it not be better to remove the abort() as they are exactly same
like the weak function. That was the original plan we had when this
weak function was done. Like in the attached patch..

--
Regards
Sudip
-------------- next part --------------
diff --git a/arch/arc/kernel/traps.c b/arch/arc/kernel/traps.c
index 51a55b0..133a4da 100644
--- a/arch/arc/kernel/traps.c
+++ b/arch/arc/kernel/traps.c
@@ -169,4 +169,3 @@ void abort(void)
 {
 	__asm__ __volatile__("trap_s  5\n");
 }
-EXPORT_SYMBOL(abort);
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index e344bdd..917b425 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -786,15 +786,6 @@ asmlinkage void __div0(void)
 }
 EXPORT_SYMBOL(__div0);
 
-void abort(void)
-{
-	BUG();
-
-	/* if that doesn't kill us, halt */
-	panic("Oops failed to kill thread");
-}
-EXPORT_SYMBOL(abort);
-
 void __init trap_init(void)
 {
 	return;
diff --git a/arch/m32r/kernel/traps.c b/arch/m32r/kernel/traps.c
index cb79fba..a6f300a 100644
--- a/arch/m32r/kernel/traps.c
+++ b/arch/m32r/kernel/traps.c
@@ -115,15 +115,6 @@ static void set_eit_vector_entries(void)
 	_flush_cache_copyback_all();
 }
 
-void abort(void)
-{
-	BUG();
-
-	/* if that doesn't kill us, halt */
-	panic("Oops failed to kill thread");
-}
-EXPORT_SYMBOL(abort);
-
 void __init trap_init(void)
 {
 	set_eit_vector_entries();
diff --git a/arch/unicore32/kernel/traps.c b/arch/unicore32/kernel/traps.c
index 5f25b39..30d6613 100644
--- a/arch/unicore32/kernel/traps.c
+++ b/arch/unicore32/kernel/traps.c
@@ -291,15 +291,6 @@ asmlinkage void __div0(void)
 }
 EXPORT_SYMBOL(__div0);
 
-void abort(void)
-{
-	BUG();
-
-	/* if that doesn't kill us, halt */
-	panic("Oops failed to kill thread");
-}
-EXPORT_SYMBOL(abort);
-
 void __init trap_init(void)
 {
 	return;
