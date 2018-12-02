Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE2BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 09:06:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F58206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 09:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DptjRWwP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F58206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=cG9vzlfGtnta/fKHJlV9fHonodl+JNJinLcf5LYef6Y=; b=Dpt
	jRWwPB/s4hCb/eoHpQfomOSOBROjBME7YC6049TSg9SifFuNu8LUp5W91gogYJN2BN8q4j45OrMRt
	qLq2Q0qP/uZuXKyvPrzTXz9VjPp7dy8FCdacAX/RUXMSd1+R7zcASryCqtOy+oWZdmiHFrN7Te9DG
	RnoxWfoIzov7WHZx0OKhDopuFVKyJcac+ttTQCn6qeAyIoIO+kUG1OMxzw3nguFjamkS4HlilQWXP
	FNn5BpDe0OhoumaBsJiIcoIryvFJv3Cva/YSmJa3rMlcT98pXnNBa/stMXiWL/Pd687gEiuxLsMvU
	S3qNR3xSA8/tW2UZcs2hyCXkqGXc/MQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTNhI-0007Sd-Io; Sun, 02 Dec 2018 09:05:52 +0000
Received: from www.osadl.org ([62.245.132.105])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTNh0-0007Q0-Ab
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 09:05:37 +0000
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at
 [178.115.242.59])
 by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id wB2942Us005968;
 Sun, 2 Dec 2018 10:04:02 +0100
From: Nicholas Mc Guire <hofrat@osadl.org>
To: Li Yang <leoyang.li@nxp.com>
Subject: [RFC PATCH] soc: fsl: guts: handle devm_kstrdup() failure
Date: Sun,  2 Dec 2018 10:00:58 +0100
Message-Id: <1543741258-17433-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_010534_668944_6D16D1F0 
X-CRM114-Status: GOOD (  10.81  )
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Nicholas Mc Guire <hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

devm_kstrdup() may return NULL if internal allocation failed.
soc_dev_attr.machine  should be checked (although its only use
in pr_info() would be safe even with a NULL). Therefor
in the unlikely case of allocation failure, fsl_guts_probe() returns
-ENOMEM as this allocating failing is an indication of something
more serious going wrong at system level.

As  machine  is from the device tree which I assume to be RO - if
that assumption is always correct - a better alternative would be
to use devm_kstrdup_const() here. That would then simply copy the
reference to the RO data and not perform any allocation at all.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: a6fc3b698130 ("soc: fsl: add GUTS driver for QorIQ platforms")
---

Problem located by experimental coccinelle script

Patch was compile tested with: multi_v7_defconfig (implies FSL_GUTS=y)

Patch is against 4.20-rc4 (localversion-next is next-20181130)

 drivers/soc/fsl/guts.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 302e0c8..a0c751b 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -156,8 +156,11 @@ static int fsl_guts_probe(struct platform_device *pdev)
 	if (of_property_read_string(root, "model", &machine))
 		of_property_read_string_index(root, "compatible", 0, &machine);
 	of_node_put(root);
-	if (machine)
+	if (machine) {
 		soc_dev_attr.machine = devm_kstrdup(dev, machine, GFP_KERNEL);
+		if (!soc_dev_attr.machine)
+			return -ENOMEM;
+	}
 
 	svr = fsl_guts_get_svr();
 	soc_die = fsl_soc_die_match(svr, fsl_soc_die);
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
