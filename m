Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1018C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:43:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE2420821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TXS8CJ81"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE2420821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1Upbgcwn/5HFmO6/X/0UCbMGGbRBr58147HtTWh7LAY=; b=TXS8CJ81vuZRC5
	6APwn0X8+LxVv7xQgao3f/f5/61MZ5cQxOf/o6BV3NWDfttFOqnjQlvYW/W3f7gk1CN5Wu5xiXPD+
	+8Uag1t2+KkxVepp1bUDYNYRD4IyUWITzR39hSGQxTINrEuvfR165LvokYxlkGbHPbOhpLBtO/0Do
	bdmta2ex36w9HCS8YL0NiuhLiv0SJvj9cocBfXBN71r+OQkFAYuLLp3HBzR+UmDCfN77CH098Ngqk
	b2geksVOo90Xbim6shAxA83y+R0tZmmQb9VAIyiF1LF0ccZu6J+psZV9PVK9Bd7bH9kskMuhVJXaO
	5gfKq59s7U1ph2X93hDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gh8WV-0007pk-QM; Wed, 09 Jan 2019 07:43:35 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh8WS-0007pE-2M
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 07:43:33 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51CFC80D;
 Tue,  8 Jan 2019 23:43:31 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC9443F6CF;
 Tue,  8 Jan 2019 23:43:29 -0800 (PST)
Date: Wed, 9 Jan 2019 07:43:24 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
To: Zhao Yuanyuan <yuanyuan.zhao@hxt-semitech.com>
Subject: Re: [RESEND 1/1] gic: its: Make sure a LPI is discarded before free.
Message-ID: <20190109074324.6445118d@why.wild-wind.fr.eu.org>
In-Reply-To: <e37e3f5e0146be65c60092a457ca5c82e25581a0.1545292748.git.yuanyuan.zhao@hxt-semitech.com>
References: <e37e3f5e0146be65c60092a457ca5c82e25581a0.1545292748.git.yuanyuan.zhao@hxt-semitech.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_234332_135860_AB6C9BB2 
X-CRM114-Status: GOOD (  15.69  )
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
Cc: dongsheng.wang@hxt-semitech.com, jason@lakedaemon.net,
 linux-kernel@vger.kernel.org, tglx@linutronix.de, yu.zheng@hxt-semitech.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 9 Jan 2019 11:53:27 +0800
Zhao Yuanyuan <yuanyuan.zhao@hxt-semitech.com> wrote:

Hi Zhao,

> Its device will be removed after all events be freed.
> Undisarded events can lead to unpredictable behaviar.
> 
> Signed-off-by: Zhao Yuanyuan <yuanyuan.zhao@hxt-semitech.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index db20e99..4fee008 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -2572,6 +2572,10 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
>  								virq + i);
>  		u32 event = its_get_event_id(data);
>  
> +		/* Discard irq before free */
> +		if (irqd_is_activated(d))
> +			its_send_discard(its_dev, event);
> +
>  		/* Mark interrupt index as unused */
>  		clear_bit(event, its_dev->event_map.lpi_map);
>  

But we already do send a discard on deactivate, which logically happens
before we free the domain. So what are you fixing here?

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
