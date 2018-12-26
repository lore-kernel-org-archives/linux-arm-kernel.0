Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF10C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:44:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AFB521736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cAm/pVAr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="FOTHh5e4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFB521736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=8j0fopXc/8Z+VrnwcNMW6aHMnclsmqZH5/9JknfcNQo=; b=cAm
	/pVAriygz8uJZ/qsbYTa13MNTfanHD5wx1epiv4sWpVeUtOMKeqS8yAjzH/kM8rW6O+KKjD5WV9/+
	5hFnTTRHu4LF+i98DCF76fjzCOUSG0OQUkJo9PZkTA5jMiwFiWE63VYuR8VMnAvxyI/tjjAjp4N69
	j/uNxcEx0vJba0E31bN+qKqJxKrUK0GZyvqj0tgPyZPTQA5SgUBRle3MViTeUQiVNN2Bx9T1j6h5v
	AtTdgnzkvAne5m2c9etR5NhLRY5XMcgVY+f2LLQF7Gc1z9qiXrA4lCBot1Uz9kpNG6Z4Qi6dEkIFm
	S2zgR0WrvibQRxAITL6aWMNyupRgWKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbzBC-0000Hu-M6; Wed, 26 Dec 2018 02:44:18 +0000
Received: from mta-p5.oit.umn.edu ([134.84.196.205])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbzB6-0000H3-Jk
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 02:44:16 +0000
Received: from localhost (unknown [127.0.0.1])
 by mta-p5.oit.umn.edu (Postfix) with ESMTP id 9ECCF5FC
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 26 Dec 2018 02:44:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
 by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dBAMW4RlxCqY for <linux-arm-kernel@lists.infradead.org>;
 Tue, 25 Dec 2018 20:44:00 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 6F7DF625
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 25 Dec 2018 20:44:00 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id b8so2629590ion.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 25 Dec 2018 18:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umn.edu; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=gkg7uHvncdT2WNv9hvr6ppmnMbQBq4T0rfrlJwBoncc=;
 b=FOTHh5e4n/SNN7xcY5M77el+DNyPSNzxNcuT1l1BiEerKLqlnaq9tJeCfF2p1wMXpk
 y0Mg76DMg2Q06Cg3n5l4cQg+HIg5X7O7LEGMeltfi6geNAiasuEtlqrGcXCGzb0aID2v
 JmrqYKpGSvtFM+Y42CMzqkrODFSCdSZXml3rpGfiQKhdPczF3mUK7TwpyrexuppP43Bu
 gQBpWluHbhj/t+9f567WXOagk4YtxtJl8Aprs89g1q8fYI8V0KQ78GOaeFmTnKNnbOOh
 H/NxWuZcQmafc9ZNqbGEhD6iAF3qnHNlmjwsfFjGehN0Go3xXOYimfQq1pcAVFcVfe7/
 IgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=gkg7uHvncdT2WNv9hvr6ppmnMbQBq4T0rfrlJwBoncc=;
 b=qUlR2OAPVn5SdODlPAOh1ye4TA8rNg0gpUSKlB/pdsfJN5ci11iiKN8ySx7iUmTPhw
 02Icyy7VFTQnHl02XGdWsgt0bOhKeMhs+1tb6dqO1pzAqRnVVHEb3S02jn3mC10ryKbF
 C7YnB6IMN6Edni7RGQzNwKjxfzY6rjTh5CrXaf/3iKbgJwd66Q947N9vvEaLTr7chSOs
 cNYFr88CYQh120DTcP6xpW4KIsZtsGqlBVH+BE66D3XA4AW/wt/W3LPb2TEErK7JoNAq
 0yvqrZbjNAK1PxWiEIGSf6Hvl0t0mKc/hoKPDY0Gz6ZKYsT3jJF+Idv8BaRGilM7mVQf
 CO1w==
X-Gm-Message-State: AA+aEWbtY6Ckp90IDKrkvAaNUXkNYeEut1uYYpVre0itxxHSue79bQon
 EgTgGHHvxZTKQ1ctjl07Z4ix6XwKxAZBM0+/P05XR9EW61sLcdu/X6hq3DCdiKH315GjcOrbgxj
 rKX/arrEpoq4Clx4LwCucCm1ByrOc47fSglHB+Dg=
X-Received: by 2002:a02:8a1c:: with SMTP id j28mr12029134jak.49.1545792240046; 
 Tue, 25 Dec 2018 18:44:00 -0800 (PST)
X-Google-Smtp-Source: AFSGD/U1RPn8FcC66zod/Zxjt8q/PyRqLZOnsnaOfpwiLxAooO7GoL5DWkhUlGa6IITWGFnb9pdCSA==
X-Received: by 2002:a02:8a1c:: with SMTP id j28mr12029124jak.49.1545792239820; 
 Tue, 25 Dec 2018 18:43:59 -0800 (PST)
Received: from localhost.localdomain
 (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net.
 [173.230.104.22])
 by smtp.gmail.com with ESMTPSA id q1sm709491ion.45.2018.12.25.18.43.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 25 Dec 2018 18:43:58 -0800 (PST)
From: Kangjie Lu <kjlu@umn.edu>
To: kjlu@umn.edu
Subject: [PATCH] rtc: fix a missing check of clk_prepare
Date: Tue, 25 Dec 2018 20:43:33 -0600
Message-Id: <20181226024333.72236-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181225_184412_737078_4771C0DC 
X-CRM114-Status: GOOD (  15.24  )
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
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 pakki001@umn.edu, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

clk_prepare() could fail, so let's check its status and if it fails
return its error code upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/rtc/rtc-coh901331.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-coh901331.c b/drivers/rtc/rtc-coh901331.c
index fc5cf5c44ae7..0b232c84f674 100644
--- a/drivers/rtc/rtc-coh901331.c
+++ b/drivers/rtc/rtc-coh901331.c
@@ -235,9 +235,13 @@ static int coh901331_suspend(struct device *dev)
 
 static int coh901331_resume(struct device *dev)
 {
+	int ret;
 	struct coh901331_port *rtap = dev_get_drvdata(dev);
 
-	clk_prepare(rtap->clk);
+	ret = clk_prepare(rtap->clk);
+	if (ret)
+		return ret;
+
 	if (device_may_wakeup(dev)) {
 		disable_irq_wake(rtap->irq);
 	} else {
-- 
2.17.2 (Apple Git-113)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
