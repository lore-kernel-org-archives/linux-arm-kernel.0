Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAC3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:49:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80E9A2084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FlflYL0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E9A2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HS5UKqrggYphDVXddGRYOX+uiaihNk7fGQxBI1VMpNM=; b=FlflYL0Gi9mGvS
	7fDhaAvoobl/cQ6sPjaVehHMhqe5OEPzeL4leyExJGej3liBLVNkBZ8ItAP5DvfmkaQ3He0ujaqNY
	FZSzjUIovS4QRp6ek6ijTehGeRH0KNuDwI1jxwiQ/yQF2srXLiMY6BulGTEjDs/y5pOTrF1Mi0Xd6
	Aicil4tdUlyvH9m/Le64AkASNMIKOEHiK50LDtiahlMLUegktaLBVl1EwDgHWXPVVMzDGuqknBh0f
	EgBeULukvjtS++pzU12cfzdO3zd8vI3c9I3ToEBjWlr61DAybl31Vpo0wQGwD5CohmchER3rZcveH
	pt+AxdI7Nn7N0ObOZydw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYoaY-0008Pt-TU; Mon, 17 Dec 2018 08:49:22 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYoaV-0008Oj-6W
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 08:49:20 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF390A78;
 Mon, 17 Dec 2018 00:49:05 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A89D43F5C0;
 Mon, 17 Dec 2018 00:49:03 -0800 (PST)
Subject: Re: [PATCH v7 01/25] arm64: Fix HCR.TGE status for NMI contexts
To: linux-arm-kernel@lists.infradead.org
References: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
 <1544633245-6036-2-git-send-email-julien.thierry@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <19f8c91b-0879-30dd-09dd-c0657b53bb33@arm.com>
Date: Mon, 17 Dec 2018 08:49:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544633245-6036-2-git-send-email-julien.thierry@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_004919_241896_117FC360 
X-CRM114-Status: GOOD (  20.48  )
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
Cc: mark.rutland@arm.com, linux-arch@vger.kernel.org,
 daniel.thompson@linaro.org, Arnd Bergmann <arnd@arndb.de>,
 marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, christoffer.dall@arm.com,
 james.morse@arm.com, joel@joelfernandes.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 12/12/2018 16:47, Julien Thierry wrote:
> When using VHE, the host needs to clear HCR_EL2.TGE bit in order
> to interract with guest TLBs, switching from EL2&0 translation regime
> to EL1&0.
> 
> However, some non-maskable asynchronous event could happen while TGE is
> cleared like SDEI. Because of this address translation operations
> relying on EL2&0 translation regime could fail (tlb invalidation,
> userspace access, ...).
> 
> Fix this by properly setting HCR_EL2.TGE when entering NMI context and
> clear it if necessary when returning to the interrupted context.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: linux-arch@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/include/asm/hardirq.h | 28 ++++++++++++++++++++++++++++
>  arch/arm64/kernel/irq.c          |  3 +++
>  include/asm-generic/hardirq.h    |  3 +++
>  include/linux/hardirq.h          |  2 ++
>  4 files changed, 36 insertions(+)
> 
> diff --git a/include/asm-generic/hardirq.h b/include/asm-generic/hardirq.h
> index d14214d..c33b53f20 100644
> --- a/include/asm-generic/hardirq.h
> +++ b/include/asm-generic/hardirq.h
> @@ -12,6 +12,9 @@
>  #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
>  #include <linux/irq.h>
>  
> +#define arch_nmi_enter()	do { } while (0)
> +#define arch_nmi_exit()		do { } while (0)
> +

As spotted by the build bot, this needs to go in include/linux/hardirq.h
under a #ifndef arch_nmi_enter.

>  #ifndef ack_bad_irq
>  static inline void ack_bad_irq(unsigned int irq)
>  {
> diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
> index 0fbbcdf..776a60f 100644
> --- a/include/linux/hardirq.h
> +++ b/include/linux/hardirq.h
> @@ -62,6 +62,7 @@ static inline void rcu_nmi_exit(void)
>  
>  #define nmi_enter()						\
>  	do {							\
> +		arch_nmi_enter();				\
>  		printk_nmi_enter();				\
>  		lockdep_off();					\
>  		ftrace_nmi_enter();				\
> @@ -80,6 +81,7 @@ static inline void rcu_nmi_exit(void)
>  		ftrace_nmi_exit();				\
>  		lockdep_on();					\
>  		printk_nmi_exit();				\
> +		arch_nmi_exit();				\
>  	} while (0)
>  
>  #endif /* LINUX_HARDIRQ_H */
> 

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
