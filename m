From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 23 Oct 2014 18:43:28 +0200
Subject: [PATCH v2 1/4] pinctrl: rockchip: Set wake_enabled
In-Reply-To: <1413913655-22351-1-git-send-email-dianders@chromium.org>
References: <1413913655-22351-1-git-send-email-dianders@chromium.org>
Message-ID: <1522951.uUd1Gprpbn@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 21. Oktober 2014, 10:47:32 schrieb Doug Anderson:
> The rockchip pinctrl driver uses irq_gc_set_wake() but doesn't setup
> the .wake_enabled member.  That means that we can never actually use a
> pin for wakeup.  When "irq_set_irq_wake()" tries to call through it
> will always get a failure from set_irq_wake_real() and will then set
> wake_depth to 0.  Assuming you can resume you'll later get an error
> message about "Unbalanced IRQ x wake disable".

The change itself looks reasonable. But now being able to read the docs for 
it, it doesn't look like all gpios are able to wake the system.

On the rk3288 it seems to be only the pins from gpio0 that can do this 
(similar for different banks on the other Rockchip SoCs) - see PMU_WAKEUP_CFG0 
and PMU_WAKEUP_CFG1[1].

So I guess we'll need something more eloquent to handle this.


Heiko

> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Tested-by: Chris Zhong <zyw@rock-chips.com>
> ---
> Changes in v2: None
> 
>  drivers/pinctrl/pinctrl-rockchip.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-rockchip.c
> b/drivers/pinctrl/pinctrl-rockchip.c index 016f457..230d8f3 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.c
> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> @@ -1563,6 +1563,7 @@ static int rockchip_interrupts_register(struct
> platform_device *pdev, gc->chip_types[0].chip.irq_unmask =
> irq_gc_mask_set_bit;
>  		gc->chip_types[0].chip.irq_set_wake = irq_gc_set_wake;
>  		gc->chip_types[0].chip.irq_set_type = rockchip_irq_set_type;
> +		gc->wake_enabled = IRQ_MSK(bank->nr_pins);
> 
>  		irq_set_handler_data(bank->irq, bank);
>  		irq_set_chained_handler(bank->irq, rockchip_irq_demux);
