From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 03 May 2013 12:05:40 +0200
Subject: [PATCH v2 2/2] clk: si5351: Set initial clkout rate when defined
 in platform data.
In-Reply-To: <1367560403-21685-2-git-send-email-marek.belisko@streamunlimited.com>
References: <1367560403-21685-1-git-send-email-marek.belisko@streamunlimited.com>
 <1367560403-21685-2-git-send-email-marek.belisko@streamunlimited.com>
Message-ID: <51838BF4.9050207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/2013 07:53 AM, Marek Belisko wrote:
> Signed-off-by: Marek Belisko<marek.belisko@streamunlimited.com>
> ---
> Changes v1->v2:
> - update commit message and comment to refer to platform data not DT

Marek,

except that the commit msg itself is very short (there is no!) you can
add my

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Next time sending patches for clk-si5351, please ensure you are using
get_maintainers.pl and add me to the list of people to Cc also.

Sebastian

>   drivers/clk/clk-si5351.c |   10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
> index cf39e53..24f5536 100644
> --- a/drivers/clk/clk-si5351.c
> +++ b/drivers/clk/clk-si5351.c
> @@ -1477,6 +1477,16 @@ static int si5351_i2c_probe(struct i2c_client *client,
>   			return -EINVAL;
>   		}
>   		drvdata->onecell.clks[n] = clk;
> +
> +		/* set initial clkout rate */
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
