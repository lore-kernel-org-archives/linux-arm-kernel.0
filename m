Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D59C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:25:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56DB2218FC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b1zSa4EH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56DB2218FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OpIanaLUi8c7npTiTl9kbjCqohVAWPK0bjJcFSewvaM=; b=b1zSa4EHN53FbvYEAXujnovXZ
	c/V19DQ/lv/Am3wFGzf5z69uqANg32Ag02Bd8Mppk4b50ufK4YIW+l2M4A2jWVyzBL12FypKFxCG+
	ePfEqIRmtp2yBJMlRRM68xJrYKWgBmSy/w/Rxw3ozxxfRlEth2od+6QkLgHrn9XAetdMWA8OCFmT7
	EGc5Bmbt8R0sMgtElBF8fUuSzHUcdfnNfjzvtrHrIOKdEurYI4BEOwTYdA3Bn51W9CaW4Uhv1qYcz
	wf+lfhkRQyCypk0A7qwhH4PKc0KMLXEL4Qe1ubkzV4w/ZsV+aO3dBh0o0IBvhO5KqVrgV7vre9KpU
	ALyybJZbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCLO-0007Gh-Fm; Thu, 31 Jan 2019 13:25:26 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCL4-0005oI-0C
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:25:11 +0000
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 2583F6669A5BB3B6B6C5;
 Thu, 31 Jan 2019 21:25:00 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Thu, 31 Jan 2019
 21:24:49 +0800
Subject: Re: [PATCH] irqchip/gic-v3-its: Fix probing for ITT_entry_size
To: Marc Zyngier <marc.zyngier@arm.com>
References: <1548933583-12504-1-git-send-email-yuzenghui@huawei.com>
 <b25b4419-d552-4829-027f-3b676afc7fbf@arm.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <232b35f6-ecff-4e84-881c-bf1805cfab07@huawei.com>
Date: Thu, 31 Jan 2019 21:21:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <b25b4419-d552-4829-027f-3b676afc7fbf@arm.com>
Content-Language: en-US
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_052506_852031_6D3D2CB8 
X-CRM114-Status: GOOD (  12.16  )
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
Cc: wanghaibin.wang@huawei.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 2019/1/31 20:48, Marc Zyngier wrote:
> On 31/01/2019 11:19, Zenghui Yu wrote:
>> According to ARM IHI 0069C (ID070116), we should use GITS_TYPER's
>> bits [7:4] as ITT_entry_size.
>>
>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>> ---
>>   include/linux/irqchip/arm-gic-v3.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
>> index 071b4cb..c848a7c 100644
>> --- a/include/linux/irqchip/arm-gic-v3.h
>> +++ b/include/linux/irqchip/arm-gic-v3.h
>> @@ -319,7 +319,7 @@
>>   #define GITS_TYPER_PLPIS		(1UL << 0)
>>   #define GITS_TYPER_VLPIS		(1UL << 1)
>>   #define GITS_TYPER_ITT_ENTRY_SIZE_SHIFT	4
>> -#define GITS_TYPER_ITT_ENTRY_SIZE(r)	((((r) >> GITS_TYPER_ITT_ENTRY_SIZE_SHIFT) & 0x1f) + 1)
>> +#define GITS_TYPER_ITT_ENTRY_SIZE(r)	((((r) >> GITS_TYPER_ITT_ENTRY_SIZE_SHIFT) & 0xf) + 1)
>>   #define GITS_TYPER_IDBITS_SHIFT		8
>>   #define GITS_TYPER_DEVBITS_SHIFT	13
>>   #define GITS_TYPER_DEVBITS(r)		((((r) >> GITS_TYPER_DEVBITS_SHIFT) & 0x1f) + 1)
>>
> 
> Well spotted. I've applied this as a fix after having added the relevant
> Fixes: tag and massaged the commit message a bit.

Thanks Marc!

Zenghui

> 
> Thanks,
> 
> 	M.
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
