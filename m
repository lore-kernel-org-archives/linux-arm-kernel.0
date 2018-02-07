From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 7 Feb 2018 13:07:53 +0000
Subject: [PATCH 2/5] drivers/bus: Split Arm CCI driver
In-Reply-To: <87shadgfam.fsf@e105922-lin.cambridge.arm.com>
References: <cover.1517855839.git.robin.murphy@arm.com>
 <1660c838bafffb0b1a0d48823bc88c701adf01e4.1517855839.git.robin.murphy@arm.com>
 <87shadgfam.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <f62d3a76-9ee0-43a5-c585-fcebce52e800@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Punit,

On 07/02/18 12:22, Punit Agrawal wrote:
[...]
>>   
>> -static void __iomem *cci_ctrl_base;
>> +void __iomem *cci_ctrl_base __ro_after_init;
> 
> Initially I wondered if cci_ctrl_base gets used in the pmu driver before
> it's initialised. But as it gets set in early_initcall() that looks to
> be fine.

In fact it's even more robust than initcall ordering, since the PMU 
device will only be created at all via cci_platform_probe(), thus 
cci_init() is guaranteed to have run successfully before the PMU driver 
probe can ever touch anything.

> Also, I wonder if it's worth adding a comment here to highlight that the
> value is used in the CCI pmu driver. If not anything it'll prevent
> trivial patches trying to _fix_ it.

That's a good point; it should be relatively straightforward to make the 
PMU driver modular after this split, at which point this should need 
exporting anyway, but in the meantime a comment to ward off the static 
checkers is a very good idea.

> Either ways, for this and the other CCI patches in the series -
> 
> Acked-by: Punit Agrawal <punit.agrawal@arm.com>

Thanks!

Robin.
