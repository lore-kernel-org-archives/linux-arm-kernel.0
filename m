Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C178C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:42:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31052206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bKZWGqmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31052206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=SuWaX4RpSYQMsZ2cgmGvsFqJhelbM4Guv+Yd1hAheLU=; b=bKZWGqmRoZcF41
	Uzb7ITJXFUHqNqp5cFcRbDveCo8iRBLKJgeoLouH/vpH7qxWN392BGwTqGlPOcfbY85YsSEtmkoih
	OzLfCyPdPRTgPp+mtMAasmArotDezZgH8CE/D+dHh2hgNSUWdLhhw/cuzjCjjkYNVdOte0aIjq4Er
	krBEey721Hv7UIWhH9LmB5ItuKC6MkQc2TTjmN+u9Q3HPb86Bm8enOXy9+uKVKnt8BztO9s2vnQC2
	LOoWLN0K9YUYujkdAI7pLTDy2/aap6RGetS4+Vb7JJM5ZnvlDbN2Ch6o8K1Nl9FIfKTamd3rEyoen
	nq46jO2qw2Wzkke/SCYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghfHN-0002uw-HS; Thu, 10 Jan 2019 18:42:09 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghfHK-0002uJ-DA
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 18:42:07 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74C8B1596;
 Thu, 10 Jan 2019 10:42:02 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 822E43F694;
 Thu, 10 Jan 2019 10:42:00 -0800 (PST)
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH] ACPI/IORT: Fix rc_dma_get_range()
Date: Thu, 10 Jan 2019 18:41:51 +0000
Message-Id: <20190110184151.27492-1-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_104206_448751_030A611B 
X-CRM114-Status: GOOD (  11.69  )
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
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Eric Auger <eric.auger@redhat.com>,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

When executed for a PCI_ROOT_COMPLEX type, iort_match_node_callback()
expects the opaque pointer argument to be a PCI bus device. At the
moment rc_dma_get_range() passes the PCI endpoint instead of the bus,
and we've been lucky to have pci_domain_nr(ptr) return 0 instead of
crashing. Pass the bus device to iort_scan_node().

Fixes: 5ac65e8c8941 ("ACPI/IORT: Support address size limit for root complexes")
Reported-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Cc: stable@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
Will, Catalin,

resending a reformatted version of this fix previously posted in [1],
please merge it for one of the upcoming -rc.

Thanks,
Lorenzo

[1] https://marc.info/?l=linux-acpi&m=154712742324811&w=2

 drivers/acpi/arm64/iort.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index fdd90ffceb85..c08afe44c488 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -952,9 +952,10 @@ static int rc_dma_get_range(struct device *dev, u64 *size)
 {
 	struct acpi_iort_node *node;
 	struct acpi_iort_root_complex *rc;
+	struct pci_bus *pbus = to_pci_dev(dev)->bus;
 
 	node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
-			      iort_match_node_callback, dev);
+			      iort_match_node_callback, &pbus->dev);
 	if (!node || node->revision < 1)
 		return -ENODEV;
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
