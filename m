Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1669C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:57:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B8E218E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ESYHKbz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B8E218E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Lwlc4DkZh4xHR6evSgkH7pAruECVdKF0+XjuQHCQpu0=; b=ESYHKbz++5YaFO
	AQveAllM7nMuIOfqnocEtrCxFbmmlmSaEw3t2fyuPT7p4F1KOxBcC6Dw7GFIuX9sFYswn3kZViBhq
	uu67dM0ClmnrUT7nYJF69ZFxJOWyditRNxlMphwuItFi/d+DvmEkX31RtPgLjMf+r8rOfFgyEnUZI
	5SsYgbaYm+f/cns4whBtQE9pcqAkKRAcR2OVMRX4kDEZp6UEXBoym56PuV/3QTe8x3qn5l1T7K1Zf
	KVasP7ARW4o13RP6/6RjpTCAkEXv1RN7LSZuHw4J8aQup612OdqyR30P6UfAPl5F+M/ARs3HHOH0p
	+u2MRKgclukG2Pg8Yzqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaMF7-0007DL-Vh; Fri, 21 Dec 2018 14:57:37 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaMEw-000757-J1
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 14:57:28 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FD6C1596;
 Fri, 21 Dec 2018 06:57:18 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9DBD3F59C;
 Fri, 21 Dec 2018 06:57:16 -0800 (PST)
Subject: Re: [PATCH v2 2/2] arm64: uaccess: Implement unsafe accessors
To: Julien Thierry <julien.thierry@arm.com>
References: <1543845318-24543-1-git-send-email-julien.thierry@arm.com>
 <1543845318-24543-3-git-send-email-julien.thierry@arm.com>
From: James Morse <james.morse@arm.com>
Message-ID: <f933b06a-0f4a-3bdb-86ef-644ac0a16163@arm.com>
Date: Fri, 21 Dec 2018 14:57:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1543845318-24543-3-git-send-email-julien.thierry@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_065726_671976_DEA2AFB9 
X-CRM114-Status: GOOD (  17.86  )
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
Cc: peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Julien,

On 03/12/2018 13:55, Julien Thierry wrote:
> Current implementation of get/put_user_unsafe default to get/put_user
> which toggle PAN before each access, despite having been told by the caller
> that multiple accesses to user memory were about to happen.
> 
> Provide implementations for user_access_begin/end to turn PAN off/on and
> implement unsafe accessors that assume PAN was already turned off.

> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 842fb95..4e6477b 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -108,6 +108,8 @@
>  #define SYS_DC_CSW			sys_insn(1, 0, 7, 10, 2)
>  #define SYS_DC_CISW			sys_insn(1, 0, 7, 14, 2)
>  
> +#define SYS_PSTATE_PAN			sys_reg(3, 0, 4, 2, 3)

Nit: Could we keep this list in encoding order please.
(it makes conflicts easier to resolve in the future)

>  #define SYS_OSDTRRX_EL1			sys_reg(2, 0, 0, 0, 2)
>  #define SYS_MDCCINT_EL1			sys_reg(2, 0, 0, 2, 0)
>  #define SYS_MDSCR_EL1			sys_reg(2, 0, 0, 2, 2)
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index 07c3408..cabfcae 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -233,6 +233,23 @@ static inline void uaccess_enable_not_uao(void)
>  	__uaccess_enable(ARM64_ALT_PAN_NOT_UAO);
>  }
>  
> +#define unsafe_user_region_active	uaccess_region_active
> +static inline bool uaccess_region_active(void)
> +{
> +	if (system_uses_ttbr0_pan()) {
> +		u64 ttbr;
> +
> +		ttbr = read_sysreg(ttbr1_el1);
> +		return ttbr & TTBR_ASID_MASK;
> +	} else if (cpus_have_const_cap(ARM64_ALT_PAN_NOT_UAO)) {
> +		return (read_sysreg(sctlr_el1) & SCTLR_EL1_SPAN) ?
> +				false :
> +				!read_sysreg_s(SYS_PSTATE_PAN);
> +	}
> +
> +	return false;
> +}

(Reading the SCTLR bit is a bit of a heavy-hammer, as suggested elsewhere on the
thread, can we use alternatives_applied here?)

It may be worth splitting this into three patches, so the 'unsafe' bits can be
merged without the debug option.


Either way, for the unsafe parts:
Reviewed-by: James Morse <james.morse@arm.com>


Thanks!

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
