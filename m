Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC495C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:22:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79D1A20645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SvbSSEwK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D1A20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WLLOZFejH1v4Yz1LMcwGAnym/K0fFstRn0vT4SSGnkg=; b=SvbSSEwKVJQ5o6aPIRq0muUUl
	IpIfsB6aqJMEb4booKTXQM15XjfNhzOFCx8Ujt1zybLAnl2enKwOJ+fZPRnh5BB+OszbEnNyaPaaW
	yZC9wqVCwnRlqp6uWZqmRecAI1hbVGL+CQxvbNTbtddKyxu30JjyohXbGyR50Kag0a5RNnQZ0p8Ef
	9uF00hDT9nwTVoCFlIwsexyyLug7NrsZZNdW/cHM0q2EMngdEnSeJdqeOL0bSKscnBEkyHje5xqVy
	FEA0U0x7d0PhsGGNlqvIIZJ2Vs4r45ju7cX0g1o+2CcilDf2pdvsjAN9QG09OnbIMbZU6HCilXZST
	O6QjyzfwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUboz-0006if-BB; Wed, 05 Dec 2018 18:22:53 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUbon-0006Oc-8u
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 18:22:49 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89B3BEBD;
 Wed,  5 Dec 2018 10:22:30 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 285AA3F575;
 Wed,  5 Dec 2018 10:22:29 -0800 (PST)
Subject: Re: [PATCH V4 5/6] arm64: mm: introduce 52-bit userspace support
To: Steve Capper <steve.capper@arm.com>, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org
References: <20181205164145.24568-1-steve.capper@arm.com>
 <20181205164145.24568-6-steve.capper@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <e1a9b147-d635-9f32-2f33-ccd689dba858@arm.com>
Date: Wed, 5 Dec 2018 18:22:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181205164145.24568-6-steve.capper@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_102241_952143_19DF25BE 
X-CRM114-Status: GOOD (  26.90  )
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
Cc: catalin.marinas@arm.com, ard.biesheuvel@linaro.org, will.deacon@arm.com,
 jcm@redhat.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Steve,

