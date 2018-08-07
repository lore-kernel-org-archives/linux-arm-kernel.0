From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 7 Aug 2018 13:31:49 +0100
Subject: [PATCH 1/2] iommu/rockchip: Handle errors returned from PM
 framework
In-Reply-To: <2940317.dDZy1L4CDY@phil>
References: <20180807085406.3863-1-marc.zyngier@arm.com>
 <20180807085406.3863-2-marc.zyngier@arm.com> <2940317.dDZy1L4CDY@phil>
Message-ID: <94b6aab1-e8d3-6929-a2e6-2f06c564bc70@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/18 13:09, Heiko Stuebner wrote:
> Hi Marc,
> 
> Am Dienstag, 7. August 2018, 10:54:05 CEST schrieb Marc Zyngier:
>> pm_runtime_get_if_in_use can fail: either PM has been disabled
>> altogether (-EINVAL), or the device hasn't been enabled yet (0).
>> Sadly, the Rockchip IOMMU driver tends to conflate the two things
>> by considering a non-zero return value as successful.
>>
>> This has the consequence of hiding other bugs, so let's handle this
>> case throughout the driver, with a WARN_ON_ONCE so that we can try
>> and work out what happened.
>>
>> Fixes: 0f181d3cf7d98 ("iommu/rockchip: Add runtime PM support")
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> I'm still not sure about the !CONFIG_PM case, as it was probably silently
> working in that case before

Do we agree that this is an orthogonal problem though?

> 
> But on the other hand we're also already running over it in other places
> like in the iommu-shutdown and I guess if someone _really_ disabled
> CONFIG_PM, a lot of additional stuff would fail anyway.
> 
> So should we wrap that in some #ifdef magic, just ignore it or simply
> select PM similar to what Tegra, Renesas and Vexpress seem to do?
> 
> I guess I like the 3rd option best ;-)

It probably doesn't hurt. At what level do you want it? As a dependency
to the IOMMU? or to the platform?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
