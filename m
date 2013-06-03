From: robherring2@gmail.com (Rob Herring)
Date: Mon, 03 Jun 2013 07:27:25 -0500
Subject: [RFC] dw_apb_timer_of: use clocksource_of_init
In-Reply-To: <201306031415.29411.heiko@sntech.de>
References: <201306030055.15413.heiko@sntech.de>
 <201306031146.57611.heiko@sntech.de> <1822564.TIKVDZSzqK@wuerfel>
 <201306031415.29411.heiko@sntech.de>
Message-ID: <51AC8BAD.4020607@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/2013 07:15 AM, Heiko St?bner wrote:
> dw_apb_timer_init used to search the devicetree for matching timer
> devices, making calls to it from board files necessary.
> 
> Change the dw_apb_timer_init to work with CLOCKSOURCE_OF_DECLARE.
> With this change the function gets called once for each timer node
> and tracks these number of calls to attach clockevent and clocksource
> devices to the nodes.
> 
> Also convert all previous users of dw_apb_timer_init to use
> clocksource_of_init.
> 
> Tested on the upcoming rk3066 code.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Acked-by: Rob Herring <rob.herring@calxeda.com>

But 1 comment:

> @@ -88,7 +88,7 @@ DT_MACHINE_START(PICOXCELL, "Picochip picoXcell")
>  	.map_io		= picoxcell_map_io,
>  	.nr_irqs	= NR_IRQS_LEGACY,
>  	.init_irq	= irqchip_init,
> -	.init_time	= dw_apb_timer_init,
> +	.init_time	= clocksource_of_init,

clocksource_of_init is the default now, so you can just remove this and
the one in socfpga.

Same for irqchip_init BTW, but that's another patch.

Rob
