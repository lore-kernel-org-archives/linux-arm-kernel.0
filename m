Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC290C282D5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:57:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AB812087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A98vhm6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB812087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ME6hG/gZCGjWm7MbNNqJoXtHQroaHlvCTRPQ3mEd030=; b=A98vhm6Bvot0RI
	QXBoMrcb/SqHWPCI6IxH7sr4rAj1gUIP1rPmRufwHPg3kVBAOwcGLWIhyCGviA4Twg5nT+CRVUDwA
	+gzKyJ3Bo18pRoMqBYl1Q2RC95eysDGuZhFVVhw6riaikzR2Ul30KhxoKAiSpi3OvMC4KjNhpgNui
	yCquC8gTiphzfGOvoHlujSAOToyIFM8bNPTw2dlwp0QyNsPhRI0B348Oqg+7nShjBGUqKC7/Hr5z/
	zP2HTftiqY80pCU9boBPUXoZtUP5YO6P/Bu0ZHhFTiQCojQHZi93yyRtsJkz96Lz+b6aOxmScLiae
	btHW0mwKqk3JbG8RR1Sw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1golgB-0002Sn-Rg; Wed, 30 Jan 2019 08:57:07 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1golg9-0002Rz-1K
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 08:57:06 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D6FAA78;
 Wed, 30 Jan 2019 00:57:04 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E63293F557;
 Wed, 30 Jan 2019 00:57:01 -0800 (PST)
Subject: Re: [PATCH v8 24/26] arm64: acpi: Make apei_claim_sea() synchronise
 with APEI's irq work
To: James Morse <james.morse@arm.com>, linux-acpi@vger.kernel.org
References: <20190129184902.102850-1-james.morse@arm.com>
 <20190129184902.102850-25-james.morse@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <858ac1d3-8b21-d3a7-d7dd-3d95294a9bea@arm.com>
Date: Wed, 30 Jan 2019 08:56:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190129184902.102850-25-james.morse@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_005705_082519_E7C2BC39 
X-CRM114-Status: GOOD (  25.11  )
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
Cc: Tony Luck <tony.luck@intel.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>,
 Will Deacon <will.deacon@arm.com>, Dongjiu Geng <gengdongjiu@huawei.com>,
 linux-mm@kvack.org, Borislav Petkov <bp@alien8.de>,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi James,

On 29/01/2019 18:49, James Morse wrote:
> APEI is unable to do all of its error handling work in nmi-context, so
> it defers non-fatal work onto the irq_work queue. arch_irq_work_raise()
> sends an IPI to the calling cpu, but this is not guaranteed to be taken
> before returning to user-space.
> 
> Unless the exception interrupted a context with irqs-masked,
> irq_work_run() can run immediately. Otherwise return -EINPROGRESS to
> indicate ghes_notify_sea() found some work to do, but it hasn't
> finished yet.
> 
> With this apei_claim_sea() returning '0' means this external-abort was
> also notification of a firmware-first RAS error, and that APEI has
> processed the CPER records.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Punit Agrawal <punit.agrawal@arm.com>
> Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> CC: Xie XiuQi <xiexiuqi@huawei.com>
> CC: gengdongjiu <gengdongjiu@huawei.com>
> 
> ---
> Changes since v7:
>  * Added Catalin's ack, then:
>  * Added __irq_enter()/exit() calls so if we interrupted preemptible code, the
>    preempt count matches what other irq-work expects.
>  * Changed the 'if (!arch_irqs_disabled_flags(interrupted_flags))' test to be
>    safe before/after Julien's PMR series.
> 
> Changes since v6:
>  * Added pr_warn() for the EINPROGRESS case so panic-tracebacks show
>    'APEI was here'.
>  * Tinkered with the commit message
> 
> Changes since v2:
>  * Removed IS_ENABLED() check, done by the caller unless we have a dummy
>    definition.
> ---
>  arch/arm64/kernel/acpi.c | 23 +++++++++++++++++++++++
>  arch/arm64/mm/fault.c    |  9 ++++-----
>  2 files changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index 803f0494dd3e..8288ae0c8f3b 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -22,6 +22,7 @@
>  #include <linux/init.h>
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
> +#include <linux/irq_work.h>
>  #include <linux/memblock.h>
>  #include <linux/of_fdt.h>
>  #include <linux/smp.h>
> @@ -268,12 +269,17 @@ pgprot_t __acpi_get_mem_attribute(phys_addr_t addr)
>  int apei_claim_sea(struct pt_regs *regs)
>  {
>  	int err = -ENOENT;
> +	bool return_to_irqs_enabled;
>  	unsigned long current_flags;
>  
>  	if (!IS_ENABLED(CONFIG_ACPI_APEI_GHES))
>  		return err;
>  
>  	current_flags = arch_local_save_flags();
> +	return_to_irqs_enabled = !irqs_disabled_flags(current_flags);
> +
> +	if (regs)
> +		return_to_irqs_enabled = interrupts_enabled(regs);
>  
>  	/*
>  	 * SEA can interrupt SError, mask it and describe this as an NMI so
> @@ -283,6 +289,23 @@ int apei_claim_sea(struct pt_regs *regs)
>  	nmi_enter();
>  	err = ghes_notify_sea();
>  	nmi_exit();
> +
> +	/*
> +	 * APEI NMI-like notifications are deferred to irq_work. Unless
> +	 * we interrupted irqs-masked code, we can do that now.
> +	 */
> +	if (!err) {
> +		if (return_to_irqs_enabled) {
> +			local_daif_restore(DAIF_PROCCTX_NOIRQ);
> +			__irq_enter();
> +			irq_work_run();
> +			__irq_exit();
> +		} else {
> +			pr_warn("APEI work queued but not completed");
> +			err = -EINPROGRESS;
> +		}
> +	}
> +

Reviewed-by: Julien Thierry <julien.thierry@arm.com>

Cheers,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
