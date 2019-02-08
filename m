Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC813C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:39:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A245218DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PKRINtjK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jt9t/toj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A245218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=g3PStKEZBV1xtf9AXSvn4Kb767jtcJEJv6Bt5vUSJiw=; b=PKR
	INtjKhzAtxuVbFXtEEnwQkJV9VmP6ngU7xa9U1orOousJ722S0ApC9ZxnMwYP6o8WL8Ijuojytipk
	jW8fW2UsP+N+GNYnHT3OLGxi9E/kV+dNe5i6HgFQMGv2VCNdxw2L6WuUNgjOG3CB5siiVBtmJZvRj
	Q3Cv+WdYz5YbPz1z1pHqIv3zp4N/McV2xqUsppqkVG4A/tInkHbnhAvurdBLeTXpos8R9YK5onECF
	T783/NGdWkupXfVkHjqqiUW0TPBRqcw8zhu+fp2W/oFmeIeH7a7BlVDE5z6DQWOxXM4VYVaGgsV60
	8uWEI4pe3zk02oBF+pE+ANcE6UG9fyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsFk9-0005Qm-La; Fri, 08 Feb 2019 23:39:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsFk6-0005QN-Q3
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 23:39:36 +0000
Received: from localhost.localdomain (unknown [194.230.155.153])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A3BDE21841;
 Fri,  8 Feb 2019 23:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549669174;
 bh=9ubX/au2dWVjytwhvCV+q9GXk0eeWyNXhgEMCJ9CNSE=;
 h=From:To:Cc:Subject:Date:From;
 b=jt9t/toj2uHZUHNa6wKwZ7Ti1eePDNZUVB4vaYk0+JMfOJYpNto7F5G/pvWKr5Avi
 Ezi2jIkukYXSNn1TS/ZPiP+ge6PVOwWf76IqUAu6unORnN2WoMlReWD0WSFxOV/8iF
 gMcvGiEppUv6N5AglpYxVmtE2VHX2M/UWqoc8se0=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Bakker <xc-racer2@live.ca>,
 =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH]  iio: adc: exynos-adc: Fix NULL pointer exception on unbind
Date: Sat,  9 Feb 2019 00:39:27 +0100
Message-Id: <20190208233927.5392-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_153934_874363_846E1A2F 
X-CRM114-Status: GOOD (  14.36  )
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
Cc: stable@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Fix NULL pointer exception on device unbind when device tree does not
contain "has-touchscreen" property.  In such case the input device is
not registered so it should not be unregistered.

    $ echo "12d10000.adc" > /sys/bus/platform/drivers/exynos-adc/unbind

    Unable to handle kernel NULL pointer dereference at virtual address 00000474
    ...
    (input_unregister_device) from [<c0772060>] (exynos_adc_remove+0x20/0x80)
    (exynos_adc_remove) from [<c0587d5c>] (platform_drv_remove+0x20/0x40)
    (platform_drv_remove) from [<c05860f0>] (device_release_driver_internal+0xdc/0x1ac)
    (device_release_driver_internal) from [<c0583ecc>] (unbind_store+0x60/0xd4)
    (unbind_store) from [<c031b89c>] (kernfs_fop_write+0x100/0x1e0)
    (kernfs_fop_write) from [<c029709c>] (__vfs_write+0x2c/0x17c)
    (__vfs_write) from [<c0297374>] (vfs_write+0xa4/0x184)
    (vfs_write) from [<c0297594>] (ksys_write+0x4c/0xac)
    (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)

Fixes: 2bb8ad9b44c5 ("iio: exynos-adc: add experimental touchscreen support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/iio/adc/exynos_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index fa2d2b5767f3..41da522fc673 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -929,7 +929,7 @@ static int exynos_adc_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct exynos_adc *info = iio_priv(indio_dev);
 
-	if (IS_REACHABLE(CONFIG_INPUT)) {
+	if (IS_REACHABLE(CONFIG_INPUT) && info->input) {
 		free_irq(info->tsirq, info);
 		input_unregister_device(info->input);
 	}
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
