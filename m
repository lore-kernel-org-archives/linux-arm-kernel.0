From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 28 Apr 2013 10:59:41 +0200
Subject: [PATCH 2/2] clk: si5351: Apply rate when clock-frequency is
 defined in devicetree.
In-Reply-To: <1366698170-31346-2-git-send-email-marek.belisko@streamunlimited.com>
References: <1366698170-31346-1-git-send-email-marek.belisko@streamunlimited.com>
 <1366698170-31346-2-git-send-email-marek.belisko@streamunlimited.com>
Message-ID: <517CE4FD.9010406@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/2013 08:22 AM, Marek Belisko wrote:
> clock-frequency property from devicetree was read but never used. Apply
> defined rate when clock is registered.
>
> Signed-off-by: Marek Belisko<marek.belisko@streamunlimited.com>
> ---
>   drivers/clk/clk-si5351.c |   10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
> index cf39e53..8323c31 100644
> --- a/drivers/clk/clk-si5351.c
> +++ b/drivers/clk/clk-si5351.c
> @@ -1477,6 +1477,16 @@ static int si5351_i2c_probe(struct i2c_client *client,
>   			return -EINVAL;
>   		}
>   		drvdata->onecell.clks[n] = clk;
> +
> +		/* set rate when defined in devicetree */

nit: We also set the rate when it is defined in platform_data
(which is disabled because there is still some CONFIG_OF dependency).

Anyway, the above comment and patch subject should refer to platform
data instead.

If you can send an updated version of this patch you get my
Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> +		if (pdata->clkout[n].rate != 0) {
> +			int ret;
> +			ret = clk_set_rate(clk, pdata->clkout[n].rate);
> +			if (ret != 0) {
> +				dev_err(&client->dev, "Cannot set rate : %d\n",
> +					ret);
> +			}
> +		}
>   	}
>
>   	ret = of_clk_add_provider(client->dev.of_node, of_clk_src_onecell_get,
