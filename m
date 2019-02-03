Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A2CC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:32:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 319BB217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cHlHDGJK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="H/Bmk39f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319BB217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=7Mgmm6O9mHezYK0Q7zDqx2o1db276fjCGtPkDQNYvTk=; b=cHl
	HDGJK3nUW0gUCv4buhYO+6hrVwPOswC7kfncxWnDerF3MxEsscz3JwMYagqvOZML13bx1TTnZp6Kx
	Gd6Kfd1R2bSI18kyJerbITeY7NpEIU1D+RkCy61TJx4tUuxQr+UHzLKWg5zo8fD4kTMJBAxyQlYo1
	XEw1rQQBCa7pMUHZuYEnex1jayl3Xc7kGz05Ul46XnPReic2q3cMXO+hxnrMvqKf7zT/8EmsPYN3i
	ECEIxPRMkkqn8B9MHYU13Q+urEWLgD0HL19HRYGFFz1IsvEjMkXYaGaPTIWBuUqSDyxP1Nx9Ubtiz
	kbMCnlMMq7Zh7cnRelV4LkJd9WXP4ng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqGwI-0000JR-Iy; Sun, 03 Feb 2019 12:31:58 +0000
Received: from onstation.org ([52.200.56.107])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqGw4-00007d-VT
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 12:31:46 +0000
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net
 [98.239.145.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: masneyb)
 by onstation.org (Postfix) with ESMTPSA id A3DD115F;
 Sun,  3 Feb 2019 12:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
 s=default; t=1549197101;
 bh=/6BKBlVr3V9azW1jkDtytolZIdZrfIhaCxzVmkTDFZI=;
 h=From:To:Cc:Subject:Date:From;
 b=H/Bmk39fx4BimPN/YiNwbVx4bnuqKhYU75Zs53RczHaw3Ou32WdGZ0BeWDeGFFNIu
 /oTjSbgx2gMQ4QTxZbH5ej4oVwaUOtS9rSkYcJt1YIpxnFTtpDt3u5e8q3y3CyPrhU
 sdeS+R/YCPx9gSjgVwyOBoLGDjARuCGsmHEF9rJ8=
From: Brian Masney <masneyb@onstation.org>
To: linus.walleij@linaro.org,
	tglx@linutronix.de,
	marc.zyngier@arm.com
Subject: [PATCH -next 1/2] genirq: export irq_chip_set_wake_parent symbol
Date: Sun,  3 Feb 2019 07:31:30 -0500
Message-Id: <20190203123131.28323-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_043145_076912_F1DB05E3 
X-CRM114-Status: UNSURE (   8.21  )
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
Cc: linaro-kernel@lists.linaro.org, kernel-build-reports@lists.linaro.org,
 sboyd@kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 bjorn.andersson@linaro.org, linux-gpio@vger.kernel.org,
 linux-next@vger.kernel.org, andy.gross@linaro.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Export the irq_chip_set_wake_parent symbol so that drivers with
hierarchical IRQ chips can be built as a module.

This fixes a build failure in linux-next's spmi-gpio when using
allmodconfig.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Reported-by: Mark Brown <broonie@kernel.org>
---
See https://www.spinics.net/lists/linux-next/msg46362.html for Mark's
message.

 kernel/irq/chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 34e969069488..086d5a34b5a0 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1381,6 +1381,7 @@ int irq_chip_set_wake_parent(struct irq_data *data, unsigned int on)
 
 	return -ENOSYS;
 }
+EXPORT_SYMBOL_GPL(irq_chip_set_wake_parent);
 #endif
 
 /**
-- 
2.17.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
