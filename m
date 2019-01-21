Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A7EC282F6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:47:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93EA720663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C7Kub5Q2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93EA720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=0VRdxpehOdAJJJWd4GGPA6UvmttZ8ofXeHAg6UHGJgI=; b=C7Kub5Q2eUFlOWoxxiXZR8rML0
	lz7vBDNe/emXjfwB0KRUdp323N7D9HO5IK5WoPlG29WPrvVta6iUnDlaNl9788C/FYkUzObjxlBrV
	OGouAgEzxqJtnc4IpD5TVKV12XgMDM6ZprrbH8i1gzIYm/UKqSaNkR/45jxO2VqamgFzXwE9jAFuG
	d8rxIEQO7zmZnQws9bagts5js9aOUGJKZa0kHLMTzuqosC8Usa7mUkc9bBv5fx71TZB3iRe2rWcbh
	X5fNEgtefMQdJ2sSi9KHx1+HLZdGKzakhe3k0wRw2MR6uuP3i6nrnFEBVtjzss3+bHRIzC+AdEw8Y
	03HotIlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glX7H-0001NZ-2w; Mon, 21 Jan 2019 10:47:43 +0000
Received: from inva020.nxp.com ([92.121.34.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glX6x-00015G-4w
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 10:47:24 +0000
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DEA821A015C;
 Mon, 21 Jan 2019 11:47:21 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 64DED1A0144;
 Mon, 21 Jan 2019 11:47:17 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D2E39402D9;
 Mon, 21 Jan 2019 18:47:11 +0800 (SGT)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [v3, 2/6] ptp_qoriq: support external trigger stamp FIFO
Date: Mon, 21 Jan 2019 18:41:39 +0800
Message-Id: <20190121104143.46782-3-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190121104143.46782-1-yangbo.lu@nxp.com>
References: <20190121104143.46782-1-yangbo.lu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_024723_477736_A74FD43C 
X-CRM114-Status: GOOD (  12.98  )
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
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Yangbo Lu <yangbo.lu@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The external trigger stamp FIFO was introduced as a new feature
for QorIQ 1588 timer IP block. This patch is to support it by
adding a new dts property "fsl,extts-fifo". Any QorIQ 1588 timer
supporting this feature is required to add this property in its
dts node.

In addition, the FIFO should be cleaned up before enabling external
trigger interrupts. Otherwise, there will be interrupts immediately
just after enabling external trigger interrupts.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes for v2:
	- Converted to use extts_clean_up instead.
Changes for v3:
	- None.
---
 drivers/ptp/ptp_qoriq.c       |   68 ++++++++++++++++++++++++++++++++--------
 include/linux/fsl/ptp_qoriq.h |    3 ++
 2 files changed, 57 insertions(+), 14 deletions(-)

diff --git a/drivers/ptp/ptp_qoriq.c b/drivers/ptp/ptp_qoriq.c
index 2743214..a2e7702 100644
--- a/drivers/ptp/ptp_qoriq.c
+++ b/drivers/ptp/ptp_qoriq.c
@@ -88,6 +88,49 @@ static void set_fipers(struct qoriq_ptp *qoriq_ptp)
 	qoriq_write(&regs->fiper_regs->tmr_fiper2, qoriq_ptp->tmr_fiper2);
 }
 
+static int extts_clean_up(struct qoriq_ptp *qoriq_ptp, int index,
+			  bool update_event)
+{
+	struct qoriq_ptp_registers *regs = &qoriq_ptp->regs;
+	struct ptp_clock_event event;
+	void __iomem *reg_etts_l;
+	void __iomem *reg_etts_h;
+	u32 valid, stat, lo, hi;
+
+	switch (index) {
+	case 0:
+		valid = ETS1_VLD;
+		reg_etts_l = &regs->etts_regs->tmr_etts1_l;
+		reg_etts_h = &regs->etts_regs->tmr_etts1_h;
+		break;
+	case 1:
+		valid = ETS2_VLD;
+		reg_etts_l = &regs->etts_regs->tmr_etts2_l;
+		reg_etts_h = &regs->etts_regs->tmr_etts2_h;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	event.type = PTP_CLOCK_EXTTS;
+	event.index = index;
+
+	do {
+		lo = qoriq_read(reg_etts_l);
+		hi = qoriq_read(reg_etts_h);
+
+		if (update_event) {
+			event.timestamp = ((u64) hi) << 32;
+			event.timestamp |= lo;
+			ptp_clock_event(qoriq_ptp->clock, &event);
+		}
+
+		stat = qoriq_read(&regs->ctrl_regs->tmr_stat);
+	} while (qoriq_ptp->extts_fifo_support && (stat & valid));
+
+	return 0;
+}
+
 /*
  * Interrupt service routine
  */
@@ -111,24 +154,12 @@ static irqreturn_t isr(int irq, void *priv)
 
 	if (irqs & ETS1) {
 		ack |= ETS1;
-		hi = qoriq_read(&regs->etts_regs->tmr_etts1_h);
-		lo = qoriq_read(&regs->etts_regs->tmr_etts1_l);
-		event.type = PTP_CLOCK_EXTTS;
-		event.index = 0;
-		event.timestamp = ((u64) hi) << 32;
-		event.timestamp |= lo;
-		ptp_clock_event(qoriq_ptp->clock, &event);
+		extts_clean_up(qoriq_ptp, 0, true);
 	}
 
 	if (irqs & ETS2) {
 		ack |= ETS2;
-		hi = qoriq_read(&regs->etts_regs->tmr_etts2_h);
-		lo = qoriq_read(&regs->etts_regs->tmr_etts2_l);
-		event.type = PTP_CLOCK_EXTTS;
-		event.index = 1;
-		event.timestamp = ((u64) hi) << 32;
-		event.timestamp |= lo;
-		ptp_clock_event(qoriq_ptp->clock, &event);
+		extts_clean_up(qoriq_ptp, 1, true);
 	}
 
 	if (irqs & ALM2) {
@@ -278,6 +309,10 @@ static int ptp_qoriq_enable(struct ptp_clock_info *ptp,
 		default:
 			return -EINVAL;
 		}
+
+		if (on)
+			extts_clean_up(qoriq_ptp, rq->extts.index, false);
+
 		break;
 	case PTP_CLK_REQ_PPS:
 		bit = PP1EN;
@@ -441,6 +476,11 @@ static int qoriq_ptp_probe(struct platform_device *dev)
 	if (of_property_read_u32(node, "fsl,cksel", &qoriq_ptp->cksel))
 		qoriq_ptp->cksel = DEFAULT_CKSEL;
 
+	if (of_property_read_bool(node, "fsl,extts-fifo"))
+		qoriq_ptp->extts_fifo_support = true;
+	else
+		qoriq_ptp->extts_fifo_support = false;
+
 	if (of_property_read_u32(node,
 				 "fsl,tclk-period", &qoriq_ptp->tclk_period) ||
 	    of_property_read_u32(node,
diff --git a/include/linux/fsl/ptp_qoriq.h b/include/linux/fsl/ptp_qoriq.h
index c1f003a..43b4b44 100644
--- a/include/linux/fsl/ptp_qoriq.h
+++ b/include/linux/fsl/ptp_qoriq.h
@@ -120,6 +120,8 @@ struct qoriq_ptp_registers {
 /* Bit definitions for the TMR_STAT register */
 #define STAT_VEC_SHIFT        (0) /* Timer general purpose status vector */
 #define STAT_VEC_MASK         (0x3f)
+#define ETS1_VLD              (1<<24)
+#define ETS2_VLD              (1<<25)
 
 /* Bit definitions for the TMR_PRSC register */
 #define PRSC_OCK_SHIFT        (0) /* Output clock division/prescale factor. */
@@ -141,6 +143,7 @@ struct qoriq_ptp {
 	struct ptp_clock *clock;
 	struct ptp_clock_info caps;
 	struct resource *rsrc;
+	bool extts_fifo_support;
 	int irq;
 	int phc_index;
 	u64 alarm_interval; /* for periodic alarm */
-- 
1.7.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
