Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAD9C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:23:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D4F720821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OasF7ewB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D4F720821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FD5Gha+airGeU6rHwzpMIGvn0P6iai3bKH41Fkoiar8=; b=OasF7ewBw08M74+zGiMyeff5a
	U0+NdfcTxvttDy4oFwcArMf1uq6P/2YxLgUV3bOIQ23bevNJWBXVaTGsT9Y6GYy3ZJUm1fVluDHzy
	R7ILmorncggwmrnDkUByINDdnKiMxyXdGHZZSz7d4C5u1DyST9ICAi8j6oiMY1DskZuRPvIG1N5oK
	Tc1eMnHyRvuy9PbDR6xM2xa27aesSYg2HBbRNXaUFC2OK+tmd40ryxgg5OW9oDNVP9dvlBQcShOVd
	2s9ub7SBAJvTwGegK+a+LLoQBiv47lXdW55tAmUrxh1G7QFjst0Uw63nzMLmVT7EQQM2lEPKaz5xB
	4Mvg3Kggg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt8jt-0000uP-GN; Mon, 11 Feb 2019 10:23:01 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt8jk-0000tl-R5
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 10:22:59 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9204BA78;
 Mon, 11 Feb 2019 02:22:44 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6B0B3F557;
 Mon, 11 Feb 2019 02:22:42 -0800 (PST)
Subject: Re: [PATCH/RFC] driver core: Postpone DMA tear-down until after
 devres release
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <20190207193653.18221-1-geert+renesas@glider.be>
 <20190208164019.GY32526@8bytes.org>
 <fa781547-7fa8-cb1a-50bd-d18351c02afd@arm.com>
 <CAMuHMdV6T8EsLZaiM-=M=fRPuDXt05aXg6egmMBr6Sc9V39iKA@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <6e64e564-aa6c-4193-1f57-ebf88d6932d5@arm.com>
Date: Mon, 11 Feb 2019 10:22:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdV6T8EsLZaiM-=M=fRPuDXt05aXg6egmMBr6Sc9V39iKA@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_022252_880900_65DD2B9D 
X-CRM114-Status: GOOD (  24.33  )
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
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 08/02/2019 18:55, Geert Uytterhoeven wrote:
> Hi Robin,
> 
> On Fri, Feb 8, 2019 at 6:55 PM Robin Murphy <robin.murphy@arm.com> wrote:
>> On 08/02/2019 16:40, Joerg Roedel wrote:
>>> On Thu, Feb 07, 2019 at 08:36:53PM +0100, Geert Uytterhoeven wrote:
>>>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>>>> index 8ac10af17c0043a3..d62487d024559620 100644
>>>> --- a/drivers/base/dd.c
>>>> +++ b/drivers/base/dd.c
>>>> @@ -968,9 +968,9 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>>>>                       drv->remove(dev);
>>>>
>>>>               device_links_driver_cleanup(dev);
>>>> -            arch_teardown_dma_ops(dev);
>>>>
>>>>               devres_release_all(dev);
>>>> +            arch_teardown_dma_ops(dev);
>>>>               dev->driver = NULL;
>>>>               dev_set_drvdata(dev, NULL);
>>>>               if (dev->pm_domain && dev->pm_domain->dismiss)
>>>
>>> Thanks for the fix! Should it also be tagged for stable and get a Fixes
> 
> FTR, Greg has added it to driver-core-testing, with a CC to stable.

So I see, great!

>>> tag? I know it only triggers with a fix in v5.0-rc, but still...
>>
>> I think so:
>>
>> Fixes: 09515ef5ddad ("of/acpi: Configure dma operations at probe time
>> for platform/amba/pci bus devices")
> 
> Thanks! It won't backport cleanly due to commit dc3c05504d38849f
> ("dma-mapping: remove dma_deconfigure") in v4.20, though.

Ah yes - backports beyond that should simply be a case of moving the 
dma_deconfigure() wrapper in the same manner.

Thanks,
Robin.

>> There aren't many drivers using dmam_alloc_*(), let alone which would
>> also find themselves behind an IOMMU on an Arm system, but it turns out
>> I actually have another one which can reproduce the BUG() with 5.0-rc.
> 
> SATA core uses dmam_alloc_*().
> 
>> I've tried a 4.12 kernel with a bit of instrumentation[1] and sure
>> enough the devres-managed buffer is freed with the wrong ops[2] even
>> then. How it manages not to blow up more catastrophically I have no
>> idea... I guess at best it just leaks the buffers and IOMMU mappings,
>> and at worst quietly frees random other pages instead.
> 
> May depend on the actual ops, and whether CMA is used or not.
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
