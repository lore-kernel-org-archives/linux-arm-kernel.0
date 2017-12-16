From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 15 Dec 2017 19:57:15 -0600
Subject: [PATCH 1/3] dt-bindings: chosen: Add clocksource and clockevent
 selection
In-Reply-To: <20171213185313.20017-2-alexandre.belloni@free-electrons.com>
References: <20171213185313.20017-1-alexandre.belloni@free-electrons.com>
 <20171213185313.20017-2-alexandre.belloni@free-electrons.com>
Message-ID: <8fe1dce0-3fd2-d740-8456-bf3b734e571a@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/13/2017 12:53 PM, Alexandre Belloni wrote:
> The clocksource and clockevent timer are probed early in the boot process.
> At that time it is difficult for linux to know whether a particular timer
> can be used as the clocksource or the clockevent or by another driver,
> especially when they are all identical or have similar features.
> 
> Until now, multiple strategies have been used to solve that:
>   - use Kconfig option as MXC_USE_EPIT or ATMEL_TCB_CLKSRC_BLOCK
>   - use a kernel parameter as the "clocksource" early_param in mach-omap2
>   - registering the first seen timer as a clockevent and the second one as
>   a clocksource as in rk_timer_init or dw_apb_timer_init
> 
> Add a linux,clocksource and a linux,clockevent node in chosen with a timer
> property pointing to the timer to use. Other properties, like the targeted
> precision may be added later.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>   Documentation/devicetree/bindings/chosen.txt | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
> index e3b13ea7d2ae..c7ee3ecb5276 100644
> --- a/Documentation/devicetree/bindings/chosen.txt
> +++ b/Documentation/devicetree/bindings/chosen.txt
> @@ -120,3 +120,23 @@ e.g.
>   While this property does not represent a real hardware, the address
>   and the size are expressed in #address-cells and #size-cells,
>   respectively, of the root node.
> +
> +linux,clocksource and linux,clockevent
> +--------------------------------------
> +
> +Those nodes have a timer property. This property is a phandle to the timer to be
> +chosen as the clocksource or clockevent. This is only useful when the platform
> +has multiple identical timers and it is not possible to let linux make the
> +correct choice.
> +
> +/ {
> +	chosen {
> +		linux,clocksource {
> +			timer = <&timer0>;
> +		};
> +
> +		linux,clockevent {
> +			timer = <&timer1>;
> +		};
> +	};
> +};
> 

It'd be nice if smth. like this will actually happen, as on some OMAP
platforms can be up to 3-4 alternatives for each clocksource/clockevent and
different combination need to be selected depending on SoC and platform
(and sometime - use case) which is pain in multi-platform environment now.

But more important note from my side is clocksource and clockevent selections seems 
not enough :( There are also sched clock (sched_clock_register()) and delay_timer
 (register_current_timer_delay() at least on ARM).
Both above can't be unregistered (at least last time I've checked).

-- 
regards,
-grygorii
