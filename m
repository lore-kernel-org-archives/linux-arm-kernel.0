Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A2FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:01:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06577206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AxBKR/jl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i9me2M/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06577206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=bWATChs/xG+dFK++paopiYkC9J2F0DazrDZUQPYVe9w=; b=AxB
	KR/jlgFbdAAoDUfJJCVQkd980vGWSl9yfewoEd02pthNTu0c1cPHQPzgjJ1wnhBI23vZFtyt0iIqt
	rUfWHiyIVeSCaCQntpysMhJoo+xqAzFG2fi6yXmn8dO/ffWvtSP2x3N0Irjlj4fTqDwnRwAYjvnB2
	xkSgeYoJlPxqGY1I//Y3F1a8cVj8p1HrBpN88Q9dJKBWl26jss3iZGa5A1Q40CY23+VFRl4bmiMS5
	lkev8LSOUsnMDyJbEosE4GlpX4Rc5KlGmgb91qYXJx6VH2lZ0C/Wc0I1vLqg0sdngLKGpnDxBidLn
	zTiHKb7Wfc+BKpCCvtOFctjWHnQMcbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj7UQ-0002vb-6p; Mon, 14 Jan 2019 19:01:38 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj7UN-0002vD-OU
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 19:01:37 +0000
Received: by mail-pg1-x541.google.com with SMTP id j10so49225pga.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 11:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=jfEV92oU/BXZCP8yvuSufQIujV0ayfJ9QmhGwQnDaWs=;
 b=i9me2M/M9GPc2ytcKjp5DGAMrLOrYSOEqdZ3LWVj1UX6rGhT5oYyEmNJ1m/T5A6miV
 i76A0AnT71KMSSDPmhcfQWIDEb6s7Cp1AaApto+zfrksMSzA03K6eYdMgYR7Dt5DWmad
 gQiSR84r1X1ft0zjkfczl7vk4siLT4eCrHWVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=jfEV92oU/BXZCP8yvuSufQIujV0ayfJ9QmhGwQnDaWs=;
 b=gj1HQSUiit+CmmCgULxb0axWLe4rorntVlf34EH2LLysw6QQwxYTFuLXTkj8IwGuoq
 4m+Irfio69ArgmJkg4fdgake8Z760uIYS7nKDF1Ddj3CsscmKkdGmAfTmp+p+jNNyHYu
 4SsmIdEQA/IOm5M9vQVI9ro+dsbAPnbKDxo5cf8pxu38+sg8XOFbbs64vOI1vmnKWTmm
 dzw5vw7DqbIX3xWrY9qiE4ahu2UrZwpfIcBhaHZ0X+MPHDpv3hlw/0Pcw8TahUL54c55
 cmbKCSlsL5tjRGEOqgXAafYR9DLBQ01yN8PN/0vvM97gGYryTrD7i5KxGw6tCuVOehQu
 L/9Q==
X-Gm-Message-State: AJcUukdWa5N8CsM2ImvKb3GFwqJpqM+K2FQhBPKcpYIxuPsV+q1HOkxw
 xjDwT+Y6wXriiOvNrpbluHmM0w==
X-Google-Smtp-Source: ALg8bN4syLCkq+ZRmkNooexV1p8UgALkw9hQry+SfUJeTX/GhzR6R1mEO6qEX3VLlP+mW1XpUwwxxg==
X-Received: by 2002:a62:c613:: with SMTP id m19mr27038791pfg.207.1547492494475; 
 Mon, 14 Jan 2019 11:01:34 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com
 ([2620:15c:202:201:ffda:7716:9afc:1301])
 by smtp.gmail.com with ESMTPSA id l85sm1958120pfg.161.2019.01.14.11.01.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 14 Jan 2019 11:01:33 -0800 (PST)
From: Evan Green <evgreen@chromium.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH] arm64: defconfig: Add Qualcomm UFS PHY
Date: Mon, 14 Jan 2019 11:01:12 -0800
Message-Id: <20190114190112.167922-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_110135_825039_91EBFBAA 
X-CRM114-Status: GOOD (  12.52  )
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
Cc: linux-scsi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Marc Gonzalez <marc.w.gonzalez@free.fr>, linux-kernel@vger.kernel.org,
 Olof Johansson <olof@lixom.net>, Douglas Anderson <dianders@chromium.org>,
 Evan Green <evgreen@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Andy Gross <andy.gross@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Simon Horman <horms+renesas@verge.net.au>,
 linux-arm-kernel@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

With commit 326a859b2814 ("scsi: ufs: Remove select of phy-qcom-ufs from
ufs-qcom"), the Qualcomm UFS controller no longer selects the Qualcomm
UFS phy (since it's not a given that PHY will be the one present).

Add that PHY into the defconfig since it's no longer being selected, and
Qualcomm platforms except for SDM845 need it.

Fixes: 326a859b2814 ("scsi: ufs: Remove select of phy-qcom-ufs from ufs-qcom")
Signed-off-by: Evan Green <evgreen@chromium.org>
---
I unfortunately don't have a non-SDM845 device to test this on. I'm hoping
it Just Works, or someone might be willing to give it a try.

Also, Martin, I'm not sure if your git commit IDs are stable, or whether or
not I should put the Fixes: in there. If they're not, this could be reordered
with the other commit and then there wouldn't need to be a Fixes. Let me know.

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0478ef9e4b78e..d43644ca75997 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -694,6 +694,8 @@ CONFIG_PHY_HISTB_COMBPHY=y
 CONFIG_PHY_HISI_INNO_USB2=y
 CONFIG_PHY_MVEBU_CP110_COMPHY=y
 CONFIG_PHY_QCOM_QMP=m
+CONFIG_PHY_QCOM_UFS=m
+CONFIG_PHY_QCOM_UFS_14NM=m
 CONFIG_PHY_QCOM_USB_HS=y
 CONFIG_PHY_RCAR_GEN3_PCIE=y
 CONFIG_PHY_RCAR_GEN3_USB2=y
-- 
2.18.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
