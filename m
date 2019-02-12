Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83D1C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:54:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A84A2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Eie36M7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A84A2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lBZQ+H13akmp21InqWnOJQvQ6HrsEiP4AtkaHLH8vTw=; b=Eie36M7Lg0xCL4
	VaTzql/mPiCmiG26I6DMyeJUH59Ofg05txXH5FXV/VH7weNbExaJ2Ze5TwpNYiODbf9dXgqGNvw+F
	GpKUqt2A/Jio2jU4h/mNaoKBJcXI0msm2PGFffyLYFkB9YrUaY2P4ls53vnZsPaqlifNK1JqX+Iuu
	uf4vVHVCeykE5bWFFojFin2Or0Jus0/00nPNjeTSD3ZuWGB9DEiwzakQpHx8ZGFCr4rak7vTnPRwE
	vzMLgddSGeIvTX68iexI5o4Fs1KprX1S2dHWjRvbrpTvPOKGngSN2GRZAAyef+N8jiYAD7JpB8F7S
	uBruF+tiai9nGVxnc3Ww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtYVk-0007aA-TL; Tue, 12 Feb 2019 13:54:08 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtYTr-0005oV-Jh
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 13:52:16 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1CDpQBY020422; Tue, 12 Feb 2019 14:52:05 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qhurj0jdf-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Tue, 12 Feb 2019 14:52:05 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 04CA472;
 Tue, 12 Feb 2019 13:52:05 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag4node2.st.com [10.75.127.11])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D45E85127;
 Tue, 12 Feb 2019 13:52:04 +0000 (GMT)
Received: from localhost (10.75.127.49) by SFHDAG4NODE2.st.com (10.75.127.11)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2;
 Tue, 12 Feb 2019 14:52:04 +0100
From: <gabriel.fernandez@st.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@st.com>
Subject: [PATCH 5/7] clk: stm32mp1: fix HSI divider flag
Date: Tue, 12 Feb 2019 14:51:52 +0100
Message-ID: <20190212135154.2733-6-gabriel.fernandez@st.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190212135154.2733-1-gabriel.fernandez@st.com>
References: <20190212135154.2733-1-gabriel.fernandez@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-12_08:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_055212_288105_EFFCF3AA 
X-CRM114-Status: UNSURE (   9.88  )
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
Cc: Gabriel Fernandez <gabriel.fernandez@st.com>, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

The divider of HSI (clk-hsi-div) is power of two divider.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 385dac678a7f..863586a71d49 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -1656,8 +1656,8 @@ static const struct stm32_mux_cfg ker_mux_cfg[M_LAST] = {
 
 static const struct clock_config stm32mp1_clock_cfg[] = {
 	/* Oscillator divider */
-	DIV(NO_ID, "clk-hsi-div", "clk-hsi", 0, RCC_HSICFGR, 0, 2,
-	    CLK_DIVIDER_READ_ONLY),
+	DIV(NO_ID, "clk-hsi-div", "clk-hsi", CLK_DIVIDER_POWER_OF_TWO,
+	    RCC_HSICFGR, 0, 2, CLK_DIVIDER_READ_ONLY),
 
 	/*  External / Internal Oscillators */
 	GATE_MP1(CK_HSE, "ck_hse", "clk-hse", 0, RCC_OCENSETR, 8, 0),
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
