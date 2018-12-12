Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CB6C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:54:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BEF420811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oWI4kS3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BEF420811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=atVA5qtgCEHOJNEnKfdW4uH1Bs9YG49FbnqEsbstxzk=; b=oWI4kS3ikJ08x5
	orplYDnrmJVNHe6lRns5yVrGXPXqvJWPAhuDz//7eM5GL83Pl8SKlkWstkFqrHtHStoE7Awt+dEXG
	KMZh9CClNpQ7TmvXOr6YZstc2K2bj5zeGmx9I3iNzPb9OTPjczuWBh/x22HuigREkpXluqggi+k/R
	tQLMXhocODAP96Uj9m5sKzTfD0URp/yC3W2ZV9iAGQXUs+OZdd26ny6Qa7xAiMlOj6OnoSjHs5MWq
	FZ7CQOgJN3j/glZmWTMrgo0tvXFzqOpkO7xnD5zwt6a0aK8+Rgdt6YnFnS7GfoTzxDiYTwmmzqTKA
	XJQKJV4SxQM60DndUt/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX9ee-0008M9-71; Wed, 12 Dec 2018 18:54:44 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX9eb-0008IS-5L; Wed, 12 Dec 2018 18:54:42 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 857FBAF81;
 Wed, 12 Dec 2018 18:54:27 +0000 (UTC)
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] staging: vchiq_2835_arm: quit using custom
 down_interruptible()
Date: Wed, 12 Dec 2018 19:51:34 +0100
Message-Id: <20181212185136.6620-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181212185136.6620-1-nsaenzjulienne@suse.de>
References: <20181212185136.6620-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_105441_455819_AB0A376D 
X-CRM114-Status: GOOD (  10.51  )
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
Cc: stefan.wahren@i2se.com, devel@driverdev.osuosl.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, eric@anholt.net,
 linux-rpi-kernel@lists.infradead.org,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

vchi_killable.h overrides down_interruptible() by implementing a
function similar to down_killable(). To make things simpler we turn
calls to down_interruptible() into kernel's implementation of
down_killable().

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index ecee54a31f8d..691038cdfdab 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -543,7 +543,7 @@ create_pagelist(char __user *buf, size_t count, unsigned short type)
 		(g_cache_line_size - 1)))) {
 		char *fragments;
 
-		if (down_interruptible(&g_free_fragments_sema) != 0) {
+		if (down_killable(&g_free_fragments_sema)) {
 			cleanup_pagelistinfo(pagelistinfo);
 			return NULL;
 		}
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
