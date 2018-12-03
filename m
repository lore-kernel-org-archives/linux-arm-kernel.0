Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047FEC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:11:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C72AD20878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SZdp8rOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72AD20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AZW/LUIO6FdU+gJi/OSXImqXrc5unRb3Jg4f1fxS0Oo=; b=SZdp8rOYOKpncXpZssAhfmFRD
	yaWbrp57IJ+6T0IyFz+fqnTV3W+krSrBemUmcoJaeB56RhV9U8f8PnO/JFctDU5jT5yHxzZB8pMb3
	vrQdTT3hJEDR9Tx5zODy7Pjc19LVANGBr1ZET8JmqyrQ9ia+6KiOfR5N3loxiXYTYGbN4C4gK2zyl
	s5Eg++06MGmdvUv6wXCFY2kTvPhf0znxHMyluHffh+sIUpSC4rmfb593ZLjsfJTmcy3O7HVkcHF2J
	dppaxw8heeoaR5me2LzIxlXp1R6pi6yeHIndE0fbdNlxmOexAGBgDIyCLMQQkEerbq2JpfdB5Zj23
	OC03zlGeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTo0o-0004d7-Au; Mon, 03 Dec 2018 13:11:46 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTo0l-0004ce-1h
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 13:11:44 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9CF51688;
 Mon,  3 Dec 2018 05:11:29 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C4893F614;
 Mon,  3 Dec 2018 05:11:28 -0800 (PST)
Subject: Re: [PATCH] arm64/mm: use correct operators for string comparison in
 cache.S
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 linux-arm-kernel@lists.infradead.org
References: <20181201110144.15970-1-ard.biesheuvel@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <c5c51e6a-a4d6-ca3d-b413-1ecbbf7186f5@arm.com>
Date: Mon, 3 Dec 2018 13:11:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181201110144.15970-1-ard.biesheuvel@linaro.org>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_051143_100549_665A9E74 
X-CRM114-Status: GOOD (  21.84  )
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
Cc: catalin.marinas@arm.com, will.deacon@arm.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Ard,

On 01/12/2018 11:01, Ard Biesheuvel wrote:
> The GAS directives that are currently being used in dcache_by_line_op
> rely on assembler behavior that is not documented, and probably not
> guaranteed to produce the correct behavior going forward.
> 
> Currently, we end up with some undefined symbols in cache.o:
> 
> $ nm arch/arm64/mm/cache.o
> 	 ...
> 	 U civac
> 	 ...
> 	 U cvac
> 	 U cvap
> 	 U cvau
> 
> This is due to the fact that the comparisons used to select the
> operation type in the dcache_by_line_op macro are comparing symbols
> not strings, and even though it seems that GAS is doing the right
> thing here (undefined symbols by the same name are equal to each
> other), it seems unwise to rely on this.
> 
> So let's provide some definitions that are guaranteed to be distinct,
> and make them local so they don't pollute the gobal symbol space.

Rather than making the unintended symbol comparisons work properly, can 
we not just implement the string comparisons that were supposed to be? 
Superficially, the diff below seems to still generate the desired output 
(although as always there's probably some subtlety I'm missing).

Robin.

----->8-----

diff --git a/arch/arm64/include/asm/assembler.h 
b/arch/arm64/include/asm/assembler.h
index 6142402c2eb4..2c5f4825fee3 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -383,13 +383,13 @@ alternative_endif
  	sub	\tmp2, \tmp1, #1
  	bic	\kaddr, \kaddr, \tmp2
  9998:
-	.if	(\op == cvau || \op == cvac)
+	.if	("\op" == "cvau" || "\op" == "cvac")
  alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
  	dc	\op, \kaddr
  alternative_else
  	dc	civac, \kaddr
  alternative_endif
-	.elseif	(\op == cvap)
+	.elseif	("\op" == "cvap")
  alternative_if ARM64_HAS_DCPOP
  	sys 3, c7, c12, 1, \kaddr	// dc cvap
  alternative_else

> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>   arch/arm64/include/asm/assembler.h | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 6142402c2eb4..d11c32df85c2 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -377,19 +377,24 @@ alternative_endif
>    * 	size:		size of the region
>    * 	Corrupts:	kaddr, size, tmp1, tmp2
>    */
> +	.set	.Lcvau,  0
> +	.set	.Lcvac,  1
> +	.set	.Lcvap,  2
> +	.set	.Lcivac, 3
> +
>   	.macro dcache_by_line_op op, domain, kaddr, size, tmp1, tmp2
>   	dcache_line_size \tmp1, \tmp2
>   	add	\size, \kaddr, \size
>   	sub	\tmp2, \tmp1, #1
>   	bic	\kaddr, \kaddr, \tmp2
>   9998:
> -	.if	(\op == cvau || \op == cvac)
> +	.if	(.L\op == .Lcvau || .L\op == .Lcvac)
>   alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
>   	dc	\op, \kaddr
>   alternative_else
>   	dc	civac, \kaddr
>   alternative_endif
> -	.elseif	(\op == cvap)
> +	.elseif	(.L\op == .Lcvap)
>   alternative_if ARM64_HAS_DCPOP
>   	sys 3, c7, c12, 1, \kaddr	// dc cvap
>   alternative_else
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
