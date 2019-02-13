Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE679C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:12:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 965FB2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GxqOLfoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965FB2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4aovx+aLKLy7Oqls5NN7uP3ND0RvyrWdmP65NYQyYb8=; b=GxqOLfoF7YLHCw
	vX0hG63mTIuOTeqg+K7ELA5Oma6Lb/7iLS/sNgZ5L5CNTuvIy3uFZwcZktVPEt/fueCH5wb+xtRAv
	3RUq89AzkXlBpWdvjMWKrlS3nDxUAiOVM3tP9qd6JhfgGqKSf1IFNTmLsKeP8jImLqI60FmdrnhnI
	2wa+Cx4ZXFveiHm554bmhP5mpPHZUVDpe1bVy/VeXvIXPKgcxYWwLOqmBDhKTmkmCeSenrp2rm1zS
	sbWCUC6HAjMu8hBekRRbSrSIwPhoOObkoER33k9YJ635OZo5nIBrnia//9Uq8PgGGdZMfrxmgDaVJ
	GUR/EViBmo0RVf4W22XA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gty5T-0002S1-3r; Wed, 13 Feb 2019 17:12:43 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gty5P-0002RK-LL
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 17:12:41 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id F0599B157;
 Wed, 13 Feb 2019 17:12:36 +0000 (UTC)
Subject: Re: [PATCH v6 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
To: Andrew Morton <akpm@linux-foundation.org>
References: <20181210011504.122604-1-drinkcat@chromium.org>
 <CANMq1KAmFKpcxi49wJyfP4N01A80B2d-2RGY2Wrwg0BvaFxAxg@mail.gmail.com>
 <20190111102155.in5rctq5krs4ewfi@8bytes.org>
 <CANMq1KCq7wEYXKLZGCZczZ_yQrmK=MkHbUXESKhHnx5G_CMNVg@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <789fb2e6-0d80-b6de-adf3-57180a50ec3e@suse.cz>
Date: Wed, 13 Feb 2019 18:12:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CANMq1KCq7wEYXKLZGCZczZ_yQrmK=MkHbUXESKhHnx5G_CMNVg@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_091239_847883_B103D848 
X-CRM114-Status: GOOD (  14.95  )
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
Cc: Michal Hocko <mhocko@suse.com>, Will Deacon <will.deacon@arm.com>,
 Levin Alexander <Alexander.Levin@microsoft.com>, linux-mm@kvack.org,
 Christoph Lameter <cl@linux.com>, Nicolas Boichat <drinkcat@chromium.org>,
 Huaisheng Ye <yehs1@lenovo.com>, Joerg Roedel <joro@8bytes.org>,
 Matthew Wilcox <willy@infradead.org>, hch@infradead.org,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 David Rientjes <rientjes@google.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>,
 Tomasz Figa <tfiga@google.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Hsin-Yi Wang <hsinyi@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Yong Wu <yong.wu@mediatek.com>, Robin Murphy <robin.murphy@arm.com>,
 lkml <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
 Pekka Enberg <penberg@kernel.org>, iommu@lists.linux-foundation.org,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/22/19 11:51 PM, Nicolas Boichat wrote:
> Hi Andrew,
> 
> On Fri, Jan 11, 2019 at 6:21 PM Joerg Roedel <joro@8bytes.org> wrote:
>>
>> On Wed, Jan 02, 2019 at 01:51:45PM +0800, Nicolas Boichat wrote:
>> > Does anyone have any further comment on this series? If not, which
>> > maintainer is going to pick this up? I assume Andrew Morton?
>>
>> Probably, yes. I don't like to carry the mm-changes in iommu-tree, so
>> this should go through mm.
> 
> Gentle ping on this series, it seems like it's better if it goes
> through your tree.
> 
> Series still applies cleanly on linux-next, but I'm happy to resend if
> that helps.

Ping, Andrew?

> Thanks!
> 
>> Regards,
>>
>>         Joerg
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
