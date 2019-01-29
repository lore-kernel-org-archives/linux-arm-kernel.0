Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DCEC282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:18:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB8B82087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GINu5HJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8B82087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yJVmj33gBcy+sfvlKLrgD+L7kViJJnwJoWXzEanmvRU=; b=GINu5HJpf2h+kg
	Lr++b34n9AyBj86CaQetPExpcxSZv50zIuCqFOQ4puTbIfTBa4651MIjzxHY2NAFiV+Ac3cR+9eUn
	Gy0SSYjK3bjRwsxSz/2GhhatOlmNiii5a0JbKFTOnrh8m8czVdyre0AyFdj3yjBRfZsfBmYGyg19U
	agCiVkmBVMc0gCH7rwQPSLQakgufur3VyVxE6ybqktsoFrMkEmr6BBOxIgGPRB3EHt708wBLRMys+
	AY94kv+mV+FPY7Ly1hSY5tJzgq72DeotBk+ZSs5LavhJ7XDBuuviM1bqS9ViC5AH22bjarePNf/nj
	UIztbtBvNNM5R42sF3tw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goXxi-0001R7-9f; Tue, 29 Jan 2019 18:18:18 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goXxe-0001Qk-FH
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 18:18:16 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E84B1596;
 Tue, 29 Jan 2019 10:18:13 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 B30EE3F557; Tue, 29 Jan 2019 10:18:12 -0800 (PST)
Date: Tue, 29 Jan 2019 18:18:10 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] arm64: kaslr: ensure randomized quantities are clean
 also when kaslr is off
Message-ID: <20190129181809.GD224095@arrakis.emea.arm.com>
References: <20190127082942.21998-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190127082942.21998-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_101814_516966_E240973F 
X-CRM114-Status: GOOD (  20.70  )
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
Cc: will.deacon@arm.com, stable@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Jan 27, 2019 at 09:29:42AM +0100, Ard Biesheuvel wrote:
> Commit 1598ecda7b23 ("arm64: kaslr: ensure randomized quantities are
> clean to the PoC") added cache maintenance to ensure that global
> variables set by the kaslr init routine are not wiped clean due to
> cache invalidation occurring during the second round of page table
> creation.
> 
> However, if kaslr_early_init() exits early with no randomization
> being applied (either due to the lack of a seed, or because the user
> has disabled kaslr explicitly), no cache maintenance is performed,
> leading to the same issue we attempted to fix earlier, as far as the
> module_alloc_base variable is concerned.
> 
> Note that module_alloc_base cannot be initialized statically, because
> that would cause it to be subject to a R_AARCH64_RELATIVE relocation,
> causing it to be overwritten by the second round of KASLR relocation
> processing.
> 
> Fixes: f80fb3a3d508 ("arm64: add support for kernel ASLR")
> Cc: <stable@vger.kernel.org> # v4.6+
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/kaslr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
> index ba6b41790fcd..b09b6f75f759 100644
> --- a/arch/arm64/kernel/kaslr.c
> +++ b/arch/arm64/kernel/kaslr.c
> @@ -88,6 +88,7 @@ u64 __init kaslr_early_init(u64 dt_phys)
>  	 * we end up running with module randomization disabled.
>  	 */
>  	module_alloc_base = (u64)_etext - MODULES_VSIZE;
> +	__flush_dcache_area(&module_alloc_base, sizeof(module_alloc_base));

Do we need something similar of memstart_offset_seed? If yes, you could
as well change the returns to a goto out.

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
