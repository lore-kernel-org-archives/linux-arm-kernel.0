Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38A5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:15:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4623C20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PO/1yfO6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4623C20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=73fED++y81ApibRUYmHew4mmBMQQ+fizrEickaa5cTI=; b=PO/1yfO6JNOc8P4brMdYFsZ/5v
	BOa1DcdPsGWDbhJ634lTil8K0QadH5WCSxRCZ2fRCY7fbAua4gXd5Pjg3dd8kKdgvCMuKbYCa4Pnj
	6Ip5yjlnnIs5OZDwccayCGFYKmn+3lO4J2ce3zNi87haUuosWDn72HcNjdgOruGN12JADg0IlNAzg
	XImcbcuugXXfGvw2Tkb6S2I9LgkMWqZuCqsBL5eXbHF5vaJHDXNrvYca1kXI/LDuhQvelJ34+Or2E
	4qTVezB6pfk1oU9YSoTe04rkzpcJQ/AcM9tFZdi2GH5pvSYjzmXFaNPifLjr0tlIVqDbkKCRLM6//
	QKOfl35A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWoA-0005m0-NU; Fri, 18 Jan 2019 16:15:50 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWnh-0005HO-94
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:15:23 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9A2F1596;
 Fri, 18 Jan 2019 08:15:20 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 05A663F557;
 Fri, 18 Jan 2019 08:15:18 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [RFC PATCH 03/12] Makefile: [HACK] Work around GCC 8 warnings :(
Date: Fri, 18 Jan 2019 16:14:12 +0000
Message-Id: <1547828061-20462-4-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1547828061-20462-1-git-send-email-Dave.Martin@arm.com>
References: <1547828061-20462-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_081521_614046_9B7E9574 
X-CRM114-Status: UNSURE (   9.29  )
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Julien Grall <Julien.Grall@arm.com>,
 Andre Przywara <andre.przywara@arm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Some of these are relatively harmless lazy coding issues; others
are overzealousness on the part of the compiler (in some cases, the
code is provably safe, yet GCC warns anyway).

Turning the warnings off locally is not nice, but better than
turning them off globally.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 Makefile | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index c4faff6..e8e9376 100644
--- a/Makefile
+++ b/Makefile
@@ -42,6 +42,7 @@ OBJS	+= builtin-stat.o
 OBJS	+= builtin-pause.o
 OBJS	+= builtin-resume.o
 OBJS	+= builtin-run.o
+CFLAGS-builtin-run.o = -Wno-format-truncation -Wno-stringop-truncation
 OBJS	+= builtin-setup.o
 OBJS	+= builtin-stop.o
 OBJS	+= builtin-version.o
@@ -63,9 +64,11 @@ OBJS	+= vfio/core.o
 OBJS	+= vfio/pci.o
 OBJS	+= virtio/blk.o
 OBJS	+= virtio/scsi.o
+CFLAGS-virtio/scsi.o = -Wno-stringop-truncation
 OBJS	+= virtio/console.o
 OBJS	+= virtio/core.o
 OBJS	+= virtio/net.o
+CFLAGS-virtio/net.o = -Wno-sizeof-pointer-memaccess -Wno-stringop-truncation
 OBJS	+= virtio/rng.o
 OBJS    += virtio/balloon.o
 OBJS	+= virtio/pci.o
@@ -82,6 +85,7 @@ OBJS	+= net/uip/udp.o
 OBJS	+= net/uip/buf.o
 OBJS	+= net/uip/csum.o
 OBJS	+= net/uip/dhcp.o
+CFLAGS-net/uip/dhcp.o = -Wno-stringop-truncation
 OBJS	+= kvm-cmd.o
 OBJS	+= util/init.o
 OBJS    += util/iovec.o
@@ -93,6 +97,7 @@ OBJS	+= util/strbuf.o
 OBJS	+= util/read-write.o
 OBJS	+= util/util.o
 OBJS	+= virtio/9p.o
+CFLAGS-virtio/9p.o = -Wno-restrict
 OBJS	+= virtio/9p-pdu.o
 OBJS	+= hw/vesa.o
 OBJS	+= hw/pci-shmem.o
@@ -439,10 +444,10 @@ endif
 %.o: %.c
 ifeq ($(C),1)
 	$(E) "  CHECK   " $@
-	$(Q) $(CHECK) -c $(CFLAGS) $(CFLAGS_DYNOPT) $< -o $@
+	$(Q) $(CHECK) -c $(CFLAGS-$@) $(CFLAGS) $(CFLAGS_DYNOPT) $< -o $@
 endif
 	$(E) "  CC      " $@
-	$(Q) $(CC) -c $(c_flags) $(CFLAGS_DYNOPT) $< -o $@
+	$(Q) $(CC) -c $(CFLAGS-$@) $(c_flags) $(CFLAGS_DYNOPT) $< -o $@
 
 
 #
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
