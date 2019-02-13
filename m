Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18567C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:34:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDFBB222C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bOlNbECr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDFBB222C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=CKYn1XoapsuXTJUhr3bxxcYMB+Z5EFSj2kSNxjHGyBo=; b=bOl
	NbECrKtZSEvBE6Lh4EaESyVjEUMk4EKw5rPvnaKHui/4+hGDxhyG5SziA5YO3E94ySftg8+7bS/Je
	C+xBO/VzW+qwYqhsDfRTEYhDbl7ocEcSi0p7AhVrlPzZjdpPVU5+5aF873cQtvRsybVIzV+0P/jpD
	Ia52IrqFADcbfY/OjEZ1Gl+y7MMp/T77zfu/yl5fgy8b3GBz2OzG+w3Jk0iCZhwJlog9xqimjfQjO
	FPI6MYqjP/jq3Z9L49V1IZke0qO6kT0XjPCf4Vg2TzYBg8MBWmtPu6ZoVo2hwRvMERFh0hHtawpzn
	hWMcxmzhp56/v3sV56PEiGqvHuIfvbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gto7l-00074d-Q6; Wed, 13 Feb 2019 06:34:25 +0000
Received: from out1.zte.com.cn ([202.103.147.172] helo=mxct.zte.com.cn)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gto7i-00073g-Be
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 06:34:24 +0000
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
 by Forcepoint Email with ESMTPS id DD67150848972F7E1E0C;
 Wed, 13 Feb 2019 14:34:10 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
 by mse01.zte.com.cn with ESMTP id x1D6Y5mP041722;
 Wed, 13 Feb 2019 14:34:05 +0800 (GMT-8)
 (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2019021314342732-25844473 ;
 Wed, 13 Feb 2019 14:34:27 +0800 
From: Peng Hao <peng.hao2@zte.com.cn>
To: nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 ludovic.desroches@microchip.com
Subject: [PATCH]  arm/mach-at91/pm : fix possible object reference leak
Date: Wed, 13 Feb 2019 22:55:46 +0800
Message-Id: <1550069746-85671-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2019-02-13 14:34:27,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-02-13 14:33:58, Serialize complete at 2019-02-13 14:33:58
X-MAIL: mse01.zte.com.cn x1D6Y5mP041722
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_223422_561032_426240FF 
X-CRM114-Status: GOOD (  11.06  )
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
Cc: Peng Hao <peng.hao2@zte.com.cn>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

of_find_device_by_node() takes a reference to the struct device
when it finds a match via get_device. When returning error we should
call put_device.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 arch/arm/mach-at91/pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 51e808a..70fadb7 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -621,6 +621,7 @@ static int __init at91_pm_backup_init(void)
 
 securam_fail:
 	iounmap(pm_data.sfrbu);
+	put_device(&pdev->dev);
 	pm_data.sfrbu = NULL;
 	return ret;
 }
-- 
1.8.3.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
