Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FEBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:02:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 131A72146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y8iZ3lAX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131A72146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zUvJTYP7rNnQYGLL3VOQLh2S2JbLGB1T99yQoxzm35M=; b=Y8iZ3lAXI7jo3k
	U/l0arKWfb5zHHDkZKh4XQwtFq6pxsrneXDivwMS1YPXDahUrpoNiI5g/6TkBqnlTeaQIRDFs/wCa
	W+FGiPt/nO988L8gAa1bWW3Nr00VyXmnSJWwqtG4Enif2G0NIeC/SJG7Z+Urq8amRj8oPKfuAz5DN
	tutn4Y5jnISw+OCCqCZrUVM0j9wW/7eDTcuul+x4PqKpsBUDFCwrS1kXQu3I6CRi39GX98s7VNRde
	aUQCUxCfeodylsR1KvAgihyTmKlOuXk/lj2iU0n6BoLdS0nxnti59aBuJXbFYJw3UIzme3WitAAll
	9KqZuhV/kDxTxXAHgVlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gh3Cc-0004rA-QY; Wed, 09 Jan 2019 02:02:42 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh3CZ-0004qb-9v
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 02:02:41 +0000
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 105AFDA6D60D1D83DBA8;
 Wed,  9 Jan 2019 10:02:31 +0800 (CST)
Received: from [127.0.0.1] (10.40.74.132) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Wed, 9 Jan 2019
 10:02:24 +0800
Subject: Re: [PATCH v3] arm64: lib: accelerate do_csum with NEON instruction
To: Will Deacon <will.deacon@arm.com>
References: <1546739729-17234-1-git-send-email-huanglingyan2@huawei.com>
 <CAKv+Gu_wsK1UNXSp=5Hvd7XCHKC3cVkYjTYHhvqM4Xt09A9iKg@mail.gmail.com>
 <9129b882-60f3-8046-0cb9-e0b2452a118d@huawei.com>
 <20190108135444.GB14476@fuggles.cambridge.arm.com>
From: "huanglingyan (A)" <huanglingyan2@huawei.com>
Message-ID: <cd5bb83e-bb0e-b348-5365-095c5fcd9648@huawei.com>
Date: Wed, 9 Jan 2019 10:03:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190108135444.GB14476@fuggles.cambridge.arm.com>
X-Originating-IP: [10.40.74.132]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_180239_518730_57642BA8 
X-CRM114-Status: GOOD (  12.37  )
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
Cc: Zhangshaokun <zhangshaokun@hisilicon.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org, ard.biesheuvel@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 2019/1/8 21:54, Will Deacon wrote:
> [re-adding Ard and LAKML -- not sure why the headers are so munged]
>
> On Mon, Jan 07, 2019 at 10:38:55AM +0800, huanglingyan (A) wrote:
>> On 2019/1/6 16:26, Ard Biesheuvel wrote:
>>     Please change this into
>>
>>     if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON) &&
>>         len >= CSUM_NEON_THRESHOLD &&
>>         may_use_simd()) {
>>             kernel_neon_begin();
>>             res = do_csum_neon(buff, len);
>>             kernel_neon_end();
>>         }
>>
>>     and drop the intermediate do_csum_arm()
>>
>>
>>         +               return do_csum_arm(buff, len);
>>         +#endif  /* CONFIG_KERNEL_MODE_NEON */
>>
>>     No else? What happens if len < CSUM_NEON_THRESHOLD ?
>>
>>
>>         +#undef do_csum
>>
>>     Can we drop this?
>>
>> Using NEON instructions will bring some costs. The spending maybe introduced
>> when reservering/restoring
>> neon registers with kernel_neon_begin()/kernel_neon_end(). Therefore NEON code
>> is Only used when
>> the length exceeds CSUM_NEON_THRESHOLD. General do csum() codes in lib/
>> checksum.c will be used in
>> shorter length. To achieve this goal, I use the "#undef do_csum" in else clause
>> to have the oppotunity to
>> utilize the general codes.
> I don't think that's how it works :/
>
> Before we get deeper into the implementation, please could you justify the
> need for a CPU-optimised checksum implementation at all? I thought this was
> usually offloaded to the NIC?
>
> Will
>
> .
This problem is introduced when testing Intel x710 network card on my ARM server.
Ip forward is set for ease of testing. Then send lots of packages to server by Tesgine
machine and then receive.

The bandwidth in Intel 8180 is 9.5 Gbps while only 5.8 Gbps in ARM. It shows that
do_csum() costs 36% in ARM and only 6% in Intel with perf tools. That's why I decide
to modify do_csum() function in ARM.

As a newbee of linux kernel, I has little knowledge of the implementation of such
situation. Looking forward to get your help of improving this patch.

Lingyan Huang
.

**************************

**************************
>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
