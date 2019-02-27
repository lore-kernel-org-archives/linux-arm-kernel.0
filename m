Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239ABC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:05:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E65C02075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OXbJvUZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65C02075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L95kxRgWr7lCXsTRz1hkUNGx98bIs99kUeajRj3APvw=; b=OXbJvUZRBadTbJ
	PHqaPZmoGIcVcX+DkxkGkUBIBS12l4+Q9BJ8ZGfg0TGmNWKTB7KFztTe0iFDmf0UIw8o6XucoJ9a7
	Gc0Hc21lfJrkZvJHFLYWOl4Rs1QJ8ZSfolBkh8VyKH+ZlwkBCaaHuexb2UXk2TqsTplFOiF/O9baX
	PMpM+njk+okEXfNpaWVuVW1fs2EzU+o4+cUj42b3YRUubxVIDHdDLkCgZn2fm7osHm2WBDbEtdkS3
	f/gxvsjzo7QTQk5EhgnUbLhbE2+vCS97DT5eFEKfbOjXThIH+d5ZRhQXTgLyJAbSe//oKkC3YW9By
	pXnF96DP+rw/1+gVI9jA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyxxx-0004O3-IZ; Wed, 27 Feb 2019 12:05:37 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyxxt-0004NV-IT
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 12:05:35 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01BFCA78;
 Wed, 27 Feb 2019 04:05:33 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14DA13F575;
 Wed, 27 Feb 2019 04:05:31 -0800 (PST)
Date: Wed, 27 Feb 2019 12:05:29 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 1/5] KVM: arm/arm64: Reset the VCPU without preemption
 and vcpu state loaded
Message-ID: <20190227120527.GC3567@e103592.cambridge.arm.com>
References: <20190125094656.5026-1-christoffer.dall@arm.com>
 <20190125094656.5026-2-christoffer.dall@arm.com>
 <20190220191450.GT3567@e103592.cambridge.arm.com>
 <20190220194143.2e1a7d2c@why.wild-wind.fr.eu.org>
 <20190226135352.GX3567@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190226135352.GX3567@e103592.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_040533_623677_A9484504 
X-CRM114-Status: GOOD (  18.75  )
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
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 01:53:52PM +0000, Dave Martin wrote:
> On Wed, Feb 20, 2019 at 07:41:43PM +0000, Marc Zyngier wrote:
> > On Wed, 20 Feb 2019 19:14:53 +0000
> > Dave Martin <Dave.Martin@arm.com> wrote:

[...]

> > > Perhaps an alternative approach would be to nobble the preempt notifier
> > > and stick an explicit vcpu_put()...vcpu_load() around the
> > > swait_event_interruptible_exclusive() call in vcpu_req_sleep().  This
> > > is not fast path.
> > 
> > What does it buy us? The problem we're solving here is a powered-off,
> > spuriously woken-up vcpu racing against the reset performed from
> > another vcpu. I don't see what adding more put/load would solve.
> 
> Not a lot.  Changes in this area would allow some code to move outside
> preempt_disable(), but only at the expense of extra cost elsewhere...
> 
> > > Any, with the code as-is, it looks like the SVE regs resetting should
> > > go in the preempt_disable() region, after the kvm_arch_vcpu_put() call.
> > 
> > All resets must go there. This is the only safe location.
> 
> OK, that's what I wanted to be sure of.

Hmmm, it turns out this is no good because we may need to kzalloc()
the vcpu->arch.sve_state storage here in the new-vcpu case.

Rather than create additional mess in this code, I will move that
allocation to be done more eagerly rather than deferred until the last
possible moment.

With the current API flow, this may mean krealloc()'ing the buffer if
the set of vector lengths for the vcpu is modified from the default
before the vcpu is run, via a user write to KVM_REG_ARM64_SVE_VLS --
though we would anyway get away with not doing it, since the default
buffer size will be the maximum that the hardware could possibly
require anyway.  We could waste a few K per vcpu, but that's almost not
worth caring about.

I'd rather not churn the API at this point, but I'll experiment to see
which approach under the hood looks cleanest.

Thoughts?

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
