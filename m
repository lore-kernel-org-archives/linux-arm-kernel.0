Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529A0C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:27:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 238CF218AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="muBT6kVl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="Sl8B2mYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238CF218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=mdHuuE5KKHMDVUk64WjI/Gy+gTc4tRHNqrH+pJV66FU=; b=muBT6kVlEs2tK8oLTmR9LoiH47
	nM9iSE62VcnOzS2wkT+F6HiYtGqStvf96yTXYU9uxzcdcPIbzCeJ2a2T2XwbmCNmqrlnTnP/YtNmK
	cQc2icLiwi9+D76Zms0FSkz0ULrzPaYZ05mptIB96Y0SP/NDDoCVN9sB0x04E4pxeDfrQw8dAAR8P
	nh5a1JdPxBTxRpR0yXB7L7OGyYjhezoEYl2eslhztFpYeyPm7gohpoUlTMZtznLVSX4dcAbLWPyKW
	BVlgk1DMG7jph0xN3P4aJ1sk8RfyQsoQF091PxOHxAOYfnItsfbGOILHZ98JH4I2wx3Z9zqSMpmna
	8Je7uSRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmguA-0008SS-ES; Thu, 24 Jan 2019 15:26:58 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmgqJ-0007Ii-IV
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 15:23:01 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id D846E25BF15;
 Fri, 25 Jan 2019 02:12:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1548342766; bh=dm/iK671NtjSHS+gUSA82jNuD6JDX33CA9cLxwGcyaU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Sl8B2mYpAl80SPB/QfYA8IY6K+tQK4fq60ogsRh/Y9xjNpi5yV5TyU058fusZYwB6
 hJCGNUxdFL7LGheTYv9zbXJq+k7c59vGcZ4NnqTmeqbXdy2kHnj070qZNJe+ymHvTj
 ympk9+ckycj562Lf5kqtuq1fAipO0w6U77WvDw2E=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id B74F5940D20; Thu, 24 Jan 2019 16:12:40 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 27/44] arm64: dts: renesas: r8a774c0: Connect RZ/G2E
 Audio-DMAC to IPMMU
Date: Thu, 24 Jan 2019 16:12:21 +0100
Message-Id: <52a20e64cce7f25727e6ca5de19424222bdd220a.1548233325.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1548233325.git.horms+renesas@verge.net.au>
References: <cover.1548233325.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_072259_758950_5131373C 
X-CRM114-Status: UNSURE (   9.70  )
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
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
 Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Hook up the RZ/G2E Audio-DMAC device to IPMMU-MP as stated by the
RZ/G2 User's manual.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index 58d4c60c54c3..6247ebc22b2a 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -1296,6 +1296,14 @@
 			resets = <&cpg 502>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
+			iommus = <&ipmmu_mp 0>, <&ipmmu_mp 1>,
+				 <&ipmmu_mp 2>, <&ipmmu_mp 3>,
+				 <&ipmmu_mp 4>, <&ipmmu_mp 5>,
+				 <&ipmmu_mp 6>, <&ipmmu_mp 7>,
+				 <&ipmmu_mp 8>, <&ipmmu_mp 9>,
+				 <&ipmmu_mp 10>, <&ipmmu_mp 11>,
+				 <&ipmmu_mp 12>, <&ipmmu_mp 13>,
+				 <&ipmmu_mp 14>, <&ipmmu_mp 15>;
 		};
 
 		xhci0: usb@ee000000 {
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
