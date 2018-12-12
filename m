Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFCCC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:52:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C122080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jh0tShKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C122080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=sQNBLtChoJq+P6XSQZnEHfqNhKprkSUS9tAXkUT3ogc=; b=Jh0tShKDRlFAWfHnPnXId88Q9q
	B4gKdRa/Vb+LaM0jnTFSgHEFIi6W2xHu206zL1QYfpmAwxtFwknyRfGJdLRTG5d3ItH4DBFPJsyWx
	zc5b+K6KZd5xsDP1pFevazzgFYdleWBxdsaEyyMqqTIW4/pJIybO0ZJdpQNl249OY56QxuoEwW4VX
	Ypcasv/rgus/V2hLuNZmFALUtEz5V94M5lTfCAy4NVM9vJ2dqQSzI5em3IWAqUC/db/VTn3AW3XOH
	Ou+rAY5lJ3aztzN4jJpX8JAxYmREkmjl/h+NhIpLQinkgSyyyvkR8/mLffxhLqY6xa6UV6mkzLKLL
	nrb5lAVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX7kG-0007mx-8g; Wed, 12 Dec 2018 16:52:24 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX7gZ-0002vf-UE
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 16:48:46 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1424015BF;
 Wed, 12 Dec 2018 08:48:30 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D05AF3F575;
 Wed, 12 Dec 2018 08:48:27 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 18/25] irqchip/gic-v3: Detect if GIC can support pseudo-NMIs
Date: Wed, 12 Dec 2018 16:47:18 +0000
Message-Id: <1544633245-6036-19-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
References: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_084836_313097_83C9F4A3 
X-CRM114-Status: GOOD (  18.65  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, daniel.thompson@linaro.org,
 Jason Cooper <jason@lakedaemon.net>, Julien Thierry <julien.thierry@arm.com>,
 marc.zyngier@arm.com, catalin.marinas@arm.com,
 Jonathan Corbet <corbet@lwn.net>, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, christoffer.dall@arm.com, james.morse@arm.com,
 joel@joelfernandes.org, Thomas Gleixner <tglx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The values non secure EL1 needs to use for PMR and RPR registers depends on
the value of SCR_EL3.FIQ.

The values non secure EL1 sees from the distributor and redistributor
depend on whether security is enabled for the GIC or not.

To avoid having to deal with two sets of values for PMR
masking/unmasking, only enable pseudo-NMIs when GIC has non-secure view
of priorities.

Also, add firmware requirements related to SCR_EL3.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/arm64/booting.txt |  5 ++++
 drivers/irqchip/irq-gic-v3.c    | 58 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
index 8d0df62..e387938 100644
--- a/Documentation/arm64/booting.txt
+++ b/Documentation/arm64/booting.txt
@@ -188,6 +188,11 @@ Before jumping into the kernel, the following conditions must be met:
   the kernel image will be entered must be initialised by software at a
   higher exception level to prevent execution in an UNKNOWN state.
 
+  - SCR_EL3.FIQ must have the same value across all CPUs the kernel is
+    executing on.
+  - The value of SCR_EL3.FIQ must be the same as the one present at boot
+    time whenever the kernel is executing.
+
   For systems with a GICv3 interrupt controller to be used in v3 mode:
   - If EL3 is present:
     ICC_SRE_EL3.Enable (bit 3) must be initialiased to 0b1.
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 4fad03d..f833842 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -63,6 +63,31 @@ struct gic_chip_data {
 static struct gic_chip_data gic_data __read_mostly;
 static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
 
+/*
+ * The behaviours of RPR and PMR registers differ depending on the value of
+ * SCR_EL3.FIQ, and the behaviour of non-secure priority registers of the
+ * distributor and redistributors depends on whether security is enabled in the
+ * GIC.
+ *
+ * When security is enabled, non-secure priority values from the (re)distributor
+ * are presented to the GIC CPUIF as follow:
+ *     (GIC_(R)DIST_PRI[irq] >> 1) | 0x80;
+ *
+ * If SCR_EL3.FIQ == 1, the values writen to/read from PMR and RPR at non-secure
+ * EL1 are subject to a similar operation thus matching the priorities presented
+ * from the (re)distributor when security is enabled.
+ *
+ * see GICv3/GICv4 Architecture Specification (IHI0069D):
+ * - section 4.8.1 Non-secure accesses to register fields for Secure interrupt
+ *   priorities.
+ * - Figure 4-7 Secure read of the priority field for a Non-secure Group 1
+ *   interrupt.
+ *
+ * For now, we only support pseudo-NMIs if we have non-secure view of
+ * priorities.
+ */
+static DEFINE_STATIC_KEY_FALSE(supports_pseudo_nmis);
+
 static struct gic_kvm_info gic_v3_kvm_info;
 static DEFINE_PER_CPU(bool, has_rss);
 
@@ -226,6 +251,12 @@ static void gic_unmask_irq(struct irq_data *d)
 	gic_poke_irq(d, GICD_ISENABLER);
 }
 
+static inline bool gic_supports_nmi(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) &&
+	       static_branch_likely(&supports_pseudo_nmis);
+}
+
 static int gic_irq_set_irqchip_state(struct irq_data *d,
 				     enum irqchip_irq_state which, bool val)
 {
@@ -567,6 +598,12 @@ static void gic_update_vlpi_properties(void)
 		!gic_data.rdists.has_direct_lpi ? "no " : "");
 }
 
+/* Check whether it's single security state view */
+static inline bool gic_dist_security_disabled(void)
+{
+	return readl_relaxed(gic_data.dist_base + GICD_CTLR) & GICD_CTLR_DS;
+}
+
 static void gic_cpu_sys_reg_init(void)
 {
 	int i, cpu = smp_processor_id();
@@ -592,6 +629,9 @@ static void gic_cpu_sys_reg_init(void)
 	/* Set priority mask register */
 	if (!gic_prio_masking_enabled())
 		write_gicreg(DEFAULT_PMR_VALUE, ICC_PMR_EL1);
+	else if (gic_supports_nmi() && group0)
+		/* Mismatch configuration with boot CPU */
+		WARN_ON(!gic_dist_security_disabled());
 
 	/*
 	 * Some firmwares hand over to the kernel with the BPR changed from
@@ -846,12 +886,6 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 #endif
 
 #ifdef CONFIG_CPU_PM
-/* Check whether it's single security state view */
-static bool gic_dist_security_disabled(void)
-{
-	return readl_relaxed(gic_data.dist_base + GICD_CTLR) & GICD_CTLR_DS;
-}
-
 static int gic_cpu_pm_notifier(struct notifier_block *self,
 			       unsigned long cmd, void *v)
 {
@@ -1095,6 +1129,11 @@ static int partition_domain_translate(struct irq_domain *d,
 	.select = gic_irq_domain_select,
 };
 
+static void gic_enable_nmi_support(void)
+{
+	static_branch_enable(&supports_pseudo_nmis);
+}
+
 static int __init gic_init_bases(void __iomem *dist_base,
 				 struct redist_region *rdist_regs,
 				 u32 nr_redist_regions,
@@ -1164,6 +1203,13 @@ static int __init gic_init_bases(void __iomem *dist_base,
 		its_cpu_init();
 	}
 
+	if (gic_prio_masking_enabled()) {
+		if (!gic_has_group0() || gic_dist_security_disabled())
+			gic_enable_nmi_support();
+		else
+			pr_warn("SCR_EL3.FIQ is cleared, cannot enable use of pseudo-NMIs\n");
+	}
+
 	return 0;
 
 out_free:
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
