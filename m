Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B40C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:42:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC4F02177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t1PcBZvp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC4F02177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AspUotceKszlAwhpBLet0PGW1GGecDcSXpDmb4AtC6g=; b=t1PcBZvpxTTIUgBvpcukaEGW0
	cvkXQSKNnLuGcX1yGZhPPTfGsxm3U0isNDVfifQ6eSTGqFLExTj3NGD24srRMSjx6jqvd+m0PHMRH
	VgjHtieTkbVC5J+fV6DTUWz9yqAOzE/ccz8IJpPZXpGDhz39cW56H2wOH5iCjxhz5XzhnTlE4y6kK
	ozND3qSp83TarIAzm89KC1LJR0N4+5MCkO3liQzH2wjOmbAbsKv1bjXSTVAtyByUCi4LW52Qlz01u
	wp3oDKBy8eKdZ9nJM6ryxG4YVn7xKZAeWToSiBg6TV+0EiMp5UVdFXWiY1Tvp/EdnYB14fRIGYUEB
	vqbPnqyAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghtKo-0003uA-LO; Fri, 11 Jan 2019 09:42:38 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghtKl-0003tD-QF
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 09:42:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB7BEEBD;
 Fri, 11 Jan 2019 01:42:32 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 372233F694;
 Fri, 11 Jan 2019 01:42:31 -0800 (PST)
Subject: Re: [PATCH v3] irqchip: gicv3-its: Use NUMA aware memory allocation
 for ITS tables
To: shameerali.kolothum.thodi@huawei.com, marc.zyngier@arm.com,
 linux-kernel@vger.kernel.org
References: <20181213105924.30384-1-shameerali.kolothum.thodi@huawei.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <9046beb6-36e7-8890-5d09-fc03b6d2728c@arm.com>
Date: Fri, 11 Jan 2019 09:42:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213105924.30384-1-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_014235_857329_5439913D 
X-CRM114-Status: GOOD (  23.14  )
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
Cc: john.garry@huawei.com, linuxarm@huawei.com, Robert.Richter@cavium.com,
 shankerd@codeaurora.org, guohanjun@huawei.com,
 linux-arm-kernel@lists.infradead.org, ganapatrao.kulkarni@cavium.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Shameer,

On 13/12/2018 10:59, Shameer Kolothum wrote:
> From: Shanker Donthineni <shankerd@codeaurora.org>
> 
> The NUMA node information is visible to ITS driver but not being used
> other than handling hardware errata. ITS/GICR hardware accesses to the
> local NUMA node is usually quicker than the remote NUMA node. How slow
> the remote NUMA accesses are depends on the implementation details.
> 
> This patch allocates memory for ITS management tables and command
> queue from the corresponding NUMA node using the appropriate NUMA
> aware functions. This change improves the performance of the ITS
> tables read latency on systems where it has more than one ITS block,
> and with the slower inter node accesses.
> 
> Apache Web server benchmarking using ab tool on a HiSilicon D06
> board with multiple numa mem nodes shows Time per request and
> Transfer rate improvements of ~3.6% with this patch.
> 
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
> 
> This is to revive the patch originally sent by Shanker[1] and
> to back it up with a benchmark test. Any further testing of
> this is most welcome.
> 
> v2-->v3
>   -Addressed comments to use page_address().
>   -Added Benchmark results to commit log.
>   -Removed T-by from Ganapatrao for now.
> 
> v1-->v2
>   -Edited commit text.
>   -Added Ganapatrao's tested-by.
> 
> Benchmark test details:
> --------------------------------
> Test Setup:
> -D06 with dimm on node 0(Sock#0) and 3 (Sock#1).
> -ITS belongs to numa node 0.
> -Filesystem mounted on a PCIe NVMe based disk.
> -Apache server installed on D06.
> -Running ab benchmark test in concurrency mode from a remote m/c
>   connected to D06 via  hns3(PCIe) n/w port.
>   "ab -k -c 750 -n 2000000 http://10.202.225.188/"
> 
> Test results are avg. of 15 runs.
> 
> For 4.20-rc1  Kernel,
> ----------------------------
> Time per request(mean, concurrent)  = 0.02753[ms]
> Transfer Rate = 416501[Kbytes/sec]
> 
> For 4.20-rc1 +  this patch,
> ----------------------------------
> Time per request(mean, concurrent)  = 0.02653[ms]
> Transfer Rate = 431954[Kbytes/sec]
> 
> % improvement ~3.6%
> 
> vmstat shows around 170K-200K interrupts per second.
> 
> ~# vmstat 1 -w
> procs -----------------------memory-- -  -system--
>   r  b         swpd         free            in
>   5  0            0     30166724          102794
>   9  0            0     30141828          171148
>   5  0            0     30150160          207185
> 13  0            0     30145924          175691
> 15  0            0     30140792          145250
> 13  0            0     30135556          201879
> 13  0            0     30134864          192391
> 10  0            0     30133632          168880
> ....
> 
> [1] https://patchwork.kernel.org/patch/9833339/
> 
>   drivers/irqchip/irq-gic-v3-its.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index db20e99..ab01061 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1749,7 +1749,8 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
>   		order = get_order(GITS_BASER_PAGES_MAX * psz);
>   	}
>   
> -	base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> +	base = (void *)page_address(alloc_pages_node(its->numa_node,
> +				    GFP_KERNEL | __GFP_ZERO, order));

If alloc_pages_node() fails, the page_address() could crash the system.

> -	its->cmd_base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> -						get_order(ITS_CMD_QUEUE_SZ));
> +	its->cmd_base = (void *)page_address(alloc_pages_node(its->numa_node,
> +					     GFP_KERNEL | __GFP_ZERO,
> +					     get_order(ITS_CMD_QUEUE_SZ)));

Similarly here. We may want to handle it properly.

Cheers
Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
