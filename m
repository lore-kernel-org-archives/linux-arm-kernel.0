Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573B5C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:40:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25B2520881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JYcZNhG4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HBNOLup3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MC/uSZjZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B2520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=HVApd8UpngfU3m+uzyNBAj2X2fq1Sn+fpuuPOX5tWBY=; b=JYcZNhG4dodG0GlWZilqWst1qx
	f5Cs3oebOeZBos42mTobMkrfyFPPYZONh8fS8G4+UEj+tP86fyff031ckjMV/UKFkDXnGbkz93oN5
	SaxbXe2GbYMTVdZ0nfEAZNTumY6vZ7ESvbuyMay4Wfj/BWmWL8M3bsDyb+iFLNrMvUJOLoBlluL5h
	V0GXNURgo5Py0KJNJIa5ORmwzNTP8nltopMqmOsyvNtSwO5rQrSEr41I2SngjCk6yVKpOHFq8jl3v
	pS+6sgvILDJK5sz5dgvZC7A25Y/sMxnocO896YlBqugfv0uhmNQFtjCgoryuocNJT8PsL4FByvMv8
	AaG5VHcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTaPp-0003cX-UO; Sun, 02 Dec 2018 22:40:41 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTaGz-0006wi-PT
 for linux-arm-kernel@bombadil.infradead.org; Sun, 02 Dec 2018 22:31:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tcTFGjWSUDe1a3RfhkbtIH7npTtVBEiYc3Nl7JTQJUI=; b=HBNOLup3ir5KWsBceG0scir3Y
 sNZfkniFznYklA+4FmBVLqSwp0oAsGm89i+fE/Vv1eeCelAGdCggtH4w5ZYF2DfThlDBVq48XDF5h
 hkuS9kr4wiD2EvWIfatG1Oanxx6fTyn9DzKzurFdkgZt67Nk8yZMX6wupSIly/1DESJyx8Zl48DQM
 39OQQoLXQXyK+DjBXpswKjheLVe31e524McyusKIkjE/k266z4PmSOBX+wLMxEDNQWmkDh1RQWv78
 TO2VW5bZgD14hSvAE5OYNUCJQEtgiz7AI+vXz/qlcTJOO98YD8RSA+/RqNSHI2WEOfYadtP3ccCY6
 fa3kY+ILA==;
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTYIU-00022R-E0
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 20:24:59 +0000
Received: by mail-wr1-x442.google.com with SMTP id c14so10073816wrr.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 12:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tcTFGjWSUDe1a3RfhkbtIH7npTtVBEiYc3Nl7JTQJUI=;
 b=MC/uSZjZ7eRKFBAaN+33BMvkhzE5N4F60Bef5bi+CJ5Q1axeeIyMA3ePctjjb85bn7
 F4HsvD6byMCepTr4LZnKSn5aHDIBNMPiwcuDFLkfCD3ZYAbgeE3B/2e3BPxZ2s0/ZaNj
 b/nvK3E78p+TprpDBPTZezlOeyZOriS6rSsFtJhO8deE/ROvxUGAj3dyGsvMhXawMzTS
 o7xupjwn9Ylhv4I732X22oeNg/WcwNK5q7KfJ65bcJbkcVujiMZ46t5/BGuoSD3MfPWy
 EPGtMC6iuQZvHGwKuV+mfnG0radtQrJXtJdhEzryiN3kEnlP6yuBxEBpS/UhOhIVvcxs
 pw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=tcTFGjWSUDe1a3RfhkbtIH7npTtVBEiYc3Nl7JTQJUI=;
 b=ecTs2xGE7vnL0G6zxh1u3aAglWZ9I8HWXhWRHeM71eqTJca+6tDy4zOVav7e1m37p7
 s7QpCDtKhTnODKT5uVjf8ctd5IM2117ZiZoBpUMtFtg58aPp2FZEAaPwKRVGfUSGf+Q5
 Vg1RK36ZRmtCU+cmkBIuEHcl4or2GbygpfZZwhPg/V2Gpmoor9cszRcRATa4Dx04C0h2
 h/JH/mH0eXkPbZWiFWs/4LRnI++jvwSpfBPQb/O5kKGYFfYlA3wFc7Ub0D1KLZXTy+hU
 SmkqSxNJvuhbj6CoOppVh/uJQm7sTRCyPgrwMOF0J9Xh5zE2oq9GEN1unKmXStjrk2VI
 0wEQ==
X-Gm-Message-State: AA+aEWYmuz7SGgqV2Y8bv7tdPX3xTk7jkvVW+bqSOjHVUqpZuGvMe/e9
 HmKI3JmHcG9L4+ZQ6whVjJo=
X-Google-Smtp-Source: AFSGD/XCOkDZxjraQA52Ty23Cet8GSvlWVOKBCI002RoLX4C/iyPpbDhESnWACNj/xn6/Cr0FWnHGg==
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr11447772wrs.281.1543782280631; 
 Sun, 02 Dec 2018 12:24:40 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
 by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 02 Dec 2018 12:24:40 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v6 17/17] ARM: suniv: f1c100s: add device tree for Lichee Pi
 Nano
Date: Sun,  2 Dec 2018 23:23:51 +0300
Message-Id: <125b26f154ad1373179d67fcde30df056e883ac8.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543781680.git.mesihkilinc@gmail.com>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_152458_595638_2C5B291E 
X-CRM114-Status: GOOD (  17.73  )
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
Cc: Mesih Kilinc <mesihkilinc@gmail.com>,
 Julian Calaby <julian.calaby@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Marc Zyngier <marc.zyngier@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Icenowy Zheng <icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Lichee Pi Nano is a F1C100s board by Lichee Pi.

Add initial device tree for it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/boot/dts/Makefile                        |  2 ++
 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts | 26 +++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b0e966d..2b96a5b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1066,6 +1066,8 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 dtb-$(CONFIG_MACH_SUN9I) += \
 	sun9i-a80-optimus.dtb \
 	sun9i-a80-cubieboard4.dtb
+dtb-$(CONFIG_MACH_SUNIV) += \
+	suniv-f1c100s-licheepi-nano.dtb
 dtb-$(CONFIG_ARCH_TANGO) += \
 	tango4-vantage-1172.dtb
 dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += \
diff --git a/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts b/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
new file mode 100644
index 0000000..a1154e6
--- /dev/null
+++ b/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR X11)
+/*
+ * Copyright 2018 Icenowy Zheng <icenowy@aosc.io>
+ */
+
+/dts-v1/;
+#include "suniv-f1c100s.dtsi"
+
+/ {
+	model = "Lichee Pi Nano";
+	compatible = "licheepi,licheepi-nano", "allwinner,suniv-f1c100s";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pe_pins>;
+	status = "okay";
+};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
