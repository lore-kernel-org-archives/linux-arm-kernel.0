Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA124C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:08:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABDB2208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gZ5gbvyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABDB2208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bLHoGpAVSNUqZJwlNQ+cfJ2TT8o0f78Cxqls5RzXJIw=; b=gZ5gbvyWuHjoAR
	kz85k/BRo5l2m+K8sT8uIWu9iCVZ2Ku61Nw0D1k5bmbkdFNeEeQOlBMukYdQxfnocPbeNa0W4x76e
	5xvdfNwgqPLv5p63/EQYO5eh9HhVYc+f6USz5pXqmzLThlZnvX7rZm1hoWM64fD3z/AqAQtwelNdL
	A3JlPUPN/LjAfmSg6qSl9MHJMon24zs4ATXEe6Mt9mY6OaJYK2QBX9ZB1JEQistB+QA7h5jA+pVSL
	OgszcaculnE2Ew/P7nmkkYyqFwzBRxFWzQ57eMeoJbjaOZM6FQaUB2JJWDxSZIH8gObhtUJmPrnqv
	zxn8ac3WyOXY5q5Jo17Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkIdu-000887-4d; Fri, 18 Jan 2019 01:08:18 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkIcs-00076r-6t
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 01:07:19 +0000
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 1DBCB69CE9D6E6039700;
 Fri, 18 Jan 2019 09:07:08 +0800 (CST)
Received: from [127.0.0.1] (10.40.74.132) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Fri, 18 Jan 2019
 09:07:02 +0800
Subject: Re: [PATCH v3] arm64: lib: accelerate do_csum with NEON instruction
To: Will Deacon <will.deacon@arm.com>
References: <1546739729-17234-1-git-send-email-huanglingyan2@huawei.com>
 <CAKv+Gu_wsK1UNXSp=5Hvd7XCHKC3cVkYjTYHhvqM4Xt09A9iKg@mail.gmail.com>
 <9129b882-60f3-8046-0cb9-e0b2452a118d@huawei.com>
 <20190108135444.GB14476@fuggles.cambridge.arm.com>
 <cd5bb83e-bb0e-b348-5365-095c5fcd9648@huawei.com>
 <20190116164657.GA1910@brain-police>
From: "huanglingyan (A)" <huanglingyan2@huawei.com>
Message-ID: <58c28adf-a01a-bb36-4def-866375e93aac@huawei.com>
Date: Fri, 18 Jan 2019 09:07:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190116164657.GA1910@brain-police>
X-Originating-IP: [10.40.74.132]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_170714_795867_1514D5B9 
X-CRM114-Status: GOOD (  12.82  )
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


On 2019/1/17 0:46, Will Deacon wrote:
> On Wed, Jan 09, 2019 at 10:03:05AM +0800, huanglingyan (A) wrote:
>> On 2019/1/8 21:54, Will Deacon wrote:
>>> [re-adding Ard and LAKML -- not sure why the headers are so munged]
>>>
>>> On Mon, Jan 07, 2019 at 10:38:55AM +0800, huanglingyan (A) wrote:
>>>> On 2019/1/6 16:26, Ard Biesheuvel wrote:
>>>>     Please change this into
>>>>
>>>>     if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON) &&
>>>>         len >= CSUM_NEON_THRESHOLD &&
>>>>         may_use_simd()) {
>>>>             kernel_neon_begin();
>>>>             res = do_csum_neon(buff, len);
>>>>             kernel_neon_end();
>>>>         }
>>>>
>>>>     and drop the intermediate do_csum_arm()
>>>>
>>>>
>>>>         +               return do_csum_arm(buff, len);
>>>>         +#endif  /* CONFIG_KERNEL_MODE_NEON */
>>>>
>>>>     No else? What happens if len < CSUM_NEON_THRESHOLD ?
>>>>
>>>>
>>>>         +#undef do_csum
>>>>
>>>>     Can we drop this?
>>>>
>>>> Using NEON instructions will bring some costs. The spending maybe introduced
>>>> when reservering/restoring
>>>> neon registers with kernel_neon_begin()/kernel_neon_end(). Therefore NEON code
>>>> is Only used when
>>>> the length exceeds CSUM_NEON_THRESHOLD. General do csum() codes in lib/
>>>> checksum.c will be used in
>>>> shorter length. To achieve this goal, I use the "#undef do_csum" in else clause
>>>> to have the oppotunity to
>>>> utilize the general codes.
>>> I don't think that's how it works :/
>>>
>>> Before we get deeper into the implementation, please could you justify the
>>> need for a CPU-optimised checksum implementation at all? I thought this was
>>> usually offloaded to the NIC?
>>>
>>> Will
>>>
>>> .
>> This problem is introduced when testing Intel x710 network card on my ARM server.
>> Ip forward is set for ease of testing. Then send lots of packages to server by Tesgine
>> machine and then receive.
> In the marketing blurb, that card boasts:
>
>   `Tx/Rx IP, SCTP, TCP, and UDP checksum offloading (IPv4, IPv6) capabilities'
>
> so we shouldn't need to run this on the CPU. Again, I'm not keen to optimise
> this given that it /really/ shouldn't be used on arm64 machines that care
> about network performance.
>
> Will
>
> .
Yeah, you are right. Checksum is usually done in network card which is told by
someone familiar with NIC. However, it may be used in testing scenaries and
some primary network cards. I think it's no harm to optimize this code while
other ARCHs have their own optimized versions.
>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
