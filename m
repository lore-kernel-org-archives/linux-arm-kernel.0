Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EC5C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:58:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33A5A20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kn92gxee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A5A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=pEMzc416E0yM9tkUBM1VC3VlJSP2srkBh5Z8NZmFCfk=; b=Kn9
	2gxeelrOf8CzIGvIrsPD7E2l07egE8GiTqXO6c1tZV1dlCYY+KsmUXwR/fJn4wtRlGbzDDapLsGHb
	tvfJNhWyuFn7Ke4meRDWIzJPMmQOL0RxhOm4LfVAEqRkJGNFAbc9QIdcFPSb1kovHF3MWrnNqE0vn
	dRIjsG4kA0RK6Mh5clATewjAxIOh5bLBEasAA/lg5jiLCPKord9jKAAJ1gO3TD6vqsD5b98JtZEhd
	9cfCm3KvgY0qexffgrWnEQqOkTlAYI7M7TpkOrgY4S3XxTAnbYDuWY2brie8OgYST8HzugK7wRuij
	Kxh8+BfF3hmZCckLkshaPThE/8dE6fQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUExa-0007J1-B0; Tue, 04 Dec 2018 17:58:14 +0000
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUExV-0007HT-Qq
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 17:58:12 +0000
Received: from localhost.localdomain (85-76-96-200-nat.elisa-mobile.fi
 [85.76.96.200])
 by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 88132B00DD;
 Tue,  4 Dec 2018 19:57:54 +0200 (EET)
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org
Subject: [PATCH] ARM: OMAP1: fix USB configuration for device-only setups
Date: Tue,  4 Dec 2018 19:57:42 +0200
Message-Id: <20181204175742.2634-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_095810_039826_D7D72912 
X-CRM114-Status: UNSURE (   9.67  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Aaro Koskinen <aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Currently we do USB configuration only if the host mode (CONFIG_USB)
is enabled. But it should be done also in the case of device-only setups,
so change the condition to CONFIG_USB_SUPPORT. This allows to use
omap_udc on Palm Tungsten E.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap1/Makefile           | 2 +-
 arch/arm/mach-omap1/include/mach/usb.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index e8ccf51c6f29..ec0235899de2 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -25,7 +25,7 @@ obj-y					+= $(i2c-omap-m) $(i2c-omap-y)
 
 led-y := leds.o
 
-usb-fs-$(CONFIG_USB)			:= usb.o
+usb-fs-$(CONFIG_USB_SUPPORT)		:= usb.o
 obj-y					+= $(usb-fs-m) $(usb-fs-y)
 
 # Specific board support
diff --git a/arch/arm/mach-omap1/include/mach/usb.h b/arch/arm/mach-omap1/include/mach/usb.h
index 77867778d4ec..5429d86c7190 100644
--- a/arch/arm/mach-omap1/include/mach/usb.h
+++ b/arch/arm/mach-omap1/include/mach/usb.h
@@ -11,7 +11,7 @@
 
 #include <linux/platform_data/usb-omap1.h>
 
-#if IS_ENABLED(CONFIG_USB)
+#if IS_ENABLED(CONFIG_USB_SUPPORT)
 void omap1_usb_init(struct omap_usb_config *pdata);
 #else
 static inline void omap1_usb_init(struct omap_usb_config *pdata)
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
