Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22196C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:40:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E39AE20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UzRYnfQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39AE20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t6z3hf0S7AfEEfLp9PLyemdNMnryhdznMje8MlyWDhI=; b=UzRYnfQy2rQm3e
	/zzrLggzE9or2e0zqcsGWfZTayB/hFm0Md1BTLz0yHycNQIlFGx5drXFThzm2MqemwyrfNQkvTATz
	OXsr36a44NRmbLUS892Arxf/zeOMFRqZjUiJ041E//irPKjPPjjBfeQzMJsP/ahjXZS4HQtWaBXIl
	S2kgX05kj+Q0QrbsblyNvwXdVG6k1ozRUTvmBbyOWM6SCNdXP9uevz7HWqn9M5orTJrsOP+7DlIwL
	e8yMK6JKkcm5HNP+4NCNW+HU38iCeR9gkka/yfP5fn6o5dfDu+SdGKcDZ8MTFpYG1R7TCfZD1EDoE
	Rnga7N7SjlM1i27FGcSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWKrU-0005Zt-Qc; Mon, 10 Dec 2018 12:40:36 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWKrR-0005Z8-O8
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 12:40:35 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F200615AB;
 Mon, 10 Dec 2018 04:40:21 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C129C3F575;
 Mon, 10 Dec 2018 04:40:21 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 598CD1AE0CBE; Mon, 10 Dec 2018 12:40:44 +0000 (GMT)
Date: Mon, 10 Dec 2018 12:40:44 +0000
From: Will Deacon <will.deacon@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v3 2/8] KVM: arm64: Rework detection of SVE, !VHE systems
Message-ID: <20181210124043.GA25144@edgewater-inn.cambridge.arm.com>
References: <20181206173126.139877-1-marc.zyngier@arm.com>
 <20181206173126.139877-3-marc.zyngier@arm.com>
 <20181210101305.GH30263@e113682-lin.lund.arm.com>
 <aff2750e-6746-3378-6d4d-dcbfc2028154@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aff2750e-6746-3378-6d4d-dcbfc2028154@arm.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_044033_793548_7AEFA9C9 
X-CRM114-Status: GOOD (  17.67  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, James Morse <james.morse@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 10:28:05AM +0000, Marc Zyngier wrote:
> On 10/12/2018 10:13, Christoffer Dall wrote:
> > On Thu, Dec 06, 2018 at 05:31:20PM +0000, Marc Zyngier wrote:
> >> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> >> index 23774970c9df..1db4c15edcdd 100644
> >> --- a/virt/kvm/arm/arm.c
> >> +++ b/virt/kvm/arm/arm.c
> >> @@ -1640,8 +1640,10 @@ int kvm_arch_init(void *opaque)
> >>  		return -ENODEV;
> >>  	}
> >>  
> >> -	if (!kvm_arch_check_sve_has_vhe()) {
> >> -		kvm_pr_unimpl("SVE system without VHE unsupported.  Broken cpu?");
> >> +	in_hyp_mode = is_kernel_in_hyp_mode();
> >> +
> >> +	if (!in_hyp_mode && kvm_arch_requires_vhe()) {
> >> +		kvm_pr_unimpl("CPU requiring VHE was booted in non-VHE mode");
> > 
> > nit: The error message feels weird to me (are we reporting CPU bugs?)
> > and I'm not sure about the unimpl and I think there's a linse space
> > missing.
> > 
> > How about:
> > 
> > 	kvm_err("Cannot support this CPU in non-VHE mode, not initializing\n");
> 
> Yup, works for me. Will, do you mind changing this message for me?

I pushed out an updated branch here:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kvm/cortex-a76-erratum-1165522

which should address all of Christoffer's comments and add his tags.

I plan to merge that into for-next/core later today.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
