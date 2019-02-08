Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33ED7C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:55:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06A4420863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dOlUFFpL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A4420863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BYNMJHaU/dx6oUXBKKXQpiZeXbCrMoIM311G8tIIP8Q=; b=dOlUFFpLnP+JqUl6GpIGfVnq8
	WXlKbIy+CWleSZk2IFi/zgZZx7vFpDEYe+Xi/vVLBfIPqBPl4E4pBneNyukkZyzfiv9yBqxJcFufo
	5XUX2TPvyXoctJQZtd16F599d3blh40uGRJ1dnrtbsPbb+I1E4G21kfuBlmEuk5Eke9QX5L8RYHZx
	C4iKsxpLCzkLAkslpIzlSkyoSt/MGgqD8pc7QMKJNUZrXCGOvtGo9f3ZLez+OxJuwf1ktKLGv9vy9
	sbBsDD+kjQPzy+0woN0i83EOvgzvJxLFT4xbwpHd819/DV9RyDJM93UZvnce5dD76DjJdlZDW0/KO
	zJ3G+r8QA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsANH-0007zI-DW; Fri, 08 Feb 2019 17:55:39 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsANE-0007yu-5S
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 17:55:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 352B680D;
 Fri,  8 Feb 2019 09:55:35 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 896003F719;
 Fri,  8 Feb 2019 09:55:33 -0800 (PST)
Subject: Re: [PATCH/RFC] driver core: Postpone DMA tear-down until after
 devres release
To: Joerg Roedel <joro@8bytes.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>
References: <20190207193653.18221-1-geert+renesas@glider.be>
 <20190208164019.GY32526@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <fa781547-7fa8-cb1a-50bd-d18351c02afd@arm.com>
Date: Fri, 8 Feb 2019 17:55:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190208164019.GY32526@8bytes.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_095536_211925_174101C9 
X-CRM114-Status: GOOD (  21.44  )
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
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 08/02/2019 16:40, Joerg Roedel wrote:
> Hi Geert,
> 
> On Thu, Feb 07, 2019 at 08:36:53PM +0100, Geert Uytterhoeven wrote:
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index 8ac10af17c0043a3..d62487d024559620 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -968,9 +968,9 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>>   			drv->remove(dev);
>>   
>>   		device_links_driver_cleanup(dev);
>> -		arch_teardown_dma_ops(dev);
>>   
>>   		devres_release_all(dev);
>> +		arch_teardown_dma_ops(dev);
>>   		dev->driver = NULL;
>>   		dev_set_drvdata(dev, NULL);
>>   		if (dev->pm_domain && dev->pm_domain->dismiss)
> 
> Thanks for the fix! Should it also be tagged for stable and get a Fixes
> tag? I know it only triggers with a fix in v5.0-rc, but still...

I think so:

Fixes: 09515ef5ddad ("of/acpi: Configure dma operations at probe time 
for platform/amba/pci bus devices")

There aren't many drivers using dmam_alloc_*(), let alone which would 
also find themselves behind an IOMMU on an Arm system, but it turns out 
I actually have another one which can reproduce the BUG() with 5.0-rc.

I've tried a 4.12 kernel with a bit of instrumentation[1] and sure 
enough the devres-managed buffer is freed with the wrong ops[2] even 
then. How it manages not to blow up more catastrophically I have no 
idea... I guess at best it just leaks the buffers and IOMMU mappings, 
and at worst quietly frees random other pages instead.

Robin.

--------------
[1]

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 4f3eecedca2d..f4dbaa5598e3 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -491,6 +491,7 @@ static inline void *dma_alloc_attrs(struct device 
*dev, size_t size,
  		return NULL;

  	cpu_addr = ops->alloc(dev, size, dma_handle, flag, attrs);
+	dev_info(dev, "alloc %lx %lx\n", (unsigned long)cpu_addr, (unsigned 
long)ops);
  	debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr);
  	return cpu_addr;
  }
@@ -512,6 +513,7 @@ static inline void dma_free_attrs(struct device 
*dev, size_t size,

  	debug_dma_free_coherent(dev, size, cpu_addr, dma_handle);
  	ops->free(dev, size, cpu_addr, dma_handle, attrs);
+	dev_info(dev, "free %lx %lx\n", (unsigned long)cpu_addr, (unsigned 
long)ops);
  }

  static inline void *dma_alloc_coherent(struct device *dev, size_t size,

-------------
[2]

/ # echo '0000:03:00.0' > /sys/bus/pci/drivers/sata_sil24/bind
[  107.417252] sata_sil24 0000:03:00.0: alloc ffff00000a6f9000 
ffff0000089b8090
[  107.424397] sata_sil24 0000:03:00.0: alloc ffff00000a719000 
ffff0000089b8090
[  107.432216] scsi host0: sata_sil24
[  107.436134] scsi host1: sata_sil24
[  107.439853] ata7: SATA max UDMA/100 host m128@0x50084000 port 
0x50080000 irq 51
[  107.447228] ata8: SATA max UDMA/100 host m128@0x50084000 port 
0x50082000 irq 51
/ # echo '0000:03:00.0' > /sys/bus/pci/drivers/sata_sil24/unbind
...
[  112.048654] sata_sil24 0000:03:00.0: free ffff00000a719000 
ffff0000089b8120
[  112.055579] sata_sil24 0000:03:00.0: free ffff00000a6f9000 
ffff0000089b8120

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
