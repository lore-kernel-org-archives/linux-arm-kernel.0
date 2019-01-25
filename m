Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AB9C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:29:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04D24218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PoJYsxHV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsDBUUhn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D24218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FgxiHNnZTLpyp5So0lH064K40DoI1IJgMNFxChf78dg=; b=PoJYsxHVBz8U3r
	HkrYL81obmxJP/9NyoIPWC1p3Hfa6p8NMfRrjwrRqqSgLgXwuV+3/WFzKFiLHF+oB9YdyuUaySjgK
	UIlW63YO+Bf3hOFb6//NeMjogLuT8BKwF+G2Fsa7Dn/qK4dNQs4ZlcSUC9jNDxfXKTGd+nrx3erO/
	R4YUf1/7H67fK1G2CuSqN4O/AAj81IqcnVF/OzgOSlUg+cu+Q/sbiT1ELr013cwVyxu0vdBEI4UyS
	yda1qx50ps5wLFxckQ1dx1Qfi7ZpRn8YsZkJqAEZoTKCWKCC2gsZIjUqwTfev8oNoqRk2Vh2jnW4W
	ABiYXTWaGv1GjumPBWew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmvw2-0006Fp-28; Fri, 25 Jan 2019 07:29:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmvvz-0006FE-2u
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 07:29:52 +0000
Received: from sol.localdomain (c-107-3-167-184.hsd1.ca.comcast.net
 [107.3.167.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 96FED218D0;
 Fri, 25 Jan 2019 07:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548401390;
 bh=C7+wb730/3XKsMNiRj9KszZnH7HKQyvxkscH9k5PF+k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RsDBUUhnJ1b9eureZO4p/KZwfT4PCVsmXtWLyL20lTDVheo++157kBm5idNtG+oqt
 tjG+qqiCJFGI8WVNNzyLy0+qLi/dQ57QvRWHqoDa2dsP5J06ULyZg7tfCpbQFfDvd0
 GU/DyMwJeFX4+uAzNAhLmZi2vio+n6+sieF16iIc=
Date: Thu, 24 Jan 2019 23:29:49 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 2/2] crypto: arm64/crct10dif - revert to C code for short
 inputs
Message-ID: <20190125072948.GC700@sol.localdomain>
References: <20190124182712.7142-1-ard.biesheuvel@linaro.org>
 <20190124182712.7142-3-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190124182712.7142-3-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_232951_141649_81D90B2C 
X-CRM114-Status: GOOD (  21.85  )
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
Cc: linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 herbert@gondor.apana.org.au
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 24, 2019 at 07:27:12PM +0100, Ard Biesheuvel wrote:
> The SIMD routine ported from x86 used to have a special code path
> for inputs < 16 bytes, which got lost somewhere along the way.
> Instead, the current glue code aligns the input pointer to permit
> the NEON routine to use special versions of the vld1 instructions
> that assume 16 byte alignment, but this could result in inputs of
> less than 16 bytes to be passed in. 

This description doesn't quite match the patch since the arm64 version of the
assembly doesn't use any alignment specifiers.  I take it that actually means
the alignment in the glue code wasn't necessary in the first place?

> This not only fails the new
> extended tests that Eric has implemented, it also results in the
> code reading before the input pointer, which could potentially
> result in crashes when dealing with less than 16 bytes of input
> at the start of a page which is preceded by an unmapped page.
> 
> So update the glue code to only invoke the NEON routine if the
> input is more than 16 bytes.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Can you add:

Fixes: 6ef5737f3931 ("crypto: arm64/crct10dif - port x86 SSE implementation to arm64")
Cc: stable@vger.kernel.org

> ---
>  arch/arm64/crypto/crct10dif-ce-glue.c | 25 +++++---------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm64/crypto/crct10dif-ce-glue.c b/arch/arm64/crypto/crct10dif-ce-glue.c
> index b461d62023f2..567c24f3d224 100644
> --- a/arch/arm64/crypto/crct10dif-ce-glue.c
> +++ b/arch/arm64/crypto/crct10dif-ce-glue.c
> @@ -39,26 +39,13 @@ static int crct10dif_update(struct shash_desc *desc, const u8 *data,
>  			    unsigned int length)
>  {
>  	u16 *crc = shash_desc_ctx(desc);
> -	unsigned int l;
>  
> -	if (unlikely((u64)data % CRC_T10DIF_PMULL_CHUNK_SIZE)) {
> -		l = min_t(u32, length, CRC_T10DIF_PMULL_CHUNK_SIZE -
> -			  ((u64)data % CRC_T10DIF_PMULL_CHUNK_SIZE));
> -
> -		*crc = crc_t10dif_generic(*crc, data, l);
> -
> -		length -= l;
> -		data += l;
> -	}
> -
> -	if (length > 0) {
> -		if (may_use_simd()) {
> -			kernel_neon_begin();
> -			*crc = crc_t10dif_pmull(*crc, data, length);
> -			kernel_neon_end();
> -		} else {
> -			*crc = crc_t10dif_generic(*crc, data, length);
> -		}
> +	if (length >= CRC_T10DIF_PMULL_CHUNK_SIZE && may_use_simd()) {
> +		kernel_neon_begin();
> +		*crc = crc_t10dif_pmull(*crc, data, length);
> +		kernel_neon_end();
> +	} else {
> +		*crc = crc_t10dif_generic(*crc, data, length);
>  	}
>  
>  	return 0;
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
