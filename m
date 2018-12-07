Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E93AC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:22:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 102B9208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RYRjKXqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102B9208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=SwEb4jUKpMG9FAtLJI4uQvdQSWzBI2bcoQiSL8b2qwE=; b=RYRjKXqe5k3v9iJonM9gM02KRl
	g5u+GnPaZe+CTytLYQqbqATpC+oY/BoFZEDdhEjP3F6iCszgZ6+LtBA3Ho0OnILXwiMCp1mFLfL00
	XACdORsDxI5dyT+8l3ByPrUM6SoB1gzQOJXXSQ39cciyXlQLNEeRHDqMZQZ+NKHvPBnHmundV70T4
	GzV92+L69Q51vxo+9jU7CrS6HIgZ4LLjjY12uIS0M8xaTOd6O/GYUPINJeaZ4554YNWdqKtWfsIZa
	Q2GNF8/1IxXOl/DD4TGLOMS+pbr9rurByNzeDJV1dB4N7NjcVMWLzjUR9lPVXmuhR41MKydQ/Gl/B
	F/5wKXyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVKlX-0008Fe-Mf; Fri, 07 Dec 2018 18:22:19 +0000
Received: from mout.kundenserver.de ([212.227.126.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVKlH-0007y0-Bl; Fri, 07 Dec 2018 18:22:04 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MzQbw-1hQReE2Bua-00vMdP; Fri, 07 Dec 2018 19:21:46 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] firmware: raspberrypi: notify VC4 firmware of a reboot
Date: Fri,  7 Dec 2018 19:21:11 +0100
Message-Id: <1544206871-15725-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544206871-15725-1-git-send-email-stefan.wahren@i2se.com>
References: <1544206871-15725-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:0PrJEB12psvLK+xaMPz3S3bkEAujIousM673CRFz2HY9f09Ev1C
 hr3WhO0fmGKlEyt1P1DwsIWSl3GQgZnRCEscb5f2mvTT/t6GMbXagcoPxqor4SttUfmjRnX
 8TujpRNYQkmwLncHuoJSJKbFoY5gqmMwF8zQY8QEHSYWsvWDyRP01AM66h4wqC/eIZplgnN
 6lg2uLFSExy2HuebbNAyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uwM1fv4boXI=:9AD+SakKhZP1zebS3hz95g
 pQ46nrxptke6QdMzHdPETNIHfyGVKGSh/RnVXfy9xH1wdohKA0RHDhQo5vvPaSdj3QLr5sSN/
 Q32el3nS9s6jLmOzFrrCDpTPGdiDLT0M8yokAHjmo7nnCqBzZ2Tni1F8NhdL2EcEUngfclLOH
 dHLYjyL3z+gGMFFXJzeYfeyq7QD3wEu4e2GZ1RpzyvO05kFCvCJ+y0RH+Uhta3WZ80BPkov/m
 AB1rQy8rvmkND1dOzmXWNobFiCqV2ckg4kbq1BFk5iBTNxsL3xT+zSQokfhBh4NO+CWlnQKYa
 G6oaFZH22DJHslMSso2UyisuFzvKjPhxNDeb4j7pp1MIcvQz5NpptnCnx+o8vze81ddwZ0m8H
 SpyBsJ265x4s/FS7dcWgGDYWRDSSgLzI2Tw5Yp+9+T8FUsVNnohVnRKolRXziQWyKycMlNQ0I
 tzhjeIUB6GdEtMGQ7ppkQ6QNiEsHwV4HeKY+1+BYZrSBjmfs9UWbGHIl7caLxkG9/IKlg10tq
 mKbVAQBaHAOTuhWk9GzB4TqbWLrch8yFC4LbV71qxr35gyVNtRO6fI6Gt6+9Pl8q4t+r/shrr
 1xY7XcidcoaWSnVLDafcJhrfIcc73eovcgBDDnkZonLJVYGcLgUcWH87icPhhXzzwi+I0l591
 JQPJJ/jiLpPBo8IupjnZAyKNoNG3WxR7+d+21G9J1qoHjM4qnpDUTFRlPK/Ifw6QQiIFQNOMR
 N8Tqcqpa7qbmDYB4fyTV48CQAIwRfrmXbfYGaO2bqMdVl/N9KQ10zRUFqoM=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_102203_700744_AB47380A 
X-CRM114-Status: GOOD (  12.53  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
 bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The firmware-owned GPIO expander on RPi 3 B+ must be in same state
after a reboot as initial power on. Otherwise this would cause a
network boot failure of the BOOTROM. So inform the VC4 firmware to restore
the expander before doing a reboot.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Tested-by: Phil Elwell <phil@raspberrypi.org>
---
 drivers/firmware/raspberrypi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index a135581..61be15d 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -238,6 +238,16 @@ static int rpi_firmware_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static void rpi_firmware_shutdown(struct platform_device *pdev)
+{
+	struct rpi_firmware *fw = platform_get_drvdata(pdev);
+
+	if (!fw)
+		return;
+
+	rpi_firmware_property(fw, RPI_FIRMWARE_NOTIFY_REBOOT, NULL, 0);
+}
+
 static int rpi_firmware_remove(struct platform_device *pdev)
 {
 	struct rpi_firmware *fw = platform_get_drvdata(pdev);
@@ -278,6 +288,7 @@ static struct platform_driver rpi_firmware_driver = {
 		.of_match_table = rpi_firmware_of_match,
 	},
 	.probe		= rpi_firmware_probe,
+	.shutdown	= rpi_firmware_shutdown,
 	.remove		= rpi_firmware_remove,
 };
 module_platform_driver(rpi_firmware_driver);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
