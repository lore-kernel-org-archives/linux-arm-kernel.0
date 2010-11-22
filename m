From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Mon, 22 Nov 2010 15:54:22 -0800
Subject: [PATCH 2/3] msm: iommu: Clock control for the IOMMU driver
In-Reply-To: <1290468761.4258.26.camel@m0nster>
References: <1290222154-11096-1-git-send-email-stepanm@codeaurora.org>	
	<1290222154-11096-3-git-send-email-stepanm@codeaurora.org>
	<1290468761.4258.26.camel@m0nster>
Message-ID: <4CEB02AE.4060509@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/2010 3:32 PM, Daniel Walker wrote:
> On Fri, 2010-11-19 at 19:02 -0800, Stepan Moskovchenko wrote:
>> +	int ret;
>> +
>> +	ret = clk_enable(drvdata->pclk);
> You don't need to check if pclk is null ?
>
Nope. If we are here, the pclk will always be non-null, which is 
something that may not necessarily be said for for AXI clock.

>>   		iommu_drvdata = dev_get_drvdata(ctx_drvdata->pdev->dev.parent);
>> +		if (!iommu_drvdata)
>> +			BUG();
> Just do,
>
> BUG_ON(!iommu_drvdata);
Will fix in v2.

>> -	__flush_iotlb(domain);
>> +	ret = __flush_iotlb(domain);
> What the relationship between this __flush_iotlb() and turning the
> clocks on/off.
>
The flush_iotlb function needs to handle clock control as well, which 
means it can now fail. As a result, we now need to check its return 
value, instead of assuming it succeeded.
>> -	pr_err("===== WOAH! =====\n");
> Cleanup right? It doesn't need it's own patch, but you could mention in
> the description that you've done "minor cleanups" or something to that
> effect.
>
Will fix in v2.
