Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46256C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:39:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14F1D2070C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UOPk+mry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F1D2070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OCycCvlobgKBXe7Veeyqtl3pV08AhMyIVltJXlApMKQ=; b=UOPk+mry6pN6uxPGPc9M9dmL8
	fvZ/HTP9zv0+uUK5Z4+mFzsqbE0ssUh17qNFACXs0ewmuD0/k8cJ5dmxNHr0SBiEtDhUc/PBv7Rk4
	F603j70EBbYubkAHY4Tf1pV10PTcb2DCWhY3qqq7U27NVeQk5uxSVWEOuAqLMSo6WAslCOVBI3lRW
	LULsRasow8sJ8NULuEVU5iNVjDdl2jW/IS9C3ungc6dE7ZI4IYCgNG8LiA1JzQTEXnFzi2E2O+Qlo
	cvt6jOZvWz+Mrn/yGDnMQCZgaR9GPO3RU2JFemQibp/8WhEmuG0N/EqMq5pdWVgx5SsVj9El1Ch8l
	JLJbhlLQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guFMk-00037x-90; Thu, 14 Feb 2019 11:39:42 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guFMh-00037d-QA
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 11:39:41 +0000
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 5597654F77549A5C5BF2;
 Thu, 14 Feb 2019 19:39:35 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Thu, 14 Feb 2019
 19:39:25 +0800
Subject: Re: [PATCH] irqchip/gic-v3-its: Avoid parsing _indirect_ twice for
 Device table
To: Marc Zyngier <marc.zyngier@arm.com>
References: <1549776250-4464-1-git-send-email-yuzenghui@huawei.com>
 <86pnrusl4u.wl-marc.zyngier@arm.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <9713bff0-8f1e-99c2-240d-aec627136cd9@huawei.com>
Date: Thu, 14 Feb 2019 19:35:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <86pnrusl4u.wl-marc.zyngier@arm.com>
Content-Language: en-US
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_033940_014371_6510C13C 
X-CRM114-Status: GOOD (  11.69  )
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

On 2019/2/14 18:46, Marc Zyngier wrote:
> On Sun, 10 Feb 2019 05:24:10 +0000,
> Zenghui Yu <yuzenghui@huawei.com> wrote:
>>
>> In current logic, its_parse_indirect_baser() will be invoked twice
>> when allocating Device tables. Add a *break* to omit the unnecessary
>> and annoying (might be ...) invoking.
>>
>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index db20e99..9f529a6 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -1946,6 +1946,8 @@ static int its_alloc_tables(struct its_node *its)
>>   			indirect = its_parse_indirect_baser(its, baser,
>>   							    psz, &order,
>>   							    its->device_ids);
>> +			break;
>> +
>>   		case GITS_BASER_TYPE_VCPU:
>>   			indirect = its_parse_indirect_baser(its, baser,
>>   							    psz, &order,
> 
> Nice catch. I've applied this to irqchip-next with the Fixes tag and a
> Cc stable.
> 

Thanks for picking it up!

Zenghui


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
