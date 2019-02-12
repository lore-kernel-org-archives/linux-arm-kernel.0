Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC96C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:45:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BF332084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ff0CGhtP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF332084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=hLY/iHcm7GrqQV4WEllO9NQZpTQdaUUS0e0H6jAmnFA=; b=Ff0
	CGhtPMrQhhIcZb5tS4Zr9i2eWZ6zw6n0GzJN+o4lgIeR+D9sBJd/SoCd5TL3/ZqqNRaZeMxQWrpiL
	4G6f9HwE5zd0Ow4wUkuKsECAmXJimcuive/jYu30zimk6w9WsjYu7+WpxMk1xDKOyWIr7JfO8LclM
	X4G2XW4pGkE2dHTVVbxtybQFoU+lloI1FnSmu3h0uUyhdAgWTqeDcMrCvXo9jUqIOukFPIxPBNsRc
	Y5dZVVoCeH0aKYECxBPsPi+oV+lTwjjJYnqHENStu9M98bFNMbBJb4aHOpDiT+ybSTkgnkAyGbiNy
	B9DYhnoMJ3aDjRBd1Ie0zKFdApyD6Dw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gthkS-00048w-G8; Tue, 12 Feb 2019 23:45:56 +0000
Received: from out1.zte.com.cn ([202.103.147.172] helo=mxct.zte.com.cn)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gthkN-000478-Tl; Tue, 12 Feb 2019 23:45:54 +0000
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
 by Forcepoint Email with ESMTPS id 8E590E239FC4DE14821F;
 Wed, 13 Feb 2019 07:45:41 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
 by mse01.zte.com.cn with ESMTP id x1CNjZ1E001782;
 Wed, 13 Feb 2019 07:45:36 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2019021307455443-25782367 ;
 Wed, 13 Feb 2019 07:45:54 +0800 
From: Wen Yang <wen.yang99@zte.com.cn>
To: narmstrong@baylibre.com
Subject: [PATCH v2 1/4] media: platform: meson-ao-cec: fix possible object
 reference leak
Date: Wed, 13 Feb 2019 07:44:35 +0800
Message-Id: <1550015075-41548-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2019-02-13 07:45:54,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-02-13 07:45:28, Serialize complete at 2019-02-13 07:45:28
X-MAIL: mse01.zte.com.cn x1CNjZ1E001782
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_154552_123510_46D98117 
X-CRM114-Status: GOOD (  11.79  )
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
Cc: wang.yi59@zte.com.cn, khilman@baylibre.com, linux-kernel@vger.kernel.org,
 "Hans Verkuil \(hansverk\)" <hansverk@cisco.com>,
 linux-media@lists.freedesktop.org, xue.zhihong@zte.com.cn,
 Wen Yang <yellowriver2010@hotmail.com>, linux-amlogic@lists.infradead.org,
 mchehab@kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The call to of_parse_phandle() returns a node pointer with refcount
incremented thus it must be explicitly decremented here after the last
usage.
The of_find_device_by_node() takes a reference to the underlying device
structure, we also should release that reference.

Hans Verkuil says:
The cec driver should never take a reference of the hdmi device.
It never accesses the HDMI device, it only needs the HDMI device pointer as
a key in the notifier list.
The real problem is that several CEC drivers take a reference of the HDMI
device and never release it. So those drivers need to be fixed.

This patch fixes those two issues.

Fixes: 7ec2c0f72cb1 ("media: platform: Add Amlogic Meson AO CEC Controller driver")
Suggested-by: Hans Verkuil (hansverk) <hansverk@cisco.com>
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Hans Verkuil (hansverk) <hansverk@cisco.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Wen Yang <yellowriver2010@hotmail.com>
Cc: linux-media@lists.freedesktop.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-media@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
v2->v1: 
- move of_node_put() to just after the 'hdmi_dev = of_find_device_by_node(np)'.
- put_device() can be done before the cec = devm_kzalloc line.

 drivers/media/platform/meson/ao-cec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/meson/ao-cec.c b/drivers/media/platform/meson/ao-cec.c
index cd4be38..f757ece 100644
--- a/drivers/media/platform/meson/ao-cec.c
+++ b/drivers/media/platform/meson/ao-cec.c
@@ -613,9 +613,11 @@ static int meson_ao_cec_probe(struct platform_device *pdev)
 	}
 
 	hdmi_dev = of_find_device_by_node(np);
+	of_node_put(np);
 	if (hdmi_dev == NULL)
 		return -EPROBE_DEFER;
 
+	put_device(&hdmi_dev->dev);
 	ao_cec = devm_kzalloc(&pdev->dev, sizeof(*ao_cec), GFP_KERNEL);
 	if (!ao_cec)
 		return -ENOMEM;
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
