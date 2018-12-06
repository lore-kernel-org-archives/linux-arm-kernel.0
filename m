Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A07C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:29:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 475C32146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qGoBhND9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475C32146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=LqiYMF8gKlbg+oAuLBSkvlxn26unoI9X/KYp5imnjUs=; b=qGoBhND9/Pa4e/eWqnqYt8WVWd
	FYPRFERBTZ7Pypg92aHoSGQAExzv3ywHRmfbAYrfXoPiBceo/qtHMteGVuuOHjeuYI+sWD4/w6kC4
	wGGrfItR+b+gXlzPjxNnxZuwqWFP43G0YxAFXgk7tlDEkVlA9dVsJaOjvuY9oshdUgki19WBpC9Iw
	Nv48wP5+gIuoi5xxqc6QRUG11BYpLf8x0oNnAkWvOFbU0ltM6dtZ3M3u393Zuz2bG92ETjZDixg+7
	uu630tvrQtlZ5aLml2oYybbQwMR+0N0wueRpVhoU4RGa4kg3+ccqfcmYeZ6vUPdE2n7eZDl9iT1H6
	wubCLq5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUyP8-00051a-F3; Thu, 06 Dec 2018 18:29:42 +0000
Received: from mout.kundenserver.de ([212.227.126.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUyOu-0004ol-QP
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 18:29:30 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MF2YC-1gfwk70DOq-00FUZS; Thu, 06 Dec 2018 19:29:07 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 01/10] staging: bcm2835-camera: Abort probe if there is no
 camera
Date: Thu,  6 Dec 2018 19:28:51 +0100
Message-Id: <1544120940-13716-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544120940-13716-1-git-send-email-stefan.wahren@i2se.com>
References: <1544120940-13716-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:XvAVjqs6KgnP4g7WXUG/unGRmYutJ1EvDtdxvPNEr0q3AAHovfR
 IX1NQ1hYPpUi4UhcglcgG9qNepfq3c6qmF0v4YFqClhMCAoH7cEWSFxrg9oOwDRuntAmq9D
 x9vVlVqjYzyogVesGhmMHrsnz9jjolDwq3eMcGF7uxYixeAC8rSqjsMX/FcKw3huHqW28iL
 s9634eNwM0ZzvQLFLkeBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IejI2bNWRnE=:bhw9v6sqGP7gdHsIiANXLQ
 bMWGWVQEPOwiuYQ8hjeqfJPOk2vZQBBjK9XLQZi85cbZ709+tylxxl7+oP8KTrI1aCQ8UYyTW
 PBYsGIqoypMjzzUQKTFZs1lpf63qg95Tu8EyAgBXcOp6pLwbi1ffmY+wOJBFuQQmSkiuHLLf/
 RrpL84jEzlVRnLmUljCHOnnW50KhvR1gSSj7DHzIOrmhrVKP3dMHi/aEbQ+Sn/dQF5AxYYhqA
 OyGd9RHREoLVA0vFilSS9Bci+NsZY4ai+oppUoyp7jxHuCEzsS9KDnnGT3imx9+zGA9XrzfNA
 ldeeJUo1xaMd0O1l8ZdwPclOzZ5YCXCdCFMI5wKskFhExfVupI0lKtOdTCVOw8fNA8cXSjvn3
 FV254gQ1vGw8tt4k/KHKLsq5cDNhz+fA6PPsHnFF/hXpMvQf731UdZwvau90/H0VfDL5CgIfh
 uu/OCXvE3NMZ9GbbKORhA8EjRGRM2zSBnQf52oT/IOQgQBF/NRN5dySm2JxJyzM89/hYZzdkC
 9CUEhPSrlOH+IVUx2b5vGmW62ocpnFrz7Ulifa9iHWpGZ+904yuVUQDMbLMl9POTEqRxu2Mt2
 xSmsexxg4YPazLJGvxyEkS+i/GKfIxoYilrAbFTbdSFvQrkmdESZ9109CGxkZGDz6OBGw4//3
 +nrjRoc9cClCF8uQEzGRcAtPrYY+QK0Kh8Ki80yLSVnoWqJkJ4c7eNhxucGQ5+7SgJ44W5knz
 IlUHEdxY5U2+DMsKFXWxYT/6nW5yW6Up+zFLxyWlebLxM/KgiNlSSW8KVh4=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_102929_174214_21669284 
X-CRM114-Status: GOOD (  13.21  )
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

Abort the probing of the camera driver in case there isn't a camera
actually connected to the Raspberry Pi. This solution also avoids a
NULL ptr dereference of mmal instance on driver unload.

Fixes: 7b3ad5abf027 ("staging: Import the BCM2835 MMAL-based V4L2 camera driver.")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index c04bdf0..d6fbef7 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -1841,6 +1841,12 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
 	num_cameras = get_num_cameras(instance,
 				      resolutions,
 				      MAX_BCM2835_CAMERAS);
+
+	if (num_cameras < 1) {
+		ret = -ENODEV;
+		goto cleanup_mmal;
+	}
+
 	if (num_cameras > MAX_BCM2835_CAMERAS)
 		num_cameras = MAX_BCM2835_CAMERAS;
 
@@ -1940,6 +1946,9 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
 	pr_info("%s: error %d while loading driver\n",
 		BM2835_MMAL_MODULE_NAME, ret);
 
+cleanup_mmal:
+	vchiq_mmal_finalise(instance);
+
 	return ret;
 }
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
