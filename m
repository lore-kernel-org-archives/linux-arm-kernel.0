From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 7 Oct 2013 09:05:40 -0700
Subject: [PATCH 1/1] clk/zynq: Fix possible memory leak
In-Reply-To: <1381107317-18120-1-git-send-email-felipensp@gmail.com>
References: <1381107317-18120-1-git-send-email-felipensp@gmail.com>
Message-ID: <38108046-8400-4f4d-b61c-d3e0cdecb431@DB8EHSMHS013.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

Looking at that function, the following calls to various clk_register_*
functions miss correct error handling as well. Therefore it might make
sense to consolidate this free in an error path at the bottom of the
function. That would make things easier when somebody wants to add more
error handling.

Other than that you're right and feel free to add my Acked-by, once you
have fixed the missing braces, Baruch pointed out.

	S?ren
