Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1583C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:58:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C41292082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KSWnisFD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gQGoqtZC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="e5Au1lXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41292082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5hXuLR9Uq4mO35R2Xvofa/MAawmGjaeB5HZ24YrNb3I=; b=KSWnisFDwN7PVt
	00Io4oRWn6mbizq2jo53bJ9zo/G/4J6yMnCDgROFhlO4FluWF0wzx4J4EFj9fVNIRYXonrfYDSINA
	u+89moRTmQNXIBfVk+UPcfmcsj+/7Sc4aVFTdAC7fPAza/1AoMdEWnfiJ6kQF8MTXrf4Lcq6S5YGu
	UpPud23ZakTpz+v/7Dck+vfWbwWvjPGeIZ82xeAa7t3iGdaPrVkau1/0zt85cKXbcEpVOWQ7NrWSZ
	0O1lU9SbFII5hyvR+rPZHuFm6HSiOIGqjJuX6bU4xodP9kjJGvqTFKBQYnPVgeRNlv16UvPAQgfxI
	MxsleZW49aOSH3UefAdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCrN-0002Xi-6v; Thu, 31 Jan 2019 13:58:29 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCqp-0002L9-JC
 for linux-arm-kernel@bombadil.infradead.org; Thu, 31 Jan 2019 13:57:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L9qT/L4DhuaGAJ7qBZnKhfl1j2KQKPFuYoKVi0aeXEM=; b=gQGoqtZCjtTyYSwp3AQEqoW2w0
 o/0gbkAFpuWqWAuL3KXbDAXEoSvXi+qL9Nh20UprVOxyJfTSfX06SA41TmV4/GUUP1vm9Bxo9XHEp
 LOINFn9uDIl+8JDCpVGkUff4zSrWqA/BWSGvc4sC4Hw991DCuLOoMbye+yshkSar08dBIuL4/ItIn
 cwjlp95x437op4kTV/Yol2wkkZ3HkzmVYbxF4VvRZGN1n/BQM/sspfYh4gH/9jzpwI5hVgkVHuaty
 fXwqrYzf91jRBsBBePhkRdsX8/SnlBOV6jz2UAZDvO2i2dv5En3k+U/ezH88q7KPrsEbeFFJaLq3k
 8y9xIUOg==;
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCZo-00068r-4A
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:40:20 +0000
Received: by mail-wm1-x341.google.com with SMTP id m1so2540720wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 05:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L9qT/L4DhuaGAJ7qBZnKhfl1j2KQKPFuYoKVi0aeXEM=;
 b=e5Au1lXKcMGVzf2HCIvrba3ow8dKukNk0vS7q8EPeRZlOXYibXPRR8GyJFQ70Gu6lM
 lu/NLS2Fu2isd5eDGxxIyLAHxqO/06hjPzC78tZf8A4OhalyXNOPaLnWfuELdvZ8pTn+
 /R6HMy75h18WyYUVqV7C6u1ZoXJNZqbEf/NFFb4io7pQn+yYSkHnGUi++ehdoD70/omb
 32R2h+3EMsC+ShUL5/8rq6jGjgIYmuxmR4DXUP3k31KNL87D9eLOZe95K06TIHkfNcFT
 nFlg6l42ORyroswzDycKVr++DEE1bX12Z2TWrjN8A1+DJFT7wvxeDP+jdjlANCnhCQmT
 uaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L9qT/L4DhuaGAJ7qBZnKhfl1j2KQKPFuYoKVi0aeXEM=;
 b=GTAw1v+8oPbV37BIz+af2Fn5gDhb056TzysLlZNm8DdJp9nY4cfwqkzE81bJj44+vF
 tjGAimFC4Vfuh7G4PXLMiuuOyuWu3hTNCVMMJLvqZl3zaN8P76j+4q/uhoyoSEJhrdS5
 GdimOrQH1wVOwtbbq48WwrgAm/r6IAXikGyIwoO+V5VN9vcd3eFPZTRkrcj4OMqTEA6M
 E+wpZBvDj6lU5MRevHOf4YE7GMftSAoPcuj3fbNdDUF+C+7iYB71B0CymqCWT1rxwUHI
 iseu6h3GCr8Sw/WNhsegIYq1C+3rDUdyrI9eYHYvvfRzbJx1fKNyxCBQmRv4l9crWlCr
 Jlzg==
