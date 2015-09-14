From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 14 Sep 2015 16:40:28 +0200
Subject: [PATCH 2/2] clk: at91: system: don't try to free_irq when there
 is no IRQ
In-Reply-To: <1441982047-11303-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1441982047-11303-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1441982047-11303-2-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150914164028.7f38505d@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On Fri, 11 Sep 2015 16:34:07 +0200
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> In the error path of at91_clk_register_system(), sys->irq is freed
> unconditionally but it may not exist or be request at all.

Not sure this is really needed since free_irq() seems to gracefully
handle the case where the irq has not been previously requested [1]
(it does not complain about invalid irq descriptors), but I guess
this extra check cannot hurt.

BTW, that's kinda weird that free_irq() accepts this case, but complains
when you're trying to free a wrong (or already freed) shared irq handler
[2].

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Best Regards,

Boris

[1]http://lxr.free-electrons.com/source/kernel/irq/manage.c#L1471
[2]http://lxr.free-electrons.com/source/kernel/irq/manage.c#L1377

> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/clk/at91/clk-system.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/at91/clk-system.c b/drivers/clk/at91/clk-system.c
> index 58008b3e8bc1..3f5314344286 100644
> --- a/drivers/clk/at91/clk-system.c
> +++ b/drivers/clk/at91/clk-system.c
> @@ -138,7 +138,8 @@ at91_clk_register_system(struct at91_pmc *pmc, const char *name,
>  
>  	clk = clk_register(NULL, &sys->hw);
>  	if (IS_ERR(clk)) {
> -		free_irq(sys->irq, sys);
> +		if (irq)
> +			free_irq(sys->irq, sys);
>  		kfree(sys);
>  	}
>  



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
