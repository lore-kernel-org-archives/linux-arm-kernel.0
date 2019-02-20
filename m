Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94960C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:33:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66B152147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="abMG3KU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B152147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JISk4mZ+hNAipCSM6uVDH14UFoYnKwXpAb5pKnuHdTs=; b=abMG3KU8SiHayc
	4NFKYrk1NJcEtvOpa9MrCVIarVsXHMBbjeBqemr56/GOJK2dKVtkm+RImmtJRRZR4IkzEjZgnFmNR
	vHWoOnWiwkzrqXVQeWyEyN11RDXzc7aMBTsD7fzCSsTZx6yffdANrl8m4B4u84qlFH92ursXmPyro
	1vrcIUV471Wb8CqGPp6uRtgrBwHxahUGx+ToqcFzVRXqpfSJBJK6mmuVULkg2v+pE5tsVdDubuDZV
	6grIXDDzbH2g8OFaarPc/k7ARudLvXezLccGmU8Z5BMViy6kzqBkXi83I/HwcJPIzsRNybvCHoqKe
	Js/m4MPk5opMrF0Qo2dg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwS0J-0007bj-D5; Wed, 20 Feb 2019 13:33:39 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwS0G-0007bP-JG
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 13:33:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C93B5EBD;
 Wed, 20 Feb 2019 05:33:35 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C59A3F690;
 Wed, 20 Feb 2019 05:33:30 -0800 (PST)
Subject: Re: [PATCH v5 11/26] KVM: arm64: Extend reset_unknown() to handle
 mixed RES0/UNKNOWN registers
To: Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.cs.columbia.edu
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-12-git-send-email-Dave.Martin@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <602da3aa-f473-7a35-1b59-31af8a162ccc@arm.com>
Date: Wed, 20 Feb 2019 13:33:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1550519559-15915-12-git-send-email-Dave.Martin@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_053336_647427_9BED39A9 
X-CRM114-Status: GOOD (  26.88  )
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
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Dave,

On 18/02/2019 19:52, Dave Martin wrote:
> The reset_unknown() system register helper initialises a guest
> register to a distinctive junk value on vcpu reset, to help expose
> and debug deficient register initialisation within the guest.
> 
> Some registers such as the SVE control register ZCR_EL1 contain a
> mixture of UNKNOWN fields and RES0 bits.  For these,
> reset_unknown() does not work at present, since it sets all bits to
> junk values instead of just the wanted bits.
> 
> There is no need to craft another special helper just for that,
> since reset_unknown() almost does the appropriate thing anyway.
> This patch takes advantage of the unused val field in struct
> sys_reg_desc to specify a mask of bits that should be initialised
> to zero instead of junk.
> 
> All existing users of reset_unknown() do not (and should not)
> define a value for val, so they will implicitly set it to zero,
> resulting in all bits being made UNKNOWN by this function: thus,
> this patch makes no functional change for currently defined
> registers.
> 
> Future patches will make use of non-zero val.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  arch/arm64/kvm/sys_regs.h | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
> index 3b1bc7f..174ffc0 100644
> --- a/arch/arm64/kvm/sys_regs.h
> +++ b/arch/arm64/kvm/sys_regs.h
> @@ -56,7 +56,12 @@ struct sys_reg_desc {
>  	/* Index into sys_reg[], or 0 if we don't need to save it. */
>  	int reg;
>  
> -	/* Value (usually reset value) */
> +	/*
> +	 * Value (usually reset value)
> +	 * For reset_unknown, each bit set to 1 in val is treated as
> +	 * RES0 in the register: the corresponding register bit is
> +	 * reset to 0 instead of "unknown".
> +	 */

Seeing there are users of this field, I find this a bit fragile. Is
there a reason not to add a separate "u64 res0_mask;" ?

The sys_reg_desc structures are instantiated once as constants for the
whole system rather than per VM/VCPU. Would it be really bad to add a
64bit field there?

>  	u64 val;
>  
>  	/* Custom get/set_user functions, fallback to generic if NULL */
> @@ -92,7 +97,9 @@ static inline void reset_unknown(struct kvm_vcpu *vcpu,
>  {
>  	BUG_ON(!r->reg);
>  	BUG_ON(r->reg >= NR_SYS_REGS);
> -	__vcpu_sys_reg(vcpu, r->reg) = 0x1de7ec7edbadc0deULL;
> +
> +	/* If non-zero, r->val specifies which register bits are RES0: */
> +	__vcpu_sys_reg(vcpu, r->reg) = 0x1de7ec7edbadc0deULL & ~r->val;
>  }
>  
>  static inline void reset_val(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
> 

Cheers,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
