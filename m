From: manabian@gmail.com (Joachim Eastwood)
Date: Sat, 8 Oct 2016 12:58:16 +0200
Subject: [PATCH] clk: nxp: clk-lpc18xx-ccu: Unmap region obtained by
 of_iomap
In-Reply-To: <1474367987-15808-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1474367987-15808-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <CAGhQ9Vwp3ajOxO_YriN=Hr=C3o8PsDGryNoGgnuiF5=P5-9S6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arvind,

On 20 September 2016 at 12:39, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> From: Arvind Yadav <arvind.yadav.cs@gmail.com>
>
> Free memory mapping, if lpc18xx_ccu_init is not successful.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Acked-by: Joachim Eastwood <manabian@gmail.com>

One comment below:

> ---
>  drivers/clk/nxp/clk-lpc18xx-ccu.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/nxp/clk-lpc18xx-ccu.c b/drivers/clk/nxp/clk-lpc18xx-ccu.c
> index f7136b9..27781b4 100644
> --- a/drivers/clk/nxp/clk-lpc18xx-ccu.c
> +++ b/drivers/clk/nxp/clk-lpc18xx-ccu.c
> @@ -277,12 +277,15 @@ static void __init lpc18xx_ccu_init(struct device_node *np)
>         }
>
>         clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
> -       if (!clk_data)
> +       if (!clk_data) {
> +               iounmap(reg_base);
>                 return;
> +       }

You could also move the kzalloc() at the beginning of the function to
save a few lines. I am fine either way.

>
>         clk_data->num = of_property_count_strings(np, "clock-names");
>         clk_data->name = kcalloc(clk_data->num, sizeof(char *), GFP_KERNEL);
>         if (!clk_data->name) {
> +               iounmap(reg_base);
>                 kfree(clk_data);
>                 return;
>         }


regards,
Joachim Eastwood
