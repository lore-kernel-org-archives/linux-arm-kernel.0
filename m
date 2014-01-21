From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 21 Jan 2014 11:52:09 +0100
Subject: [PATCH] clk: nomadik: fix multiplatform problem
In-Reply-To: <1390291581-5858-1-git-send-email-linus.walleij@linaro.org>
References: <1390291581-5858-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20140121105209.GC13396@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 09:06:21AM +0100, Linus Walleij wrote:
> The Nomadik debugfs screws up multiplatform boots if debugfs
> is enabled on the multiplatform image, since it's a simple
> initcall that is unconditionally executed and reads from certain
> memory locations.
> 
> Fix this by checking that the driver has been properly
> initialized, so a base offset to the Nomadik SRC controller
> exists, before proceeding to register debugfs files.
> 
> Reported-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Hi Linus

Thanks for fixing this so quick. I tested on my kirkwood, no longer
crashes.

Tested-by: Andrew Lunn <andrew@lunn.ch>

Thanks
	Andrew

> ---
>  drivers/clk/clk-nomadik.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clk/clk-nomadik.c b/drivers/clk/clk-nomadik.c
> index 6a934a5296bd..05e04ce0f148 100644
> --- a/drivers/clk/clk-nomadik.c
> +++ b/drivers/clk/clk-nomadik.c
> @@ -494,6 +494,9 @@ static const struct file_operations nomadik_src_clk_debugfs_ops = {
>  
>  static int __init nomadik_src_clk_init_debugfs(void)
>  {
> +	/* Vital for multiplatform */
> +	if (!src_base)
> +		return -ENODEV;
>  	src_pcksr0_boot = readl(src_base + SRC_PCKSR0);
>  	src_pcksr1_boot = readl(src_base + SRC_PCKSR1);
>  	debugfs_create_file("nomadik-src-clk", S_IFREG | S_IRUGO,
> -- 
> 1.8.4.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
