Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B21CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:49:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66509217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K6k/39+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66509217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=8hf1ch/8liO6u4DpVtMgsADD1Fbq7Q8YUp/rObFPahM=; b=K6k/39+oedlWNR4fc4cx6cVqMW
	PSFrBdKmEHDP/ss/LQ56Or2eVqUtne7a80Ftrmj07hnwFnHdGCoaZFvw7gFWxO8JYNV6cKRlXGyle
	ZGwhmhTC8gN0L+BL2LTu0CX0jQZ75+cKSxDJAQL1CnzQ2b4vyyD47EIltgowJwRs7k23QwnVg0Z0B
	J8nJkHUn2CLrybr2zR1EJPS0pS7CdJ1m9g3NvTvwzZLUWAWP/pHoUXmEAv6lFWOQwVYM57jWcHuNh
	y3sBiCsyo4n1Gv16W5pZ1UKXwpUdQY1vuieo4K9KrczeRhu2IDZPDWLPVVMvd4df8YdD/eA14jPlb
	5vZrPJng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZf26-0001Xi-IE; Wed, 19 Dec 2018 16:49:18 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZf1b-00011c-LJ
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 16:48:50 +0000
Received: from localhost (p54B333DA.dip0.t-ipconnect.de [84.179.51.218])
 by pokefinder.org (Postfix) with ESMTPSA id 55BAD2E3560;
 Wed, 19 Dec 2018 17:48:34 +0100 (CET)
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Subject: [PATCH 01/10] i2c: add suspended flag and accessors for i2c adapters
Date: Wed, 19 Dec 2018 17:48:17 +0100
Message-Id: <20181219164827.20985-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_084847_842277_E83D100F 
X-CRM114-Status: GOOD (  14.23  )
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
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-pm@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

A few drivers open code handling of suspended adapters. It could be
handled by the core, though, to ensure generic handling. This patch adds
the flag and accessor functions. The usage of these helpers is optional,
though. See the kerneldoc in this patch.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core-base.c |  1 +
 include/linux/i2c.h         | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 28460f6a60cc..2c465455b2f6 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1232,6 +1232,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	if (!adap->lock_ops)
 		adap->lock_ops = &i2c_adapter_lock_ops;
 
+	adap->locked_flags = 0;
 	rt_mutex_init(&adap->bus_lock);
 	rt_mutex_init(&adap->mux_lock);
 	mutex_init(&adap->userspace_clients_lock);
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 65b4eaed1d96..b7401c55dc83 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -680,6 +680,8 @@ struct i2c_adapter {
 	int timeout;			/* in jiffies */
 	int retries;
 	struct device dev;		/* the adapter device */
+	unsigned long locked_flags;	/* owned by the I2C core */
+#define I2C_ALF_IS_SUSPENDED	0
 
 	int nr;
 	char name[48];
@@ -762,6 +764,38 @@ i2c_unlock_bus(struct i2c_adapter *adapter, unsigned int flags)
 	adapter->lock_ops->unlock_bus(adapter, flags);
 }
 
+/**
+ * i2c_mark_adapter_suspended - Report suspended state of the adapter to the core
+ * @adap: Adapter to mark as suspended
+ *
+ * When using this helper to mark an adapter as suspended, the core will reject
+ * further transfers to this adapter. The usage of this helper is optional but
+ * recommended for devices having distinct handlers for systems suspend and
+ * runtime suspend. More complex devices are free to implement custom solutions
+ * to reject transfers when suspended.
+ */
+static inline void i2c_mark_adapter_suspended(struct i2c_adapter *adap)
+{
+	i2c_lock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
+	set_bit(I2C_ALF_IS_SUSPENDED, &adap->locked_flags);
+	i2c_unlock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
+}
+
+/**
+ * i2c_mark_adapter_resumed - Report resumed state of the adapter to the core
+ * @adap: Adapter to mark as resumed
+ *
+ * When using this helper to mark an adapter as resumed, the core will allow
+ * further transfers to this adapter. See also further notes to
+ * @i2c_mark_adapter_suspended().
+ */
+static inline void i2c_mark_adapter_resumed(struct i2c_adapter *adap)
+{
+	i2c_lock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
+	clear_bit(I2C_ALF_IS_SUSPENDED, &adap->locked_flags);
+	i2c_unlock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
+}
+
 /*flags for the client struct: */
 #define I2C_CLIENT_PEC		0x04	/* Use Packet Error Checking */
 #define I2C_CLIENT_TEN		0x10	/* we have a ten bit chip address */
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
