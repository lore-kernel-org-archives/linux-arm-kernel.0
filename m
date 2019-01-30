Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4E5C282D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:25:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD69E2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GTfjRzVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD69E2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QE4p1G3pRywPGfF4pHjwjkA3MEONWTHNT8bc7eWNTKs=; b=GTfjRzVYzzA8TD
	9AMRUm62epIYyTAgol4yiJ6zXaAG03HYZ16i4LSruBhMcGx8bXD2QV017q96fL37AdU5UUU9D2kco
	fq89zQDnIcevOFpjTayMD8pegXMt7oQzQH6n+IWSodLNrTcO6+tCQnQL1n+YiJTQ+xosMmCngCHRA
	7Qp+nplJaQzRuoT3VBf5KwWL/58oR4deCXhKWZX1tXz5l2L4h4PAUiFlsq0SRXI97x7E0aCvnOSDz
	KCt9at5McizK2bkdl7BWukouXP+tUUQgJGN1crPHr7v0eg55Uk3jyD/ABw2r6ALrcO/3woR0P6s07
	5PeXS5wNT3bN5Cfl3EOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gojJW-00045B-Ke; Wed, 30 Jan 2019 06:25:34 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gojJT-00044T-IJ
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 06:25:33 +0000
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 4BB7B57AB6670DA8943D;
 Wed, 30 Jan 2019 14:25:20 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Wed, 30 Jan 2019
 14:25:16 +0800
Subject: Re: [PATCH -next] irqchip/tango: Fix potential NULL pointer
 dereference
To: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, Marc Zyngier
 <marc.zyngier@arm.com>
References: <20190129080122.20392-1-yuehaibing@huawei.com>
 <86a7jjvo4y.wl-marc.zyngier@arm.com> <yw1x8sz31wqw.fsf@mansr.com>
From: YueHaibing <yuehaibing@huawei.com>
Message-ID: <59e45e0d-558a-a40d-36d5-47e7ce3fb5a0@huawei.com>
Date: Wed, 30 Jan 2019 14:25:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <yw1x8sz31wqw.fsf@mansr.com>
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_222531_776077_36D0765D 
X-CRM114-Status: GOOD (  14.90  )
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
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net,
 linux-arm-kernel@lists.infradead.org, marc.w.gonzalez@free.fr
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2019/1/29 20:20, M=E5ns Rullg=E5rd wrote:
> Marc Zyngier <marc.zyngier@arm.com> writes:
> =

>> On Tue, 29 Jan 2019 08:01:22 +0000,
>> YueHaibing <yuehaibing@huawei.com> wrote:
>>>
>>> There is a potential NULL pointer dereference in case kzalloc()
>>> fails and returns NULL.
>>>
>>> Fixes: 4bba66899ac6 ("irqchip/tango: Add support for Sigma Designs SMP8=
6xx/SMP87xx interrupt controller")
>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>> ---
>>>  drivers/irqchip/irq-tango.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/irqchip/irq-tango.c b/drivers/irqchip/irq-tango.c
>>> index ae28d86..a63b828 100644
>>> --- a/drivers/irqchip/irq-tango.c
>>> +++ b/drivers/irqchip/irq-tango.c
>>> @@ -191,6 +191,8 @@ static int __init tangox_irq_init(void __iomem *bas=
e, struct resource *baseres,
>>>  		panic("%pOFn: failed to get address", node);
>>>  =

>>>  	chip =3D kzalloc(sizeof(*chip), GFP_KERNEL);
>>> +	if (!chip)
>>> +		return -ENOMEM;
>>>  	chip->ctl =3D res.start - baseres->start;
>>>  	chip->base =3D base;
>>>  =

>>
>> This is a commendable effort, but given that the whole error handling
>> of this driver is just to simply panic, I have the ugly feeling that
>> this lack of check is more a feature than a bug... Not that I like it,
>> but at least it is consistent.
> =

> That seemed to be the norm for irqchip drivers when I wrote this one,
> and a fair number of them still panic on errors during init.  There's
> really not much else that can sanely be done since nothing will work
> without irq handling.
> =

> As for the error return added by this patch, nothing checks it, so a
> failure would merely result in the irqchip being silently skipped and
> nothing working.  Propagating the error back to of_irq_init() also has
> no effect, not even a warning.  Besides, kzalloc() is extremely unlikely
> to fail at this stage, and if it does, you have much bigger problems.

Thanks for your comment.

> =



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
