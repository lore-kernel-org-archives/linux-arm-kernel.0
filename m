Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6AEC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:03:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9698120868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tVoIDuCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9698120868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hEe2isyxEKxH4ZVnN1B7DLXJpnGFLTVtk6DNOMylP/8=; b=tVoIDuCkONIX2b/npgf8beB/o
	TFY20OnCXmZrK5vZJTmFFXCb8ksO7Ckq3lmmoMBShs3hHLFLH5CekN6wkW2nW/blWWonjiLf29YDm
	ygnuGIsXCwrfropixHVz/cs1LvHJmYD2A99lWRljQfTNdCBTJhSY/8HnoGxXsDuy0VDf9Y6rhEret
	swzBmZQUoJ+xRT+p39k49HCMzJb4dyigjECtyZu+HujvJYU8LAIqyFYcRL+SU33LmTveZ8hPClAYz
	D4rfmkd6HVA/HwJgfoJP9i8U0Zqgrr/Cy0oQsu7kvMhW4XSc8hiZ51ctO3n7T4BS0PBiuyzse8jhy
	gi8GZ4DCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVEqV-0002IY-M5; Fri, 07 Dec 2018 12:03:03 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVEqS-0002HC-BF
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 12:03:01 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC346EBD;
 Fri,  7 Dec 2018 04:02:49 -0800 (PST)
Received: from [10.37.13.21] (unknown [10.37.13.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2246B3F5AF;
 Fri,  7 Dec 2018 04:02:47 -0800 (PST)
Subject: Re: [PATCH V5 4/7] arm64: mm: Offset TTBR1 to allow 52-bit
 PTRS_PER_PGD
To: Steve Capper <steve.capper@arm.com>, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org
References: <20181206225042.11548-1-steve.capper@arm.com>
 <20181206225042.11548-5-steve.capper@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <bc7581b3-2cb9-b11f-d33f-4999cbff3a0f@arm.com>
Date: Fri, 7 Dec 2018 12:04:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20181206225042.11548-5-steve.capper@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_040300_453385_26556318 
X-CRM114-Status: GOOD (  24.45  )
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
Cc: catalin.marinas@arm.com, will.deacon@arm.com, jcm@redhat.com,
 ard.biesheuvel@linaro.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/06/2018 10:50 PM, Steve Capper wrote:
> Enabling 52-bit VAs on arm64 requires that the PGD table expands from 64
> entries (for the 48-bit case) to 1024 entries. This quantity,
> PTRS_PER_PGD is used as follows to compute which PGD entry corresponds
> to a given virtual address, addr:
> 
> pgd_index(addr) -> (addr >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1)
> 
> Userspace addresses are prefixed by 0's, so for a 48-bit userspace
> address, uva, the following is true:
> (uva >> PGDIR_SHIFT) & (1024 - 1) == (uva >> PGDIR_SHIFT) & (64 - 1)
> 
> In other words, a 48-bit userspace address will have the same pgd_index
> when using PTRS_PER_PGD = 64 and 1024.
> 
> Kernel addresses are prefixed by 1's so, given a 48-bit kernel address,
> kva, we have the following inequality:
> (kva >> PGDIR_SHIFT) & (1024 - 1) != (kva >> PGDIR_SHIFT) & (64 - 1)
> 
> In other words a 48-bit kernel virtual address will have a different
> pgd_index when using PTRS_PER_PGD = 64 and 1024.
> 
> If, however, we note that:
> kva = 0xFFFF << 48 + lower (where lower[63:48] == 0b)
> and, PGDIR_SHIFT = 42 (as we are dealing with 64KB PAGE_SIZE)
> 
> We can consider:
> (kva >> PGDIR_SHIFT) & (1024 - 1) - (kva >> PGDIR_SHIFT) & (64 - 1)
>   = (0xFFFF << 6) & 0x3FF - (0xFFFF << 6) & 0x3F	// "lower" cancels out
>   = 0x3C0
> 
> In other words, one can switch PTRS_PER_PGD to the 52-bit value globally
> provided that they increment ttbr1_el1 by 0x3C0 * 8 = 0x1E00 bytes when
> running with 48-bit kernel VAs (TCR_EL1.T1SZ = 16).
> 
> For kernel configuration where 52-bit userspace VAs are possible, this
> patch offsets ttbr1_el1 and sets PTRS_PER_PGD corresponding to the
> 52-bit value.
> 
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Steve Capper <steve.capper@arm.com>
> 
> ---
> 
> Changed in V5, removed ttbr1 save/restore logic for software PAN as
> hardware PAN is a mandatory ARMv8.1 feature anyway. The logic to enable
> 52-bit VAs has also been changed to depend on
> ARM64_PAN || !ARM64_SW_TTBR0_PAN
> (in a later patch)
> 
> This patch is new in V4 of the series
> ---
>   arch/arm64/include/asm/assembler.h     | 23 +++++++++++++++++++++++
>   arch/arm64/include/asm/pgtable-hwdef.h |  9 +++++++++
>   arch/arm64/kernel/head.S               |  1 +
>   arch/arm64/kernel/hibernate-asm.S      |  1 +
>   arch/arm64/mm/proc.S                   |  4 ++++
>   5 files changed, 38 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 6142402c2eb4..e2fe378d2a63 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -515,6 +515,29 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
>   	mrs	\rd, sp_el0
>   	.endm
>   
> +/*
> + * Offset ttbr1 to allow for 48-bit kernel VAs set with 52-bit PTRS_PER_PGD.
> + * orr is used as it can cover the immediate value (and is idempotent).
> + * In future this may be nop'ed out when dealing with 52-bit kernel VAs.
> + * 	ttbr: Value of ttbr to set, modified.
> + */
> +	.macro	offset_ttbr1, ttbr
> +#ifdef CONFIG_ARM64_52BIT_VA
> +	orr	\ttbr, \ttbr, #TTBR1_BADDR_4852_OFFSET
> +#endif
> +	.endm
> +
> +/*
> + * Perform the reverse of offset_ttbr1.
> + * bic is used as it can cover the immediate value and, in future, won't need
> + * to be nop'ed out when dealing with 52-bit kernel VAs.
> + */
> +	.macro	restore_ttbr1, ttbr
> +#ifdef CONFIG_ARM64_52BIT_VA
> +	bic	\ttbr, \ttbr, #TTBR1_BADDR_4852_OFFSET
> +#endif
> +	.endm
> +

The above operation is safe as long as the TTBR1_BADDR_4852_OFFSET is
aligned to 2^6 or more. Otherwise we could corrupt the Bits[51:48]
of the BADDR stored in TTBR1[5:2] and thus the TTBR1:BADDR must be 
aligned to 64bytes minimum as per v8.2LVA restrictions. Since we have
restricted the VA_BITS to 48, we should be safe here.


Do we need a BUILD_BUG_ON() or something to check if this is still valid?

Eitherway,

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
