Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAD4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:27:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CC212081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="APlfUtWY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Z3VQ61Cd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC212081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5vF2iYK/tei3m0DnbZy9vdyI5omyWOV6G6yljvsdZe0=; b=APlfUtWY0nLE6Q
	QJD6uYJuQcZhWotK+FpX/QurV7cW1RR3jwEhCuE/6xbKy9SYvDkkBTLC35hUlEjEWBGGkuCaJDPOX
	njVB1+zLsvHura71ocPaTsOisN00VQzhIs3r235dYzbI3FEuDjda520aivgpWk4zjP+RqoEjOGAg8
	xr3+XA1dTmuvIvt2r7usp0TuO2CSBg3qCCeZKUvhqTAz2zkLfKa6VMyvFs8ixU3nuRzavK5MBPwVm
	RuueR3+hPc0RkWj0W4AFtHgrbaVVWf37K/ZTt90dVW/pgOGmWku9uIwCdN25awgSbyfPk375OPlzH
	5Z0iEfw8aw8Fss70tDmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUAjz-0006Rp-Ci; Tue, 04 Dec 2018 13:27:55 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUAjw-0006Po-0v
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 13:27:53 +0000
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id 841245C03A3;
 Tue,  4 Dec 2018 14:27:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1543930056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:
 content-transfer-encoding:content-transfer-encoding:in-reply-to:
 references; bh=l/NqMlMJK6NCuID2vd75UkjcijsChz0PXtxpAkinb6A=;
 b=Z3VQ61CdqWFgxFzEkOjzTmIHpJ5Jv61kLXyp523WCTiAT2fVLCgnemUzqQIYMSf+Amqhfy
 7wEWsStTzS9y4ABLxwtVEPxzx8FobRfn6j0WjCGSbwERljOgkaPhpkmtMJMzBQeRmP3o2Z
 4QT3l+tHjscUfGZwK35zGspSrtLyZRE=
From: Stefan Agner <stefan@agner.ch>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de
Subject: [PATCH v2 1/2] pci: imx6: avoid dereferencing program counter from
 user mode
Date: Tue,  4 Dec 2018 14:27:32 +0100
Message-Id: <20181204132733.14422-1-stefan@agner.ch>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_052752_216999_BB4461BD 
X-CRM114-Status: GOOD (  13.27  )
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
Cc: lorenzo.pieralisi@arm.com, andrew.smirnov@gmail.com, robin.murphy@arm.com,
 linux@armlinux.org.uk, stefan@agner.ch, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, bhelgaas@google.com, leonard.crestez@nxp.com,
 festevam@gmail.com, linux-arm-kernel@lists.infradead.org, tpiepho@impinj.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The custom fault handler is currently only meant to handle kernel
mode bus faults. Exit in case the abort happened in user mode.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/pci/controller/dwc/pci-imx6.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 69f86234f7c0..54a29e441303 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -270,8 +270,14 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
 		unsigned int fsr, struct pt_regs *regs)
 {
 	unsigned long pc = instruction_pointer(regs);
-	unsigned long instr = *(unsigned long *)pc;
-	int reg = (instr >> 12) & 15;
+	unsigned long instr;
+	int reg;
+
+	if (user_mode(regs))
+		return 1;
+
+	instr = *(unsigned long *)pc;
+	reg = (instr >> 12) & 15;
 
 	/*
 	 * If the instruction being executed was a read,
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
