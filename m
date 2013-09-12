From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 12 Sep 2013 10:32:23 -0600
Subject: [PATCH RFC v2 13/16] ARM: tegra: split tegra_pmc_init() in two
In-Reply-To: <52315D84.10703@gmail.com>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1377638890-371-14-git-send-email-sebastian.hesselbarth@gmail.com>
 <5230CAF7.6010103@wwwdotorg.org> <52315D84.10703@gmail.com>
Message-ID: <5231EC97.2060901@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2013 12:21 AM, Sebastian Hesselbarth wrote:
> On 09/11/2013 09:56 PM, Stephen Warren wrote:
>> On 08/27/2013 03:28 PM, Sebastian Hesselbarth wrote:
>>> From: Stephen Warren <swarren@nvidia.com>
>>>
>>> Tegra's board file currently initializes clocks much earlier than those
>>> for most other ARM SoCs. The reason is:
>>>
>>> * The PMC HW block is involved in the path of some interrupts (i.e. it
>>> inverts, or not, the IRQ input pin dedicated to the PMIC).
>>>
>>> * So, that part of the PMC must be initialized early so that the IRQ
>>> polarity is correct.
>>>
>>> * The PMC initialization is currently monolithic, and the PMC has some
>>> clock inputs, so the init routine ends up calling of_clk_get_by_name(),
>>> and hence clocks must be set up early too.
>>>
>>> In order to defer clock initialization to the more typical location,
>>> split out the portions of tegra_pmc_init() that are truly IRQ-related
>>> into a separate tegra_pmc_init_irq(), which can be called from the
>>> machine descriptor's .init_irq() function, and defer the rest until
>>> the machine descriptor's .init_machine() function. With arch/arm calling
>>> of_clk_init(NULL) from time_init() this also allows the removal of
>>> .init_time() hook.
>>
>> Sebastian, I assume you're targeting v3.13 or later for this patch
>> series? If so, it might be a good idea if I apply this patch myself to
>> the Tegra tree so that I can base any future Tegra patches on top of it
>> to avoid any possible conflicts. I can put this patch first in the
>> cleanup branch so you can merge it into whatever tree you use for the
>> rest of this series. Does that work for you? If so, let me know. Thanks.
> 
> Yes, I was waiting for v3.12-rc1 to drop to have something stable with
> the new machs inside. I haven't made up my mind who will finally take
> the patches but I guess it's either arm-soc or each individual
> maintainer.

OK, I'll take this one patch through the Tegra tree, making sure it's
first and based on v3.12-rc1, and I'll create a tag for you to pull into
your branch as needed.

> Currently, the patch set includes your original patch and another one to
> remove .init_time when the arch-wide default callback is available. If
> you want to take it now, I can add the corresponding dependency to the
> cover letter and drop the patch from my set.

Sounds good. From memory, that second patch you mentioned can go through
any tree you want; I don't think it will cause any conflicts since it's
tiny.
