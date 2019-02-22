Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75854C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:51:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F7D220652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d8XKav99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7D220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Sit+FXCK1PXqtRWwh4Wv9E7j956MPJtHDf2kiqug11w=; b=d8XKav99Id7RDz
	WjQTPxVwQ/qobSviY31AATRBW5u6vdgjEBBVigDUWIOPZ3gonh7BsWcSAX/5toAiIok95xgtv92YS
	VRwdSEJZvLbyglo9LcQn/Oega+rxGZvSOhCJxOLdilb9kMK6nqKiJNjDbAq5wO7aCk/Ujxvmi3N6j
	OvPyupXvfzJrewzPHmx1mBezMWvIpWfJ68Us/8ic1boeFxB3mZnxrHbuJpIXRZVOpf1s1uPuEzDkr
	+M3dbESuyWPFX5TIj4oTPL7Arv3BHwFqE7Oq1vdiMqruHk3y2dVS5FJ6gP+bk4gQazfrXRst9G3XH
	i3R1lq0qpuJ5SWTr7XFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx9MZ-0001yD-O6; Fri, 22 Feb 2019 11:51:31 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx9MW-0001xW-3m
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 11:51:29 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D32CA78;
 Fri, 22 Feb 2019 03:51:25 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9D713F5C1;
 Fri, 22 Feb 2019 03:51:23 -0800 (PST)
Date: Fri, 22 Feb 2019 11:51:19 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH] KVM: arm64: Fix architecturally invalid reset value for
 FPEXC32_EL2
Message-ID: <20190222115119.170cb5fc@why.wild-wind.fr.eu.org>
In-Reply-To: <20190222105604.GB3567@e103592.cambridge.arm.com>
References: <1550749352-2315-1-git-send-email-Dave.Martin@arm.com>
 <20190222100103.03fb773d@why.wild-wind.fr.eu.org>
 <20190222105604.GB3567@e103592.cambridge.arm.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_035128_161044_A616A657 
X-CRM114-Status: GOOD (  17.75  )
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
Cc: Julien Thierry <julien.thierry@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, stable@vger.kernel.org,
 James Morse <james.morse@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 22 Feb 2019 10:56:07 +0000
Dave Martin <Dave.Martin@arm.com> wrote:

> On Fri, Feb 22, 2019 at 10:01:03AM +0000, Marc Zyngier wrote:
> > On Thu, 21 Feb 2019 11:42:32 +0000
> > Dave Martin <Dave.Martin@arm.com> wrote:
> >   
> > > Due to what looks like a typo dating back to the original addition
> > > of FPEXC32_EL2 handling, KVM currently initialises this register to
> > > an architecturally invalid value.
> > > 
> > > As a result, the VECITR field (RES1) in bits [10:8] is initialised
> > > with 0, and the two reserved (RES0) bits [6:5] are initialised with
> > > 1.  (In the Common VFP Subarchitecture as specified by ARMv7-A,
> > > these two bits were IMP DEF.  ARMv8-A removes them.)
> > > 
> > > This patch changes the reset value from 0x70 to 0x700, which
> > > reflects the architectural constraints and is presumably what was
> > > originally intended.
> > > 
> > > Cc: <stable@vger.kernel.org> # 4.12.x-
> > > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > > Cc: Christoffer Dall <christoffer.dall@arm.com>
> > > Fixes: 62a89c44954f ("arm64: KVM: 32bit handling of coprocessor traps")
> > > Signed-off-by: Dave Martin <Dave.Martin@arm.com>  
> > 
> > Applied to -next.
> > 
> > Thanks,  
> 
> Thanks.
> 
> I have a patch for <= v4.11 which I can send to stable once this patch
> reaches torvalds/master.
> 
> Is it worth it though, in your opinion?

I don't think it has much value. To be honest, this patch mostly serves
as documentation, as any implementation worth its salt will honour the
RES0/RES1 properties. I've kept the cc stable in your original patch,
but arguably it doesn't fix anything real.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
