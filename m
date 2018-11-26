From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 26 Nov 2018 15:09:56 +0000
Subject: [PATCH 1/7] arm64: capabilities: Merge entries for
 ARM64_WORKAROUND_CLEAN_CACHE
In-Reply-To: <20181126140603.GA29684@arm.com>
References: <1541418917-14219-1-git-send-email-suzuki.poulose@arm.com>
 <1541418917-14219-2-git-send-email-suzuki.poulose@arm.com>
 <20181126140603.GA29684@arm.com>
Message-ID: <20181126150956.GA24096@en101>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2018 at 02:06:04PM +0000, Will Deacon wrote:
> On Mon, Nov 05, 2018 at 11:55:11AM +0000, Suzuki K Poulose wrote:
> > We have two entries for ARM64_WORKAROUND_CLEAN_CACHE capability :
> > 
> > 1) ARM Errata 826319, 827319, 824069, 819472 on A53 r0p[012]
> > 2) ARM Errata 819472 on A53 r0p[01]
> > 
> > Both have the same work around. Merge these entries to avoid
> > duplicate entries for a single capability.
> > 
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Andre Przywara <andre.przywara@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > ---
> >  arch/arm64/kernel/cpu_errata.c | 19 +++++++------------
> >  1 file changed, 7 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> > index a509e351..c825bc0 100644
> > --- a/arch/arm64/kernel/cpu_errata.c
> > +++ b/arch/arm64/kernel/cpu_errata.c
> > @@ -573,24 +573,19 @@ static const struct midr_range arm64_harden_el2_vectors[] = {
> >  const struct arm64_cpu_capabilities arm64_errata[] = {
> >  #if	defined(CONFIG_ARM64_ERRATUM_826319) || \
> >  	defined(CONFIG_ARM64_ERRATUM_827319) || \
> > -	defined(CONFIG_ARM64_ERRATUM_824069)
> > +	defined(CONFIG_ARM64_ERRATUM_824069) || \
> > +	defined(CONFIG_ARM64_ERRATUM_819472)
> >  	{
> > -	/* Cortex-A53 r0p[012] */
> > -		.desc = "ARM errata 826319, 827319, 824069",
> > +	/*
> > +	 * Cortex-A53 r0p[012]: ARM errata 826319, 827319, 824069
> > +	 * Cortex-A53 r0p[01] : ARM errata 819472
> > +	 */
> > +		.desc = "ARM errata 826319, 827319, 824069, 819472",
> >  		.capability = ARM64_WORKAROUND_CLEAN_CACHE,
> >  		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A53, 0, 0, 2),
> >  		.cpu_enable = cpu_enable_cache_maint_trap,
> 
> Isn't this a semantic change wrt the Kconfig options? After this change,
> if I /only/ set CONFIG_ARM64_ERRATUM_819472=y, then I still get the
> workaround applied for CPUs > r0[p01] which isn't what I asked for.

You're right. I could change this to :


diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 787d785..56a921f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -313,6 +313,11 @@ menu "Kernel Features"
 
 menu "ARM errata workarounds via the alternatives framework"
 
+config ARM64_WORKAROUND_CLEAN_CACHE
+	default y
+	depends on ARM64_ERRATUM_826319 || ARM64_ERRATUM_827319 ||
+		   ARM64_ERRATUM_824069 || ARM64_ERRATUM_819472
+
 config ARM64_ERRATUM_826319
 	bool "Cortex-A53: 826319: System might deadlock if a write cannot complete until read data is accepted"
 	default y
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index a509e351..80f2e66 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -570,24 +570,28 @@ static const struct midr_range arm64_harden_el2_vectors[] = {
 
 #endif
 
-const struct arm64_cpu_capabilities arm64_errata[] = {
+#ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
+static const struct midr_range workaround_clean_cache[] = {
 #if	defined(CONFIG_ARM64_ERRATUM_826319) || \
 	defined(CONFIG_ARM64_ERRATUM_827319) || \
 	defined(CONFIG_ARM64_ERRATUM_824069)
-	{
-	/* Cortex-A53 r0p[012] */
-		.desc = "ARM errata 826319, 827319, 824069",
-		.capability = ARM64_WORKAROUND_CLEAN_CACHE,
-		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A53, 0, 0, 2),
-		.cpu_enable = cpu_enable_cache_maint_trap,
-	},
+	/* Cortex-A53 r0p[012]: ARM errata 826319, 827319, 824069 */
+	MIDR_REV_RANGE(MIDR_CORTEX_A53, 0, 0, 2),
+#endif
+#ifdef	CONFIG_ARM64_ERRATUM_819472
+	/* Cortex-A53 r0p[01] : ARM errata 819472 */
+	MIDR_REV_RANGE(MIDR_CORTEX_A53, 0, 0, 1),
+#endif
+	{},
+};
 #endif
-#ifdef CONFIG_ARM64_ERRATUM_819472
+
+const struct arm64_cpu_capabilities arm64_errata[] = {
+#ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
 	{
-	/* Cortex-A53 r0p[01] */
-		.desc = "ARM errata 819472",
+		.desc = "ARM errata 826319, 827319, 824069, 819472",
 		.capability = ARM64_WORKAROUND_CLEAN_CACHE,
-		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A53, 0, 0, 1),
+		ERRATA_MIDR_REV_LIST(workaround_clean_cache),
 		.cpu_enable = cpu_enable_cache_maint_trap,
 	},
 #endif

---

Cheers
Suzuki
