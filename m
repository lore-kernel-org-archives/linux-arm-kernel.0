Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2578EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:39:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6B7C2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mDf3BQPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B7C2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=y/wggp0aWL+5XKX0q81hxZ+1rgVmuIm2zTWd8ptFjNs=; b=mDf3BQPxBmXWR57kt1XbrLaHC
	LoJ/nEt++u1Cb+ZbFH+eHa86s7ZqoiDMz/4Wl2r8YZq91bmWgEUDRuhQBKmb2LjQ1gJp9Km86vjx4
	e1SIAra7OPnEoBbegRyOENXbFuByYrvzhEG5gCKz2gcSk3KuDrxHBqkLcTie8VHk/+nNlNzsZC3hC
	y4xGDjw0xL7CABAWuCJMDJwzzketJAlyYnzR6i5XIeIHW1iuf+yC9oeIcu8Xy+YkD9xhyJDmWpbK1
	Cr+BLiynnKCGqbYkGnJhAkAFikz3jEC0gHgw96+Tf22udz1tGjy0TED1dgGF7U1cr0f0aPuzM+bg1
	1zU+GrbCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjhf7-00057G-6F; Wed, 16 Jan 2019 09:39:05 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjhf3-00056R-NG
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 09:39:03 +0000
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 9C3C792EAE6057F38CFD;
 Wed, 16 Jan 2019 17:38:32 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.43) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Wed, 16 Jan 2019
 17:38:26 +0800
Subject: Re: [PATCH] arm64: kpti: Update arm64_kernel_use_ng_mappings() when
 forced on
To: James Morse <james.morse@arm.com>, <linux-arm-kernel@lists.infradead.org>
References: <20190115184917.248995-1-james.morse@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <21310b0b-8a75-1adf-a844-b2f3f520fa2d@huawei.com>
Date: Wed, 16 Jan 2019 09:38:21 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190115184917.248995-1-james.morse@arm.com>
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_013901_934326_76BFB467 
X-CRM114-Status: GOOD (  21.03  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 Will Deacon <will.deacon@arm.com>, Linuxarm <linuxarm@huawei.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 15/01/2019 18:49, James Morse wrote:
> Since commit b89d82ef01b3 ("arm64: kpti: Avoid rewriting early page

About b89d82ef01b3, I got an *unconfirmed* (emphasis on this, I don't 
want to cry wolf) report yesterday that the symptom I saw (boot delay) 
has been seen on 5.0-rc2 on our D06 board. I could not see it.

Please note that this would be same board which we saw this on:
https://lkml.org/lkml/2018/6/20/589

I only witnessed the issue on the predecessor A72-based D05 board.

The reporter is very busy, but we'll keep tabs on it.

Thanks,
John

> tables when KASLR is enabled"), a kernel built with CONFIG_RANDOMIZE_BASE
> can decide early whether to use non-global mappings by checking the
> kaslr_offset().
>
> A kernel built without CONFIG_RANDOMIZE_BASE, instead checks the
> cpufeature static-key.
>
> This leaves a gap where CONFIG_RANDOMIZE_BASE was enabled, no
> kaslr seed was provided, but kpti was forced on using the cmdline
> option.
>
> When the decision is made late, kpti_install_ng_mappings() will re-write
> the page tables, but arm64_kernel_use_ng_mappings()'s value does not
> change as it only tests the cpufeature static-key if
> CONFIG_RANDOMIZE_BASE is disabled.
> This function influences PROT_DEFAULT via PTE_MAYBE_NG, and causes
> pgattr_change_is_safe() to catch nG->G transitions when the unchanged
> PROT_DEFAULT is used as part of PAGE_KERNEL_RO:
> [    1.942255] alternatives: patching kernel code
> [    1.998288] ------------[ cut here ]------------
> [    2.000693] kernel BUG at arch/arm64/mm/mmu.c:165!
> [    2.019215] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> [    2.020257] Modules linked in:
> [    2.020807] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc2 #51
> [    2.021917] Hardware name: linux,dummy-virt (DT)
> [    2.022790] pstate: 40000005 (nZcv daif -PAN -UAO)
> [    2.023742] pc : __create_pgd_mapping+0x508/0x6d0
> [    2.024671] lr : __create_pgd_mapping+0x500/0x6d0
>
> [    2.058059] Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
> [    2.059369] Call trace:
> [    2.059845]  __create_pgd_mapping+0x508/0x6d0
> [    2.060684]  update_mapping_prot+0x48/0xd0
> [    2.061477]  mark_linear_text_alias_ro+0xdc/0xe4
> [    2.070502]  smp_cpus_done+0x90/0x98
> [    2.071216]  smp_init+0x100/0x114
> [    2.071878]  kernel_init_freeable+0xd4/0x220
> [    2.072750]  kernel_init+0x10/0x100
> [    2.073455]  ret_from_fork+0x10/0x18
>
> [    2.075414] ---[ end trace 3572f3a7782292de ]---
> [    2.076389] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
>
> If arm64_kernel_unmapped_at_el0() is true, arm64_kernel_use_ng_mappings()
> should also be true.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> CC: John Garry <john.garry@huawei.com>
> CC: Will Deacon <will.deacon@arm.com>
>
> ---
>  arch/arm64/include/asm/mmu.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index ac352accb3d9..3e8063f4f9d3 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -60,8 +60,11 @@ static inline bool arm64_kernel_use_ng_mappings(void)
>  	 * later determine that kpti is required, then
>  	 * kpti_install_ng_mappings() will make them non-global.
>  	 */
> +	if (arm64_kernel_unmapped_at_el0())
> +		return true;
> +
>  	if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> -		return arm64_kernel_unmapped_at_el0();
> +		return false;
>
>  	/*
>  	 * KASLR is enabled so we're going to be enabling kpti on non-broken
>



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
