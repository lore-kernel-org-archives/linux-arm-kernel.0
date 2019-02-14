Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA199C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:20:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC3221928
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j0Gc8nST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC3221928
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yPczavLupErYxfCl3atMQ5BN6OsTJ8/mLi4NUN6Aebc=; b=j0Gc8nSTbFkkaF
	Q3BzicP8svanj6lUgxjPrewoZAhRDuPCblbyHr73CdmK584OJB2151XPKKh94cIKGmE/mS986G5rR
	MxyuR6Iq33ZrIZJOAbj4AUfSpbr9r9b+o0IanrlfF5AmV0pKkXNTccTzgBaedU3a4cFY/UXdqJjEB
	xAwvCVTovRro1/BPwDdFeplSOJApRs6++smyG3X1OBSYN7YM+Bb8PWb3WOAqnzweeEFM0OIPXe+fC
	mWTibkDNuBduxWRVqzRBgHV0jILsgBDCB8+gA8Wj69fe1jqMZ0sxx6Zor23SF1PQ5Rl+aTpoQaGdP
	6d/bG+IpZ1jY30PAFDrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guQIb-0000KF-KI; Thu, 14 Feb 2019 23:20:09 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guQIX-0007nS-GP; Thu, 14 Feb 2019 23:20:06 +0000
X-UUID: cc1d7ad41da84ce5bac4b63eb566dbf8-20190214
X-UUID: cc1d7ad41da84ce5bac4b63eb566dbf8-20190214
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <sean.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 262101727; Thu, 14 Feb 2019 15:19:57 -0800
Received: from MTKMBS01N2.mediatek.inc (172.21.101.79) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 14 Feb 2019 15:19:56 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 15 Feb 2019 07:19:42 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Fri, 15 Feb 2019 07:19:42 +0800
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <marcel@holtmann.org>,
 <johan.hedberg@gmail.com>
Subject: [PATCH 3/6] Bluetooth: mediatek: fix up an error path to restore
 bdev->tx_state
Date: Fri, 15 Feb 2019 07:19:35 +0800
Message-ID: <b1a496748170af6a89d8ba19db9412787ef53668.1550184473.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1550184473.git.sean.wang@mediatek.com>
References: <cover.1550184473.git.sean.wang@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: ACAD13D1EF135519F32787DB83F81F87797C5CA104C85759C2350E3BC01C1A222000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_152005_547735_6DCC22B2 
X-CRM114-Status: UNSURE (   9.23  )
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
Cc: devicetree@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Restore bdev->tx_state with clearing bit BTMTKUART_TX_WAIT_VND_EVT
when there is an error on waiting for the corresponding event.

Fixes: 7237c4c9ec92 ("Bluetooth: mediatek: Add protocol support for MediaTek serial devices")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtkuart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index b8ea011b82d8..9f8177b216b6 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -115,11 +115,13 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev, u8 op, u8 flag, u16 plen,
 				  TASK_INTERRUPTIBLE, HCI_INIT_TIMEOUT);
 	if (err == -EINTR) {
 		bt_dev_err(hdev, "Execution of wmt command interrupted");
+		clear_bit(BTMTKUART_TX_WAIT_VND_EVT, &bdev->tx_state);
 		return err;
 	}
 
 	if (err) {
 		bt_dev_err(hdev, "Execution of wmt command timed out");
+		clear_bit(BTMTKUART_TX_WAIT_VND_EVT, &bdev->tx_state);
 		return -ETIMEDOUT;
 	}
 
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
