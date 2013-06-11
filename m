From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Tue, 11 Jun 2013 13:01:05 +0530
Subject: [PATCH 3/3] clk: tegra: T114: add DFLL DVCO reset control
In-Reply-To: <alpine.DEB.2.02.1306071703050.7753@utopia.booyaka.com>
References: <20130607121505.21868.72360.stgit@dusk.lan>
 <20130607121901.21868.65416.stgit@dusk.lan> <51B21105.1080301@wwwdotorg.org>
 <alpine.DEB.2.02.1306071703050.7753@utopia.booyaka.com>
Message-ID: <51B6D239.5030905@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 June 2013 10:36 PM, Paul Walmsley wrote:
> Hi Stephen,
>
> On Fri, 7 Jun 2013, Stephen Warren wrote:
>
>> On 06/07/2013 06:19 AM, Paul Walmsley wrote:
>>> Add DFLL DVCO reset line control functions to the CAR IP block driver.
>>>
>>> The DVCO present in the DFLL IP block has a separate reset line,
>>> exposed via the CAR IP block.  This reset line is asserted upon SoC
>>> reset.  Unless something (such as the DFLL driver) deasserts this
>>> line, the DVCO will not oscillate, although reads and writes to the
>>> DFLL IP block will complete.
>>>
>>> Thanks to Aleksandr Frid <afrid@nvidia.com> for identifying this and
>>> saving hours of debugging time.
>>> diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
>>>   void tegra114_clock_tune_cpu_trimmers_high(void);
>>>   void tegra114_clock_tune_cpu_trimmers_low(void);
>>>   void tegra114_clock_tune_cpu_trimmers_init(void);
>>> +void tegra114_clock_assert_dfll_dvco_reset(void);
>>> +void tegra114_clock_deassert_dfll_dvco_reset(void);
>> Where/what is the code that will call these new APIs? If it's going to
>> be something in drivers/clk, that seems fine.
> That's correct - they'll be used by the DFLL clocksource code, which will
> live in drivers/clk/tegra.  You've seen the patches already ;-)

Why not implement these APIs in DFLL clock driver itself and pass RST 
address register to driver?

>> The reset assert/de-assert functions at least might be worth exposing
>> using the new generic module reset API. I believe Prashant Gaikwad is
>> working on converting the Tegra clock driver to be a module reset
>> provider, hence removing the existing custom
>> tegra_periph_reset_{de,}assert() APIs.
> OK, will take a look to see if this can be done without getting in the way
> of Prashant's work.  I'd na?vely assume that it might be best to convert
> these as part of his series - that way we won't duplicate effort.
>
> Prashant, what stage are you at in the conversion?  If you're close to
> completion, maybe we can just add this functionality in with your patches?
>

You can continue with this patch. I do not see any need to add this 
reset control to generic reset module.

> - Paul
