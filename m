Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E01C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:32:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22DF520837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qut1ZhZr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DF520837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U8EFeBhbMXMUpbxB5xjMTsdjlpFYP0IpCEMTOAKPYn0=; b=Qut1ZhZrMr6o/k
	Lag6ehJO5w9gH68oA4KpJgM2pSJfAMQfVvxrzZUrSjzw4Ivn4cbUcPMDYPxH3TMPsaniBE0deJkXz
	/IeRtWpHOGR4SqF3ZAJeo7Fqozp8WqzNyjECPX0mh8GxhDNpnYBaqSaLZnvkBaVK0hvvo3mQ97TVY
	4jqgPpKSKYa3cZzeiY8hj1zyHFDsyvWVloRn7X0M5P20GiGFtdNXPn/GF+oBvOZP7VTjxuCpXWEK6
	gcvPtHGnp7HLeTYQgJ00dmoMJrIxZ80Gte01KSjaPyBSwUR/eFo3mtNAHLJBDnOaGBDXx6oRTucdi
	vVgJ1JwCFvwPPTpmOv/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVJ2k-0007jG-24; Fri, 07 Dec 2018 16:31:58 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVJ2g-0007gd-Bb
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 16:31:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7014315BE;
 Fri,  7 Dec 2018 08:31:48 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
 [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 394FF3F575;
 Fri,  7 Dec 2018 08:31:46 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: hch@lst.de
Subject: [PATCH 2/2] ACPI / scan: Refactor _CCA enforcement
Date: Fri,  7 Dec 2018 16:31:35 +0000
Message-Id: <fe956f04bfe7f8293f6205ee224b087046e40a91.1544199754.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.1.dirty
In-Reply-To: <cover.1544199754.git.robin.murphy@arm.com>
References: <cover.1544199754.git.robin.murphy@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_083154_433191_D005F232 
X-CRM114-Status: GOOD (  17.41  )
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
Cc: linux-pci@vger.kernel.org, catalin.marinas@arm.com, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, will.deacon@arm.com, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, gregkh@linuxfoundation.org,
 bhelgaas@google.com, lenb@kernel.org, linux-arm-kernel@lists.infradead.org,
 m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Rather than checking the DMA attribute at each callsite, just pass it
through for acpi_dma_configure() to handle directly. That can then deal
with the relatively exceptional DEV_DMA_NOT_SUPPORTED case by explicitly
installing dummy DMA ops instead of just skipping setup entirely. This
will then free up the dev->dma_ops == NULL case for some valuable
fastpath optimisations.

CC: Rafael J. Wysocki <rjw@rjwysocki.net>
CC: Len Brown <lenb@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/acpi/scan.c      | 5 +++++
 drivers/base/platform.c  | 3 +--
 drivers/pci/pci-driver.c | 3 +--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index bd1c59fb0e17..b75ae34ed188 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1456,6 +1456,11 @@ int acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
 	const struct iommu_ops *iommu;
 	u64 dma_addr = 0, size = 0;
 
+	if (attr == DEV_DMA_NOT_SUPPORTED) {
+		set_dma_ops(dev, &dma_dummy_ops);
+		return 0;
+	}
+
 	iort_dma_setup(dev, &dma_addr, &size);
 
 	iommu = iort_iommu_configure(dev);
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 41b91af95afb..c6daca875c17 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1138,8 +1138,7 @@ int platform_dma_configure(struct device *dev)
 		ret = of_dma_configure(dev, dev->of_node, true);
 	} else if (has_acpi_companion(dev)) {
 		attr = acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
-		if (attr != DEV_DMA_NOT_SUPPORTED)
-			ret = acpi_dma_configure(dev, attr);
+		ret = acpi_dma_configure(dev, attr);
 	}
 
 	return ret;
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index bef17c3fca67..f899a28b90f8 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1602,8 +1602,7 @@ static int pci_dma_configure(struct device *dev)
 		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
 		enum dev_dma_attr attr = acpi_get_dma_attr(adev);
 
-		if (attr != DEV_DMA_NOT_SUPPORTED)
-			ret = acpi_dma_configure(dev, attr);
+		ret = acpi_dma_configure(dev, attr);
 	}
 
 	pci_put_host_bridge_device(bridge);
-- 
2.19.1.dirty


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
