Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3713C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:59:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB7EF2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pspIvpfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7EF2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zhqevjB9h6jis4QDVAKRkBkqouYWeEqJH0kLbZYOpnY=; b=pspIvpfcqnt+dj
	8yY2NgAjR0EcbqzwVSA2qZpbd5u7TNQEsU/dH7IFfdWDTlczldM7b9mcn6lcdbQ2mSt3pzV70Jul2
	oHOOTUt+iZrE26BkEdy0Bi/MohAKLp7GgOOXPswF0lVPMYk4794jywTWS0DLPf7QLEzLVD6ZMZOEz
	SYAp9W9cZbMXSYGosmpBeZ36HiV6sy5jgoJ3yMIG/935qw2X2ebdBICu6hzFf9epY8v5CRRd0MJsd
	g4AsMK+XvPSbgCZD8s6QR0omp6KNHRx0VTUbTfOXAD7AMcln69x+8VlXMIX9hizM8xyLK6Ua2mY0D
	tuspkJNrKd5EA0JwA2Ew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWN2D-0006Fa-MS; Mon, 10 Dec 2018 14:59:49 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWN2B-0005h5-FS
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 14:59:48 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01D7C1596;
 Mon, 10 Dec 2018 06:59:36 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 586983F59C; Mon, 10 Dec 2018 06:59:34 -0800 (PST)
Date: Mon, 10 Dec 2018 14:59:31 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v2 2/2] arm64: uaccess: Implement unsafe accessors
Message-ID: <20181210145931.GE4048@arrakis.emea.arm.com>
References: <1543845318-24543-1-git-send-email-julien.thierry@arm.com>
 <1543845318-24543-3-git-send-email-julien.thierry@arm.com>
 <20181206182551.GB37411@arrakis.emea.arm.com>
 <6424e0f6-7755-c19a-5bc4-a70be5839644@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6424e0f6-7755-c19a-5bc4-a70be5839644@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_065947_517632_0F43CDCA 
X-CRM114-Status: GOOD (  20.03  )
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
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>, peterz@infradead.org,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
 james.morse@arm.com, hpa@zytor.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 08:38:11AM +0000, Julien Thierry wrote:
> 
> 
> On 12/06/2018 06:25 PM, Catalin Marinas wrote:
> > On Mon, Dec 03, 2018 at 01:55:18PM +0000, Julien Thierry wrote:
> > > diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> > > index 07c3408..cabfcae 100644
> > > --- a/arch/arm64/include/asm/uaccess.h
> > > +++ b/arch/arm64/include/asm/uaccess.h
> > > @@ -233,6 +233,23 @@ static inline void uaccess_enable_not_uao(void)
> > >   	__uaccess_enable(ARM64_ALT_PAN_NOT_UAO);
> > >   }
> > > +#define unsafe_user_region_active	uaccess_region_active
> > > +static inline bool uaccess_region_active(void)
> > > +{
> > > +	if (system_uses_ttbr0_pan()) {
> > > +		u64 ttbr;
> > > +
> > > +		ttbr = read_sysreg(ttbr1_el1);
> > > +		return ttbr & TTBR_ASID_MASK;
> > 
> > Nitpick: could write this in 1-2 lines.
> 
> True, I can do that in 1 line.
> 
> > > +	} else if (cpus_have_const_cap(ARM64_ALT_PAN_NOT_UAO)) {
> > > +		return (read_sysreg(sctlr_el1) & SCTLR_EL1_SPAN) ?
> > > +				false :
> > > +				!read_sysreg_s(SYS_PSTATE_PAN);
> > > +	}
> > 
> > ARM64_ALT_PAN_NOT_UAO implies ARM64_HAS_PAN which implies SCTLR_EL1.SPAN
> > is 0 at run-time. Is this to cope with the case of being called prior to
> > cpu_enable_pan()?
> > 
> 
> Yes, the issue I can into is that for cpufeatures, .cpu_enable() callbacks
> are called inside stop_machine() which obviously might_sleep and so attempts
> to check whether user_access is on. But for features that get enabled before
> PAN, the PAN bit will be set.

OK, so the PSTATE.PAN bit only makes sense when SCTLR_EL1.SPAN is 0, IOW
the PAN hardware feature has been enabled. Maybe you could write it
(together with some comment):

	} else if (cpus_have_const_cap(ARM64_ALT_PAN_NOT_UAO) &&
		 !(read_sysreg(sctlr_el1) & SCTLR_EL1_SPAN)) {
		 /* only if PAN is present and enabled */
		return !read_sysreg_s(SYS_PSTATE_PAN)
	}

On the cpufeature.c side of things, it seems that we enable the
static_branch before calling the cpu_enable. I wonder whether changing
the order here would help with avoid the SCTLR_EL1 read (not sure what
else it would break; cc'ing Suzuki).

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
