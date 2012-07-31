From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 31 Jul 2012 09:46:28 +0100
Subject: AB8500 Regulators
In-Reply-To: <20120730174831.GP4468@opensource.wolfsonmicro.com>
References: <501690F7.2010904@linaro.org>
 <20120730152618.GI4468@opensource.wolfsonmicro.com>
 <5016B70A.1030601@linaro.org>
 <20120730174831.GP4468@opensource.wolfsonmicro.com>
Message-ID: <50179B64.60209@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/07/12 18:48, Mark Brown wrote:
> On Mon, Jul 30, 2012 at 05:32:10PM +0100, Lee Jones wrote:
>> On 30/07/12 16:26, Mark Brown wrote:
>>> On Mon, Jul 30, 2012 at 02:49:43PM +0100, Lee Jones wrote:
>
>>>> could be dealt with using the API. There is currently no API to set
>>>> up ST-Ericsson's configuration. So what's the best thing to do? How
>
>>> Well, a good start would be to work out what those register writes
>>> actually do and then we can have a discussion on how to do whatever
>>> that is.
>
>> Most of the configuration seems to pertain to voltage selection and
>
> So what makes you say there's no API for any of this then?  Clearly
> setting voltages is something that's supported.
>
>> making regulators valid. I assume this means you can enable them via
>> their own registers and the enablement will take hold. This seems
>
> Please be more specific, frankly I'm having a really hard time working
> out what the above means.  Obviously most of what drivers do involves
> writing to registers...
>
>> like pretty routine stuff as far as regulator configuration goes.
>
> Which seems like a very good reason why it shouldn't just be done by a
> magic sequence of undocumented register writes.

Please listen to what I'm saying as a whole. Breaking that paragraph up 
takes it entirely out of context. I'm mostly agreeing with what you're 
saying, and asking you some advice.

Let me attempt to break it down, so there's no more ambiguity:

- I know that Device Drivers write to registers!
- I agree that magic-number blasting is the wrong thing to do here
- My aim is to convert to using whatever current APIs there are
- I'm happy to extend APIs or write new ones as required
- I now know how the changing voltage API works
   - What I don't know is where we'd call it from to initialise them
   - Can we do that from the ab8500 regulator driver's init() or probe()?
- WRT the 'valid' registers, I'm not sure what they do. The doc says:
   "Supply control thru Hardware signal and SysClkReq balls validation."
   - More comments on what the writes do individually can be seen in [1]
   - Perhaps we can extend the API thus:

> diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
> index 2dac0d6..87fb141 100644
> --- a/drivers/regulator/ab8500.c
> +++ b/drivers/regulator/ab8500.c
> @@ -51,6 +51,10 @@ struct ab8500_regulator_info {
>         int max_uV;
>         int min_uV;
>         int fixed_uV;
> +       u8 valid_bank;
> +       u8 valid_reg;
> +       u8 valid_mask;
> +       u8 valid_val_enable;
>         u8 update_bank;
>         u8 update_reg;
>         u8 update_mask;

Then I think most (if not all) of our bases are covered.

[1] arch/arm/mach-ux500/board-mop500-regulators.c
     'struct ab8500_regulator_reg_init ab8500_regulator_reg_init[]'

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
