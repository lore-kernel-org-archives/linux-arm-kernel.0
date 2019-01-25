Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E0DC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:55:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A337F218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="deAxAaxN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="aIaUgUV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A337F218D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=6W6KYFpB2rgpNNioURANeYkiHdGA4UddRgq7NJE5sb0=; b=deAxAaxNiVNhuKrgnpmjRMhYK/
	aAEAgI71OyGhr50ARVQKABA0WeVFRSjweiH7JDBE3cSW0veBVj1mk9VY6jyDSFqKIFtvQwCZ31j3c
	eWXX2FCQWSIaNgeNHGAXgwH0uBrkZx3ZX5bhg/eNditKxLtER1A0NFsOtYuaYQ96MCK+gVZVT8H0G
	k+/1wm0+zDwfboY2YAsri6plG4zYEu2I3WCL+2SMgD37dRQ84TpgbexjLHN/QbGdgtvZyUrrRM9h9
	yD1x1qiX9LqY1SzNk+q50PePiif7/9Jk2i8CqzelUhHz4cMhpUlXekwCXp/3VJ/Lvw8A2a5efbeMY
	Z2ivFA3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmvOe-0002NX-8W; Fri, 25 Jan 2019 06:55:24 +0000
Received: from conuserg-10.nifty.com ([210.131.2.77])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmvOB-0000t9-A1
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 06:55:01 +0000
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id x0P6sNWq014857;
 Fri, 25 Jan 2019 15:54:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x0P6sNWq014857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1548399267;
 bh=JpjYnlzbJzFxJppLI7k9UasCvqng+Fbq9QF1FVS+cPA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aIaUgUV/z3tnO3OqYn0P4UjD6wtahh3E/fv3BlrP+MViv7Dxdc2ZhUfeV1c7xr7rf
 25rTAQrWUTXkOTOgHRw7IAWFzmXKP5C5Us3NjpSAur8puItZullTdtXHc0xtLQWBh7
 TM+55q+xXanH5sUgNd2FBfJuFyHvEOB6dp1qEAcqxHBU2SJS5UoOWTL3rEhm8NojWf
 X11WYfUI9rq+vY1IpSZsmrZLKToWM1/CfSrzE7J592J35bu4faRwpn9lEWMV8EHw0J
 D8Y8br/JpNC6/YAeZUP2fMpwAuxV3Jpo2OQRbPKRoPuHUxUVNA2xifj1RrCimZHZ+J
 Spf2FMAKBcNkA==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH 3/3] media: prefix header search paths with $(srctree)/
Date: Fri, 25 Jan 2019 15:54:19 +0900
Message-Id: <1548399259-17750-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548399259-17750-1-git-send-email-yamada.masahiro@socionext.com>
References: <1548399259-17750-1-git-send-email-yamada.masahiro@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_225455_883505_FB84D8F8 
X-CRM114-Status: UNSURE (   9.14  )
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
Cc: Abylay Ospan <aospan@netup.ru>, Andy Walls <awalls@md.metrocast.net>,
 Sergey Kozlov <serjk@netup.ru>, Akihiro Tsukada <tskd08@gmail.com>,
 Patrice Chotard <patrice.chotard@st.com>, linux-kernel@vger.kernel.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Sakari Ailus <sakari.ailus@iki.fi>, Hans Verkuil <hans.verkuil@cisco.com>,
 Mike Isely <isely@pobox.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Currently, the Kbuild core manipulates header search paths in a crazy
way [1].

To fix this mess, I want all Makefiles to add explicit $(srctree)/ to
the search paths in the srctree. Some Makefiles are already written in
that way, but not all. The goal of this work is to make the notation
consistent, and finally get rid of the gross hacks.

Having whitespaces after -I does not matter since commit 48f6e3cf5bc6
("kbuild: do not drop -I without parameter").

