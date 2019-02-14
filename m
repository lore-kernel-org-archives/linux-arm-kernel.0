Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57279C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:17:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26E94222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i5JxvgKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E94222A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hGZ6e1ag+eAim3YAkSPQaU0SPmQY/zXH/Av87HikW2s=; b=i5JxvgKeDJj4Ke
	FvTbqVjM2HLLFnCYmBh4WtePuitcW+Co/0e5nbIlE3Mrdh4Wx1e4mFQ5ADRcMzsI/4Oj5Sxw0Ypot
	sK2mwTEZo92F43upzUl5SAGj8X/fZVhD1CKxciNglor1hVTlvGL9B7mdqyoA46f1JUNaz+8yR16Kt
	xcf3ZeznXuDdGWBm+FpVwi2tw1uLZg6/hEQF0V53lWndG+6Wt2yUfTbUJCQAV39/N3VxW1fEjeU5V
	baWxhk+qYELc8VQAc9vKOEGQqFtdrAFIMjUo3XEFa3OgDjKdcUWdcz57FjEocINjh+FA7/cuyxtu2
	pCbY3RbNkflZAf4V4dTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guDlF-0008Gb-4I; Thu, 14 Feb 2019 09:56:53 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guDlB-000802-N7
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 09:56:51 +0000
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 399B92302BC2C915E4C1;
 Thu, 14 Feb 2019 17:56:43 +0800 (CST)
Received: from [127.0.0.1] (10.40.74.132) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Thu, 14 Feb 2019
 17:56:36 +0800
Subject: Re: [PATCH v3] arm64: lib: accelerate do_csum with NEON instruction
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
References: <1546739729-17234-1-git-send-email-huanglingyan2@huawei.com>
 <CAKv+Gu_wsK1UNXSp=5Hvd7XCHKC3cVkYjTYHhvqM4Xt09A9iKg@mail.gmail.com>
 <9129b882-60f3-8046-0cb9-e0b2452a118d@huawei.com>
 <20190108135444.GB14476@fuggles.cambridge.arm.com>
 <cd5bb83e-bb0e-b348-5365-095c5fcd9648@huawei.com>
 <20190116164657.GA1910@brain-police>
 <58c28adf-a01a-bb36-4def-866375e93aac@huawei.com>
 <CAKv+Gu-MUDT-pAE4kwHbCsW2MSYBCDB3N1reRgeFL1EwiNQvxQ@mail.gmail.com>
 <d97f1ba1-1b73-1bde-cd8f-de55115acd9e@huawei.com>
 <CAKv+Gu_jzU934k=SU-0bpF7NrqZ-KW2u_G3a+WDkxs+O6bzQow@mail.gmail.com>
 <f42aa98b-3d43-8f63-7636-9fa630a060e4@huawei.com>
 <CAKv+Gu9XDneyLwidA+fGkpgJOb0owegYHNPJ2iLfqAovZox9GQ@mail.gmail.com>
 <CAKv+Gu-NuJCkeWqdK_pi4Vm7tyM4X=ZKqWdYg-m=Go2O6_fUrQ@mail.gmail.com>
