Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86239C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:01:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B367218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DNpMRlyH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="R81ueSNd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B367218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=dDQkFhsz+OsBta2zeE0S8sqyEyFEU/L6DoHGPo0NewY=; b=DNp
	MRlyHgqwWMleQVnwaMkvGR/0Lo63Rlo3MZii2luDB1nUsugO+vK0CNmANTGJuLMjn+s0ddx/ushif
	VsXS+SVNyymFA33Sg8UEJTWJyYwqgbpFVqH9Nc3zzNRHxNSXYBkWL/x/87mfi1owXWU4cqg5EB4U+
	hAi/+Y/V0SpI6kKENs0hVyqhLMV9uYa8jwrqOWUto91PwOTFRvPja1OpgHx0czV6f6Uhk64bc/vvg
	uejdoGrboh+PJt/5ruAnhjKtMcvoaNL82deCW0oVlrm6NGQwtyeJjtcM/CtvNF4T6TngIhMhWjC9K
	SAWQuGh3adbn8GIYSRMcDI3wqrMly0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvbzz-00009M-GB; Mon, 18 Feb 2019 06:01:51 +0000
Received: from conuserg-07.nifty.com ([210.131.2.74])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvbzv-00008b-Gz; Mon, 18 Feb 2019 06:01:49 +0000
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id x1I617hP006910;
 Mon, 18 Feb 2019 15:01:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x1I617hP006910
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1550469668;
 bh=NxLW51joWyvnJN1RnKNbaCQPsjav24QXUL7FZQbjRU0=;
 h=From:To:Cc:Subject:Date:From;
 b=R81ueSNdiAOMm8788ckrvP8r9ErabEmk5m+otXRzuz1n03mpjh4VN8EnOnqFC7lZb
 rwYgt2hpW+j1yBo026+MPCTjDyfNb/e494jiJc7GIIht5ePf/LYcpA5I1KybzYdyxK
 VltDqvGWePalbRuSiZhB0vcBdKmOHEFBhZU7eMXR9flrlaPLDY27IjagBAAWB8878u
 XZZiC1rp/F+4vo86Cq41tdoY5NXn3jVcnAQcODYcX6kaycLn7pnVXnFSVDXluwy8JA
 eaoIUGJpeNn2RhxYjWCkb2URNZXrhxjYUOmLW/U7r1zdfLRQpVftSaahLEfbyp9wxd
 z5AG2TANZMfCA==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org
Subject: [PATCH 0/2] x86: turn off wrongly enabled CONFIG_GENERIC_HWEIGHT
Date: Mon, 18 Feb 2019 14:59:29 +0900
Message-Id: <1550469571-25933-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_220147_892037_CCFABD30 
X-CRM114-Status: UNSURE (   7.64  )
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
Cc: Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Kalle Valo <kvalo@codeaurora.org>,
 Felix Fietkau <nbd@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


x86 should not enable CONFIG_GENERIC_HWEIGHT
because lib/hweight.c is not used by x86.

The only user is drivers/net/wireless/mediatek/mt76/mac80211.c

Of course, this driver is wrong since drivers should use the
generic API, hweight8().

After fixing it, x86 does not need to compile lib/hweight.c at all.

The real implementation is located in arch/x86/lib/hweight.S



Masahiro Yamada (2):
  wireless: mt76: call hweight8() instead of __sw_hweight8()
  x86: disable CONFIG_GENERIC_HWEIGHT and remove __HAVE_ARCH_SW_HWEIGHT

 arch/x86/Kconfig                              | 3 ---
 arch/x86/include/asm/arch_hweight.h           | 2 --
 drivers/net/wireless/mediatek/mt76/mac80211.c | 2 +-
 lib/hweight.c                                 | 4 ----
 4 files changed, 1 insertion(+), 10 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