[1]: https://patchwork.kernel.org/patch/9632347/

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/media/common/b2c2/Makefile            | 4 ++--
 drivers/media/i2c/smiapp/Makefile             | 2 +-
 drivers/media/mmc/siano/Makefile              | 3 +--
 drivers/media/pci/b2c2/Makefile               | 2 +-
 drivers/media/pci/bt8xx/Makefile              | 4 ++--
 drivers/media/pci/cx18/Makefile               | 4 ++--
 drivers/media/pci/cx23885/Makefile            | 4 ++--
 drivers/media/pci/cx88/Makefile               | 4 ++--
 drivers/media/pci/ddbridge/Makefile           | 4 ++--
 drivers/media/pci/dm1105/Makefile             | 2 +-
 drivers/media/pci/mantis/Makefile             | 2 +-
 drivers/media/pci/netup_unidvb/Makefile       | 2 +-
 drivers/media/pci/ngene/Makefile              | 4 ++--
 drivers/media/pci/pluto2/Makefile             | 2 +-
 drivers/media/pci/pt1/Makefile                | 4 ++--
 drivers/media/pci/pt3/Makefile                | 4 ++--
 drivers/media/pci/smipcie/Makefile            | 5 ++---
 drivers/media/pci/ttpci/Makefile              | 4 ++--
 drivers/media/platform/sti/c8sectpfe/Makefile | 4 ++--
 drivers/media/spi/Makefile                    | 2 +-
 drivers/media/usb/as102/Makefile              | 2 +-
 drivers/media/usb/au0828/Makefile             | 4 ++--
 drivers/media/usb/b2c2/Makefile               | 2 +-
 drivers/media/usb/cx231xx/Makefile            | 4 ++--
 drivers/media/usb/em28xx/Makefile             | 4 ++--
 drivers/media/usb/go7007/Makefile             | 2 +-
 drivers/media/usb/pvrusb2/Makefile            | 4 ++--
 drivers/media/usb/siano/Makefile              | 2 +-
 drivers/media/usb/tm6000/Makefile             | 4 ++--
 drivers/media/usb/ttusb-budget/Makefile       | 2 +-
 30 files changed, 47 insertions(+), 49 deletions(-)

diff --git a/drivers/media/common/b2c2/Makefile b/drivers/media/common/b2c2/Makefile
index aa2dc24..0e32b77 100644
--- a/drivers/media/common/b2c2/Makefile
+++ b/drivers/media/common/b2c2/Makefile
@@ -4,5 +4,5 @@ b2c2-flexcop-objs += flexcop-sram.o flexcop-eeprom.o flexcop-misc.o
 b2c2-flexcop-objs += flexcop-hw-filter.o
 obj-$(CONFIG_DVB_B2C2_FLEXCOP) += b2c2-flexcop.o
 
-ccflags-y += -Idrivers/media/dvb-frontends/
-ccflags-y += -Idrivers/media/tuners/
+ccflags-y += -I $(srctree)/drivers/media/dvb-frontends/
+ccflags-y += -I $(srctree)/drivers/media/tuners/
diff --git a/drivers/media/i2c/smiapp/Makefile b/drivers/media/i2c/smiapp/Makefile
index f45a003..9f03aef 100644
--- a/drivers/media/i2c/smiapp/Makefile
+++ b/drivers/media/i2c/smiapp/Makefile
@@ -2,4 +2,4 @@ smiapp-objs			+= smiapp-core.o smiapp-regs.o \
 				   smiapp-quirk.o smiapp-limits.o
 obj-$(CONFIG_VIDEO_SMIAPP)	+= smiapp.o
 
-ccflags-y += -Idrivers/media/i2c
+ccflags-y += -I $(srctree)/drivers/media/i2c
diff --git a/drivers/media/mmc/siano/Makefile b/drivers/media/mmc/siano/Makefile
index 5fc3456..848548f 100644
--- a/drivers/media/mmc/siano/Makefile
+++ b/drivers/media/mmc/siano/Makefile
@@ -1,4 +1,3 @@
 obj-$(CONFIG_SMS_SDIO_DRV) += smssdio.o
 
