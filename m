Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666F0C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:20:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3617B20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hAMgf6JV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3617B20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mansr.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bhwAmUfkROqW3mJbmg/voRrVHuGKauUsOGtKytzTw8E=; b=hAMgf6JVvOHPLa
	gzOeuRnstdW/lZg4lBKwmI3RcZLUnCs6swq6Z+FG8GagwpEDUOF/U+ZL4XwFnjzc2d1mRCNtqkbDE
	WXK3GAt7zwK7N+nGgP+vrXkElyPon4LTu7RmmV2ob71LgY6sod3HC1yCGIT7Z5/PfrQv7aObB13+M
	J4phLJJQYCaavhGhGNesRub7uD37FprDStt6kAfaGjTCaWpn7dQnMYMl1YLGH2LH5gp+Z5opRDqKE
	Hh+3ibSKZ8CteICqQ/O/YgBc7wqWaYBvkafffU0/XCS9Od48IqMFvhI3igBYzwNflV0KJ3tINVBHo
	Xtob5RLmhPg6VCsYoYoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goSNT-00031l-7A; Tue, 29 Jan 2019 12:20:31 +0000
Received: from unicorn.mansr.com ([81.2.72.234])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goSNP-000315-DE
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 12:20:29 +0000
Received: by unicorn.mansr.com (Postfix, from userid 51770)
 id 4D53615AC8; Tue, 29 Jan 2019 12:20:07 +0000 (GMT)
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH -next] irqchip/tango: Fix potential NULL pointer
 dereference
References: <20190129080122.20392-1-yuehaibing@huawei.com>
 <86a7jjvo4y.wl-marc.zyngier@arm.com>
Date: Tue, 29 Jan 2019 12:20:07 +0000
In-Reply-To: <86a7jjvo4y.wl-marc.zyngier@arm.com> (Marc Zyngier's message of
 "Tue, 29 Jan 2019 08:55:41 +0000")
Message-ID: <yw1x8sz31wqw.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_042027_621878_9A465E18 
X-CRM114-Status: GOOD (  14.34  )
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
Cc: jason@lakedaemon.net, marc.w.gonzalez@free.fr,
 YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Marc Zyngier <marc.zyngier@arm.com> writes:

> On Tue, 29 Jan 2019 08:01:22 +0000,
> YueHaibing <yuehaibing@huawei.com> wrote:
>> =

>> There is a potential NULL pointer dereference in case kzalloc()
>> fails and returns NULL.
>> =

>> Fixes: 4bba66899ac6 ("irqchip/tango: Add support for Sigma Designs SMP86=
xx/SMP87xx interrupt controller")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/irqchip/irq-tango.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> =

>> diff --git a/drivers/irqchip/irq-tango.c b/drivers/irqchip/irq-tango.c
>> index ae28d86..a63b828 100644
>> --- a/drivers/irqchip/irq-tango.c
>> +++ b/drivers/irqchip/irq-tango.c
>> @@ -191,6 +191,8 @@ static int __init tangox_irq_init(void __iomem *base=
, struct resource *baseres,
>>  		panic("%pOFn: failed to get address", node);
>>  =

>>  	chip =3D kzalloc(sizeof(*chip), GFP_KERNEL);
>> +	if (!chip)
>> +		return -ENOMEM;
>>  	chip->ctl =3D res.start - baseres->start;
>>  	chip->base =3D base;
>>  =

>
> This is a commendable effort, but given that the whole error handling
> of this driver is just to simply panic, I have the ugly feeling that
> this lack of check is more a feature than a bug... Not that I like it,
> but at least it is consistent.

That seemed to be the norm for irqchip drivers when I wrote this one,
and a fair number of them still panic on errors during init.  There's
really not much else that can sanely be done since nothing will work
without irq handling.

As for the error return added by this patch, nothing checks it, so a
failure would merely result in the irqchip being silently skipped and
nothing working.  Propagating the error back to of_irq_init() also has
no effect, not even a warning.  Besides, kzalloc() is extremely unlikely
to fail at this stage, and if it does, you have much bigger problems.

-- =

M=E5ns Rullg=E5rd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
