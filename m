Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DC7C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 12:05:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE0A20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 12:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HF0RY+0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE0A20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=+rAJf+YtbvKLUF6VQ2h5Ot/r8SuSx3X/7Ba2CSr+uGY=; b=HF0
	RY+0a2FgFyIMsqj61fSc7DxDr052X1qY1w+/VI9RGRTE2A6qBWf8GdhbRk4TNygO73j9E2fGrsx1R
	nO0gypw+9wOWyUZR11HmMw9ONDvUDN87Iq/eGMjFtg3Sfk1DU2k0OukDtoFDSlnuKMEJcQEzeeOJa
	jMmLIw0yo0o8dUQoB5M9G/fjF2xNicwNmw2htHl25q+GccWQCZ6vKuySnM5LIndBkgpwuMpm7LrR1
	zbr1pGCCm2WriK3QWkBaKHliHxKLqVK5VLPhSLa/7ugKQCpMbRrqlJwmHINf7pzMJkVKDJelfihfv
	h6gKbUzM1Fv5YnFEtGqBYXErXlGV+Yw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gT41M-0001w8-3y; Sat, 01 Dec 2018 12:05:16 +0000
Received: from www.osadl.org ([62.245.132.105])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gT41I-0000gX-LJ
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 12:05:14 +0000
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at
 [178.115.242.59])
 by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id wB1C0Tuv022428;
 Sat, 1 Dec 2018 13:00:30 +0100
From: Nicholas Mc Guire <hofrat@osadl.org>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: [RFC PATCH] gpio: pl061: handle failed allocations
Date: Sat,  1 Dec 2018 12:57:18 +0100
Message-Id: <1543665438-26756-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_040513_026170_44D6F9A6 
X-CRM114-Status: GOOD (  12.87  )
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
Cc: Nicholas Mc Guire <hofrat@osadl.org>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

devm_kzalloc(), devm_kstrdup() and devm_kasprintf() all can
fail internal allocation and return NULL. Using any of the assigned
objects without checking is not safe. As this is early in the boot
phase and these allocations really should not fail, any failure here
is probably an indication of a more serious issue so it makes little
sense to try and rollback the previous allocated resources or try to
continue;  but rather the probe function is simply exited with -ENOMEM.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 684284b64aae ("ARM: integrator: add MMCI device to IM-PD1")
---

devm_kstrdup() issue found by experimental coccinelle script, the rest during
review of the reported issue.

Q: Not sure if brute force returning here without rollback of previously
   allocated resources is acceptable - but I guess if any of those
   allocations failed the system is doomed anyway so trying a  continue;
   here does not seem sensible to me.

While at it switched the kasprintf to the managed API variant - or should
this be done in a separate patch ?

Patch was compile tested with: multi_v4t_defconfig (implies
INTEGRATOR_IMPD1=y)

Patch is against 4.20-rc4 (localversion-next is next-20181130)

 arch/arm/mach-integrator/impd1.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index a109f648..0f916c2 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -393,7 +393,11 @@ static int __ref impd1_probe(struct lm_device *dev)
 					      sizeof(*lookup) + 3 * sizeof(struct gpiod_lookup),
 					      GFP_KERNEL);
 			chipname = devm_kstrdup(&dev->dev, devname, GFP_KERNEL);
-			mmciname = kasprintf(GFP_KERNEL, "lm%x:00700", dev->id);
+			mmciname = devm_kasprintf(&dev->dev, GFP_KERNEL,
+						  "lm%x:00700", dev->id);
+			if (!lookup || !chipname || !mmciname)
+				return -ENOMEM;
+
 			lookup->dev_id = mmciname;
 			/*
 			 * Offsets on GPIO block 1:
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