From: "huanglingyan (A)" <huanglingyan2@huawei.com>
Message-ID: <f4b7b467-410c-9454-535e-f8a413297fa1@huawei.com>
Date: Thu, 14 Feb 2019 17:57:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-NuJCkeWqdK_pi4Vm7tyM4X=ZKqWdYg-m=Go2O6_fUrQ@mail.gmail.com>
X-Originating-IP: [10.40.74.132]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_015649_965918_556B1316 
X-CRM114-Status: GOOD (  24.00  )
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 2019/2/14 1:55, Ard Biesheuvel wrote:
> (+ Ilias)
>
> On Wed, 13 Feb 2019 at 10:15, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> On Wed, 13 Feb 2019 at 09:42, huanglingyan (A) <huanglingyan2@huawei.com> wrote:
>>>
>>> On 2019/2/12 15:07, Ard Biesheuvel wrote:
>>>> On Tue, 12 Feb 2019 at 03:25, huanglingyan (A) <huanglingyan2@huawei.com> wrote:
>>>>> On 2019/1/18 19:14, Ard Biesheuvel wrote:
>>>>>> On Fri, 18 Jan 2019 at 02:07, huanglingyan (A) <huanglingyan2@huawei.com> wrote:
>>>>>>> On 2019/1/17 0:46, Will Deacon wrote:
>>>>>>>> On Wed, Jan 09, 2019 at 10:03:05AM +0800, huanglingyan (A) wrote:
>>>>>>>>> On 2019/1/8 21:54, Will Deacon wrote:
>>>>>>>>>> [re-adding Ard and LAKML -- not sure why the headers are so munged]
>>>>>>>>>>
>>>>>>>>>> On Mon, Jan 07, 2019 at 10:38:55AM +0800, huanglingyan (A) wrote:
>>>>>>>>>>> On 2019/1/6 16:26, Ard Biesheuvel wrote:
>>>>>>>>>>>     Please change this into
>>>>>>>>>>>
>>>>>>>>>>>     if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON) &&
>>>>>>>>>>>         len >= CSUM_NEON_THRESHOLD &&
>>>>>>>>>>>         may_use_simd()) {
>>>>>>>>>>>             kernel_neon_begin();
>>>>>>>>>>>             res = do_csum_neon(buff, len);
>>>>>>>>>>>             kernel_neon_end();
>>>>>>>>>>>         }
>>>>>>>>>>>
>>>>>>>>>>>     and drop the intermediate do_csum_arm()
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>         +               return do_csum_arm(buff, len);
>>>>>>>>>>>         +#endif  /* CONFIG_KERNEL_MODE_NEON */
>>>>>>>>>>>
>>>>>>>>>>>     No else? What happens if len < CSUM_NEON_THRESHOLD ?
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>         +#undef do_csum
>>>>>>>>>>>
>>>>>>>>>>>     Can we drop this?
>>>>>>>>>>>
>>>>>>>>>>> Using NEON instructions will bring some costs. The spending maybe introduced
>>>>>>>>>>> when reservering/restoring
>>>>>>>>>>> neon registers with kernel_neon_begin()/kernel_neon_end(). Therefore NEON code
>>>>>>>>>>> is Only used when
>>>>>>>>>>> the length exceeds CSUM_NEON_THRESHOLD. General do csum() codes in lib/
>>>>>>>>>>> checksum.c will be used in
>>>>>>>>>>> shorter length. To achieve this goal, I use the "#undef do_csum" in else clause
>>>>>>>>>>> to have the oppotunity to
>>>>>>>>>>> utilize the general codes.
>>>>>>>>>> I don't think that's how it works :/
>>>>>>>>>>
>>>>>>>>>> Before we get deeper into the implementation, please could you justify the
>>>>>>>>>> need for a CPU-optimised checksum implementation at all? I thought this was
>>>>>>>>>> usually offloaded to the NIC?
>>>>>>>>>>
>>>>>>>>>> Will
>>>>>>>>>>
>>>>>>>>>> .
>>>>>>>>> This problem is introduced when testing Intel x710 network card on my ARM server.
>>>>>>>>> Ip forward is set for ease of testing. Then send lots of packages to server by Tesgine
>>>>>>>>> machine and then receive.
>>>>>>>> In the marketing blurb, that card boasts:
>>>>>>>>
>>>>>>>>   `Tx/Rx IP, SCTP, TCP, and UDP checksum offloading (IPv4, IPv6) capabilities'
>>>>>>>>
>>>>>>>> so we shouldn't need to run this on the CPU. Again, I'm not keen to optimise
>>>>>>>> this given that it /really/ shouldn't be used on arm64 machines that care
>>>>>>>> about network performance.
>>>>>>>>
>>>>>>>> Will
>>>>>>>>
>>>>>>>> .
>>>>>>> Yeah, you are right. Checksum is usually done in network card which is told by
>>>>>>> someone familiar with NIC. However, it may be used in testing scenaries and
>>>>>>> some primary network cards. I think it's no harm to optimize this code while
>>>>>>> other ARCHs have their own optimized versions.
>>>>>> I disagree. If this code path is never exercised, we should not
>>>>>> include it. We can revisit this decision when there is a use case
>>>>>> where the checksumming performance is an actual bottleneck.
>>>>>>
>>>>>> .
>>>>> The mainstream network cards has an option to switch the csum pattern.
>>>>> Users can determine the one who calculate csum, hardware or software.
>>>>>
>>>>>         ethtool -K eth0 rx-checksum off
>>>>>         ethtool -K eth0 tx-checksum-ip-generic off
>>>>>
>>>>> What's more, there's some network features that may cause hardware
>>>>> checksum not work, like gso ( not so sure). Which means, the software
>>>>> checksum has its existing meaning.
>>>>>
>>>> This does not make any sense to me. Segmentation offload relies on the
>>>> hardware generating the actual packets, and I don't see how it would
>>>> be able to do that if it cannot generate the checksum as well.
>>> I test on my platform of  IP-forward scenery.  The network card has checksum capability.
>>> The hardware do checksum when gro feature is off. However, checksum is done by
>>> software when gro is on. In this sceney, do_csum function has 60% percentage of CPU load
>>> and the performance decreases 20% due to software checksum.
>>>
>>> The command I use is
>>>         ethtool -K eth0 gro off
>>>
>> But this is about IP forwarding, right? So GRO is enabled, which means
>> the packets are combined at the rx side. So does this mean the kernel
>> always recalculates the checksum in software in this case? Or only for
>> forwarded packets, where I would expect the outgoing interface to
>> recalculate the checksum if TX checksum offload is enabled.
> OK, after digging into this a bit more (with the help of Ilias -
> thanks!), I agree that there may be cases where we still rely on
> software IP checksumming even when using offload capable hardware. So
> I also agree that it makes sense to provide an optimized
> implementation for arm64.
>
> However, I am not yet convinced that a SIMD implementation is worth
> the hassle. I did some background reading [0] and came up with a
> scalar arm64 assembler implementation [1] that is almost as fast on
> Cortex-A57, and so I would like to get a feeling for how it performs
> on other micro-architectures. (Do note that the code has not been
> tested on big endian yet.)
>
> Lingyan, could you please compare the scalar performance with the NEON
> performance on your CPU? Thanks.
OK, I'll test it on my CPU. The experimental platform should be built again.
I will inform you as soon as I get the results.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
