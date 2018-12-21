Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50916C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:22:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C3F218FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MUWdnRYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C3F218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=AR/mVFXenW6goKxcektkqy6hJgkZ8mGHpBQThVQuN+U=; b=MUWdnRYjcng1pq9+/bgSXvilqW
	tPt6iHFNNS1vAMcyjx51KPX/n8gXtgm03H2wlnDhR9VkymSMtja3xHwRjCQ+MQJZg5h8OBXlZyfi2
	+FBW9oSo2VkBfnTwK6WkAiZvReBqurWYClhWuBb6Hh1t5XE0ZA7NUxJ9VTfkRUVOmFcnsV+rN0Gng
	gzQE3rw2TwpgxUtDFrZVC7+ZxBTYTT0Y2uE73e7/tlR+oXiVV9IZo9xSukI9yDOIo+XFXyPB90jk8
	8ReFSZjMnOV3MNP/1oru7iY9OINPvqUwrMGreslgDMS7XZiS48YDUla/Wn/xrs/RxdiYTJQvqZqOw
	2Tj+M6MA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga8aT-0000C2-Sm; Fri, 21 Dec 2018 00:22:45 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga8ZJ-0007MB-Ma
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 00:21:35 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Dec 2018 16:21:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,379,1539673200"; d="scan'208";a="112251095"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
 by orsmga003.jf.intel.com with ESMTP; 20 Dec 2018 16:21:25 -0800
From: thor.thayer@linux.intel.com
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
 dinguyen@kernel.org, arnd@arndb.de, linux@armlinux.org.uk,
 catalin.marinas@arm.com, will.deacon@arm.com, peppe.cavallaro@st.com,
 alexandre.torgue@st.com, joabreu@synopsys.com
Subject: [PATCHv2 5/6] net: stmmac: socfpga: Use shared System Manager driver
Date: Thu, 20 Dec 2018 18:23:21 -0600
Message-Id: <1545351802-4354-6-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545351802-4354-1-git-send-email-thor.thayer@linux.intel.com>
References: <1545351802-4354-1-git-send-email-thor.thayer@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_162133_780094_E35EE432 
X-CRM114-Status: GOOD (  11.09  )
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
Cc: devicetree@vger.kernel.org, Thor Thayer <thor.thayer@linux.intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bjorn.andersson@linaro.org, olof@lixom.net, mcoquelin.stm32@gmail.com,
 mchehab+samsung@kernel.org, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

The ARM64 System Manager requires a different method of reading
the System Manager than ARM32. A new System Manager driver was
created to steer ARM32 System Manager calls to regmap_mmio and
ARM64 System Manager calls to the new access method.

Convert from syscon to the shared System Manager driver so that
both ARM64 and ARM32 are supported.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
v2  No change to code. Update commit message.
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 5b3b06a0a3bf..743c7f471edb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -15,6 +15,7 @@
  * Adopted from dwmac-sti.c
  */
 
+#include <linux/mfd/altera-sysmgr.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -114,7 +115,8 @@ static int socfpga_dwmac_parse_data(struct socfpga_dwmac *dwmac, struct device *
 
 	dwmac->interface = of_get_phy_mode(np);
 
-	sys_mgr_base_addr = syscon_regmap_lookup_by_phandle(np, "altr,sysmgr-syscon");
+	sys_mgr_base_addr =
+		altr_sysmgr_regmap_lookup_by_phandle(np, "altr,sysmgr-syscon");
 	if (IS_ERR(sys_mgr_base_addr)) {
 		dev_info(dev, "No sysmgr-syscon node found\n");
 		return PTR_ERR(sys_mgr_base_addr);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
