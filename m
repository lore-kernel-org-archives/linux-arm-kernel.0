Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53799C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:07:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22EA320840
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K04Sdwqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22EA320840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DRcKI3XcVsMtHtcOUc4UOnHuAIuIvX5wUJ7xiRVWB6o=; b=K04SdwqpjmZ58b
	GSj6EUb/yJ08APt0XuS0BsrOHhiIcvYoa271dIP7/83YypnHtHxeOXDRauAUVdlwy9favheLRWFwt
	laeeqKpFcYkiLEK6NxaujwvL0wGI6c2jXxflayjGVu3E1hhaby7FBUHuDzgnTZO7+J0/k7+FXaCBW
	cVklGNRbPYr9Oq/G72FoTAEg8H/3t+3aJ4g5Zc4e8mYDdkeJfFIzMuqHg1tH+5klO/PT6uARwMF89
	GqmiklhTGhLenkSKddcBvDj92FnpvDxAnHHbEHJ0e9lUpHD97FRcGMSEyBZNCPH2v7Gl5pM6uqLVO
	NwyISYOQwnLnAkwIUH8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjdQL-0005fJ-LL; Wed, 16 Jan 2019 05:07:33 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjdQI-0005e8-DP; Wed, 16 Jan 2019 05:07:32 +0000
X-UUID: 8b5212d391bf4da7ab5536a35a87e50f-20190115
X-UUID: 8b5212d391bf4da7ab5536a35a87e50f-20190115
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <ck.hu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1264960476; Tue, 15 Jan 2019 21:07:25 -0800
Received: from mtkmbs03n1.mediatek.inc (172.21.101.181) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 15 Jan 2019 21:07:24 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 16 Jan 2019 13:07:22 +0800
Received: from mtkslt305.mediatek.inc (10.21.14.140) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Wed, 16 Jan 2019 13:07:22 +0800
From: CK Hu <ck.hu@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Houlong Wei <houlong.wei@mediatek.com>
Subject: [PATCH 1/3] mailbox: Add ability for clients to abort data in channel
Date: Wed, 16 Jan 2019 13:04:33 +0800
Message-ID: <20190116050435.11624-2-ck.hu@mediatek.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190116050435.11624-1-ck.hu@mediatek.com>
References: <20190116050435.11624-1-ck.hu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_210730_459907_B0239ED7 
X-CRM114-Status: GOOD (  13.85  )
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
Cc: CK Hu <ck.hu@mediatek.com>, srv_heupstream@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch supplies a new framework API, mbox_abort_channel(), and
a new controller interface, abort_data().

For some client's application, it need to clean up the data in channel
but keep the channel so it could send data to channel later.

Signed-off-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/mailbox/mailbox.c          | 23 +++++++++++++++++++++++
 include/linux/mailbox_client.h     |  1 +
 include/linux/mailbox_controller.h |  4 ++++
 3 files changed, 28 insertions(+)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index c6a7d4582dc6..281647162c76 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -428,6 +428,29 @@ struct mbox_chan *mbox_request_channel_byname(struct mbox_client *cl,
 }
 EXPORT_SYMBOL_GPL(mbox_request_channel_byname);
 
+/**
+ * mbox_abort_channel - The client abort all data in a mailbox
+ *			channel by this call.
+ * @chan: The mailbox channel to be aborted.
+ */
+void mbox_abort_channel(struct mbox_chan *chan)
+{
+	unsigned long flags;
+
+	if (!chan || !chan->cl)
+		return;
+
+	if (chan->mbox->ops->abort_data)
+		chan->mbox->ops->abort_data(chan);
+
+	/* The queued TX requests are simply aborted, no callbacks are made */
+	spin_lock_irqsave(&chan->lock, flags);
+	chan->cl = NULL;
+	chan->active_req = NULL;
+	spin_unlock_irqrestore(&chan->lock, flags);
+}
+EXPORT_SYMBOL_GPL(mbox_abort_channel);
+
 /**
  * mbox_free_channel - The client relinquishes control of a mailbox
  *			channel by this call.
diff --git a/include/linux/mailbox_client.h b/include/linux/mailbox_client.h
index faa7da3c9c8b..209d1d458029 100644
--- a/include/linux/mailbox_client.h
+++ b/include/linux/mailbox_client.h
@@ -47,6 +47,7 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg);
 int mbox_flush(struct mbox_chan *chan, unsigned long timeout);
 void mbox_client_txdone(struct mbox_chan *chan, int r); /* atomic */
 bool mbox_client_peek_data(struct mbox_chan *chan); /* atomic */
+void mbox_abort_channel(struct mbox_chan *chan); /* may sleep */
 void mbox_free_channel(struct mbox_chan *chan); /* may sleep */
 
 #endif /* __MAILBOX_CLIENT_H */
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index 4994a438444c..518aa4ca2fe4 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -27,6 +27,9 @@ struct mbox_chan;
  * @flush:	Called when a client requests transmissions to be blocking but
  *		the context doesn't allow sleeping. Typically the controller
  *		will implement a busy loop waiting for the data to flush out.
+ * @abort_data:	Called when a client relinquishes control of a chan.
+ *		This call may block too. The controller may do stuff
+ *		that need to sleep.
  * @startup:	Called when a client requests the chan. The controller
  *		could ask clients for additional parameters of communication
  *		to be provided via client's chan_data. This call may
@@ -50,6 +53,7 @@ struct mbox_chan;
 struct mbox_chan_ops {
 	int (*send_data)(struct mbox_chan *chan, void *data);
 	int (*flush)(struct mbox_chan *chan, unsigned long timeout);
+	void (*abort_data)(struct mbox_chan *chan);
 	int (*startup)(struct mbox_chan *chan);
 	void (*shutdown)(struct mbox_chan *chan);
 	bool (*last_tx_done)(struct mbox_chan *chan);
-- 
2.18.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
