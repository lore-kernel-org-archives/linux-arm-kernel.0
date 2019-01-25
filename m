Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B76CC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:13:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 137CF218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IghChXqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137CF218D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jAHOlUFFVtkkUJ9YCcpft4G1pTfUbJ3gASaVnJ0LpjQ=; b=IghChXqwOxOclW9ul/6XN25cB
	+019fIJpO+hhWZOwwYkQu2yaHmo0Cc3JBZr2tTQ1DkHgmn0A+5dFlll8sMHwwVPTHUU/H/vFwAg0v
	KQDZWx1KdR7o54VbizK5zYPTFUuyaSW4S9To/xwqm50S5P2y6kfEc32BwWOs9t50wf1kE4eBL07+G
	SeoPmy++R0cOv/7sL+bNHxX9t/qJ/SSLECPnF2ZNJt7fM5QAbO7qZnep/qKpiOgSW6b1DsCwKWrp3
	vXOFU9K0PzZVQZdwd7T0x7zsANsZvnha3fJZTVkJyOFe+DNWqEZMwwEzhqh6DlM6WBVDtLNOIcI2t
	c9wOq9PKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn46D-0005DX-Rk; Fri, 25 Jan 2019 16:12:57 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn46B-0005DA-08
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 16:12:56 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 263DEA78;
 Fri, 25 Jan 2019 08:12:54 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDAF93F5AF;
 Fri, 25 Jan 2019 08:12:51 -0800 (PST)
Subject: Re: [PATCH v5 3/4] perf/smmuv3: Add MSI irq support
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 lorenzo.pieralisi@arm.com
References: <20181130154751.28580-1-shameerali.kolothum.thodi@huawei.com>
 <20181130154751.28580-4-shameerali.kolothum.thodi@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <232c64b8-f445-7420-275c-6f47bb13690b@arm.com>
Date: Fri, 25 Jan 2019 16:12:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130154751.28580-4-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_081255_053049_01FB2E2A 
X-CRM114-Status: GOOD (  21.85  )
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
Cc: mark.rutland@arm.com, vkilari@codeaurora.org, neil.m.leeder@gmail.com,
 jean-philippe.brucker@arm.com, pabba@codeaurora.org, john.garry@huawei.com,
 will.deacon@arm.com, rruigrok@codeaurora.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, guohanjun@huawei.com,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 30/11/2018 15:47, Shameer Kolothum wrote:
> This adds support for MSI-based counter overflow interrupt.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   drivers/perf/arm_smmuv3_pmu.c | 58 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 58 insertions(+)
> 
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index fb9dcd8..71d10a0 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -68,6 +68,7 @@
>   #define SMMU_PMCG_OVSSET0               0xCC0
>   #define SMMU_PMCG_CFGR                  0xE00
>   #define SMMU_PMCG_CFGR_RELOC_CTRS       BIT(20)
> +#define SMMU_PMCG_CFGR_MSI              BIT(21)
>   #define SMMU_PMCG_CFGR_SID_FILTER_TYPE  BIT(23)

Nit: Ah, clearly I missed the genesis in patch #2, but it would be nice 
to have these guys in the usual descending order.

Otherwise,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   #define SMMU_PMCG_CFGR_SIZE_MASK        GENMASK(13, 8)
>   #define SMMU_PMCG_CFGR_NCTR_MASK        GENMASK(5, 0)
> @@ -78,6 +79,12 @@
>   #define SMMU_PMCG_IRQ_CTRL              0xE50
>   #define SMMU_PMCG_IRQ_CTRL_IRQEN        BIT(0)
>   #define SMMU_PMCG_IRQ_CFG0              0xE58
> +#define SMMU_PMCG_IRQ_CFG1              0xE60
> +#define SMMU_PMCG_IRQ_CFG2              0xE64
> +
> +/* MSI config fields */
> +#define MSI_CFG0_ADDR_MASK              GENMASK_ULL(51, 2)
> +#define MSI_CFG2_MEMATTR_DEVICE_nGnRE   0x1
>   
>   #define SMMU_DEFAULT_FILTER_SPAN        1
>   #define SMMU_DEFAULT_FILTER_STREAM_ID   GENMASK(31, 0)
> @@ -587,11 +594,62 @@ static irqreturn_t smmu_pmu_handle_irq(int irq_num, void *data)
>   	return IRQ_HANDLED;
>   }
>   
> +static void smmu_pmu_free_msis(void *data)
> +{
> +	struct device *dev = data;
> +
> +	platform_msi_domain_free_irqs(dev);
> +}
> +
> +static void smmu_pmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> +{
> +	phys_addr_t doorbell;
> +	struct device *dev = msi_desc_to_dev(desc);
> +	struct smmu_pmu *pmu = dev_get_drvdata(dev);
> +
> +	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
> +	doorbell &= MSI_CFG0_ADDR_MASK;
> +
> +	writeq_relaxed(doorbell, pmu->reg_base + SMMU_PMCG_IRQ_CFG0);
> +	writel_relaxed(msg->data, pmu->reg_base + SMMU_PMCG_IRQ_CFG1);
> +	writel_relaxed(MSI_CFG2_MEMATTR_DEVICE_nGnRE,
> +		       pmu->reg_base + SMMU_PMCG_IRQ_CFG2);
> +}
> +
> +static void smmu_pmu_setup_msi(struct smmu_pmu *pmu)
> +{
> +	struct msi_desc *desc;
> +	struct device *dev = pmu->dev;
> +	int ret;
> +
> +	/* Clear MSI address reg */
> +	writeq_relaxed(0, pmu->reg_base + SMMU_PMCG_IRQ_CFG0);
> +
> +	/* MSI supported or not */
> +	if (!(readl(pmu->reg_base + SMMU_PMCG_CFGR) & SMMU_PMCG_CFGR_MSI))
> +		return;
> +
> +	ret = platform_msi_domain_alloc_irqs(dev, 1, smmu_pmu_write_msi_msg);
> +	if (ret) {
> +		dev_warn(dev, "failed to allocate MSIs\n");
> +		return;
> +	}
> +
> +	desc = first_msi_entry(dev);
> +	if (desc)
> +		pmu->irq = desc->irq;
> +
> +	/* Add callback to free MSIs on teardown */
> +	devm_add_action(dev, smmu_pmu_free_msis, dev);
> +}
> +
>   static int smmu_pmu_setup_irq(struct smmu_pmu *pmu)
>   {
>   	unsigned long flags = IRQF_NOBALANCING | IRQF_SHARED | IRQF_NO_THREAD;
>   	int irq, ret = -ENXIO;
>   
> +	smmu_pmu_setup_msi(pmu);
> +
>   	irq = pmu->irq;
>   	if (irq)
>   		ret = devm_request_irq(pmu->dev, irq, smmu_pmu_handle_irq,
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
