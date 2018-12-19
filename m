Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3DFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:12:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72D5121841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UYRFl2Ml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D5121841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=aruom47RHzZKLfscuUXKU3iYbFLgF+JRX39al32pWMo=; b=UYRFl2MlqSOTCI
	jPDcoOHsicGMWm0hP9Xm/VOaFwD8HWvWJx+BEWfSg4mGSSFGxm/1WfNFd/tYvU5n9wRRv9vlii8gW
	bJf+NjeoNtgYEOhVJgXgGmPSJC8fuhfAICr5l+YG16FD993GmlEl+11fOfJAgM5G4K6fTPRkSY+bF
	qai4KDdf6nB0DkfGJOfV5ZPylK36SMy0peIdu5d1OF40UQ+5dCyPBUr+Pda7hDpqyAzEHcRwa73yE
	C8+aCND04Cq5zTeP6commJSNWkc0y6MWYnfGqDczDncal2IffPKFJe5qEqVwQDfGH8+xE3nYTWX0U
	VDGz15bbvLuMnOBqYMLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZdWX-00019R-VL; Wed, 19 Dec 2018 15:12:37 +0000
Received: from gateway23.websitewelcome.com ([192.185.50.104])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZdWB-0000gC-Gk
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 15:12:19 +0000
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
 by gateway23.websitewelcome.com (Postfix) with ESMTP id 99A92CA37
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 09:11:51 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id ZdVnghsIjiQerZdVngnOaX; Wed, 19 Dec 2018 09:11:51 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=48540 helo=embeddedor)
 by gator4166.hostgator.com with esmtpa (Exim 4.91)
 (envelope-from <gustavo@embeddedor.com>)
 id 1gZdVm-000PVb-RZ; Wed, 19 Dec 2018 09:11:51 -0600
Date: Wed, 19 Dec 2018 09:11:49 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Christoffer Dall <christoffer.dall@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>
Subject: [WRONG] KVM: arm/arm64: vgic: fix off-by-one bug in vgic_get_irq()
Message-ID: <20181219151149.GA6524@embeddedor>
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
X-Source-IP: 189.250.106.44
X-Source-L: No
X-Exim-ID: 1gZdVm-000PVb-RZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.106.44]:48540
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_071216_080171_A8F73001 
X-CRM114-Status: UNSURE (   9.57  )
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
Cc: stable@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Marc,

This is wrong: commit 6022fcc0e87a0eb5e9a72b15ed70dd29ebcb7343

The above is not my original patch and it should not be tagged for stable,
as it introduces the same kind of bug I intended to fix:

array_index_nospec() can now return kvm->arch.vgic.nr_spis + VGIC_NR_PRIVATE_IRQS
and this is not what you want. So, in this case the following line of code
is just fine as it is:

intid = array_index_nospec(intid, kvm->arch.vgic.nr_spis + VGIC_NR_PRIVATE_IRQS); 


As the commit log says, my patch fixes:

commit 41b87599c74300027f305d7b34368ec558978ff2

not both:

commit 41b87599c74300027f305d7b34368ec558978ff2

and 

commit bea2ef803ade3359026d5d357348842bca9edcf1

If you want to apply the fix on top of bea2ef803ade3359026d5d357348842bca9edcf1
then you should apply this instead:

diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index bb1a83345741..e607547c7bb0 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -103,7 +103,7 @@ struct vgic_irq *vgic_get_irq(struct kvm *kvm, struct kvm_vcpu *vcpu,
 {
        /* SGIs and PPIs */
        if (intid <= VGIC_MAX_PRIVATE) {
-               intid = array_index_nospec(intid, VGIC_MAX_PRIVATE);
+               intid = array_index_nospec(intid, VGIC_MAX_PRIVATE + 1);
                return &vcpu->arch.vgic_cpu.private_irqs[intid];
        }
 

The commit log should remain the same.

Thanks
--
Gustavo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
