Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E4AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:05:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A9EE2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SXaK3hwR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9EE2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=OGzEh02REdXO50df00PBsI4nxKfEWC3fLbDdmDenIPM=; b=SXa
	K3hwRP0miP1NjV/nxCVxNiAZYEN8vmH9I5hUNvmQPML5FgVO81wfxfx3wchq0VlUllfRGuKaqBoLL
	D2dbbIWc/G5SjoIO1vIo0/ZYzQnFHR2l0a7zf5XpoQCSf6Mp5N9uofzOPTp75hvLLEnONs63OosX3
	bDnvKe7S89kC8YImOFOycM3DutV54dKEoUgYrEP0P8PXvmflMAuEgNFwTw5b5Ha0TrSEawA518vaI
	1ifTjYb4T5qcqx0XZQ/Lr8tZUS0AgjcMI/AhSltdBJGSyOFDR2Npu+PgniGULPjo9IJ9zDllqqFnc
	6DDj7hYvWv0dRYYu5h7m9wxy916TRFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxCNm-0005zQ-Sv; Fri, 22 Feb 2019 15:04:58 +0000
Received: from inva020.nxp.com ([92.121.34.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxCNG-0005PE-HG
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 15:04:29 +0000
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D70651A01A7;
 Fri, 22 Feb 2019 16:04:20 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CAE161A01A6;
 Fri, 22 Feb 2019 16:04:20 +0100 (CET)
Received: from fsr-ub1664-016.ea.freescale.net
 (fsr-ub1664-016.ea.freescale.net [10.171.71.216])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 6608C2062B;
 Fri, 22 Feb 2019 16:04:20 +0100 (CET)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
 "David S . Miller" <davem@davemloft.net>
Subject: [PATCH net-next v3 0/4] enetc: Add mdio support and device tree nodes
Date: Fri, 22 Feb 2019 17:04:15 +0200
Message-Id: <1550847859-17346-1-git-send-email-claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_070426_732859_3A2F4A4E 
X-CRM114-Status: UNSURE (   8.54  )
X-CRM114-Notice: Please train this message.
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
Cc: devicetree@vger.kernel.org, alexandru.marginean@nxp.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This is the missing part to enable PCI probing of the ENETC ethernet
ports on the LS1028A SoC and external traffic on the LS1028A RDB board.
It's one of the first items on the TODO list for the recently merged
ENETC ethernet driver.

v3: Add DT bindings doc for ENETC connections

Claudiu Manoil (4):
  arm64: dts: fsl: ls1028a: Add PCI IERC node and ENETC endpoints
  arm64: dts: fsl: ls1028a-rdb: Add ENETC external eth ports for the
    LS1028A RDB board
  enetc: Add ENETC PF level external MDIO support
  dt-bindings: net: freescale: enetc: Add connection bindings for ENETC
    ethernet nodes

 .../devicetree/bindings/net/fsl-enetc.txt          | 109 +++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts  |  17 ++
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi     |  33 ++++
 drivers/net/ethernet/freescale/enetc/Makefile      |   3 +-
 drivers/net/ethernet/freescale/enetc/enetc_mdio.c  | 199 +++++++++++++++++++++
 drivers/net/ethernet/freescale/enetc/enetc_pf.c    |  12 ++
 drivers/net/ethernet/freescale/enetc/enetc_pf.h    |   6 +
 7 files changed, 378 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/fsl-enetc.txt
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_mdio.c

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
