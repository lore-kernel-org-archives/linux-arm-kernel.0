Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD90C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:55:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEA94218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TF/1VWs7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA94218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VgUf9PcQIUHG+0VwjpQQapUKJ4gvyF9S3KnRYhNoYJE=; b=TF/1VWs7/AvYsPL3cEu51uqZp
	cukfnRkg84R88WfEn8U1U6C8mmGpeJZ4yM7iAT3hO52zYfV2b/1quaQRnw6u+g/IAYaTuiZhNB5Dh
	f/XwwuijE16kKgIFWlvx927XfTcR+zFd+xu4LcALHA1tZZDP01BMhYFMnNi4QxC2WrXm92naB+LVY
	SsPDZO0sjwneAm3Q4KEpR2I7O8oOpUd8lRg4anJuT21/WTx3IXpkbMI8b9LPkaje9ud8KxbDYmjWz
	Q1h3J8M/90JjNbuB/PbW3UhWLDvk6A1aIhsBoWKbyjKzTcgxXiqdwbPGVtbge8V5cBcO86TwgLWgw
	TRNPHDj0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpd2d-0008AC-S1; Fri, 01 Feb 2019 17:55:51 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpd2Z-00089s-M4
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 17:55:49 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9AB515BE;
 Fri,  1 Feb 2019 09:55:46 -0800 (PST)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0976F3F589;
 Fri,  1 Feb 2019 09:55:44 -0800 (PST)
Subject: Re: [PATCH v3 1/3] KVM: arm/arm64: vgic: Make vgic_irq->irq_lock a
 raw_spinlock
To: Julia Cartwright <julia@ni.com>
References: <1546873577-13895-1-git-send-email-julien.thierry@arm.com>
 <1546873577-13895-2-git-send-email-julien.thierry@arm.com>
 <fa628aae-68eb-7140-0533-367cafa26ed6@arm.com>
 <20190201173650.GC29111@jcartwri.amer.corp.natinst.com>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <6eeb2d94-cdda-006b-f32f-7857b61b3eaa@arm.com>
Date: Fri, 1 Feb 2019 17:55:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190201173650.GC29111@jcartwri.amer.corp.natinst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_095547_728551_ABE374C6 
X-CRM114-Status: GOOD (  19.37  )
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
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
 Julien Thierry <julien.thierry@arm.com>,
 "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
 "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Julia,

On 01/02/2019 17:36, Julia Cartwright wrote:
> On Fri, Feb 01, 2019 at 03:30:58PM +0000, Julien Grall wrote:
>> Hi Julien,
>>
>> On 07/01/2019 15:06, Julien Thierry wrote:
>>> vgic_irq->irq_lock must always be taken with interrupts disabled as
>>> it is used in interrupt context.
>>
>> I am a bit confused with the reason here. The code mention that ap_list_lock
>> could be taken from the timer interrupt handler interrupt. I assume it
>> speaks about the handler kvm_arch_timer_handler. Looking at the
>> configuration of the interrupt, the flag IRQF_NO_THREAD is not set, so the
>> interrupt should be threaded when CONFIG_PREEMPT_FULL is set. If my
>> understanding is correct, this means the interrupt thread would sleep if it
>> takes the spinlock.
>>
>> Did I miss anything? Do you have an exact path where the vGIC is actually
>> called from an interrupt context?
> 
> The part you're missing is that percpu interrupts are not force
> threaded:
> 
> 	static int irq_setup_forced_threading(struct irqaction *new)
> 	{
> 		if (!force_irqthreads)
> 			return 0;
> 		if (new->flags & (IRQF_NO_THREAD | IRQF_PERCPU | IRQF_ONESHOT))
> 			return 0;
> 	
> 		/* ...*/
> 	}

Thank you for the pointer! I think it would be worth mentioning in the commit 
message that per-cpu interrupts are not threaded.

Best regards,

-- 
Julien Grall

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
