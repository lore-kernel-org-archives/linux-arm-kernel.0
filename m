Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D9FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:33:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 387C820844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l6kal2ii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387C820844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r+Zuhv4DGGSMXriXVVhQHCA4/+BrVxmgQ1GLJiHJp1Y=; b=l6kal2iiHSesA/
	PG5HImb9k5/M0YPGBO0JRW9WE42iZ0HsBgJYuTxczmKdT9ls/lyXgzDh2pzH9V1dSaDRlkJzaX2K2
	nPzTqhlM5NZjEYhT0MtLxpP+3a6WN+NFEr49Op9Erju3wYNaibffRaMgOubXhizaqEI/zWSg5szwO
	llY5Wv61MahSNBEuGj9NPt59focIgJ0V0IjetMwmpkYlfewPLSqTqVVoZD6hdD/mbEjHEH97pNogZ
	e5XOZZT/jHtCLTXsBJkB056X/Gh5Gyl6i8UCsVWSKWIQxVoTW7Am+SGgpmewIeWHoVPi7ye31Ynpi
	nXrU7Yc1lnrTbYlAPA7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goReB-0005qn-Q5; Tue, 29 Jan 2019 11:33:43 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goRe7-0005q2-PJ
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 11:33:41 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 017D1EBD;
 Tue, 29 Jan 2019 03:33:39 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AC8C3F589;
 Tue, 29 Jan 2019 03:33:36 -0800 (PST)
Subject: Re: [PATCH v9 20/26] irqchip/gic-v3: Handle pseudo-NMIs
To: Marc Zyngier <marc.zyngier@arm.com>
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
 <1548084825-8803-21-git-send-email-julien.thierry@arm.com>
 <86wompuh5j.wl-marc.zyngier@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <c332af8d-4529-dbb0-f760-0c2518823053@arm.com>
Date: Tue, 29 Jan 2019 11:33:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <86wompuh5j.wl-marc.zyngier@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_033339_831383_5F3C9F2F 
X-CRM114-Status: GOOD (  16.43  )
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
Cc: mark.rutland@arm.com, daniel.thompson@linaro.org,
 Jason Cooper <jason@lakedaemon.net>, catalin.marinas@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, christoffer.dall@arm.com,
 james.morse@arm.com, joel@joelfernandes.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 28/01/2019 11:59, Marc Zyngier wrote:
> On Mon, 21 Jan 2019 15:33:39 +0000,
> Julien Thierry <julien.thierry@arm.com> wrote:
>>
>> Provide a higher priority to be used for pseudo-NMIs. When such an
>> interrupt is received, keep interrupts fully disabled at CPU level to
>> prevent receiving other pseudo-NMIs while handling the current one.
>>
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Jason Cooper <jason@lakedaemon.net>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  drivers/irqchip/irq-gic-v3.c | 42 ++++++++++++++++++++++++++++++++++++------
>>  1 file changed, 36 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index 5374b43..4df1e94 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -41,6 +41,8 @@
>>  
>>  #include "irq-gic-common.h"
>>  
>> +#define GICD_INT_NMI_PRI	(GICD_INT_DEF_PRI & ~0x80)
>> +
>>  #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
>>  
>>  struct redist_region {
>> @@ -381,12 +383,45 @@ static u64 gic_mpidr_to_affinity(unsigned long mpidr)
>>  	return aff;
>>  }
>>  
>> +static inline void gic_deactivate_unexpected_irq(u32 irqnr)
> 
> Same remark as on some other patches: you should be able to drop the
> inline attribute without any ill effect. I'd also like this to be
> renamed "gic_deactivate_spurious", or something similar.
> 

I'm a bit concern about using spurious since it is not related to
GICC_INT_SPURIOUS, we actually read a valid IRQ number, we just don't
know how we should handle it.

Would "gic_deactivate_unhandled" work? Or "gic_deactivate_bad"?

Thanks,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
