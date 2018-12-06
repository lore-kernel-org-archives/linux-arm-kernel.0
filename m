Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFE6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:30:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6642208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fcBKQmWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6642208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=NgABWu4GRYKy/lijhCcDhHoYii2Jm/QwlleXvChqrZU=; b=fcBKQmWiro0F2T8Fo69y0mfLRT
	9Htlfa+C1k5iX+MdTkveb7RYKuRUd2wz9VBCS7ZS73vBPfnhOrojkIvPc5OEbB9pPyyhXmuKOCKeX
	mOMDcsCci6gtqe6K95ePv6qYpOYyVfgRF2zy2r7SH38WAE88aI3AoM3qCoAMLQdQArmKJoZdGHwSm
	wjwl9ZkPpG02EGNxJLb9dJgyc3ApSct/uEp4GEKq8QtyQtdLWtdSXoe86B+TErLz5FAaklttn6odw
	quxbXcza9sx8AITrF0UFIdZNc8s8Gms9xa23JnB7wt8JjQ0+VujU16zPHg7r8hLwBkvhUStad9tKe
	GwpnE/qA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUyPX-0005c1-4b; Thu, 06 Dec 2018 18:30:07 +0000
Received: from mout.kundenserver.de ([212.227.126.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUyOv-0004op-8B
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 18:29:32 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1My6xz-1hPQQl0J2N-00zVej; Thu, 06 Dec 2018 19:29:08 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 04/10] staging: vchiq_arm: Fix camera device registration
Date: Thu,  6 Dec 2018 19:28:54 +0100
Message-Id: <1544120940-13716-5-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544120940-13716-1-git-send-email-stefan.wahren@i2se.com>
References: <1544120940-13716-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:RNRNSadj1RZ7N0BB46g43eo8zHPBOZ2r0T7RdX4o8WKt2QdxAFq
 K13hprJK3vI3c91hc7EmexEbjsm1+/hQNxELBlsUxo4zkAe7i1X0omqaI0a5NQ1WdPPcIsc
 XzDkAFOEkgo2qDodXzINNOyy/874cmqLTubTwPs6GGPTN4UBDXNyU1iuk5D4sZzB1UAncRJ
 zY4tWnCqWGclN6Oqen9Zg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q2AQONZiF9k=:RfmJ336hL9J4YbW/0KhHqh
 IqwUORzWl2OYOBp7xNqQEFHqWmIU6d6mdzdGzV4pop4G3F9uIkvc4GyL7OSFfNub45jLo5Fy0
 2CoHTH1r+VzLlnDubJA6WFebKWklxERzI6N4SxKJetBBjPIrkfrrRD99YWLBJzFWpzu4ZY+6r
 bMtdJIXUpVbTGXYzEWO8vfX7yN8LAjlCgq3gdL1rPLtcqCper6pkGpcsE8BLUqOR/Dt3mDJoW
 5H2wsaaLiRWgEzIr1/gNM3+7TIzDpF7kEfS7WGvhEVss3IvO+NbtAkdgkVY3ZZlZn+LqZ78dZ
 GxQ2ePenRP84jUn8YWpbquAqTvrB1e/AtHndPo7mO26fLCPn726ZhRj4h6Imo+oq8K85OfQwo
 +wnN0okzxNarLLieurlsQNV79JmN6dcdTQr4pNwnmq7KvUCtISvrhFEHIIk/KuQ8pP6bmMg4Z
 otW5muf10OHoqNRx6vNVhZf27e7sjN6BKogTi9wt+IEMTB4GJVz+qoq0vNqQjzeHLoqn1hhDd
 hwTAWU/gAc1N2/9EVjYsVId1Ou09+U4taNUgTwUBUNCbMaeDlLlRqWW4XDGNUeRixEEiOY5uu
 FDf96U82izST978h5w89c2wYXSEHE2HBGsxK/n1qu7tq1FRjYxVLUl8rAEZiqnu5G9SOaIbKL
 PGmm+bRfjMQGolrZM5UGtozrnTV2AkHJDfqUtnQA/rMn9c1fxOGXXObJA85RoQG1x3F2XSaC2
 1d6mKBH8p8C5TcvYbY5VIdnq6XVMO4Q36ckSW/qWHk0ubd3He7dwHXGNv0A=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_102929_591775_D85A2FCD 
X-CRM114-Status: GOOD (  14.17  )
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
Cc: devel@driverdev.osuosl.org, Stefan Wahren <stefan.wahren@i2se.com>,
 Takashi Iwai <tiwai@suse.de>, Eric Anholt <eric@anholt.net>,
 linux-arm-kernel@lists.infradead.org,
 Dave Stevenson <dave.stevenson@raspberrypi.org>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Since the camera driver isn't probed via DT, we need to properly setup DMA.

Fixes: 37b7b3087a2f ("staging/vc04_services: Register a platform device for the camera driver.")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  | 27 +++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 0caee2d..f2c1dcd 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -49,6 +49,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/compat.h>
+#include <linux/dma-mapping.h>
 #include <soc/bcm2835/raspberrypi-firmware.h>
 
 #include "vchiq_core.h"
@@ -3479,6 +3480,28 @@ static const struct of_device_id vchiq_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, vchiq_of_match);
 
+static struct platform_device *
+vchiq_register_child(struct platform_device *pdev, const char *name)
+{
+	struct platform_device_info pdevinfo;
+	struct platform_device *child;
+
+	memset(&pdevinfo, 0, sizeof(pdevinfo));
+
+	pdevinfo.parent = &pdev->dev;
+	pdevinfo.name = name;
+	pdevinfo.id = PLATFORM_DEVID_NONE;
+	pdevinfo.dma_mask = DMA_BIT_MASK(32);
+
+	child = platform_device_register_full(&pdevinfo);
+	if (IS_ERR(child)) {
+		dev_warn(&pdev->dev, "%s not registered\n", name);
+		child = NULL;
+	}
+
+	return child;
+}
+
 static int vchiq_probe(struct platform_device *pdev)
 {
 	struct device_node *fw_node;
@@ -3529,9 +3552,7 @@ static int vchiq_probe(struct platform_device *pdev)
 		VCHIQ_VERSION, VCHIQ_VERSION_MIN,
 		MAJOR(vchiq_devid), MINOR(vchiq_devid));
 
-	bcm2835_camera = platform_device_register_data(&pdev->dev,
-						       "bcm2835-camera", -1,
-						       NULL, 0);
+	bcm2835_camera = vchiq_register_child(pdev, "bcm2835-camera");
 
 	return 0;
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
