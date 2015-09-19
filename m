From: lee.jones@linaro.org (Lee Jones)
Date: Sat, 19 Sep 2015 10:57:58 +0100
Subject: [PATCH 1/2] mfd: twl6040: Fix deferred probe handling for clk32k
In-Reply-To: <1442593745-16725-2-git-send-email-tony@atomide.com>
References: <1442593745-16725-1-git-send-email-tony@atomide.com>
 <1442593745-16725-2-git-send-email-tony@atomide.com>
Message-ID: <20150919095758.GH3218@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Sep 2015, Tony Lindgren wrote:

> Commit 68bab8662f49 ("mfd: twl6040: Optional clk32k clock handling")
> added clock handling for the 32k clock from palmas-clk. However, that
> patch did not consider a typical situation where twl6040 is built-in,
> and palmas-clk is a loadable module like we have in omap2plus_defconfig.
> 
> If palmas-clk is not loaded before twl6040 probes, we will get a
> "clk32k is not handled" warning during booting. This means that any
> drivers relying on this clock will mysteriously fail, including
> omap5-uevm WLAN and audio.
> 
> Note that for WLAN, we probably should also eventually get
> the clk32kgaudio for MMC3 directly as that's shared between
> audio and WLAN SDIO at least for omap5-uevm. It seems the
> WLAN chip cannot get it as otherwise MMC3 won't get properly
> probed.
> 
> Fixes: 68bab8662f49 ("mfd: twl6040: Optional clk32k clock handling")
> Cc: Benoit Cousson <bcousson@baylibre.com>
> Cc: Dr. H. Nikolaus Schaller <hns@goldelico.com>
> Cc: Grazvydas Ignotas <notasas@gmail.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Sourav Poddar <sourav.poddar@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/mfd/twl6040.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

> --- a/drivers/mfd/twl6040.c
> +++ b/drivers/mfd/twl6040.c
> @@ -647,6 +647,8 @@ static int twl6040_probe(struct i2c_client *client,
>  
>  	twl6040->clk32k = devm_clk_get(&client->dev, "clk32k");
>  	if (IS_ERR(twl6040->clk32k)) {
> +		if (PTR_ERR(twl6040->clk32k) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
>  		dev_info(&client->dev, "clk32k is not handled\n");
>  		twl6040->clk32k = NULL;
>  	}

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