-ccflags-y += -Idrivers/media/common/siano
-
+ccflags-y += -I $(srctree)/drivers/media/common/siano
diff --git a/drivers/media/pci/b2c2/Makefile b/drivers/media/pci/b2c2/Makefile
index b43b916..14ed6e4 100644
--- a/drivers/media/pci/b2c2/Makefile
+++ b/drivers/media/pci/b2c2/Makefile
@@ -6,4 +6,4 @@ endif
 b2c2-flexcop-pci-objs += flexcop-pci.o
 obj-$(CONFIG_DVB_B2C2_FLEXCOP_PCI) += b2c2-flexcop-pci.o
 
-ccflags-y += -Idrivers/media/common/b2c2/
+ccflags-y += -I $(srctree)/drivers/media/common/b2c2/
diff --git a/drivers/media/pci/bt8xx/Makefile b/drivers/media/pci/bt8xx/Makefile
index 0b5032c..69bc0d9 100644
--- a/drivers/media/pci/bt8xx/Makefile
+++ b/drivers/media/pci/bt8xx/Makefile
@@ -6,5 +6,5 @@ bttv-objs      :=      bttv-driver.o bttv-cards.o bttv-if.o \
 obj-$(CONFIG_VIDEO_BT848) += bttv.o
 obj-$(CONFIG_DVB_BT8XX) += bt878.o dvb-bt8xx.o dst.o dst_ca.o
 
-ccflags-y += -Idrivers/media/dvb-frontends
-ccflags-y += -Idrivers/media/tuners
+ccflags-y += -I $(srctree)/drivers/media/dvb-frontends
+ccflags-y += -I $(srctree)/drivers/media/tuners
diff --git a/drivers/media/pci/cx18/Makefile b/drivers/media/pci/cx18/Makefile
index 9c82c2d..df00ef8 100644
--- a/drivers/media/pci/cx18/Makefile
+++ b/drivers/media/pci/cx18/Makefile
@@ -9,5 +9,5 @@ cx18-alsa-objs := cx18-alsa-main.o cx18-alsa-pcm.o
 obj-$(CONFIG_VIDEO_CX18) += cx18.o
 obj-$(CONFIG_VIDEO_CX18_ALSA) += cx18-alsa.o
 
-ccflags-y += -Idrivers/media/dvb-frontends
-ccflags-y += -Idrivers/media/tuners
+ccflags-y += -I $(srctree)/drivers/media/dvb-frontends
+ccflags-y += -I $(srctree)/drivers/media/tuners
diff --git a/drivers/media/pci/cx23885/Makefile b/drivers/media/pci/cx23885/Makefile
index 130f0aa..a785169 100644
--- a/drivers/media/pci/cx23885/Makefile
+++ b/drivers/media/pci/cx23885/Makefile
@@ -8,7 +8,7 @@ cx23885-objs	:= cx23885-cards.o cx23885-video.o cx23885-vbi.o \
 obj-$(CONFIG_VIDEO_CX23885) += cx23885.o
 obj-$(CONFIG_MEDIA_ALTERA_CI) += altera-ci.o
 
-ccflags-y += -Idrivers/media/tuners
-ccflags-y += -Idrivers/media/dvb-frontends
+ccflags-y += -I $(srctree)/drivers/media/tuners
+ccflags-y += -I $(srctree)/drivers/media/dvb-frontends
 
 ccflags-y += $(extra-cflags-y) $(extra-cflags-m)
diff --git a/drivers/media/pci/cx88/Makefile b/drivers/media/pci/cx88/Makefile
index d0f45d6..c2a0158 100644
--- a/drivers/media/pci/cx88/Makefile
+++ b/drivers/media/pci/cx88/Makefile
@@ -10,5 +10,5 @@ obj-$(CONFIG_VIDEO_CX88_ALSA) += cx88-alsa.o
 obj-$(CONFIG_VIDEO_CX88_BLACKBIRD) += cx88-blackbird.o
 obj-$(CONFIG_VIDEO_CX88_DVB) += cx88-dvb.o
 obj-$(CONFIG_VIDEO_CX88_VP3054) += cx88-vp3054-i2c.o
