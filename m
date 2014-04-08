From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 8 Apr 2014 10:46:06 +0800
Subject: L2 cache suspend/resume
In-Reply-To: <5342C5C9.8010904@wwwdotorg.org>
References: <20140405112700.GJ7528@n2100.arm.linux.org.uk>
 <5342C5C9.8010904@wwwdotorg.org>
Message-ID: <534362EE.9060803@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 04/07/2014 11:35 PM, Stephen Warren wrote:
> On 04/05/2014 05:27 AM, Russell King - ARM Linux wrote:
>> While looking through the L2 resume code paths, I notice that:
>>
>>   * exynos
>>   * imx
>>   * tegra
>>
>> all resume their L2 caches from assembly code, rather than using
>> outer_disable() before cpu_suspend(), and outer_resume() afterwards.
>>  From what I can see, these are all running in the secure world, so that
>> isn't the reason.
>>
>> What is the reason for this difference?  Can these three be converted to
>> the outer_disable()...outer_resume() method?
> Joseph, Peter, can you please comment on this. Thanks.
For Tegra, the L2 RAM were not in the same power domain as CPU cluster. 
We retain the L2 data across the CPU cluster power down state and only 
restore the L2 controller before MMU got enabled in the resume flow.

And read the other mail from Russell that add these support into common 
code, that's nice for us too. We don't need to separate the same code 
for different SoCs that needs the same method. :)

-Joseph
