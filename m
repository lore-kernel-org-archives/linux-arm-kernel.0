Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF731C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:12:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC21E2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XGgV6HN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC21E2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=8OedJxX/gLCyKc4VSoKaF+qtMIsmdXP2tXgKd3Qkn6k=; b=XGgV6HN4eZbr9q
	zand2GPBtSO80G6nVVZHC09uQFHHw+Du67fK0AN3KFHuv5vQgo/RxULzQ2p2ihLUiG2xTruW7+AbB
	TKq9xAcyGMxw8LAho1n/100Ws5KbBhpfokzsIF3c1+zFWYeRGDxWJI/eLB495PvKYQgfgqonLhVYz
	sT2RQdByPwA0dalZxRiv5+Fuf/mEPeZyHk1bmZiXcdIrRZgwgHXb/laNi6nUnoEF9KNzDJfVLluD8
	xYYpL4kZgyj1+NskwjHbe2a79VAuiIhkwdrJ6Ayy3TUCmzn7yz0Q6g7fQ8+t6Y1J9O9D+UYytgOw/
	g/nQ6vYIn8064/oMgaPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXArZ-0001yU-Lq; Wed, 12 Dec 2018 20:12:09 +0000
Received: from gateway21.websitewelcome.com ([192.185.45.38])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXArW-0001xM-AQ
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 20:12:07 +0000
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
 by gateway21.websitewelcome.com (Postfix) with ESMTP id CF29D400DC962
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:11:42 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id XAr8g3v6EaEIgXAr8grF5d; Wed, 12 Dec 2018 14:11:42 -0600
X-Authority-Reason: nr=8
Received: from [189.250.70.203] (port=45282 helo=embeddedor)
 by gator4166.hostgator.com with esmtpa (Exim 4.91)
 (envelope-from <gustavo@embeddedor.com>)
 id 1gXAqp-003BG9-PE; Wed, 12 Dec 2018 14:11:42 -0600
Date: Wed, 12 Dec 2018 14:11:23 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Mark Rutland <mark.rutland@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>
Subject: [PATCH] KVM: arm/arm64: vgic: fix off-by-one bug in vgic_get_irq()
Message-ID: <20181212201123.GA26674@embeddedor>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.70.203
X-Source-L: No
X-Exim-ID: 1gXAqp-003BG9-PE
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.70.203]:45282
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_121206_411182_6B04E01F 
X-CRM114-Status: GOOD (  10.55  )
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
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When using the nospec API, it should be taken into account that:

"...if the CPU speculates past the bounds check then
 * array_index_nospec() will clamp the index within the range of [0,
 * size)."

The above is part of the header for macro array_index_nospec() in
linux/nospec.h

Now, in this particular case, if intid evaluates to exactly VGIC_MAX_SPI
or to exaclty VGIC_MAX_PRIVATE, the array_index_nospec() macro ends up
returning VGIC_MAX_SPI - 1 or VGIC_MAX_PRIVATE - 1 respectively, instead
of VGIC_MAX_SPI or VGIC_MAX_PRIVATE, which, based on the original logic:

	/* SGIs and PPIs */
	if (intid <= VGIC_MAX_PRIVATE)
 		return &vcpu->arch.vgic_cpu.private_irqs[intid];

 	/* SPIs */
	if (intid <= VGIC_MAX_SPI)
 		return &kvm->arch.vgic.spis[intid - VGIC_NR_PRIVATE_IRQS];

are valid values for intid.

Fix this by calling array_index_nospec() macro with VGIC_MAX_PRIVATE + 1
and VGIC_MAX_SPI + 1 as arguments for its parameter size.

Fixes: 41b87599c743 ("KVM: arm/arm64: vgic: fix possible spectre-v1 in vgic_get_irq()")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 virt/kvm/arm/vgic/vgic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index 50e25438fb3c..5db40696055a 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -103,13 +103,13 @@ struct vgic_irq *vgic_get_irq(struct kvm *kvm, struct kvm_vcpu *vcpu,
 {
 	/* SGIs and PPIs */
 	if (intid <= VGIC_MAX_PRIVATE) {
-		intid = array_index_nospec(intid, VGIC_MAX_PRIVATE);
+		intid = array_index_nospec(intid, VGIC_MAX_PRIVATE + 1);
 		return &vcpu->arch.vgic_cpu.private_irqs[intid];
 	}
 
 	/* SPIs */
 	if (intid <= VGIC_MAX_SPI) {
-		intid = array_index_nospec(intid, VGIC_MAX_SPI);
+		intid = array_index_nospec(intid, VGIC_MAX_SPI + 1);
 		return &kvm->arch.vgic.spis[intid - VGIC_NR_PRIVATE_IRQS];
 	}
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
