Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E884BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:50:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9FF420878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JDWzB00l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9FF420878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OZBuywFNkH5wvqrd6DxVncG0gEV0T6nyBahBQepL3YA=; b=JDWzB00lLRR0Xe
	oyHEntOxScf2Xy4/UOF9ZfvmfxrCcuDAN0pXEyZgmbW1kFRKhk6WmLX010vuFdDqYRrqHbswlZA0R
	gsh5M9e9cbPbwOoonKnJ+LLf3EbNqLOuOXZGObJvyD1hIOakz8sYG5koYLaM0SyK+EYmkrf4uehzb
	t181/+wfSiWAXsqgpu+ow0/IRrPYc54o/MwUIWlwO9gs44vW8u9FIzryBNucqG0aZ7wPU4JAOzjoQ
	LsflYcB8iNf5vZMUSRqAz1M2/qxmqCLDCROORjZJjMEE9wgGlRKqxC0XAdiG9vxIWkY4H0gw+hsZk
	dkLz7Xov3ndnNkOl5pZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUsAr-0006R0-8X; Thu, 06 Dec 2018 11:50:33 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUsAk-0006Qa-Se
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 11:50:31 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AA9380D;
 Thu,  6 Dec 2018 03:50:16 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 4471C3F5AF; Thu,  6 Dec 2018 03:50:15 -0800 (PST)
Date: Thu, 6 Dec 2018 11:50:12 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steve Capper <steve.capper@arm.com>
Subject: Re: [PATCH V4 4/6] arm64: mm: Offset TTBR1 to allow 52-bit
 PTRS_PER_PGD
Message-ID: <20181206115011.GC54495@arrakis.emea.arm.com>
References: <20181205164145.24568-1-steve.capper@arm.com>
 <20181205164145.24568-5-steve.capper@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181205164145.24568-5-steve.capper@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_035029_757296_5F3329F2 
X-CRM114-Status: GOOD (  12.53  )
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
Cc: linux-mm@kvack.org, ard.biesheuvel@linaro.org, will.deacon@arm.com,
 linux-arm-kernel@lists.infradead.org, jcm@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 04:41:43PM +0000, Steve Capper wrote:
> diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
> index 4128bec033f6..cd361dd16b12 100644
> --- a/arch/arm64/include/asm/asm-uaccess.h
> +++ b/arch/arm64/include/asm/asm-uaccess.h
> @@ -14,11 +14,13 @@
>  #ifdef CONFIG_ARM64_SW_TTBR0_PAN
>  	.macro	__uaccess_ttbr0_disable, tmp1
>  	mrs	\tmp1, ttbr1_el1			// swapper_pg_dir
> +	restore_ttbr1 \tmp1
>  	bic	\tmp1, \tmp1, #TTBR_ASID_MASK
>  	sub	\tmp1, \tmp1, #RESERVED_TTBR0_SIZE	// reserved_ttbr0 just before swapper_pg_dir
>  	msr	ttbr0_el1, \tmp1			// set reserved TTBR0_EL1
>  	isb
>  	add	\tmp1, \tmp1, #RESERVED_TTBR0_SIZE
> +	offset_ttbr1 \tmp1
>  	msr	ttbr1_el1, \tmp1		// set reserved ASID
>  	isb
>  	.endm
> @@ -27,8 +29,10 @@
>  	get_thread_info \tmp1
>  	ldr	\tmp1, [\tmp1, #TSK_TI_TTBR0]	// load saved TTBR0_EL1
>  	mrs	\tmp2, ttbr1_el1
> +	restore_ttbr1 \tmp2
>  	extr    \tmp2, \tmp2, \tmp1, #48
>  	ror     \tmp2, \tmp2, #16
> +	offset_ttbr1 \tmp2
>  	msr	ttbr1_el1, \tmp2		// set the active ASID
>  	isb
>  	msr	ttbr0_el1, \tmp1		// set the non-PAN TTBR0_EL1

The patch looks alright but I think we can simplify it further if we add:

	depends on ARM64_PAN || !ARM64_SW_TTBR0_PAN

to the 52-bit Kconfig entry.

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
