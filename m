Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6645C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:09:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2F43217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FXdvrOSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F43217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gap8MuU+3ZvZ4A47kiD+hAprPq0njAPEY2Y93aJeJQU=; b=FXdvrOSpCsijD6
	jCpe4840BSJUiunXdPs1oKOdSKfiQRgWmsFDYKfZcnT391XkQmpBXbF9tClv+4j1tuEl1vOajQmYr
	f+cnk5oNDXx/ieQhU6O3fYEUXH2mOKXE3L+lXIRr92sX5VidpTcp14UXZxWZs/CYvOZB2gYhFnyFL
	b+FZl/YL/iWEXmemBTx6JmXf1tgZat+hAqEd0tiD6fFYJKsk78+bAFEsoXm8+rM7cLotxxl9UPv/v
	RcYgvCaQkGMNMPSwtWbwmJjyjwq3ZfK9sV2hy4FtTfqxwNHCySUKC8soycLzLH7krFOW9ftbvJDfz
	rjZzARNJ3UavHDtC51dQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybXi-0002lK-Fa; Tue, 26 Feb 2019 12:09:02 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybWF-0001LB-U3
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:08:01 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 280C480D;
 Tue, 26 Feb 2019 04:07:31 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B5073F71D;
 Tue, 26 Feb 2019 04:07:29 -0800 (PST)
Date: Tue, 26 Feb 2019 12:07:26 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v5 11/26] KVM: arm64: Extend reset_unknown() to handle
 mixed RES0/UNKNOWN registers
Message-ID: <20190226120726.GM3567@e103592.cambridge.arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-12-git-send-email-Dave.Martin@arm.com>
 <602da3aa-f473-7a35-1b59-31af8a162ccc@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <602da3aa-f473-7a35-1b59-31af8a162ccc@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_040732_521095_564C86C9 
X-CRM114-Status: GOOD (  28.50  )
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
Cc: Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Zhang Lei <zhang.lei@jp.fujitsu.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 20, 2019 at 01:33:28PM +0000, Julien Thierry wrote:
> Hi Dave,
> 
> On 18/02/2019 19:52, Dave Martin wrote:
> > The reset_unknown() system register helper initialises a guest
> > register to a distinctive junk value on vcpu reset, to help expose
> > and debug deficient register initialisation within the guest.
> > 
> > Some registers such as the SVE control register ZCR_EL1 contain a
> > mixture of UNKNOWN fields and RES0 bits.  For these,
> > reset_unknown() does not work at present, since it sets all bits to
> > junk values instead of just the wanted bits.
> > 
> > There is no need to craft another special helper just for that,
> > since reset_unknown() almost does the appropriate thing anyway.
> > This patch takes advantage of the unused val field in struct
> > sys_reg_desc to specify a mask of bits that should be initialised
> > to zero instead of junk.
> > 
> > All existing users of reset_unknown() do not (and should not)
> > define a value for val, so they will implicitly set it to zero,
> > resulting in all bits being made UNKNOWN by this function: thus,
> > this patch makes no functional change for currently defined
> > registers.
> > 
> > Future patches will make use of non-zero val.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > ---
> >  arch/arm64/kvm/sys_regs.h | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
> > index 3b1bc7f..174ffc0 100644
> > --- a/arch/arm64/kvm/sys_regs.h
> > +++ b/arch/arm64/kvm/sys_regs.h
> > @@ -56,7 +56,12 @@ struct sys_reg_desc {
> >  	/* Index into sys_reg[], or 0 if we don't need to save it. */
> >  	int reg;
> >  
> > -	/* Value (usually reset value) */
> > +	/*
> > +	 * Value (usually reset value)
> > +	 * For reset_unknown, each bit set to 1 in val is treated as
> > +	 * RES0 in the register: the corresponding register bit is
> > +	 * reset to 0 instead of "unknown".
> > +	 */
> 
> Seeing there are users of this field, I find this a bit fragile. Is

In fact, I only see reset_val(), and the reset_val workalikes
reset_bcr(), reset_bvr() etc., using this field.

So, when used, this is always the reset value right now.

We could water the comment down to "data used by the reset method."


> there a reason not to add a separate "u64 res0_mask;" ?
> 
> The sys_reg_desc structures are instantiated once as constants for the
> whole system rather than per VM/VCPU. Would it be really bad to add a
> 64bit field there?

Not really.  I was trying to avoid overengineering something that will
probably only ever be used in one or two places.

With that in mind, I'm feeling this patch may be premature factoring
and can be dropped.  Initialising ZCR_EL1 with 0, or a fixed value
based on 0x1de7ec7edbadc0deULL would be good enough for this currently
unique case.  

Thoughts?

[...]

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
