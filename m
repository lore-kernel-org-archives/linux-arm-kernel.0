Return-Path: <SRS0=E6tZ=PC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E614EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 19:57:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6E782087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 19:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C3P/Hvz2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="csF9Jj/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E782087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=tHcL/i0497OQDokggRBhbjNywcTCXD2OkiENPUD+an8=; b=C3P
	/Hvz2D1Jgsuz3RYL3UJyP0zkkygxJpZ14PG2J8Ssq0Erzzm7BaRHkkyau2U/YADRDH31th0SL64wV
	nPa2d7hNIBasbgyfqOM22BqDiJey+azF/CkffumTv2lF+GgnrlRqTDzSWrwX0VveuGdNcgxdH6XpR
	rtRrn3A60OwHnTvbe6U5oqxXAePermtxrpx7byimC5oWZhvQTx/4QN8XCS3IZ8Q28FjwjV4pfjBXs
	hwYHcozHnD8yeiJB0smLSf2LXkiFG2quUFKFwH0et9QgdtCbxQl6A8zx4zEXfalH3HXIbrdBYj+M6
	DqOC6+nCzuubazeMWSOT0/Zyc8QuvtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbspf-000780-HZ; Tue, 25 Dec 2018 19:57:39 +0000
Received: from mta-p5.oit.umn.edu ([134.84.196.205])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbspM-000779-E5
 for linux-arm-kernel@lists.infradead.org; Tue, 25 Dec 2018 19:57:22 +0000
Received: from localhost (unknown [127.0.0.1])
 by mta-p5.oit.umn.edu (Postfix) with ESMTP id 374D2B34
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 25 Dec 2018 19:57:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
 by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ks6kmNxLNqvl for <linux-arm-kernel@lists.infradead.org>;
 Tue, 25 Dec 2018 13:57:09 -0600 (CST)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com
 [209.85.166.198])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 1158DAA8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 25 Dec 2018 13:57:08 -0600 (CST)
Received: by mail-it1-f198.google.com with SMTP id x3so16831027itb.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 25 Dec 2018 11:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umn.edu; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=4j9+iKNJ8s8Atk43E6W22afZdFKgiCQCrarKCTLLx2U=;
 b=csF9Jj/7OOUwV4hj5i7DaPXTnR2vtYi1mwCZIslMfU7d0KheTkWjLgEhopTmfF1M1K
 y9dmwZqHn/xRuZ6ku4F7Ww0xTPgKl3bn1vRm91zmYSR1L1Rx7byYprwJfRGS1LsvQtp0
 Y6O+c2I77j/FgQxcg8j/kgG4eI2cqurZQNj1kcfMhcQgqYsBQObiCKhzvmvHhpbqu9x9
 jIGiriUBsCGHYWpt6/7GyspFQbLnDN+FVuJziPlGO6C0toNf2Yu9DjnkyZnOMnLyByGa
 U5cTBN1Kh1jM0NHcuw2XCQ3hpZrJcGM6lGT7aEps4GK6bWoNXuQmXcuNYRxxRU+5EBbl
 rcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=4j9+iKNJ8s8Atk43E6W22afZdFKgiCQCrarKCTLLx2U=;
 b=mWuyq4E2k9ug3guM6UNwRTTGtOHW9OUTXY4KQ68rAqpTJzJ/3U6tmHAjGS6n0VqK0J
 gveZoT8cQ5h6Chkip0nZKdiOGgJJpre+Avu0jGZyqxs++0dEPv/9smD25ywvVDzBu35i
 Eq+FpbT6WyORC4NIxBZt5Imt9wz2kRmJK5GIRyZimAbC3Q8Fky7rde7ETliC0jlSVmBF
 w+Guqv2NYDi2pwD27A+wnx+4NkfV6mtID4ycaaNY2Ume9HEMKwDAJKi4yvFkktg5SU6g
 GO0g/YzzOoMnppmAh/t069qsU1WEdBrOBjM32dHFADTakddTD3eX4y4YQnVZFpsRJnS0
 FaRQ==
X-Gm-Message-State: AJcUukcrHGkNMNgTRJEQMlsk53H33RjLZrJR6am7bjs+FcTYtUz09wIV
 WFi0lZLQcVsEqzDZQOP8fX5ZgwZIvMjS8TzJqADnEzaaEYVA595c8Sk1ZX/m8iJLA20jNPdl/Wp
 rA54KTClbMn+tujWIzFnuCpo+MuVljEowdE3U34s=
X-Received: by 2002:a5e:8b05:: with SMTP id g5mr9776635iok.144.1545767827793; 
 Tue, 25 Dec 2018 11:57:07 -0800 (PST)
X-Google-Smtp-Source: ALg8bN7vluLCp7C7vcRQxK+NcD0t1sWSsJOm8Qq1TE6IIG4dScS+etAMbNphm/TDaM+we8iSFRKXTA==
X-Received: by 2002:a5e:8b05:: with SMTP id g5mr9776625iok.144.1545767827556; 
 Tue, 25 Dec 2018 11:57:07 -0800 (PST)
Received: from localhost.localdomain
 (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net.
 [173.230.104.22])
 by smtp.gmail.com with ESMTPSA id d128sm16530360iof.37.2018.12.25.11.57.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 25 Dec 2018 11:57:06 -0800 (PST)
From: Kangjie Lu <kjlu@umn.edu>
To: kjlu@umn.edu
Subject: [PATCH] hwtracing: stm: avoid a double-fetch case when fetching
 policy id
Date: Tue, 25 Dec 2018 13:56:37 -0600
Message-Id: <20181225195637.69304-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181225_115720_563691_5915483D 
X-CRM114-Status: GOOD (  13.80  )
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
Cc: Alexandre Torgue <alexandre.torgue@st.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-kernel@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 pakki001@umn.edu, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

"size" is fetched from user space and security checked. The fix avoids
fetching it again. Since "size" is no longer used after the second
fetch in the current code, so let's just skip copying "size" in the
second fetch.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/hwtracing/stm/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 93ce3aa740a9..55df1d374c57 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -752,7 +752,8 @@ static int stm_char_policy_set_ioctl(struct stm_file *stmf, void __user *arg)
 	if (!id)
 		return -ENOMEM;
 
-	if (copy_from_user(id, arg, size)) {
+	if (copy_from_user(id + sizeof(size),
+				arg + sizeof(size), size - sizeof(size))) {
 		ret = -EFAULT;
 		goto err_free;
 	}
-- 
2.17.2 (Apple Git-113)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
