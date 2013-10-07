From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 7 Oct 2013 05:10:41 +0300
Subject: [PATCH 1/1] clk/zynq: Fix possible memory leak
In-Reply-To: <1381107317-18120-1-git-send-email-felipensp@gmail.com>
References: <1381107317-18120-1-git-send-email-felipensp@gmail.com>
Message-ID: <20131007021041.GE4875@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On Sun, Oct 06, 2013 at 09:55:17PM -0300, Felipe Pena wrote:
> The zynq_clk_register_fclk function can leak memory (fclk_lock) when unable 
> to alloc memory for fclk_gate_lock
> 
> Signed-off-by: Felipe Pena <felipensp@gmail.com>
> ---
>  drivers/clk/zynq/clkc.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
> index cc40fe6..7ea4b5c 100644
> --- a/drivers/clk/zynq/clkc.c
> +++ b/drivers/clk/zynq/clkc.c
> @@ -117,6 +117,7 @@ static void __init zynq_clk_register_fclk(enum zynq_clk fclk,
>  		goto err;
>  	fclk_gate_lock = kmalloc(sizeof(*fclk_gate_lock), GFP_KERNEL);
>  	if (!fclk_gate_lock)
> +		kfree(fclk_lock);
>  		goto err;

Missing braces.

>  	spin_lock_init(fclk_lock);
>  	spin_lock_init(fclk_gate_lock);

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
