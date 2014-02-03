From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 03 Feb 2014 21:17:46 +0100
Subject: [PATCH 1/2] clocksource: sunxi: Add new compatibles
In-Reply-To: <20140203194505.GF25625@lukather>
References: <1391348280-9484-1-git-send-email-maxime.ripard@free-electrons.com>
 <52EFC573.2050302@linaro.org> <20140203194505.GF25625@lukather>
Message-ID: <52EFF96A.1020302@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/2014 08:45 PM, Maxime Ripard wrote:
> Hi Daniel,
>
> (Adding DT mailing-list in CC)
>
> On Mon, Feb 03, 2014 at 05:36:03PM +0100, Daniel Lezcano wrote:
>> On 02/02/2014 02:37 PM, Maxime Ripard wrote:
>>> The Allwinner A10 compatibles were following a slightly different compatible
>>> patterns than the rest of the SoCs for historical reasons. Add compatibles
>>> matching the other pattern to the timer driver for consistency, and keep the
>>> older one for backward compatibility.
>>
>> Hi Maxime,
>>
>> is it really needed to keep the old pattern ?
>
> We agreed during the ARM Kernel Summit to consider the DT as a stable
> ABI.
>
> While I'd be ok with removing the older ones, that also means that we
> would break the boot of newer kernels with older DT, so yes, we
> actually need to keep the old compatibles.

Thanks for the clarification.

So these old compatibles will stay there 'ad vitam aeternam', right ?


>>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>> ---
>>>   Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt | 5 +++--
>>>   drivers/clocksource/sun4i_timer.c                                 | 4 ++++
>>>   2 files changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt b/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt
>>> index 48aeb78..d9e35ae 100644
>>> --- a/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt
>>> +++ b/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt
>>> @@ -2,7 +2,8 @@ Allwinner A1X SoCs Timer Controller
>>>
>>>   Required properties:
>>>
>>> -- compatible : should be "allwinner,sun4i-timer"
>>> +- compatible : should be "allwinner,sun4i-a10-timer"
>>> +               (Deprecated "allwinner,sun4i-timer")
>>>   - reg : Specifies base physical address and size of the registers.
>>>   - interrupts : The interrupt of the first timer
>>>   - clocks: phandle to the source clock (usually a 24 MHz fixed clock)
>>> @@ -10,7 +11,7 @@ Required properties:
>>>   Example:
>>>
>>>   timer {
>>> -	compatible = "allwinner,sun4i-timer";
>>> +	compatible = "allwinner,sun4i-a10-timer";
>>>   	reg = <0x01c20c00 0x400>;
>>>   	interrupts = <22>;
>>>   	clocks = <&osc>;
>>> diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
>>> index bf497af..de03895 100644
>>> --- a/drivers/clocksource/sun4i_timer.c
>>> +++ b/drivers/clocksource/sun4i_timer.c
>>> @@ -196,5 +196,9 @@ static void __init sun4i_timer_init(struct device_node *node)
>>>   	clockevents_config_and_register(&sun4i_clockevent, rate,
>>>   					TIMER_SYNC_TICKS, 0xffffffff);
>>>   }
>>> +CLOCKSOURCE_OF_DECLARE(sun4i, "allwinner,sun4i-a10-timer",
>>> +		       sun4i_timer_init);
>>> +
>>> +/* Deprecated */
>>>   CLOCKSOURCE_OF_DECLARE(sun4i, "allwinner,sun4i-timer",
>>>   		       sun4i_timer_init);
>>>
>>
>>
>> --
>>   <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