-ccflags-y += -Idrivers/media/tuners
-ccflags-y += -Idrivers/media/dvb-frontends
+ccflags-y += -I $(srctree)/drivers/media/tuners
+ccflags-y += -I $(srctree)/drivers/media/dvb-frontends
diff --git a/drivers/media/pci/ddbridge/Makefile b/drivers/media/pci/ddbridge/Makefile
index 5b6d5bb..2b77c8d 100644
--- a/drivers/media/pci/ddbridge/Makefile
+++ b/drivers/media/pci/ddbridge/Makefile
@@ -9,5 +9,5 @@ ddbridge-objs := ddbridge-main.o ddbridge-core.o ddbridge-ci.o \
 
 obj-$(CONFIG_DVB_DDBRIDGE) += ddbridge.o
 
-ccflags-y += -Idrivers/media/dvb-frontends/
-ccflags-y += -Idrivers/media/tuners/
+ccflags-y += -I $(srctree)/drivers/media/dvb-frontends/
+ccflags-y += -I $(srctree)/drivers/media/tuners/
diff --git a/drivers/media/pci/dm1105/Makefile b/drivers/media/pci/dm1105/Makefile
index d22c254..87e8e80 100644
--- a/drivers/media/pci/dm1105/Makefile
+++ b/drivers/media/pci/dm1105/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_DVB_DM1105) += dm1105.o
 
-ccflags-y += -Idrivers/media/dvb-frontends
+ccflags-y += -I $(srctree)/drivers/media/dvb-frontends
diff --git a/drivers/media/pci/mantis/Makefile b/drivers/media/pci/mantis/Makefile
index b5ef396..49e8224 100644
--- a/drivers/media/pci/mantis/Makefile
+++ b/drivers/media/pci/mantis/Makefile
@@ -26,4 +26,4 @@ obj-$(CONFIG_MANTIS_CORE)	+= mantis_core.o
 obj-$(CONFIG_DVB_MANTIS)	+= mantis.o
 obj-$(CONFIG_DVB_HOPPER)	+= hopper.o
 
-ccflags-y += -Idrivers/media/dvb-frontends/
+ccflags-y += -I $(srctree)/drivers/media/dvb-frontends/
diff --git a/drivers/media/pci/netup_unidvb/Makefile b/drivers/media/pci/netup_unidvb/Makefile
index 944c3e1..215bdaf 100644
--- a/drivers/media/pci/netup_unidvb/Makefile
+++ b/drivers/media/pci/netup_unidvb/Makefile
@@ -6,4 +6,4 @@ netup-unidvb-objs += netup_unidvb_spi.o
 
 obj-$(CONFIG_DVB_NETUP_UNIDVB) += netup-unidvb.o
 
-ccflags-y += -Idrivers/media/dvb-frontends
+ccflags-y += -I $(srctree)/drivers/media/dvb-frontends
diff --git a/drivers/media/pci/ngene/Makefile b/drivers/media/pci/ngene/Makefile
index ec450ad..5d16090 100644
--- a/drivers/media/pci/ngene/Makefile
+++ b/drivers/media/pci/ngene/Makefile
@@ -7,5 +7,5 @@ ngene-objs := ngene-core.o ngene-i2c.o ngene-cards.o ngene-dvb.o
 
 obj-$(CONFIG_DVB_NGENE) += ngene.o
 
-ccflags-y += -Idrivers/media/dvb-frontends/
-ccflags-y += -Idrivers/media/tuners/
+ccflags-y += -I $(srctree)/drivers/media/dvb-frontends/
+ccflags-y += -I $(srctree)/drivers/media/tuners/
diff --git a/drivers/media/pci/pluto2/Makefile b/drivers/media/pci/pluto2/Makefile
index 3c2aea1..4d21a2c 100644
--- a/drivers/media/pci/pluto2/Makefile
+++ b/drivers/media/pci/pluto2/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_DVB_PLUTO2) += pluto2.o
 
