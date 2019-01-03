Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51065C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:51:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EC5520815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dfZbb9TL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC5520815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=SiF2osGhVPdgGhrO2it4J2wBw+/hcWQ+8R3PS05O3tM=; b=dfZbb9TLhouH+6HXKKAylne7fV
	1qXMDh+NJutJozXHocVtkQatiRkwQGefdoLp2vph4qukBmN1te91S8eBcQUW6s4iFn2fDXXdC2Xqy
	4Tw9tsWjpURVDGqDFM4BLXHWxsegkBVJT3vNknUophSjQijQ4cpglTBphwVj33tkfgBocoKEkscOG
	b11xA1GOEsgLq19XNKXXS6WL7pckapMdVR8JogNS6dswPE8YbPWcKcH1RWAD185hBI+JeFRaG+CQJ
	2Xtdoa4KEDoTHhBneH8v33wwpNFbgo2vPgecNFKtEKFt2L4ll/S6cxV9o83cVcCNjo8735WEenl03
	yE/WPmbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gerDw-0003QE-TY; Thu, 03 Jan 2019 00:51:00 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gerCd-0000tg-9X
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 00:49:46 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17BFA1596;
 Wed,  2 Jan 2019 16:49:39 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com
 [10.118.12.119])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 415EF3F5AF;
 Wed,  2 Jan 2019 16:49:38 -0800 (PST)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 6/7] arm64: add sysfs vulnerability show for speculative
 store bypass
Date: Wed,  2 Jan 2019 18:49:20 -0600
Message-Id: <20190103004921.1928921-7-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190103004921.1928921-1-jeremy.linton@arm.com>
References: <20190103004921.1928921-1-jeremy.linton@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_164939_835869_0790103D 
X-CRM114-Status: GOOD (  10.68  )
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
Cc: mark.rutland@arm.com, mlangsdo@redhat.com, suzuki.poulose@arm.com,
 marc.zyngier@arm.com, catalin.marinas@arm.com, julien.thierry@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org,
 Jeremy Linton <jeremy.linton@arm.com>, steven.price@arm.com, ykaukab@suse.de,
 dave.martin@arm.com, shankerd@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Mian Yousaf Kaukab <ykaukab@suse.de>

Return status based on ssbd_state and the arm64 SSBS feature.
Return string "Unknown" in case CONFIG_ARM64_SSBD is disabled
or arch workaround2 is not available in the firmware.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
[Added SSBS logic]
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/cpu_errata.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 96a55accefa9..c962b5856c87 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -420,6 +420,7 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
 		ssbd_state = ARM64_SSBD_UNKNOWN;
 		return false;
 
+	/* machines with mixed mitigation requirements must not return this */
 	case SMCCC_RET_NOT_REQUIRED:
 		pr_info_once("%s mitigation not required\n", entry->desc);
 		ssbd_state = ARM64_SSBD_MITIGATED;
@@ -810,4 +811,31 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
 	}
 }
 
+ssize_t cpu_show_spec_store_bypass(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	/*
+	 *  Two assumptions: First, get_ssbd_state() reflects the worse case
+	 *  for hetrogenous machines, and that if SSBS is supported its
+	 *  supported by all cores.
+	 */
+	switch (arm64_get_ssbd_state()) {
+	case ARM64_SSBD_MITIGATED:
+		return sprintf(buf, "Not affected\n");
+
+	case ARM64_SSBD_KERNEL:
+	case ARM64_SSBD_FORCE_ENABLE:
+		if (cpus_have_cap(ARM64_SSBS))
+			return sprintf(buf, "Not affected\n");
+		return sprintf(buf,
+			"Mitigation: Speculative Store Bypass disabled\n");
+
+	case ARM64_SSBD_FORCE_DISABLE:
+		return sprintf(buf, "Vulnerable\n");
+
+	default: /* ARM64_SSBD_UNKNOWN*/
+		return sprintf(buf, "Unknown\n");
+	}
+}
+
 #endif
-- 
2.17.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
