Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C205C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:11:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E40C20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TY+wNvxZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E40C20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iIA/fIZHRbwBN8lqcRm7OLj5u3KpLEbCxZ1ahhiYEOM=; b=TY+wNvxZbTChh6
	KshumGmrMmGwhS+VQ+X0NvNZp03MvuMqWp3A5yX+fi0KzizqS5jzZ3DeXd482dzK9LGIYJD0lkSA3
	BeLwxopN0Snu2Qmh7mRqQ+vPSGB+G5csfpBoCWO+hhXAHjlU2s0RGd5hETTyng/SiupUH31wwRsCe
	l/n5ddP8W06M8YwOMEEXBYR1pNosGhhJ+XQyX0t03lf/oYnk9WM5lcp/vAVJlYVovFU3OOacK5mbZ
	1+PIgyChEzKDIR2TuoHx1EMoIVNtGtkMZAFOiuzjoT5biMRt/kbfBaytaoOko60JDdNhxDXzDkJIb
	STSMPAM/Atn2lD+vqFpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXnFq-0000jX-7A; Fri, 14 Dec 2018 13:11:46 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXnFm-0000iB-9z
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 13:11:43 +0000
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 609CF8DC1C50C;
 Fri, 14 Dec 2018 21:11:32 +0800 (CST)
Received: from FRA1000014316.huawei.com (100.126.230.97) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Fri, 14 Dec 2018 21:11:24 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-pci@vger.kernel.org>
Subject: [RFC PATCH 1/2] pci/portdrv: Allow for vendor defined performance
 monitoring units.
Date: Fri, 14 Dec 2018 21:10:54 +0800
Message-ID: <20181214131055.52253-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181214131055.52253-1-Jonathan.Cameron@huawei.com>
References: <20181214131055.52253-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [100.126.230.97]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_051142_521928_259C52AD 
X-CRM114-Status: GOOD (  13.56  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Shaokun Zhang <zhangshaokun@hisilicon.com>, Will Deacon <will.deacon@arm.com>,
 linuxarm@huawei.com, Keith Busch <keith.busch@intel.com>,
 Zhou Wang <wangzhou1@hisilicon.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When originally introduced (and still in the docs) it was possible to have
drivers matched by HID, now it isn't so this is a bit ugly in that it will
call any registered PMU driver.

How would people prefer this was done?

* Drop the association with the port and handle as uncore.
  Whilst the driver that follows is not in config space, it is likely that
  future PMU units will use DVSEC (in PCI config space) and so this option
  won't really be available.

* Put a full subsystem style driver matching layer in here.
  Moderately simple to do do and well understood.

Right now this code is a hack to get the conversation going!

It would be nice if there was a standard PCIe PMU specification but whilst
there isn't, everyone will end up doing it differently...

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/portdrv.h      | 4 +++-
 drivers/pci/pcie/portdrv_core.c | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index e495f04394d0..64315713a93d 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -20,8 +20,10 @@
 #define PCIE_PORT_SERVICE_HP		(1 << PCIE_PORT_SERVICE_HP_SHIFT)
 #define PCIE_PORT_SERVICE_DPC_SHIFT	3	/* Downstream Port Containment */
 #define PCIE_PORT_SERVICE_DPC		(1 << PCIE_PORT_SERVICE_DPC_SHIFT)
+#define PCIE_PORT_SERVICE_PMU_SHIFT	4	/* Vendor defined Perf Units */
+#define PCIE_PORT_SERVICE_PMU		(1 << PCIE_PORT_SERVICE_PMU_SHIFT)
 
-#define PCIE_PORT_DEVICE_MAXSERVICES   4
+#define PCIE_PORT_DEVICE_MAXSERVICES   5
 
 #ifdef CONFIG_PCIEAER
 int pcie_aer_init(void);
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index f458ac9cb70c..c032896a9ab1 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -250,6 +250,8 @@ static int get_port_device_capability(struct pci_dev *dev)
 	    pci_aer_available() && services & PCIE_PORT_SERVICE_AER)
 		services |= PCIE_PORT_SERVICE_DPC;
 
+	services |= PCIE_PORT_SERVICE_PMU;
+
 	return services;
 }
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