On 05/12/2018 16:41, Steve Capper wrote:
> On arm64 there is optional support for a 52-bit virtual address space.
> To exploit this one has to be running with a 64KB page size and be
> running on hardware that supports this.
> 
> For an arm64 kernel supporting a 48 bit VA with a 64KB page size,
> some changes are needed to support a 52-bit userspace:
>   * TCR_EL1.T0SZ needs to be 12 instead of 16,
>   * TASK_SIZE needs to reflect the new size.
> 
> This patch implements the above when the support for 52-bit VAs is
> detected at early boot time.
> 
> On arm64 userspace addresses translation is controlled by TTBR0_EL1. As
> well as userspace, TTBR0_EL1 controls:
>   * The identity mapping,
>   * EFI runtime code.
> 
> It is possible to run a kernel with an identity mapping that has a
> larger VA size than userspace (and for this case __cpu_set_tcr_t0sz()
> would set TCR_EL1.T0SZ as appropriate). However, when the conditions for
> 52-bit userspace are met; it is possible to keep TCR_EL1.T0SZ fixed at
> 12. Thus in this patch, the TCR_EL1.T0SZ size changing logic is
> disabled.
> 
> Signed-off-by: Steve Capper <steve.capper@arm.com>
> 
> ---
> 
> Changed in V4, pgd_index logic removed as we offset ttbr1 instead
> ---
>   arch/arm64/Kconfig                   |  4 ++++
>   arch/arm64/include/asm/assembler.h   |  7 +++----
>   arch/arm64/include/asm/mmu_context.h |  3 +++
>   arch/arm64/include/asm/processor.h   | 14 +++++++++-----
>   arch/arm64/kernel/head.S             | 13 +++++++++++++
>   arch/arm64/mm/fault.c                |  2 +-
>   arch/arm64/mm/mmu.c                  |  1 +
>   arch/arm64/mm/proc.S                 | 10 +++++++++-
>   8 files changed, 43 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 787d7850e064..eab02d24f5d1 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -709,6 +709,10 @@ config ARM64_PA_BITS_52
>   
>   endchoice
>   
> +config ARM64_52BIT_VA
> +	def_bool y
> +	depends on ARM64_VA_BITS_48 && ARM64_64K_PAGES
> +
>   config ARM64_PA_BITS
>   	int
>   	default 48 if ARM64_PA_BITS_48
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index e2fe378d2a63..243ec4f0c00f 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -342,11 +342,10 @@ alternative_endif
>   	.endm
>   
>   /*
> - * tcr_set_idmap_t0sz - update TCR.T0SZ so that we can load the ID map
> + * tcr_set_t0sz - update TCR.T0SZ so that we can load the ID map
>    */
> -	.macro	tcr_set_idmap_t0sz, valreg, tmpreg
> -	ldr_l	\tmpreg, idmap_t0sz
> -	bfi	\valreg, \tmpreg, #TCR_T0SZ_OFFSET, #TCR_TxSZ_WIDTH
> +	.macro	tcr_set_t0sz, valreg, t0sz
> +	bfi	\valreg, \t0sz, #TCR_T0SZ_OFFSET, #TCR_TxSZ_WIDTH
>   	.endm
>   
>   /*
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index 1e58bf58c22b..b125fafc611b 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -72,6 +72,9 @@ extern u64 idmap_ptrs_per_pgd;
>   
>   static inline bool __cpu_uses_extended_idmap(void)
>   {
> +	if (IS_ENABLED(CONFIG_ARM64_52BIT_VA))
> +		return false;
> +
>   	return unlikely(idmap_t0sz != TCR_T0SZ(VA_BITS));
>   }
>   
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index fe95fd8b065e..b363fc705be4 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -19,11 +19,12 @@
>   #ifndef __ASM_PROCESSOR_H
>   #define __ASM_PROCESSOR_H
>   
> -#define TASK_SIZE_64		(UL(1) << VA_BITS)
> -
> -#define KERNEL_DS	UL(-1)
> -#define USER_DS		(TASK_SIZE_64 - 1)
> -
> +#define KERNEL_DS		UL(-1)
> +#ifdef CONFIG_ARM64_52BIT_VA
> +#define USER_DS			((UL(1) << 52) - 1)
> +#else
> +#define USER_DS			((UL(1) << VA_BITS) - 1)
> +#endif /* CONFIG_ARM64_52IT_VA */
>   #ifndef __ASSEMBLY__
>   #ifdef __KERNEL__
>   
> @@ -48,6 +49,9 @@
>   
>   #define DEFAULT_MAP_WINDOW_64	(UL(1) << VA_BITS)
>   
> +extern u64 vabits_user;
> +#define TASK_SIZE_64		(UL(1) << vabits_user)
> +
>   #ifdef CONFIG_COMPAT
>   #define TASK_SIZE_32		UL(0x100000000)
>   #define TASK_SIZE		(test_thread_flag(TIF_32BIT) ? \
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index f60081be9a1b..5bc776b8ee5e 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -318,6 +318,19 @@ __create_page_tables:
>   	adrp	x0, idmap_pg_dir
>   	adrp	x3, __idmap_text_start		// __pa(__idmap_text_start)
>   
> +#ifdef CONFIG_ARM64_52BIT_VA
> +	mrs_s	x6, SYS_ID_AA64MMFR2_EL1
> +	and	x6, x6, #(0xf << ID_AA64MMFR2_LVA_SHIFT)
> +	mov	x5, #52
> +	cbnz	x6, 1f
> +#endif
> +	mov	x5, #VA_BITS
> +1:
> +	adr_l	x6, vabits_user
> +	str	x5, [x6]
> +	dmb	sy
> +	dc	ivac, x6		// Invalidate potentially stale cache line
> +

I think we may need a check for the secondary CPUs to make sure that they have
the 52bit support once the boot CPU has decided to use the feature and fail the
CPU bring up (just like we do for the granule support).

Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
