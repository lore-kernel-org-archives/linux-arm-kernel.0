From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 May 2014 10:19:47 +0200
Subject: [PATCH 01/22] serial: 8250_dw: Add optional reset control support
In-Reply-To: <1400831485-28576-2-git-send-email-wens@csie.org>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
 <1400831485-28576-2-git-send-email-wens@csie.org>
Message-ID: <8689536.mXHvcWVbGA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 May 2014 15:51:04 Chen-Yu Tsai wrote:
>                 p->regshift = val;
>  
> +       data->rst = devm_reset_control_get_optional(p->dev, NULL);
> +
>         /* clock got configured through clk api, all done */
>         if (p->uartclk)
>                 return 0;
> @@ -362,6 +366,9 @@ static int dw8250_probe(struct platform_device *pdev)
>                 return -ENODEV;
>         }
>  
> +       if (!IS_ERR_OR_NULL(data->rst))
> +               reset_control_deassert(data->rst);
> +

You should basically never use IS_ERR_OR_NULL(). devm_reset_control_get_optional()
doesn't return NULL, so IS_ERR() should be safe.

Alternatively, change the code above to set data->rst to NULL if there
is no reset line or error out if you get a different error (e.g. EPROBE_DEFER).

	Arnd
