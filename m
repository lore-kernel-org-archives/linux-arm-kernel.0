Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED4AC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 20:27:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16AF02195D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 20:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QAk8P8gd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16AF02195D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+LQ12Y1aeF2+Q9kXutYdyhpZPDmp1bSjOkRNZNNcRZY=; b=QAk8P8gdTnJO1+
	4uBqcnQ9ysetMmsIQxffKAd74oDYlMM4b5cfHdJWONMdGnZ/BBUskft9+OuJmVUO9uGjcHoTuFHzK
	1/IgS9WCfMbgm7Jd2aMvBNim5bmbO+UkoHOW/zywwtuBTLckDk7jtbKuZPzD53Di1AQgYWdk1LFNs
	Puct8kA2sU8WjM+WhFLy8Xx/TnXxevLPejFs9hTGaeBQdN6M4t68ddMgfF2MsCV6p3ak1D+pyUQ45
	enDp/NbXr82bMAtV3Q+b4LVH0pLKiZM5a9w6GL44BnhgNhbZet6dj7ZoT1dSw0SdXrmnLJejto0OP
	jmTSm0hF7fSBdhiWh/Jg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ganrU-0008Pk-0m; Sat, 22 Dec 2018 20:27:04 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ganrC-000885-5L
 for linux-arm-kernel@lists.infradead.org; Sat, 22 Dec 2018 20:26:48 +0000
Received: from localhost (p54B67A8B.dip0.t-ipconnect.de [84.182.122.139])
 by pokefinder.org (Postfix) with ESMTPSA id 1B15A2E35C9;
 Sat, 22 Dec 2018 21:26:33 +0100 (CET)
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Subject: [PATCH v2 2/9] i2c: reject new transfers when adapters are suspended
Date: Sat, 22 Dec 2018 21:26:16 +0100
Message-Id: <20181222202623.4521-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
References: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181222_122646_402849_24BCC3E6 
X-CRM114-Status: UNSURE (   8.80  )
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
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Wolfram Sang <wsa@the-dreams.de>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Using the 'is_suspended' flag from the PM core, we now reject new
transfers if the parent of the adapter is already marked suspended.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/i2c/fault-codes | 4 ++++
 drivers/i2c/i2c-core-base.c   | 3 +++
 drivers/i2c/i2c-core-smbus.c  | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/Documentation/i2c/fault-codes b/Documentation/i2c/fault-codes
index 47c25abb7d52..0cee0fc545b4 100644
--- a/Documentation/i2c/fault-codes
+++ b/Documentation/i2c/fault-codes
@@ -112,6 +112,10 @@ EPROTO
 	case is when the length of an SMBus block data response
 	(from the SMBus slave) is outside the range 1-32 bytes.
 
+ESHUTDOWN
+	Returned when a transfer was requested using an adapter
+	which is already suspended.
+
 ETIMEDOUT
 	This is returned by drivers when an operation took too much
 	time, and was aborted before it completed.
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 28460f6a60cc..3ce238b782f3 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1865,6 +1865,9 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 
 	if (WARN_ON(!msgs || num < 1))
 		return -EINVAL;
+	if (WARN(device_is_suspended(adap->dev.parent),
+		 "Accessing already suspended I2C/SMBus adapter"))
+		return -ESHUTDOWN;
 
 	if (adap->quirks && i2c_check_for_quirks(adap, msgs, num))
 		return -EOPNOTSUPP;
diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index 9cd66cabb84f..e0f7f22feabd 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -547,6 +547,10 @@ s32 __i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 	int try;
 	s32 res;
 
+	if (WARN(device_is_suspended(adapter->dev.parent),
+		 "Accessing already suspended I2C/SMBus adapter"))
+		return -ESHUTDOWN;
+
 	/* If enabled, the following two tracepoints are conditional on
 	 * read_write and protocol.
 	 */
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
