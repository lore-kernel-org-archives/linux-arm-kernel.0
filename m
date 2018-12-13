Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAFAC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:44:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A79D720870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YPgRV2Ff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79D720870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VrYQHi138KDLwEo/KkD6uGTOHHhJA208hj0WllwDcrw=; b=YPgRV2FfB+6m/p
	zI1x0IHYe2IpoZNsgYKNF2yJJ22jRA9UKS8AgdQv0m8RJF5Yo+0+zGxpifc9Yx7M9O3eY8218GzAe
	5JiNA3IhaF9nI8a0OznSRoTIg35lPwy5Lj6z5HDW6oySQKUoJkVqq7TVi8L/WPrFdotQNzJYjQ0WU
	G7l4GnsNBAbJ4Bnfc5TxIX+2iOq+pYDyQu9XDj9Nxq3lJhZVj+HcnAxmcoxG8qhL5JCigWvPBbjhq
	EwnsgjAqeVf3g99Kppf6l8Odm3kzifcPsxDKVqpbi/JX5gW/KfgFM3g54SmLzl3O5j5XVmr5YtDkn
	6Mnyl/rdlgSRb7W3gnWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXOTe-0008Sg-EA; Thu, 13 Dec 2018 10:44:22 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXOTa-0008OZ-00; Thu, 13 Dec 2018 10:44:19 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34ABCA78;
 Thu, 13 Dec 2018 02:44:06 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD5CF3F6A8;
 Thu, 13 Dec 2018 02:44:04 -0800 (PST)
Subject: Re: [PATCH] arm64: invalidate TLB before turning MMU on
To: Qian Cai <cai@lca.pw>
References: <1544654224.18411.11.camel@lca.pw>
 <20181213052259.56352-1-cai@lca.pw>
From: James Morse <james.morse@arm.com>
Message-ID: <1b150a95-2b80-2be3-0b77-599404f882dc@arm.com>
Date: Thu, 13 Dec 2018 10:44:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181213052259.56352-1-cai@lca.pw>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_024418_044775_93BB7CA1 
X-CRM114-Status: GOOD (  18.08  )
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
Cc: ard.biesheuvel@linaro.org, marc.zyngier@arm.com, catalin.marinas@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, takahiro.akashi@linaro.org,
 kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Qian,

On 13/12/2018 05:22, Qian Cai wrote:
> On this HPE Apollo 70 arm64 server with 256 CPUs, triggering a crash
> dump just hung. It has 4 threads on each core. Each 2-core share a same
> L1 and L2 caches, so that is 8 CPUs shares those. All CPUs share a same
> L3 cache.
> 
> It turned out that this was due to the TLB contained stale entries (or
> uninitialized junk which just happened to look valid) from the first
> kernel before turning the MMU on in the second kernel which caused this
> instruction hung,

This is a great find, thanks for debugging this!

The kernel should already handle this, as we don't trust the bootloader to clean
up either.

In arch/arm64/mm/proc.S::__cpu_setup()
|/*
| *	__cpu_setup
| *
| *	Initialise the processor for turning the MMU on.  Return in x0 the
| *	value of the SCTLR_EL1 register.
| */
| 	.pushsection ".idmap.text", "awx"
| ENTRY(__cpu_setup)
| 	tlbi	vmalle1				// Invalidate local TLB
| 	dsb	nsh

This is called from stext, which then branches to __primary_switch(), which
calls __enable_mmu() where you see this problem. It shouldn't not be possible to
allocate new tlb entries between these points...

Do you have CONFIG_RANDOMIZE_BASE disabled? This causes enable_mmu() to be
called twice, the extra tlb maintenance is in __primary_switch.
(if it works with this turned off, it points to the extra off/tlbi/on sequence).


> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 4471f570a295..5196f3d729de 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -771,6 +771,10 @@ ENTRY(__enable_mmu)
>  	msr	ttbr0_el1, x2			// load TTBR0
>  	msr	ttbr1_el1, x1			// load TTBR1
>  	isb
> +	dsb	nshst
> +	tlbi	vmalle1				// invalidate TLB
> +	dsb	nsh
> +	isb
>  	msr	sctlr_el1, x0
>  	isb

The overall change here is that we do extra maintenance later.

Can move this around to bisect where the TLB entries are either coming from, or
failing-to-be invalidated?
Do your first and kdump kernels have the same VA_BITS/PAGE_SIZE?
As a stab in the dark, (totally untested):
------------------------------%<------------------------------
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 2c75b0b903ae..a5f3b7314bda 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -406,9 +406,6 @@ ENDPROC(idmap_kpti_install_ng_mappings)
  */
        .pushsection ".idmap.text", "awx"
 ENTRY(__cpu_setup)
-       tlbi    vmalle1                         // Invalidate local TLB
-       dsb     nsh
-
        mov     x0, #3 << 20
        msr     cpacr_el1, x0                   // Enable FP/ASIMD
        mov     x0, #1 << 12                    // Reset mdscr_el1 and disable
@@ -465,5 +462,10 @@ ENTRY(__cpu_setup)
 1:
 #endif /* CONFIG_ARM64_HW_AFDBM */
        msr     tcr_el1, x10
+       isb
+
+       tlbi    vmalle1                         // Invalidate local TLB
+       dsb     nsh
+
        ret                                     // return to head.S
 ENDPROC(__cpu_setup)
------------------------------%<------------------------------


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
