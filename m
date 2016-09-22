From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 22 Sep 2016 17:39:53 +0300
Subject: [PATCH] clocksource: timer-digicolor: Unmap region obtained by
 of_iomap
In-Reply-To: <1474554073-8658-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1474554073-8658-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <20160922143953.3pd7yicmwosuk3xk@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arvind Yadav,

On Thu, Sep 22, 2016 at 07:51:13PM +0530, Arvind Yadav wrote:
> Free memory mapping, if digicolor_timer_init is not successful.

Thanks for looking into that.

Why not add a devm_of_iomap() variant of of_iomap() that calls devm_ioremap() 
instead of ioremap()?

I'm not sure that cleaning up after a clocksource driver init failure makes 
much sense. Something is clearly fundamentally wrong in your device tree, and 
your system will most likely not boot anyway.

baruch

> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/clocksource/timer-digicolor.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-digicolor.c b/drivers/clocksource/timer-digicolor.c
> index 10318cc..e6e5e6a 100644
> --- a/drivers/clocksource/timer-digicolor.c
> +++ b/drivers/clocksource/timer-digicolor.c
> @@ -167,12 +167,14 @@ static int __init digicolor_timer_init(struct device_node *node)
>  	irq = irq_of_parse_and_map(node, dc_timer_dev.timer_id);
>  	if (irq <= 0) {
>  		pr_err("Can't parse IRQ");
> +		iounmap(dc_timer_dev.base);
>  		return -EINVAL;
>  	}
>  
>  	clk = of_clk_get(node, 0);
>  	if (IS_ERR(clk)) {
>  		pr_err("Can't get timer clock");
> +		iounmap(dc_timer_dev.base);
>  		return PTR_ERR(clk);
>  	}
>  	clk_prepare_enable(clk);
> @@ -192,6 +194,7 @@ static int __init digicolor_timer_init(struct device_node *node)
>  			  &dc_timer_dev.ce);
>  	if (ret) {
>  		pr_warn("request of timer irq %d failed (%d)\n", irq, ret);
> +		iounmap(dc_timer_dev.base);
>  		return ret;
>  	}

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
