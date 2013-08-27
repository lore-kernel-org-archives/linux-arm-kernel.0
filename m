From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 28 Aug 2013 00:09:24 +0200
Subject: [PATCH RFC v2 13/16] ARM: tegra: split tegra_pmc_init() in two
In-Reply-To: <521D214C.80809@wwwdotorg.org>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1377638890-371-14-git-send-email-sebastian.hesselbarth@gmail.com>
 <521D214C.80809@wwwdotorg.org>
Message-ID: <521D2394.7030005@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/13 23:59, Stephen Warren wrote:
> On 08/27/2013 03:28 PM, Sebastian Hesselbarth wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> Tegra's board file currently initializes clocks much earlier than those
>> for most other ARM SoCs. The reason is:
>>
>> * The PMC HW block is involved in the path of some interrupts (i.e. it
>> inverts, or not, the IRQ input pin dedicated to the PMIC).
>>
>> * So, that part of the PMC must be initialized early so that the IRQ
>> polarity is correct.
>>
>> * The PMC initialization is currently monolithic, and the PMC has some
>> clock inputs, so the init routine ends up calling of_clk_get_by_name(),
>> and hence clocks must be set up early too.
>>
>> In order to defer clock initialization to the more typical location,
>> split out the portions of tegra_pmc_init() that are truly IRQ-related
>> into a separate tegra_pmc_init_irq(), which can be called from the
>> machine descriptor's .init_irq() function, and defer the rest until
>> the machine descriptor's .init_machine() function. With arch/arm calling
>> of_clk_init(NULL) from time_init() this also allows the removal of
>> .init_time() hook.
>>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> ---
>> Changelog:
>> v1->v2:
>> - took Stephen Warren's patch provided to separate Tegra's pmc_init
>> - sqashed in .init_time removal and reworded patch text
>
> I think it'd be better to keep the 2 patches separate so the two logical
> changes are in different patches. I suppose it isn't a huge deal though.
>
> Either way, on this patch, your S-o-b line is missing above.

Stephen,

I was already wondering here, if I should separate the patches into 
preparation and actual removal. I put that question into the cover
letter and removed it from this patch text ;)

As you suggest to use preparation/removal, I will take that approach
for the final patch set. Will take you original unmodified patch then.

Sebastian
