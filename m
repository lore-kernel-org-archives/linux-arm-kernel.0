Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A9BC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:17:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D51C8214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="siZWVd0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51C8214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=M2htshirsMME7NMYmRG7BtiQ3aEF54cM58N7gHBkVb4=; b=siZWVd0QXFAfBuKjbhlirV0FO
	8WHShe2bsG8vL3ynA2RX7WUUjw9t2ekDOEA/P9QZS/xEMLNz9KCLw8vjTN7qwPOKazqQwcH8xQkKX
	NIddkL1ceqicBO3LzvVoqO3LP0h3ulVE9BrxQbV7Fls5Rb8nC+JRWeyTd0CmPkf98BscMaI3/zK+s
	Umawzjcz4+Z2FvmXQ7/0rhJ2sXmh1USTKu7dXu4VVVBZIqL0ByVGab9HcerqwCuTjQpHMuKruNoGp
	DQYViM88Yc8xiXgTKM7VLeLF15Sf4Y8PmnZE7aziWl+nQDJCaEO97+Ru6YhzAzJnc45azJEp5KOKu
	iqMgVx0jg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtXwX-0001Li-JI; Tue, 12 Feb 2019 13:17:45 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtXwT-0001Ke-Qu
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 13:17:43 +0000
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 56F399D614730395FFD3;
 Tue, 12 Feb 2019 21:17:32 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Tue, 12 Feb 2019
 21:17:25 +0800
Subject: Re: [PATCH] irqchip/gic-v3-its: Avoid parsing _indirect_ twice for
 Device table
To: <marc.zyngier@arm.com>
References: <1549776250-4464-1-git-send-email-yuzenghui@huawei.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <18c972e9-5230-4a0c-3fbf-e3c6c224d6fc@huawei.com>
Date: Tue, 12 Feb 2019 21:17:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <1549776250-4464-1-git-send-email-yuzenghui@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_051742_039277_6C88FA68 
X-CRM114-Status: GOOD (  11.79  )
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
Cc: jason@lakedaemon.net, linux-kernel@vger.kernel.org, shankerd@codeaurora.org,
 wanghaibin.wang@huawei.com, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Marc,

On 2019/2/10 13:24, Zenghui Yu wrote:
> In current logic, its_parse_indirect_baser() will be invoked twice
> when allocating Device tables. Add a *break* to omit the unnecessary
> and annoying (might be ...) invoking.
> 

Forgot to add:

Fixes: 32bd44dc19de ("irqchip/gic-v3-its: Fix the incorrect parsing of 
VCPU table size")

> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>   drivers/irqchip/irq-gic-v3-its.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index db20e99..9f529a6 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1946,6 +1946,8 @@ static int its_alloc_tables(struct its_node *its)
>   			indirect = its_parse_indirect_baser(its, baser,
>   							    psz, &order,
>   							    its->device_ids);
> +			break;
> +
>   		case GITS_BASER_TYPE_VCPU:
>   			indirect = its_parse_indirect_baser(its, baser,
>   							    psz, &order,
> 

Thanks,
Zenghui


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
