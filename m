Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D8CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 06:45:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A028721773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 06:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zf/qk4bE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A028721773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RHsoYDj/NxmZI4UrVwMPHPQEV4VIy3eluxx37hr3GBQ=; b=Zf/qk4bENFppQqipurPAIt7Vk
	kr6MlzR28yhTQNnn7A6WAr9t3QePf2J5sOxxvohQj0ATFe5lMPBDuo/ARChP0Nq8Lt/YI1lX1c3lW
	2/HWpCEljUmM594M4lwUkhJipAlZRS0VZnQnvaA7SydX3EK8MtYzdYQDHKVmR+XSQPjv3NL0wBu98
	UOtDqI+Tg7z9p7qSX8AlWdZJbZXXNYLi5+YHfoJpDCnrMIMQxGNs9Ukbe+7FY7Lt4MGxZ68h8a7s7
	NzMOVKlyOPOrGX5iN2L/fUFywVT+2dJP3puNYjT/Ij2bhlKRdgF01DhW+xI1utfAOtIhZIHO9fi80
	eOX2J/+gw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbJzD-00053h-1J; Mon, 24 Dec 2018 06:45:11 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbJz9-0003nj-9w
 for linux-arm-kernel@lists.infradead.org; Mon, 24 Dec 2018 06:45:09 +0000
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 5DDA26467878B;
 Mon, 24 Dec 2018 14:44:48 +0800 (CST)
Received: from [127.0.0.1] (10.40.57.36) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Mon, 24 Dec 2018
 14:44:41 +0800
Subject: Re: question about broadcast invalidation and atc invalidation
To: Zhongmiao <zhongmiao@hisilicon.com>, "Liujunlong (June)"
 <Junlong.Liu@hisilicon.com>, Jean-Philippe Brucker
 <jean-philippe.brucker@arm.com>, Will Deacon <Will.Deacon@arm.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, <zhongmiao@huawei.com>
References: <e33aad8d-ab12-e1c7-0b8b-85fe09260270@hisilicon.com>
 <fb76a20b-0ff4-d64e-4f9c-c160254b07ce@arm.com>
 <8CD08B4737CACA4ABE0228F45E441A91638DE813@dggemm521-mbs.china.huawei.com>
From: Zhongmiao <zhongmiao@hisilicon.com>
Message-ID: <29168a05-815f-1dc4-abb7-61c273ce4fb4@hisilicon.com>
Date: Mon, 24 Dec 2018 14:44:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <8CD08B4737CACA4ABE0228F45E441A91638DE813@dggemm521-mbs.china.huawei.com>
X-Originating-IP: [10.40.57.36]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181223_224507_518673_853EFA6D 
X-CRM114-Status: GOOD (  12.67  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Jean:
On 2018/12/24 14:36, Zhongmiao wrote:
>
>
>
> Hi,
>
> On 21/12/2018 09:31, Zhongmiao wrote:
>> Hi Jean:
>> 	Now Soft need to make sure build atc inv cmd to smmu after Execute
>> "TLBI" (dvm sync). I don't think it's very reasonable. Why  Smmu The
>> smmu automatically sends the inv atc command when smmu receive
>> broadcast invalidation ?
>
> I'd also like to see this done by hardware, but it's not straightforward. I see two difficulties with turning broadcast TLBI into ATC invalidation:
>
> * TLBI uses VMID and ASID to target the TLB entries to invalidate, but ATS uses RID and PASID. The SMMU would need to do a reverse lookup to convert VMID:ASID into RID:PASID, and there may be multiple RID:PASID pairs associated to one VMID:ASID.
>
> * ATS flow control. Each endpoint has a limited number of in-flight ATC invalidate requests. If the CPU is sending TLBI too fast, the SMMU would have to buffer them or back-pressure the interconnect, while waiting for in-flight ATC invalidate to complete.
>
> So for the moment the architecture doesn't support this. We use MMU notifiers to convert VMID:ASID into RID:PASID and wait for ATC invalidation to complete.
>

I got it about this.But How does the software(application) know to go to 
invalidate remote ATC? This entry may not be cached at remote ATC.

> Thanks,
> Jean
>

Thanks,
Miao


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
