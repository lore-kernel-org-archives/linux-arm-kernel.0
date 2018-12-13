Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED6CC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:12:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A13E20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W6ti8ZLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A13E20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xSZOp0nBCd/ekMVO6JSgRXCYc7Q+ZrhBQhLiF9kUFcU=; b=W6ti8ZLRP93QCf
	ZK9plivx18sZV3iRp9nMolPSaIKzjzTa2nOQU5Zg1m54Ljgp+r5Qp/IgeYRCyPzZN0rt4Jw+9mmuU
	As434IExAgsZOtnSzdLB+DgIyn40mYOQN2vG+MklmxS6l18FpoUy71luB1+HWajMgObcse1joZF9G
	s34kbaojCk5y/3vyvPt2ycBT0d1NbI59ViND7cUPjV1GDeJQjOg9SfHR348Ef5uj1q7/TMJrX+TW/
	xtb0nU5Vj8hW9Tu26O6pUz9NVsIxHd6y2qASw8s6PVkhE1PgIgPVx5za71CZNichhnlgAdU/nsyWv
	yVP0TuW1N5Yd7U4zNMXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXWOx-0000lL-ST; Thu, 13 Dec 2018 19:12:03 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXWOt-0000kq-R7
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 19:12:01 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4302A78;
 Thu, 13 Dec 2018 11:11:48 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6C153F575;
 Thu, 13 Dec 2018 11:11:47 -0800 (PST)
Date: Thu, 13 Dec 2018 19:11:45 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v2 1/2] KVM: arm64: Filter out invalid core register IDs
 in KVM_GET_REG_LIST
Message-ID: <20181213191144.GD3505@e103592.cambridge.arm.com>
References: <1544645824-16461-1-git-send-email-Dave.Martin@arm.com>
 <1544645824-16461-2-git-send-email-Dave.Martin@arm.com>
 <20181213183038.GC3505@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181213183038.GC3505@e103592.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_111159_879285_F8881731 
X-CRM114-Status: GOOD (  22.50  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, stable@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 06:30:39PM +0000, Dave Martin wrote:
> On Wed, Dec 12, 2018 at 08:17:03PM +0000, Dave Martin wrote:
> > Since commit d26c25a9d19b ("arm64: KVM: Tighten guest core register
> > access from userspace"), KVM_{GET,SET}_ONE_REG rejects register IDs
> > that do not correspond to a single underlying architectural register.
> > 
> > KVM_GET_REG_LIST was not changed to match however: instead, it
> > simply yields a list of 32-bit register IDs that together cover the
> > whole kvm_regs struct.  This means that if userspace tries to use
> > the resulting list of IDs directly to drive calls to KVM_*_ONE_REG,
> > some of those calls will now fail.
> > 
> > This was not the intention.  Instead, iterating KVM_*_ONE_REG over
> > the list of IDs returned by KVM_GET_REG_LIST should be guaranteed
> > to work.
> > 
> > This patch fixes the problem by splitting validate_core_reg_id()
> > into a backend core_reg_size_from_offset() which does all of the
> > work except for checking that the size field in the register ID
> > matches, and kvm_arm_copy_reg_indices() and num_core_regs() are
> > converted to use this to enumerate the valid offsets.
> > 
> > kvm_arm_copy_reg_indices() now also sets the register ID size field
> > appropriately based on the value returned, so the register ID
> > supplied to userspace is fully qualified for use with the register
> > access ioctls.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: d26c25a9d19b ("arm64: KVM: Tighten guest core register access from userspace")
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> 
> Tested now with [1], which obtains the reg list with KVM_GET_REG_LIST
> and then tries to read each register listed.
> 
> (Comparing v4.19 with a patches v4.20-rc5 was a bit lazy here, but there
> is no reason to suppose the results would be different.)
> 
> 
> This confirms both the exactly expected bug behaviour and the fix.
> 
> 
> I have not yet checked what qemu does with the KVM_GET_REG_LIST data.

Further to this, qemu seems only to use the non-KVM_REG_ARM_CORE
registers from the KVM_GET_REG_LIST output, and uses its own built-in
knowledge to enumerate the core regs (since that is a fixed set anyway).

qemu already explicitly marks core regs with the correct size (32-/64-
or 128-bit) when doing KVM_GET_ONE_REG/KVM_SET_ONE_REG.  So it shouldn't
be affected by this patch.

[...]

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
