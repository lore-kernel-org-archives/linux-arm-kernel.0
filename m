Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102A0C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:36:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3FE520844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FyLOYCo3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3FE520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lGS+35Qu8vmp4EBXf291HH6/EceF1Nso4lqgwAlxYXw=; b=FyLOYCo3tQbUuA
	d+vBfkyH9ZmgqeWj/q7PhuLWxsn4dr0phMR68XqwL0E8UBQytU0VKT8y4/T4qzo4xkW83mtnT6zuT
	QXT9gV3mciDYjfqH7euo8f9EH9F5fgVLq+57ZMrWOihz0JQSiU36+0VPXXsqMzFRJOGrboqh8L96d
	p3947VRNl1FgOrTE10z9Xl27IbHOhpA/xIj0V24i5uliKmoTVLctBDPznWWpYaI+GHRampAaqOnzZ
	c49HRzIOylahsnHpot8Dr1BU6AQTs2inpptEZwFpwb6UftRzkSZfhFeNNqKrgLI2HZY1YvMXKVKqv
	9kD+VT+NwybeS7B7pBPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goRhA-0000V8-JS; Tue, 29 Jan 2019 11:36:48 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goRgS-0008OC-Lx
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 11:36:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 193ADEBD;
 Tue, 29 Jan 2019 03:36:04 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D15093F589;
 Tue, 29 Jan 2019 03:36:01 -0800 (PST)
Subject: Re: [PATCH v9 21/26] irqchip/gic: Add functions to access irq
 priorities
To: Marc Zyngier <marc.zyngier@arm.com>
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
 <1548084825-8803-22-git-send-email-julien.thierry@arm.com>
 <86va29ugy0.wl-marc.zyngier@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <a47b09ff-7d68-8ed9-785e-8334319aef37@arm.com>
Date: Tue, 29 Jan 2019 11:36:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <86va29ugy0.wl-marc.zyngier@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_033606_245143_4979B315 
X-CRM114-Status: GOOD (  17.32  )
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



On 28/01/2019 12:04, Marc Zyngier wrote:
> On Mon, 21 Jan 2019 15:33:40 +0000,
> Julien Thierry <julien.thierry@arm.com> wrote:
>>
>> Add accessors to the GIC distributor/redistributors priority registers.
>>
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Jason Cooper <jason@lakedaemon.net>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  drivers/irqchip/irq-gic-common.c | 10 ++++++++++
>>  drivers/irqchip/irq-gic-common.h |  2 ++
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
>> index 3c93c6f..04eadbc 100644
>> --- a/drivers/irqchip/irq-gic-common.c
>> +++ b/drivers/irqchip/irq-gic-common.c
>> @@ -110,6 +110,16 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
>>  	return ret;
>>  }
>>  
>> +void gic_set_irq_prio(unsigned int irq, void __iomem *base, u8 prio)
>> +{
>> +	writeb_relaxed(prio, base + GIC_DIST_PRI + irq);
>> +}
>> +
>> +u8 gic_get_irq_prio(unsigned int irq, void __iomem *base)
>> +{
>> +	return readb_relaxed(base + GIC_DIST_PRI + irq);
>> +}
>> +
> 
> Is there a reason why this is in irq-gic-common.c? If we can avoid it,
> I'd rather this is made private to GICv3, as I do not intend to
> support this for earlier revisions on the architecture.
> 

The only reason I put it in common is that the same code works both for
gicv3 and gic drivers.

But if you prefer the gic driver not to see it I'll move it to the gicv3
driver.

Thanks,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