-ccflags-y += -Idrivers/media/dvb-frontends/
+ccflags-y += -I $(srctree)/drivers/media/dvb-frontends/
diff --git a/drivers/media/pci/pt1/Makefile b/drivers/media/pci/pt1/Makefile
index bc491e0..f80a1cd 100644
--- a/drivers/media/pci/pt1/Makefile
+++ b/drivers/media/pci/pt1/Makefile
@@ -2,5 +2,5 @@ earth-pt1-objs := pt1.o
 
 obj-$(CONFIG_DVB_PT1) += earth-pt1.o
 
-ccflags-y += -Idrivers/media/dvb-frontends
-ccflags-y += -Idrivers/media/tuners
+ccflags-y += -I $(srctree)/drivers/media/dvb-frontends
+ccflags-y += -I $(srctree)/drivers/media/tuners
diff --git a/drivers/media/pci/pt3/Makefile b/drivers/media/pci/pt3/Makefile
index 8698d5d..da6b265 100644
--- a/drivers/media/pci/pt3/Makefile
+++ b/drivers/media/pci/pt3/Makefile
@@ -4,5 +4,5 @@ earth-pt3-objs += pt3.o pt3_i2c.o pt3_dma.o
 
 obj-$(CONFIG_DVB_PT3) += earth-pt3.o
 
-ccflags-y += -Idrivers/media/dvb-frontends
-ccflags-y += -Idrivers/media/tuners
+ccflags-y += -I $(srctree)/drivers/media/dvb-frontends
+ccflags-y += -I $(srctree)/drivers/media/tuners
diff --git a/drivers/media/pci/smipcie/Makefile b/drivers/media/pci/smipcie/Makefile
index 214ebfe..2426b75 100644
--- a/drivers/media/pci/smipcie/Makefile
+++ b/drivers/media/pci/smipcie/Makefile
@@ -4,6 +4,5 @@ smipcie-objs	:= smipcie-main.o smipcie-ir.o
 
 obj-$(CONFIG_DVB_SMIPCIE) += smipcie.o
 
-ccflags-y += -Idrivers/media/tuners
-ccflags-y += -Idrivers/media/dvb-frontends
-
+ccflags-y += -I $(srctree)/drivers/media/tuners
+ccflags-y += -I $(srctree)/drivers/media/dvb-frontends
diff --git a/drivers/media/pci/ttpci/Makefile b/drivers/media/pci/ttpci/Makefile
index 58ca127..9b44c47 100644
--- a/drivers/media/pci/ttpci/Makefile
+++ b/drivers/media/pci/ttpci/Makefile
@@ -18,5 +18,5 @@ obj-$(CONFIG_DVB_BUDGET_CI) += budget-ci.o
 obj-$(CONFIG_DVB_BUDGET_PATCH) += budget-patch.o
 obj-$(CONFIG_DVB_AV7110) += dvb-ttpci.o
 
-ccflags-y += -Idrivers/media/dvb-frontends/
-ccflags-y += -Idrivers/media/tuners
+ccflags-y += -I $(srctree)/drivers/media/dvb-frontends/
+ccflags-y += -I $(srctree)/drivers/media/tuners
diff --git a/drivers/media/platform/sti/c8sectpfe/Makefile b/drivers/media/platform/sti/c8sectpfe/Makefile
index 4bf0c6b..aedfc72 100644
--- a/drivers/media/platform/sti/c8sectpfe/Makefile
+++ b/drivers/media/platform/sti/c8sectpfe/Makefile
@@ -4,5 +4,5 @@ c8sectpfe-y += c8sectpfe-core.o c8sectpfe-common.o c8sectpfe-dvb.o \
 
 obj-$(CONFIG_DVB_C8SECTPFE) += c8sectpfe.o
 