X-Gm-Message-State: AJcUuke1jbUhAKyc+z00YUJ2AnAUM17H8ZOq+Pq5iIKpChWiZ8XjmHXj
 2KxfZdwGjV7a+w0c0iJrK29dlQ==
X-Google-Smtp-Source: ALg8bN5ugTtKbDvNIkD3NnnntM+dInMSRDxKmxkYXU3KGu0I7hpyCIDQ+W242HUk2m4I14x0y1G/qg==
X-Received: by 2002:a1c:23cb:: with SMTP id j194mr27851527wmj.91.1548942017998; 
 Thu, 31 Jan 2019 05:40:17 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.40.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 05:40:17 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 31/35] irqchip: davinci-cp-intc: move the driver to
 drivers/irqchip
Date: Thu, 31 Jan 2019 14:39:24 +0100
Message-Id: <20190131133928.17985-32-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_084020_176274_0E460F02 
X-CRM114-Status: GOOD (  12.97  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The cp-intc driver has now been cleaned up. Move it to drivers/irqchip
where it belongs.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/Kconfig                             | 8 ++------
 arch/arm/mach-davinci/Makefile                            | 2 --
 drivers/irqchip/Kconfig                                   | 5 +++++
 drivers/irqchip/Makefile                                  | 1 +
 .../cp_intc.c => drivers/irqchip/irq-davinci-cp-intc.c    | 0
 5 files changed, 8 insertions(+), 8 deletions(-)
 rename arch/arm/mach-davinci/cp_intc.c => drivers/irqchip/irq-davinci-cp-intc.c (100%)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 71a4d875dd39..5a59cebc7d0a 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -1,10 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 if ARCH_DAVINCI
 
-config CP_INTC
-	bool
-	select IRQ_DOMAIN
-
 config ARCH_DAVINCI_DMx
 	bool
 
@@ -33,13 +29,13 @@ config ARCH_DAVINCI_DA830
 	select ARCH_DAVINCI_DA8XX
 	# needed on silicon revs 1.0, 1.1:
 	select CPU_DCACHE_WRITETHROUGH if !CPU_DCACHE_DISABLE
-	select CP_INTC
+	select DAVINCI_CP_INTC
 
 config ARCH_DAVINCI_DA850
 	bool "DA850/OMAP-L138/AM18x based system"
 	depends on !ARCH_DAVINCI_DMx || (AUTO_ZRELADDR && ARM_PATCH_PHYS_VIRT)
 	select ARCH_DAVINCI_DA8XX
-	select CP_INTC
+	select DAVINCI_CP_INTC
 
 config ARCH_DAVINCI_DA8XX
 	bool
diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index 983865a99616..f76a8482784f 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -18,8 +18,6 @@ obj-$(CONFIG_ARCH_DAVINCI_DM365)	+= dm365.o devices.o
 obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= da830.o devices-da8xx.o usb-da8xx.o
 obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= da850.o devices-da8xx.o usb-da8xx.o
 
-obj-$(CONFIG_CP_INTC)			+= cp_intc.o
-
 # Board specific
 obj-$(CONFIG_MACH_DA8XX_DT)		+= da8xx-dt.o pdata-quirks.o
 obj-$(CONFIG_MACH_DAVINCI_EVM)  	+= board-dm644x-evm.o
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index ea0eb82bf1d2..48fc5024c073 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -134,6 +134,11 @@ config DAVINCI_AINTC
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 
+config DAVINCI_CP_INTC
+	bool
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+
 config DW_APB_ICTL
 	bool
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 623e0ec5f9d0..e6cd0c98eff2 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_ATH79)			+= irq-ath79-misc.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
 obj-$(CONFIG_DAVINCI_AINTC)		+= irq-davinci-aintc.o
+obj-$(CONFIG_DAVINCI_CP_INTC)		+= irq-davinci-cp-intc.o
 obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o
 obj-$(CONFIG_FARADAY_FTINTC010)		+= irq-ftintc010.o
 obj-$(CONFIG_ARCH_HIP04)		+= irq-hip04.o
diff --git a/arch/arm/mach-davinci/cp_intc.c b/drivers/irqchip/irq-davinci-cp-intc.c
similarity index 100%
rename from arch/arm/mach-davinci/cp_intc.c
rename to drivers/irqchip/irq-davinci-cp-intc.c
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
