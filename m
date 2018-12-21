Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA76C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:53:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FC9721908
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q+0EbVq/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC9721908
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=75Z1MN9yLoPGGjD+5gMbM/nOC7uiBXqwBqpVB/3Hpro=; b=Q+0EbVq/hVK6wMJZQv7gJVsE90
	p9E1FSGGjOPzwBi+zXWTyEVHS1elh+ao3sPAv9dk8qHsTEPiISoEzBKCD8y2DA4ffBs6OnTJm2OS4
	iu36IweGwR8/aZwdzza7XXFz3inodw6rh13TYbq0rN3PSzfaPX5wiJUZIDjTmvgUKX0bKq7wdTDJV
	zzWPQnewHYiA7W+UtZ2GwRYEC6YLi/o1QSlf7F4Vl8WI8HChyhN60wnaLC/TYny8Dvj/n1mP2B6SN
	chj/wehol8KvrG7c9AcvI4V+dMKY+e6Ak4P3yTlWcQrVzjs+q0ZDkZ4AF1XSQf83uhsoKuT0ux53T
	fVPxAI6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaJNG-0000bZ-EI; Fri, 21 Dec 2018 11:53:50 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaJNC-0000b1-Sm
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 11:53:48 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 813811596;
 Fri, 21 Dec 2018 03:53:32 -0800 (PST)
Received: from [10.1.196.78] (ostrya.cambridge.arm.com [10.1.196.78])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 680813F5C0;
 Fri, 21 Dec 2018 03:53:31 -0800 (PST)
Subject: Re: question about broadcast invalidation and atc invalidation
To: Zhongmiao <zhongmiao@hisilicon.com>, Will Deacon <Will.Deacon@arm.com>,
 "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
 "Chengchuanning (Hisi-Turing)" <chengchuanning@hisilicon.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <e33aad8d-ab12-e1c7-0b8b-85fe09260270@hisilicon.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <fb76a20b-0ff4-d64e-4f9c-c160254b07ce@arm.com>
Date: Fri, 21 Dec 2018 11:53:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <e33aad8d-ab12-e1c7-0b8b-85fe09260270@hisilicon.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_035346_935051_4FFE1962 
X-CRM114-Status: GOOD (  13.08  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 21/12/2018 09:31, Zhongmiao wrote:
> Hi Jean:
> 	Now Soft need to make sure build atc inv cmd to smmu after Execute 
> "TLBI" (dvm sync). I don't think it's very reasonable. Why  Smmu The 
> smmu automatically sends the inv atc command when smmu receive 
> broadcast invalidation ?

I'd also like to see this done by hardware, but it's not
straightforward. I see two difficulties with turning broadcast TLBI into
ATC invalidation:

* TLBI uses VMID and ASID to target the TLB entries to invalidate, but
ATS uses RID and PASID. The SMMU would need to do a reverse lookup to
convert VMID:ASID into RID:PASID, and there may be multiple RID:PASID
pairs associated to one VMID:ASID.

* ATS flow control. Each endpoint has a limited number of in-flight ATC
invalidate requests. If the CPU is sending TLBI too fast, the SMMU would
have to buffer them or back-pressure the interconnect, while waiting for
in-flight ATC invalidate to complete.

So for the moment the architecture doesn't support this. We use MMU
notifiers to convert VMID:ASID into RID:PASID and wait for ATC
invalidation to complete.

Thanks,
Jean

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