-ccflags-y += -Idrivers/media/dvb-frontends/
-ccflags-y += -Idrivers/media/tuners/
+ccflags-y += -I $(srctree)/drivers/media/dvb-frontends/
+ccflags-y += -I $(srctree)/drivers/media/tuners/
diff --git a/drivers/media/spi/Makefile b/drivers/media/spi/Makefile
index c254e2a..446e6c5 100644
--- a/drivers/media/spi/Makefile
+++ b/drivers/media/spi/Makefile
@@ -1,4 +1,4 @@
 obj-$(CONFIG_VIDEO_GS1662) += gs1662.o
 obj-$(CONFIG_CXD2880_SPI_DRV) += cxd2880-spi.o
 
-ccflags-y += -Idrivers/media/dvb-frontends/cxd2880
+ccflags-y += -I $(srctree)/drivers/media/dvb-frontends/cxd2880
diff --git a/drivers/media/usb/as102/Makefile b/drivers/media/usb/as102/Makefile
index b0b3196..de671ae 100644
--- a/drivers/media/usb/as102/Makefile
+++ b/drivers/media/usb/as102/Makefile
@@ -4,4 +4,4 @@ dvb-as102-objs := as102_drv.o as102_fw.o as10x_cmd.o as10x_cmd_stream.o \
 
 obj-$(CONFIG_DVB_AS102) += dvb-as102.o
 
-ccflags-y += -Idrivers/media/dvb-frontends
+ccflags-y += -I $(srctree)/drivers/media/dvb-frontends
diff --git a/drivers/media/usb/au0828/Makefile b/drivers/media/usb/au0828/Makefile
index 5691881..4347812 100644
--- a/drivers/media/usb/au0828/Makefile
+++ b/drivers/media/usb/au0828/Makefile
@@ -11,7 +11,7 @@ endif
 
 obj-$(CONFIG_VIDEO_AU0828) += au0828.o
 
-ccflags-y += -Idrivers/media/tuners
-ccflags-y += -Idrivers/media/dvb-frontends
+ccflags-y += -I $(srctree)/drivers/media/tuners
+ccflags-y += -I $(srctree)/drivers/media/dvb-frontends
 
 ccflags-y += $(extra-cflags-y) $(extra-cflags-m)
diff --git a/drivers/media/usb/b2c2/Makefile b/drivers/media/usb/b2c2/Makefile
index f3cef05..e7f949d 100644
--- a/drivers/media/usb/b2c2/Makefile
+++ b/drivers/media/usb/b2c2/Makefile
@@ -1,4 +1,4 @@
 b2c2-flexcop-usb-objs := flexcop-usb.o
 obj-$(CONFIG_DVB_B2C2_FLEXCOP_USB) += b2c2-flexcop-usb.o
 
-ccflags-y += -Idrivers/media/common/b2c2/
+ccflags-y += -I $(srctree)/drivers/media/common/b2c2/
diff --git a/drivers/media/usb/cx231xx/Makefile b/drivers/media/usb/cx231xx/Makefile
index af824fd..8acbbcb 100644
--- a/drivers/media/usb/cx231xx/Makefile
+++ b/drivers/media/usb/cx231xx/Makefile
@@ -9,5 +9,5 @@ obj-$(CONFIG_VIDEO_CX231XX) += cx231xx.o
 obj-$(CONFIG_VIDEO_CX231XX_ALSA) += cx231xx-alsa.o
 obj-$(CONFIG_VIDEO_CX231XX_DVB) += cx231xx-dvb.o
 
-ccflags-y += -Idrivers/media/tuners
-ccflags-y += -Idrivers/media/dvb-frontends
+ccflags-y += -I $(srctree)/drivers/media/tuners
+ccflags-y += -I $(srctree)/drivers/media/dvb-frontends
diff --git a/drivers/media/usb/em28xx/Makefile b/drivers/media/usb/em28xx/Makefile
index 8a22400..8c2fc31 100644
--- a/drivers/media/usb/em28xx/Makefile
+++ b/drivers/media/usb/em28xx/Makefile
@@ -11,5 +11,5 @@ obj-$(CONFIG_VIDEO_EM28XX_ALSA) += em28xx-alsa.o
 obj-$(CONFIG_VIDEO_EM28XX_DVB) += em28xx-dvb.o
 obj-$(CONFIG_VIDEO_EM28XX_RC) += em28xx-rc.o
 
