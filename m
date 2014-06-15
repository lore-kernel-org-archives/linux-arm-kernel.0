From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Sat, 14 Jun 2014 22:31:40 -0300
Subject: [PATCHV2]Fixes memory leak in clk-sunxi.c
In-Reply-To: <1402794944-3357-1-git-send-email-xerofoify@gmail.com>
References: <1402794944-3357-1-git-send-email-xerofoify@gmail.com>
Message-ID: <539CF77C.4010500@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

El 14/06/14 22:15, Nick escribi?:
> Signed-off-by: Nick <xerofoify@gmail.com>
> ---
>   drivers/clk/sunxi/clk-sunxi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 6f4fc51..c2ce538 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -41,10 +41,10 @@ static void __init sun4i_osc_clk_setup(struct device_node *node)
>   	const char *clk_name = node->name;
>   	u32 rate;
>
> -	if (of_property_read_u32(node, "clock-frequency", &rate))
> +	if (of_property_read_u32(node, "clock-frequency", &rate)) {
>   		kree(gate);
>   		return;
> -
> +	}
>   	/* allocate fixed-rate and gate clock structs */
>   	fixed = kzalloc(sizeof(struct clk_fixed_rate), GFP_KERNEL);
>   	if (!fixed)
>

There is no memory leak there, and I think the message was pretty clear 
when I mentioned it[1] and then Sergei mentioned it[2] twice[3]. As for 
the bug report[4] you linked in a private email, it has been closed as 
resolved by the original reporter.

Cheers,

Emilio

[1] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/263631.html
[2] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/263677.html
[3] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/263683.html
[4] https://bugzilla.kernel.org/show_bug.cgi?id=59961
