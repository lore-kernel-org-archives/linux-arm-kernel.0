Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16852C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:47:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7B4F20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JZLB6jsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B4F20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=1bhhabKD1YU+fqS55gzEp8HTTWfC7dThRDTEJ+9QZyM=; b=JZLB6jsE9yvQZM6TcPui7kW19T
	Xus80nKsPd/9iDD/Uggp9LNpH5gh9cypYyVTDAxsKSHvZbUAtGYnHjAsc/PCbRa/VaLy2AP2ICg2B
	rImR+b1MDEjRkxk4mCpDZEq7OPnmX5GN8QUOKlpD95e8lBIsgxSdjXD3eZIV7/um2QceKgHZrBfS/
	h4FV3CKYkVBOpIZJQovCvvFRPcp3ADS81+S9BExOSZlgH/ONi0ci30j0s9dYQHTzIuByn83B2ACkz
	8czDzpFMo1NDtKivwtHT/dFPKHjwFzeSkgZuCg891Kllf1/4qrt43gHZG8AhUfovoFCW4vuiAY3jM
	WjMJNJeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsGo5-0005mu-Lk; Sat, 09 Feb 2019 00:47:45 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsGns-0005d0-0n
 for linux-arm-kernel@lists.infradead.org; Sat, 09 Feb 2019 00:47:33 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8060A1650;
 Fri,  8 Feb 2019 16:47:31 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com
 [10.118.12.119])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EAFD43F719;
 Fri,  8 Feb 2019 16:47:30 -0800 (PST)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [RFC 2/3] arm_pmu: acpi: spe: Add initial MADT/SPE probing
Date: Fri,  8 Feb 2019 18:47:17 -0600
Message-Id: <20190209004718.3292087-3-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190209004718.3292087-1-jeremy.linton@arm.com>
References: <20190209004718.3292087-1-jeremy.linton@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_164732_146360_072B2F53 
X-CRM114-Status: GOOD (  15.09  )
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
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, rafael.j.wysocki@intel.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org,
 Jeremy Linton <jeremy.linton@arm.com>, robert.moore@intel.com,
 linux-acpi@vger.kernel.org, lenb@kernel.org, erik.schmauss@intel.com,
 devel@acpica.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

ACPI 6.3 adds additional fields to the MADT GICC
structure to describe SPE PPI's. We pick these out
of the cached reference to the madt_gicc structure
similarly to the core PMU code. We then create a platform
device referring to the IRQ and let the user/module loader
decide whether to load the SPE driver.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/include/asm/acpi.h |  3 ++
 drivers/perf/arm_pmu_acpi.c   | 67 +++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 2def77ec14be..f9f9f2eb5d54 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -40,6 +40,9 @@
 	(!(entry) || (entry)->header.length < ACPI_MADT_GICC_MIN_LENGTH || \
 	(unsigned long)(entry) + (entry)->header.length > (end))
 
+#define ACPI_MADT_GICC_SPE  (ACPI_OFFSET(struct acpi_madt_generic_interrupt, \
+	spe_overflow_interrupt) + sizeof(u16))
+
 /* Basic configuration for ACPI */
 #ifdef	CONFIG_ACPI
 pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index 0f197516d708..725d413b47dc 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -74,6 +74,71 @@ static void arm_pmu_acpi_unregister_irq(int cpu)
 	acpi_unregister_gsi(gsi);
 }
 
+static struct resource spe_resources[] = {
+	{
+		/* irq */
+		.flags          = IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device spe_dev = {
+	.name = "arm,spe-v1",
+	.id = -1,
+	.resource = spe_resources,
+	.num_resources = ARRAY_SIZE(spe_resources)
+};
+
+/*
+ * For lack of a better place, hook the normal PMU MADT walk
+ * and create a SPE device if we detect a recent MADT with
+ * a homogeneous PPI mapping.
+ */
+static int arm_spe_acpi_parse_irqs(void)
+{
+	int cpu, ret, irq;
+	u16 gsi = 0;
+	bool first = true;
+
+	struct acpi_madt_generic_interrupt *gicc;
+
+	/*
+	 * sanity check all the GICC tables for the same interrupt number
+	 * for now we only support homogeneous ACPI/SPE machines.
+	 */
+	for_each_possible_cpu(cpu) {
+		gicc = acpi_cpu_get_madt_gicc(cpu);
+
+		if (gicc->header.length < ACPI_MADT_GICC_SPE)
+			return -ENODEV;
+
+		if (first) {
+			gsi = gicc->spe_overflow_interrupt;
+			if (!gsi)
+				return -ENODEV;
+			first = false;
+		} else if (gsi != gicc->spe_overflow_interrupt) {
+			pr_warn("ACPI: SPE must have homogeneous interrupts\n");
+			return -EINVAL;
+		}
+	}
+
+	irq = acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE,
+				ACPI_ACTIVE_HIGH);
+	if (irq < 0) {
+		pr_warn("ACPI: SPE Unable to register interrupt: %d\n", gsi);
+		return irq;
+	}
+
+	spe_resources[0].start = irq;
+	ret = platform_device_register(&spe_dev);
+	if (ret < 0) {
+		pr_warn("ACPI: SPE: Unable to register device\n");
+		acpi_unregister_gsi(gsi);
+	}
+
+	return ret;
+}
+
 static int arm_pmu_acpi_parse_irqs(void)
 {
 	int irq, cpu, irq_cpu, err;
@@ -279,6 +344,8 @@ static int arm_pmu_acpi_init(void)
 	if (acpi_disabled)
 		return 0;
 
+	arm_spe_acpi_parse_irqs(); /* failures are expected */
+
 	ret = arm_pmu_acpi_parse_irqs();
 	if (ret)
 		return ret;
-- 
2.17.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
