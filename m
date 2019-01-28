Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4073FC282CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:49:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BED22086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IoZYTH8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BED22086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OFfe/wX8iu6JlMdLudABmw0qwhTr7904SHRq+20pDPk=; b=IoZYTH8ZUqVZ/g
	RYYchwEmdoBxjwvovZ9edC90m6mmZLfwRcmskNmwabDeoxwraoS3QCYpbs/Ri45JpXLfziXhu3JL1
	GGXaCsqksgoCicgl40PlSNSQRaU3LFpW9mdtu7XSY05IXlVTaCl1A7cSaaW9S0wnDvJHMT9E4BGaJ
	+vPLtvo1G0ZxErYz/zhnJO36uOqsysQECXHsp6NiR8R9uutJPELrWpLsQBkgdY9cSF5Jlc1l2VwVo
	kr0+xiej/LCagaPS0I5DT4lO/x4sJjS7FHwB+rvu6gY87GAJppYQ8UGky1EI1BrN+S5l0Oxiqit2o
	pXF2iEfg9/XzLnoYZeiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go5PO-0005lS-Ut; Mon, 28 Jan 2019 11:48:58 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go5PL-0005kd-Fu
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 11:48:56 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FB72EBD;
 Mon, 28 Jan 2019 03:48:53 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B85C3F59C;
 Mon, 28 Jan 2019 03:48:51 -0800 (PST)
Subject: Re: [PATCH v9 01/26] arm64: Fix HCR.TGE status for NMI contexts
To: Julien Thierry <julien.thierry@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
 <1548084825-8803-2-git-send-email-julien.thierry@arm.com>
From: James Morse <james.morse@arm.com>
Message-ID: <8e8c4f5b-5b83-7bbc-1b84-36d68e210968@arm.com>
Date: Mon, 28 Jan 2019 11:48:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548084825-8803-2-git-send-email-julien.thierry@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_034855_542024_EE1561EC 
X-CRM114-Status: GOOD (  16.78  )
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
 joel@joelfernandes.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Julien,

On 21/01/2019 15:33, Julien Thierry wrote:
> When using VHE, the host needs to clear HCR_EL2.TGE bit in order
> to interract with guest TLBs, switching from EL2&0 translation regime

(interact)


> to EL1&0.
> 
> However, some non-maskable asynchronous event could happen while TGE is
> cleared like SDEI. Because of this address translation operations
> relying on EL2&0 translation regime could fail (tlb invalidation,
> userspace access, ...).
> 
> Fix this by properly setting HCR_EL2.TGE when entering NMI context and
> clear it if necessary when returning to the interrupted context.

Yes please. This would not have been fun to debug!

Reviewed-by: James Morse <james.morse@arm.com>



I was looking for why we need core code to do this, instead of updating the
arch's call sites. Your 'irqdesc: Add domain handlers for NMIs' patch (pointed
to from the cover letter) is the reason: core-code calls nmi_enter()/nmi_exit()
itself.


Thanks,

James


> diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hardirq.h
> index 1473fc2..94b7481 100644
> --- a/arch/arm64/include/asm/hardirq.h
> +++ b/arch/arm64/include/asm/hardirq.h
> @@ -19,6 +19,7 @@
>  #include <linux/cache.h>
>  #include <linux/threads.h>
>  #include <asm/irq.h>
> +#include <asm/kvm_arm.h>

percpu.h?
sysreg.h?
barrier.h?


> @@ -37,6 +38,33 @@
>  
>  #define __ARCH_IRQ_EXIT_IRQS_DISABLED	1
>  
> +struct nmi_ctx {
> +	u64 hcr;
> +};
> +
> +DECLARE_PER_CPU(struct nmi_ctx, nmi_contexts);
> +
> +#define arch_nmi_enter()							\
> +	do {									\
> +		if (is_kernel_in_hyp_mode()) {					\
> +			struct nmi_ctx *nmi_ctx = this_cpu_ptr(&nmi_contexts);	\
> +			nmi_ctx->hcr = read_sysreg(hcr_el2);			\
> +			if (!(nmi_ctx->hcr & HCR_TGE)) {			\
> +				write_sysreg(nmi_ctx->hcr | HCR_TGE, hcr_el2);	\
> +				isb();						\
> +			}							\
> +		}								\
> +	} while (0)
> +
> +#define arch_nmi_exit()								\
> +	do {									\
> +		if (is_kernel_in_hyp_mode()) {					\
> +			struct nmi_ctx *nmi_ctx = this_cpu_ptr(&nmi_contexts);	\
> +			if (!(nmi_ctx->hcr & HCR_TGE))				\
> +				write_sysreg(nmi_ctx->hcr, hcr_el2);		\
> +		}								\
> +	} while (0)
> +
>  static inline void ack_bad_irq(unsigned int irq)
>  {
>  	extern unsigned long irq_err_count;



> diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
> index 0fbbcdf..da0af63 100644
> --- a/include/linux/hardirq.h
> +++ b/include/linux/hardirq.h
> @@ -60,8 +60,14 @@ static inline void rcu_nmi_exit(void)
>   */
>  extern void irq_exit(void);
>  
> +#ifndef arch_nmi_enter
> +#define arch_nmi_enter()	do { } while (0)
> +#define arch_nmi_exit()		do { } while (0)
> +#endif
> +
>  #define nmi_enter()						\
>  	do {							\
> +		arch_nmi_enter();				\
>  		printk_nmi_enter();				\
>  		lockdep_off();					\
>  		ftrace_nmi_enter();				\
> @@ -80,6 +86,7 @@ static inline void rcu_nmi_exit(void)
>  		ftrace_nmi_exit();				\
>  		lockdep_on();					\
>  		printk_nmi_exit();				\
> +		arch_nmi_exit();				\
>  	} while (0)
>  
>  #endif /* LINUX_HARDIRQ_H */
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
