Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367CBC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:56:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15DF62087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TBWYwhes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15DF62087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hYxRbmKk1h0+wO4UNOfyHpF6/kP64LvqzFOqnz1jleI=; b=TBWYwhesL46vIN
	yc6CMrsr/jFqhBokg0/9YCpzvXrjp9sDBZDDE2XBJ7KMhcitf1xZz6cyRDialCRdP5veYbUeTwVDu
	I8eSvHhGhZ4qQeuaoAjC8BQPJGkLlrDnvwBAYoVqXKDOas+eaQbk4KXRtRORwtqbB9s4oyczVTHJq
	IPAzkFfWDwZemi14jfk7cRtKxJn2RngMEwdfd1AVip63HXNwn3Eti/AKkeQ7cqw7t2nB4OqcyotC/
	1GYuKAdy7TsPN3iNhYxhn+YSW6T2Q8m4/e7MX3tWtUpDawGlxJlhp4PanQiT8xR+LanhzgWKeVh80
	OPEsdW1uE+67K9BdvzAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp88q-0000IK-Jx; Thu, 31 Jan 2019 08:56:12 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp88o-0000Ht-0L
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 08:56:11 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53C75A78;
 Thu, 31 Jan 2019 00:56:09 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D6FF3F589;
 Thu, 31 Jan 2019 00:56:06 -0800 (PST)
Subject: Re: [PATCH v9 01/26] arm64: Fix HCR.TGE status for NMI contexts
To: Christoffer Dall <christoffer.dall@arm.com>
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
 <1548084825-8803-2-git-send-email-julien.thierry@arm.com>
 <8e8c4f5b-5b83-7bbc-1b84-36d68e210968@arm.com>
 <847c54ef-ea41-eea5-8aff-72e0cea465f8@arm.com>
 <20190131081900.GM13482@e113682-lin.lund.arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <32af4a5c-7aeb-0171-1b4a-2cbee5f78bca@arm.com>
Date: Thu, 31 Jan 2019 08:56:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190131081900.GM13482@e113682-lin.lund.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_005610_047731_38A0DF5D 
X-CRM114-Status: GOOD (  13.32  )
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
Cc: mark.rutland@arm.com, linux-arch@vger.kernel.org,
 daniel.thompson@linaro.org, Arnd Bergmann <arnd@arndb.de>,
 marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 James Morse <james.morse@arm.com>, joel@joelfernandes.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 31/01/2019 08:19, Christoffer Dall wrote:
> On Mon, Jan 28, 2019 at 03:42:42PM +0000, Julien Thierry wrote:
>> Hi James,
>>
>> On 28/01/2019 11:48, James Morse wrote:
>>> Hi Julien,
>>>
>>> On 21/01/2019 15:33, Julien Thierry wrote:
>>>> When using VHE, the host needs to clear HCR_EL2.TGE bit in order
>>>> to interract with guest TLBs, switching from EL2&0 translation regime
>>>
>>> (interact)
>>>
>>>
>>>> to EL1&0.
>>>>
>>>> However, some non-maskable asynchronous event could happen while TGE is
>>>> cleared like SDEI. Because of this address translation operations
>>>> relying on EL2&0 translation regime could fail (tlb invalidation,
>>>> userspace access, ...).
>>>>
>>>> Fix this by properly setting HCR_EL2.TGE when entering NMI context and
>>>> clear it if necessary when returning to the interrupted context.
>>>
>>> Yes please. This would not have been fun to debug!
>>>
>>> Reviewed-by: James Morse <james.morse@arm.com>
>>>
>>>
>>
>> Thanks.
>>
>>>
>>> I was looking for why we need core code to do this, instead of updating the
>>> arch's call sites. Your 'irqdesc: Add domain handlers for NMIs' patch (pointed
>>> to from the cover letter) is the reason: core-code calls nmi_enter()/nmi_exit()
>>> itself.
>>>
>>
>> Yes, that's the main reason.
>>
> I wondered the same thing, but I don't understand the explanation :(
> 
> Why can't we do a local_daif_mask() around the (very small) calls that
> clear TGE instead?
> 

That would protect against the pseudo-NMIs, but you can still get an
SDEI at that point even with all daif bits set. Or did I misunderstand
how SDEI works?

Thanks,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
