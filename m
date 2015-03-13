From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 13 Mar 2015 11:04:21 +0000
Subject: [PATCH v10 18/21] ARM64 / ACPI: Select
 ACPI_REDUCED_HARDWARE_ONLY if ACPI is enabled on ARM64
In-Reply-To: <5502596D.6020901@huawei.com>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
 <1426077587-1561-19-git-send-email-hanjun.guo@linaro.org>
 <20150312182151.GA3867@red-moon> <5502596D.6020901@huawei.com>
Message-ID: <20150313110421.GA5229@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 03:28:45AM +0000, Hanjun Guo wrote:

[...]

> >  /*
> >   * acpi_boot_table_init() called from setup_arch(), always.
> >   *	1. find RSDP and get its address, and then find XSDT
> >   *	2. extract all tables and checksums them all
> >   *	3. check ACPI FADT revision
> > + *	4. check ACPI FADT HW reduced flag
> >   *
> >   * We can parse ACPI boot-time tables such as MADT after
> >   * this function is called.
> >   */
> >  void __init acpi_boot_table_init(void)
> >  {
> > +	struct acpi_table_header *table;
> > +	struct acpi_table_fadt *fadt;
> > +	acpi_status status;
> > +	acpi_size tbl_size;
> > +
> >  	/*
> >  	 * Enable ACPI instead of device tree unless
> >  	 * - ACPI has been disabled explicitly (acpi=off), or
> > @@ -351,19 +318,52 @@ void __init acpi_boot_table_init(void)
> >  	    (!param_acpi_force && of_scan_flat_dt(dt_scan_depth1_nodes, NULL)))
> >  		return;
> >  
> > -	enable_acpi();
> > -
> >  	/* Initialize the ACPI boot-time table parser. */
> >  	if (acpi_table_init()) {
> 
> Since we disable ACPI in default, it is a bit strange for me to init all
> the ACPI tables and parse FADT when ACPI is disabled, could you
> put some comments here to clarify the purpose? other than that, it is looks
> good to me.

Ok, the purpose was to make things simpler, but I think that given
current code it is not 100% safe to init ACPI tables with
acpi_disabled == 1.

To me having to enable ACPI to parse the tables and check *if* ACPI tables
are there is a bit crazy, but I agree with you that given current code
it is safer.

Patch rewritten, here below, please have a look, test it and rework
bits as needed, I added comments where I thought they were needed but
please add to that if you feel it is worth it.

It should be easy to split, let me know if you want an incremental
version.

Thanks !
Lorenzo

---
 arch/arm64/kernel/acpi.c | 103 +++++++++++++++++++++++++++++++----------------
 1 file changed, 69 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 5819ef7..e5ee4d4 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -291,43 +291,60 @@ void acpi_unregister_gsi(u32 gsi)
 }
 EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
 
-static int __init acpi_parse_fadt(struct acpi_table_header *table)
+/*
+ * acpi_fadt_sanity_check() - Check FADT presence and carry out sanity
+ *			      checks on it
+ *
+ * Return 0 on success,  <0 on failure
+ */
+static int __init acpi_fadt_sanity_check(void)
 {
-	struct acpi_table_fadt *fadt = (struct acpi_table_fadt *)table;
+	struct acpi_table_header *table;
+	struct acpi_table_fadt *fadt;
+	acpi_status status;
+	acpi_size tbl_size;
+	int ret = 0;
+
+	/*
+	 * FADT is required on arm64; retrieve it to check its presence
+	 * and carry out revision and ACPI HW reduced compliancy tests
+	 */
+	status = acpi_get_table_with_size(ACPI_SIG_FADT, 0, &table, &tbl_size);
+	if (ACPI_FAILURE(status)) {
+		const char *msg = acpi_format_exception(status);
+
+		pr_err("Failed to get FADT table, %s\n", msg);
+		return -ENODEV;
+	}
+
+	fadt = (struct acpi_table_fadt *)table;
 
 	/*
 	 * Revision in table header is the FADT Major revision, and there
 	 * is a minor revision of FADT which was introduced by ACPI 5.1,
 	 * we only deal with ACPI 5.1 or newer revision to get GIC and SMP
-	 * boot protocol configuration data, or we will disable ACPI.
+	 * boot protocol configuration data.
 	 */
-	if (table->revision > 5 ||
-	    (table->revision == 5 && fadt->minor_revision >= 1)) {
-		if (!acpi_gbl_reduced_hardware) {
-			pr_err("Not hardware reduced ACPI mode, will not be supported\n");
-			goto disable_acpi;
-		}
-
-		/*
-		 * ACPI 5.1 only has two explicit methods to boot up SMP,
-		 * PSCI and Parking protocol, but the Parking protocol is
-		 * only specified for ARMv7 now, so make PSCI as the only
-		 * way for the SMP boot protocol before some updates for
-		 * the Parking protocol spec.
-		 */
-		if (acpi_psci_present())
-			return 0;
-
-		pr_warn("No PSCI support, will not bring up secondary CPUs\n");
-		return -EOPNOTSUPP;
+	if (table->revision < 5 ||
+	   (table->revision == 5 && fadt->minor_revision < 1)) {
+		pr_err("Unsupported FADT revision %d.%d, should be 5.1+\n",
+		       table->revision, fadt->minor_revision);
+		ret = -EINVAL;
+		goto out;
 	}
 
-	pr_warn("Unsupported FADT revision %d.%d, should be 5.1+, will disable ACPI\n",
-		table->revision, fadt->minor_revision);
+	if (!(fadt->flags & ACPI_FADT_HW_REDUCED)) {
+		pr_err("FADT not ACPI hardware reduced compliant\n");
+		ret = -EINVAL;
+	}
 
-disable_acpi:
-	disable_acpi();
-	return -EINVAL;
+out:
+	/*
+	 * acpi_get_table_with_size() creates FADT table mapping that
+	 * should be released after parsing and before resuming boot
+	 */
+	early_acpi_os_unmap_memory((char *)table, tbl_size);
+	return ret;
 }
 
 /*
@@ -335,12 +352,17 @@ disable_acpi:
  *	1. find RSDP and get its address, and then find XSDT
  *	2. extract all tables and checksums them all
  *	3. check ACPI FADT revision
+ *	4. check ACPI FADT HW reduced flag
  *
  * We can parse ACPI boot-time tables such as MADT after
  * this function is called.
+ *
+ * ACPI is enabled on return if ACPI tables initialized and sanity checks
+ * passed, disabled otherwise
  */
 void __init acpi_boot_table_init(void)
 {
+
 	/*
 	 * Enable ACPI instead of device tree unless
 	 * - ACPI has been disabled explicitly (acpi=off), or
@@ -351,19 +373,32 @@ void __init acpi_boot_table_init(void)
 	    (!param_acpi_force && of_scan_flat_dt(dt_scan_depth1_nodes, NULL)))
 		return;
 
+	/*
+	 * ACPI is disabled at this point. Enable it in order to parse
+	 * the ACPI tables and carry out sanity checks
+	 */
 	enable_acpi();
 
 	/* Initialize the ACPI boot-time table parser. */
 	if (acpi_table_init()) {
-		disable_acpi();
-		return;
+		pr_err("Failed to init ACPI tables\n");
+		goto init_failed;
 	}
 
-	if (acpi_table_parse(ACPI_SIG_FADT, acpi_parse_fadt)) {
-		/* disable ACPI if no FADT is found */
-		disable_acpi();
-		pr_err("Can't find FADT\n");
-	}
+	/*
+	 * Check FADT presence and carry out FADT sanity checks
+	 */
+	if (acpi_fadt_sanity_check() < 0)
+		goto init_failed;
+
+	/*
+	 * ACPI tables initialized and FADT sanity checks passed, leave
+	 * ACPI enabled and carry on booting
+	 */
+	return;
+
+init_failed:
+	disable_acpi();
 }
 
 void __init acpi_gic_init(void)
-- 
1.9.1
