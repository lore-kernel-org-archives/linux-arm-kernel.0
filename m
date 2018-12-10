Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8F2C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:50:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 193D3204FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="owiz8q9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193D3204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FF7bWVGetrZG3d1UXMizR8006vxNbrTbw2WNo+75fdo=; b=owiz8q9bY6vCDwSyu5/t8GDDy
	FL43MxFdH6wKvm9O8XKPAiEupoVUfNPxffpO1XCxFoHPwK1/CvuWo+eJqBO9au+jrG5WlfkgkzAVf
	2h4GmVrbQyWn+GQ1W0f6gZfMAC8LQOaCYLaNUvchcjWhsCM3sh1HXXsvuywSepW9QXw115rRQn5UY
	rjSgbq98vY6UMB6he7TtJXfvRwQjUeNf/dIlSRMsbaQc+yHLUrO3b1jDAhggUONSOMdwiScLgdabQ
	lRVsBcmpqUd3Egm/tw7IcDEtUyc17dshwwBTTYnosSnpy+kh/c2lg1SYgB9Fwbz1TTgsYvU+6pCxb
	rJlyoL/6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWMtA-0001kv-PY; Mon, 10 Dec 2018 14:50:28 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWMt7-0001jo-Rr
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 14:50:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91DCF15AD;
 Mon, 10 Dec 2018 06:50:15 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A2ED3F59C;
 Mon, 10 Dec 2018 06:50:14 -0800 (PST)
Subject: Re: [PATCH 0/5] arm64: assorted fixes for dcache_by_line_op
To: Will Deacon <will.deacon@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20181206155739.20229-1-ard.biesheuvel@linaro.org>
 <20181207175326.GB11430@edgewater-inn.cambridge.arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <0169dc42-9cac-4d22-3009-e84ce39ce507@arm.com>
Date: Mon, 10 Dec 2018 14:50:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181207175326.GB11430@edgewater-inn.cambridge.arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_065025_915153_1B00F07A 
X-CRM114-Status: GOOD (  24.49  )
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
Cc: Suzuki Poulose <suzuki.poulose@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Will,

On 07/12/2018 17:53, Will Deacon wrote:
> Hi Ard,
> 
> Cheers for looking at this.
> 
> On Thu, Dec 06, 2018 at 04:57:34PM +0100, Ard Biesheuvel wrote:
>> This fixes two issues in dcache_by_line_op: patch #4 fixes the logic
>> that is applied when patching DC CVAP instructions, and patch #5 gets
>> rid of some unintended undefined symbols resulting from incorrect use
>> of conditional GAS directives.
>>
>> Patches #1 to #3 are groundwork for #4.
>>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
>> Cc: Dave Martin <Dave.Martin@arm.com>
>>
>> Ard Biesheuvel (5):
>>    arm64/alternative_cb: move callback reference into replacements
>>      section
>>    arm64/alternative_cb: add nr_alts parameter to callback handlers
>>    arm64/alternative_cb: add support for alternative sequences
>>    arm64/assembler: use callback to 3-way alt-patch DC CVAP instructions
>>    arm64/mm: use string comparisons in dcache_by_line_op
>>
>>   arch/arm64/include/asm/alternative.h | 54 +++++++++++---------
>>   arch/arm64/include/asm/assembler.h   | 17 +++---
>>   arch/arm64/include/asm/kvm_mmu.h     |  4 +-
>>   arch/arm64/kernel/alternative.c      | 22 +++++---
>>   arch/arm64/kernel/cpu_errata.c       | 24 ++++++---
>>   arch/arm64/kvm/va_layout.c           |  8 +--
>>   6 files changed, 79 insertions(+), 50 deletions(-)
> 
> Whilst I can see that this solves the problem, I do wonder whether the
> additional infrastructure is really worth it. Couldn't we just do something
> really simple like the diff below instead?

Given that there's really only one place we expect CVAP to be used, I 
reckon we could factor that out beforehand to make life even simpler, as 
below.

Robin.

----->8-----
diff --git a/arch/arm64/include/asm/assembler.h 
b/arch/arm64/include/asm/assembler.h
index 6142402c2eb4..8d88d3f1e90e 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -390,11 +390,7 @@ alternative_else
  	dc	civac, \kaddr
  alternative_endif
  	.elseif	(\op == cvap)
-alternative_if ARM64_HAS_DCPOP
  	sys 3, c7, c12, 1, \kaddr	// dc cvap
-alternative_else
-	dc	cvac, \kaddr
-alternative_endif
  	.else
  	dc	\op, \kaddr
  	.endif
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 0c22ede52f90..98b17bee4f9d 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -212,6 +212,9 @@ ENDPROC(__dma_clean_area)
   *	- size    - size in question
   */
  ENTRY(__clean_dcache_area_pop)
+	alternative_if_not ARM64_HAS_DCPOP
+	b __clean_dcache_area_poc
+	alternative_else_nop_endif
  	dcache_by_line_op cvap, sy, x0, x1, x2, x3
  	ret
  ENDPIPROC(__clean_dcache_area_pop)
-----8<----

> 
> Will
> 
> --->8
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 953208267252..8dea015b6599 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -390,27 +390,38 @@ alternative_endif
>    * 	size:		size of the region
>    * 	Corrupts:	kaddr, size, tmp1, tmp2
>    */
> +	.macro __dcache_op_workaround_clean_cache, op, kaddr
> +alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
> +	dc	\op, \kaddr
> +alternative_else
> +	dc	civac, \kaddr
> +alternative_endif
> +	.endm
> +
>   	.macro dcache_by_line_op op, domain, kaddr, size, tmp1, tmp2
>   	dcache_line_size \tmp1, \tmp2
>   	add	\size, \kaddr, \size
>   	sub	\tmp2, \tmp1, #1
>   	bic	\kaddr, \kaddr, \tmp2
>   9998:
> -	.if	(\op == cvau || \op == cvac)
> -alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
> -	dc	\op, \kaddr
> -alternative_else
> -	dc	civac, \kaddr
> -alternative_endif
> -	.elseif	(\op == cvap)
> +	.ifc	\op, cvau
> +	__dcache_op_workaround_clean_cache \op, \kaddr
> +	.else
> +	.ifc	\op, cvac
> +	__dcache_op_workaround_clean_cache \op, \kaddr
> +	.else
> +	.ifc	\op, cvap
>   alternative_if ARM64_HAS_DCPOP
>   	sys 3, c7, c12, 1, \kaddr	// dc cvap
> -alternative_else
> -	dc	cvac, \kaddr
> -alternative_endif
> +	b	9996f
> +alternative_else_nop_endif
> +	__dcache_op_workaround_clean_cache cvac, \kaddr
> +9996:
>   	.else
>   	dc	\op, \kaddr
>   	.endif
> +	.endif
> +	.endif
>   	add	\kaddr, \kaddr, \tmp1
>   	cmp	\kaddr, \size
>   	b.lo	9998b
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
