Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A5CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:54:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97A532171F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n067rJGr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="lPczBkvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A532171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=B/3tltdSfL6wpFz3DPnJmM1KCiqKchZQeOaX8Lyl1KU=; b=n06
	7rJGr2sFzal80y3+vc44vdtRK5wKdK6cHlX2Snna/RggC/NT8pIX2TeyRomW+rx55U50iqR2LIZnA
	4Ljegj1/xzAfpKc37S8JBt5saMbCLv4f6ni4ynryNdhQfUo4RTSOHVofSO+7cyhJIr3T8SIkViK4S
	n/bwogddY939MVWQYf7O7BhJhn9eejJt23zM7/P9eHtD2OJLQXwopTKu1zG6XJfuzmV5OsXc+Z2/O
	1hELfmQFkj2obxzWtYdVYpkw2Qwn6fI4tpRfwBmHupG/d8ogOku5I+0roFg4pfhpqAsoBcHzASfOg
	VQr+UKw/bITw5xRf73Fc0nK86TBKeTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbzLN-0003WJ-HU; Wed, 26 Dec 2018 02:54:49 +0000
Received: from mta-p6.oit.umn.edu ([134.84.196.206])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbzLH-0003VK-SU
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 02:54:47 +0000
Received: from localhost (unknown [127.0.0.1])
 by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4D7BA997
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 26 Dec 2018 02:54:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
 by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id own-MxXtOVKK for <linux-arm-kernel@lists.infradead.org>;
 Tue, 25 Dec 2018 20:54:33 -0600 (CST)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com
 [209.85.166.197])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 1DACDAB8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 25 Dec 2018 20:54:33 -0600 (CST)
Received: by mail-it1-f197.google.com with SMTP id c128so18654787itc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 25 Dec 2018 18:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umn.edu; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=Hi1WaWFF9Q9te4wz4HnCZv6G1koFXgSyMoUWP6/BZHI=;
 b=lPczBkvzZxTNOh8YfUDZWfoGmFi8WBuyPcbo87rzY7nU7lvTkvrymqY2LJdkv4E5OV
 87egBKy7Xs+F1RKUnCywaj1Ft7yIHEsP1wE59I44dTKl78A8YtoS398aHsiFVGMQWKE5
 IIGe1Hh7/COTrrz7NPFG/6ZwOExKT6oQMlVIwIi+escWUul12IAvWKJPVdCz7mbxwbFV
 d1clGSE5t8NyvlB4aTE+ASDEpg7ns7zkGAWH6ygOmvEUQ/zJgAL0BWRqqWojlRuxPGGs
 OqZCxnkNq2CNd07OjGKHPu+BjQkg2sRjVXYTEKqDSaolTXuDZazlD8BrcnZLHl2JDIZ7
 Isaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Hi1WaWFF9Q9te4wz4HnCZv6G1koFXgSyMoUWP6/BZHI=;
 b=iMM2/jWKNNpWnPFRDlxh62OG/hcxbwsHpGUTcx8WognszlY1tfGRHjitO4OUpewoUP
 tri3giJAQV1EWDXMvE/xy0/Iu7scW9cEi4k3WZ/1sMXrnWZk2kHZCVs1DqgzQ+c+h+zj
 BoHB1YNRdvOlg1+jzKApGadCvqsfCZIaaRs+/lOjbGRtFS5iK/pRHlj6Uj7dIB1P1oKG
 73gddKIQAv+RR30exIG0b9jk+jRKnOlhRDvLSkBmEv8qjEcGsSW+kQi/caoEBNG4i1WW
 NQDBaAvcq+PKPij5YGOxaD9HEVuJCUAwQ+uwtxxofJhTGfaK3aku44hEFlfNO8D8KeTk
 Ojmg==
X-Gm-Message-State: AA+aEWb8qXgs/OPdts6sptfT5QKA8r3nBzbNglul/GSySfF2bIJQYl1v
 FFM+OrHqUtLwuhaBVOBvNVZCNvMKJjQUOryTXWuaK3iTANxFkAvxVMEWlqcyCmkCdcVwtQ0iVzN
 3jtrKb2v51+MLNlXoOTak/uyhEzmwhflzrMnWcUA=
X-Received: by 2002:a24:1fc7:: with SMTP id
 d190mr11074920itd.126.1545792872689; 
 Tue, 25 Dec 2018 18:54:32 -0800 (PST)
X-Google-Smtp-Source: AFSGD/VG4BDwEHGMkGYlMA0z8SX+L4UK20udAbjIt5b5fe1zIoYJ2ZbB5K/zP5FQMUhgrk/yB8R8Sg==
X-Received: by 2002:a24:1fc7:: with SMTP id
 d190mr11074908itd.126.1545792872479; 
 Tue, 25 Dec 2018 18:54:32 -0800 (PST)
Received: from localhost.localdomain
 (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net.
 [173.230.104.22])
 by smtp.gmail.com with ESMTPSA id 125sm14397722itk.28.2018.12.25.18.54.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 25 Dec 2018 18:54:31 -0800 (PST)
From: Kangjie Lu <kjlu@umn.edu>
To: kjlu@umn.edu
Subject: [PATCH] atmel: fix a missing check of clk_prepare
Date: Tue, 25 Dec 2018 20:54:05 -0600
Message-Id: <20181226025405.72480-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181225_185444_018833_632E82CE 
X-CRM114-Status: GOOD (  13.57  )
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org,
 Ludovic Desroches <ludovic.desroches@microchip.com>, pakki001@umn.edu,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

clk_prepare() could fail, so let's check its status, and if it fails,
issue an error message.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/misc/atmel-ssc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index d8e3cc2dc747..9e69d0585f49 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -60,7 +60,8 @@ struct ssc_device *ssc_request(unsigned int ssc_num)
 	ssc->user++;
 	spin_unlock(&user_lock);
 
-	clk_prepare(ssc->clk);
+	if (clk_prepare(ssc->clk))
+		pr_err("ssc: failed to prepare clk.\n");
 
 	return ssc;
 }
-- 
2.17.2 (Apple Git-113)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
