From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 03 Nov 2014 08:15:53 +0100
Subject: [Regression Resend] mmc: mx28: sd card detection broken since
 3.18-rc1
In-Reply-To: <5456B7B3.60401@gmail.com>
References: <1747777414.897866.1414878004147.JavaMail.open-xchange@oxbsltgw09.schlund.de>
 <5456B7B3.60401@gmail.com>
Message-ID: <54572BA9.1090305@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kristina,

Am 03.11.2014 um 00:01 schrieb Kristina Mart?enko:
> [...]
> I ran into this issue as well. Seems that a card-detect flag 
> (MMC_CAP2_CD_ACTIVE_HIGH) can currently be set based on an 
> uninitialized variable, which can lead to the card being reported as 
> not present. This patch fixes it for me:
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 03c53b72a2d6..f0e187682d3b 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -311,7 +311,7 @@ int mmc_of_parse(struct mmc_host *host)
>  	struct device_node *np;
>  	u32 bus_width;
>  	int len, ret;
> -	bool cap_invert, gpio_invert;
> +	bool cap_invert, gpio_invert = false;
>  
>  	if (!host->parent || !host->parent->of_node)
>  		return 0;
> @@ -401,6 +401,7 @@ int mmc_of_parse(struct mmc_host *host)
>  	else
>  		cap_invert = false;
>  
> +	gpio_invert = false;
>  	ret = mmc_gpiod_request_ro(host, "wp", 0, false, 0, &gpio_invert);
>  	if (ret) {
>  		if (ret == -EPROBE_DEFER)
>
> Let me know if this also fixes it for you, and I'll send in a proper 
> patch.

the patch works for me too. You can also add:

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

> Thanks,
> Kristina

Thanks a lot
Stefan