-ccflags-y += -Idrivers/media/tuners
-ccflags-y += -Idrivers/media/dvb-frontends
+ccflags-y += -I $(srctree)/drivers/media/tuners
+ccflags-y += -I $(srctree)/drivers/media/dvb-frontends
diff --git a/drivers/media/usb/go7007/Makefile b/drivers/media/usb/go7007/Makefile
index 3d95bbc..712a350 100644
--- a/drivers/media/usb/go7007/Makefile
+++ b/drivers/media/usb/go7007/Makefile
@@ -9,4 +9,4 @@ go7007-y := go7007-v4l2.o go7007-driver.o go7007-i2c.o go7007-fw.o \
 
 s2250-y := s2250-board.o
 
-ccflags-$(CONFIG_VIDEO_GO7007_LOADER:m=y) += -Idrivers/media/common
+ccflags-$(CONFIG_VIDEO_GO7007_LOADER:m=y) += -I $(srctree)/drivers/media/common
diff --git a/drivers/media/usb/pvrusb2/Makefile b/drivers/media/usb/pvrusb2/Makefile
index 9facf68..2e71afc 100644
--- a/drivers/media/usb/pvrusb2/Makefile
+++ b/drivers/media/usb/pvrusb2/Makefile
@@ -17,5 +17,5 @@ pvrusb2-objs	:= pvrusb2-i2c-core.o \
 
 obj-$(CONFIG_VIDEO_PVRUSB2) += pvrusb2.o
 
-ccflags-y += -Idrivers/media/tuners
-ccflags-y += -Idrivers/media/dvb-frontends
+ccflags-y += -I $(srctree)/drivers/media/tuners
+ccflags-y += -I $(srctree)/drivers/media/dvb-frontends
diff --git a/drivers/media/usb/siano/Makefile b/drivers/media/usb/siano/Makefile
index 7d48864..ba56e98 100644
--- a/drivers/media/usb/siano/Makefile
+++ b/drivers/media/usb/siano/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_SMS_USB_DRV) += smsusb.o
 
-ccflags-y += -Idrivers/media/common/siano
+ccflags-y += -I $(srctree)/drivers/media/common/siano
 ccflags-y += $(extra-cflags-y) $(extra-cflags-m)
 
diff --git a/drivers/media/usb/tm6000/Makefile b/drivers/media/usb/tm6000/Makefile
index 744c039..75247a0 100644
--- a/drivers/media/usb/tm6000/Makefile
+++ b/drivers/media/usb/tm6000/Makefile
@@ -10,5 +10,5 @@ obj-$(CONFIG_VIDEO_TM6000) += tm6000.o
 obj-$(CONFIG_VIDEO_TM6000_ALSA) += tm6000-alsa.o
 obj-$(CONFIG_VIDEO_TM6000_DVB) += tm6000-dvb.o
 
-ccflags-y += -Idrivers/media/tuners
-ccflags-y += -Idrivers/media/dvb-frontends
+ccflags-y += -I $(srctree)/drivers/media/tuners
+ccflags-y += -I $(srctree)/drivers/media/dvb-frontends
diff --git a/drivers/media/usb/ttusb-budget/Makefile b/drivers/media/usb/ttusb-budget/Makefile
index fe4372d..37847d7 100644
--- a/drivers/media/usb/ttusb-budget/Makefile
+++ b/drivers/media/usb/ttusb-budget/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_DVB_TTUSB_BUDGET) += dvb-ttusb-budget.o
 
-ccflags-y += -Idrivers/media/dvb-frontends
+ccflags-y += -I $(srctree)/drivers/media/dvb-frontends
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
