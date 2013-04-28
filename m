From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 28 Apr 2013 20:03:26 +0200
Subject: [PATCH] clk: si5351: Allow to build without CONFIG_OF
In-Reply-To: <1367144681-14248-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1367144681-14248-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <201304282003.26593.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 28 April 2013, Sebastian Hesselbarth wrote:
> diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
> index 8323c31..91c0f01 100644
> --- a/drivers/clk/clk-si5351.c
> +++ b/drivers/clk/clk-si5351.c
> @@ -1489,12 +1489,14 @@ static int si5351_i2c_probe(struct i2c_client *client,
>                 }
>         }
>  
> +#ifdef CONFIG_OF
>         ret = of_clk_add_provider(client->dev.of_node, of_clk_src_onecell_get,
>                                   &drvdata->onecell);
>         if (ret) {
>                 dev_err(&client->dev, "unable to add clk provider\n");
>                 return ret;
>         }
> +#endif
>  

I think we should instead make of_clk_add_provider return 0 if CONFIG_OF
is disabled, adn we don't consider it an error condition to call it.
That is also what we return when CONFIG_OF is enabled and we boot without
a device tree.

	Arnd
