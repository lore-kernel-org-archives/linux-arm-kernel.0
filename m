From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 25 Sep 2012 13:16:40 -0700
Subject: [PATCH 03/10] msm: iommu: Convert to clk_prepare/unprepare
In-Reply-To: <5060DF7D.9000305@codeaurora.org>
References: <1348194419-11486-1-git-send-email-sboyd@codeaurora.org>
 <1348194419-11486-4-git-send-email-sboyd@codeaurora.org>
 <5060DF7D.9000305@codeaurora.org>
Message-ID: <50621128.5040805@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/12 15:32, Saravana Kannan wrote:
>> @@ -275,8 +275,11 @@ static int msm_iommu_remove(struct
>> platform_device *pdev)
>>
>>       drv = platform_get_drvdata(pdev);
>>       if (drv) {
>> -        if (drv->clk)
>> +        if (drv->clk) {
>> +            clk_unprepare(drv->clk);
>>               clk_put(drv->clk);
>> +        }
>> +        clk_unprepare(drv->pclk);
>
>
> Are these changes right? Every other clk API change in this patch is
> using the combined prepare_enable/disable_unprepare() calls. So, when
> would we end up at this location with the clocks prepared but not
> enabled?
>
> Also, what if the device gets probed and then immediately removed.
> Will it work correctly?
>

It should work correctly. If you look at the bottom of msm_iommu_probe()
you see that it call clk_disable() and doesn't unprepare the clock. So
if the driver is unbound the clocks should be disabled but still prepared.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
