Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAF0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:04:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 067E92075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OLdaeCIm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067E92075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zDd+gfongbFlFT2bxmdCWWgPXmGEM6fzSzDMomhcY0c=; b=OLdaeCImjfMW+qNKXn7ObewgC
	P2rxoSQeQuzcrgObidgUk8c90dZtWuaFv4Cp4kMPhwULj4fJ6o4d8eBcwX4Ia96NX0dr28Wjczaml
	yaJrZ+OrcWgex9Bvm0eNslHzbT4NOyH5ZNrkvKy9CvGh3E7i0g0g9Z+aViO2HKmjtm5EzsFG0p8kU
	PFaCWEUY+9ZV19D/Jn0KRVuQ+AHNl9QDpQBbOrRBM32VHZyjoTkuAyNvv45m4oa/KQkazF9ylp37v
	b3isXyjLZxYJ/3fofAYcLBSAeFTix3QByXlWSU4SV22MiLD47w5/Db6+4P+NKW/QaeDflxmmPvxxq
	ydUW2dWrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxDJ4-00075L-5x; Fri, 22 Feb 2019 16:04:10 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxDJ0-00070z-Bo
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 16:04:07 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D8CF80D;
 Fri, 22 Feb 2019 08:04:05 -0800 (PST)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8ACAF3F575;
 Fri, 22 Feb 2019 08:04:03 -0800 (PST)
Subject: Re: [PATCH v5 11/26] KVM: arm64: Extend reset_unknown() to handle
 mixed RES0/UNKNOWN registers
To: Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.cs.columbia.edu
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-12-git-send-email-Dave.Martin@arm.com>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <a77d3eb5-58a2-5c1a-95b5-e3d54804e5ac@arm.com>
Date: Fri, 22 Feb 2019 16:04:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1550519559-15915-12-git-send-email-Dave.Martin@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_080406_418598_F2958C70 
X-CRM114-Status: GOOD (  23.53  )
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Zhang Lei <zhang.lei@jp.fujitsu.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
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

Reviewed-by: Julien Grall <julien.grall@arm.com>

Cheers,

> ---
>   arch/arm64/kvm/sys_regs.h | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
> index 3b1bc7f..174ffc0 100644
> --- a/arch/arm64/kvm/sys_regs.h
> +++ b/arch/arm64/kvm/sys_regs.h
> @@ -56,7 +56,12 @@ struct sys_reg_desc {
>   	/* Index into sys_reg[], or 0 if we don't need to save it. */
>   	int reg;
>   
> -	/* Value (usually reset value) */
> +	/*
> +	 * Value (usually reset value)
> +	 * For reset_unknown, each bit set to 1 in val is treated as
> +	 * RES0 in the register: the corresponding register bit is
> +	 * reset to 0 instead of "unknown".
> +	 */
>   	u64 val;
>   
>   	/* Custom get/set_user functions, fallback to generic if NULL */
> @@ -92,7 +97,9 @@ static inline void reset_unknown(struct kvm_vcpu *vcpu,
>   {
>   	BUG_ON(!r->reg);
>   	BUG_ON(r->reg >= NR_SYS_REGS);
> -	__vcpu_sys_reg(vcpu, r->reg) = 0x1de7ec7edbadc0deULL;
> +
> +	/* If non-zero, r->val specifies which register bits are RES0: */
> +	__vcpu_sys_reg(vcpu, r->reg) = 0x1de7ec7edbadc0deULL & ~r->val;
>   }
>   
>   static inline void reset_val(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
> 

-- 
Julien Grall

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
