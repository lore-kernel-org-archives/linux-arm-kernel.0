From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 1 Oct 2015 10:34:12 +0200
Subject: [PATCH 06/16] clk: at91: clk-main: factorize irq handling
In-Reply-To: <1443629469-15086-7-git-send-email-alexandre.belloni@free-electrons.com>
References: <1443629469-15086-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1443629469-15086-7-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20151001103412.1ac2231d@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On Wed, 30 Sep 2015 18:10:59 +0200
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> The three different irq handlers are doing the same thing, factorize their
> code in a generic irq handler.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/clk/at91/clk-main.c | 43 ++++++++++++++++---------------------------
>  1 file changed, 16 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
> index c1f119748bdc..79a380cd1f4e 100644
> --- a/drivers/clk/at91/clk-main.c
> +++ b/drivers/clk/at91/clk-main.c
> @@ -71,12 +71,21 @@ struct clk_sam9x5_main {
>  
>  #define to_clk_sam9x5_main(hw) container_of(hw, struct clk_sam9x5_main, hw)
>  
> -static irqreturn_t clk_main_osc_irq_handler(int irq, void *dev_id)
> +/* Generic structure */
> +struct clk_main {
> +	struct clk_hw hw;
> +	struct at91_pmc *pmc;
> +	unsigned int irq;
> +	wait_queue_head_t wait;
> +};
> +#define to_clk_main(hw) container_of(hw, struct clk_main, hw)

It wasn't clear to me at first glance that this structure was actually
a base struct for the clk_main_rc_osc and clk_sam9x5_main struct.
Maybe you should rename it into struct clk_main_base and then replace
the hw, pmc, irq and fields in the child structures by a base field.

Something like:

struct clk_sam9x5_main {
	struct clk_main_base base;
	u8 parent;
};

struct clk_main_rc_osc {
	struct clk_main_base base;
	unsigned long frequency;
	unsigned long accuracy;
};

Also, it would avoid any problem if someone decides to change the field
oder in one of those structures.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
