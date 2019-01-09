Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3769AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:56:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F09214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PndL8UiJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F09214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=GV+/tRvzp+paqmRtucWCjE6kLQ71L9i5/1j9yFrQeKE=; b=PndL8UiJ3bXXkGZA5Ub1JQkeWI
	h9IpuYxKWQ/+M4jLOWtokMlGNhU+j7318wPjGiJtvl6Pucp8zQugA4huprserhNZuCCkvPfjvx03S
	Vn1Txq5x8WHLHTWaE0iDsN9APp24o3iwKhL091hEDoicGSSfZFNwVzInyE1zUxNRVXc10mOrQOUfr
	caOcq0trvp8NTYxTaxvflVHu7BVWq4BkOhJlydcB+NCbAMaJL2tjkx5G7yS+IrVCtpF7zGwCgViFT
	5jEIwIP5RbdOrEyacItqlsQYCDcPfSxfjUx4UFlie7ZilOkwbJ6JUQ+xSGulxJIe/0jcwRH5tfspt
	XdxQyzAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghNhv-0006S6-6F; Wed, 09 Jan 2019 23:56:23 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghNhR-0005xa-IN
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 23:55:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE8C9EBD;
 Wed,  9 Jan 2019 15:55:50 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com
 [10.118.12.119])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 019CC3F5AF;
 Wed,  9 Jan 2019 15:55:49 -0800 (PST)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/7] sysfs/cpu: Allow individual architectures to select
 vulnerabilities
Date: Wed,  9 Jan 2019 17:55:38 -0600
Message-Id: <20190109235544.2992426-2-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190109235544.2992426-1-jeremy.linton@arm.com>
References: <20190109235544.2992426-1-jeremy.linton@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_155553_669342_9DDB6C2B 
X-CRM114-Status: GOOD (  14.25  )
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
Cc: mlangsdo@redhat.com, "Rafael J . Wysocki" <rafael@kernel.org>,
 catalin.marinas@arm.com, will.deacon@arm.com, Ingo Molnar <mingo@kernel.org>,
 stefan.wahren@i2se.com, Andi Kleen <ak@linux.intel.com>,
 julien.thierry@arm.com, steven.price@arm.com, Waiman Long <longman@redhat.com>,
 dave.martin@arm.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
 ykaukab@suse.de, Josh Poimboeuf <jpoimboe@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, shankerd@codeaurora.org,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jiri Kosina <jkosina@suse.cz>,
 linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

As suggested on the list, https://lkml.org/lkml/2019/1/4/282, there are
a number of cases where its useful for a system to avoid exporting a
sysfs entry for a given vulnerability. This set adds an architecture
specific callback which returns the bitmap of vulnerabilities the
architecture would like to advertise.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Kosina <jkosina@suse.cz>
---
 drivers/base/cpu.c  | 19 +++++++++++++++++++
 include/linux/cpu.h |  7 +++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index eb9443d5bae1..35f6dfb24cd6 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -561,6 +561,11 @@ static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	NULL
 };
 
+uint __weak arch_supported_vuln_attr_fields(void)
+{
+	return VULN_MELTDOWN|VULN_SPECTREV1|VULN_SPECTREV2|VULN_SSB|VULN_L1TF;
+}
+
 static const struct attribute_group cpu_root_vulnerabilities_group = {
 	.name  = "vulnerabilities",
 	.attrs = cpu_root_vulnerabilities_attrs,
@@ -568,6 +573,20 @@ static const struct attribute_group cpu_root_vulnerabilities_group = {
 
 static void __init cpu_register_vulnerabilities(void)
 {
+	int fld;
+	int max_fields = ARRAY_SIZE(cpu_root_vulnerabilities_attrs) - 1;
+	struct attribute **hd = cpu_root_vulnerabilities_attrs;
+	uint enabled_fields = arch_supported_vuln_attr_fields();
+
+	/* only enable entries requested by the arch code */
+	for (fld = 0; fld < max_fields; fld++) {
+		if (enabled_fields & 1 << fld) {
+			*hd = cpu_root_vulnerabilities_attrs[fld];
+			hd++;
+		}
+	}
+	*hd = NULL;
+
 	if (sysfs_create_group(&cpu_subsys.dev_root->kobj,
 			       &cpu_root_vulnerabilities_group))
 		pr_err("Unable to register CPU vulnerabilities\n");
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 218df7f4d3e1..5e45814bcc24 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -189,4 +189,11 @@ static inline void cpu_smt_check_topology_early(void) { }
 static inline void cpu_smt_check_topology(void) { }
 #endif
 
+/* generic cpu vulnerability attributes */
+#define VULN_MELTDOWN  0x01
+#define VULN_SPECTREV1 0x02
+#define VULN_SPECTREV2 0x04
+#define VULN_SSB       0x08
+#define VULN_L1TF      0x10
+
 #endif /* _LINUX_CPU_H_ */
-- 
2.17.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
