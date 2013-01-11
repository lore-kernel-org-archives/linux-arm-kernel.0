From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Fri, 11 Jan 2013 23:12:20 +0100
Subject: [REPOST PATCH 2/2] i2c: pxa: Use i2c-core to get bus number now
In-Reply-To: <1357927027-4857-3-git-send-email-dianders@chromium.org>
References: <1353522362-25519-2-git-send-email-dianders@chromium.org>
 <1357927027-4857-1-git-send-email-dianders@chromium.org>
 <1357927027-4857-3-git-send-email-dianders@chromium.org>
Message-ID: <50F08E44.3050500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/11/2013 06:57 PM, Doug Anderson wrote:
> The commit: "i2c-core: dt: Pick i2c bus number from i2c alias if
> present" adds support for automatically picking the bus number based
> on the alias ID.  Remove the now unnecessary code from i2c-pxa that
> did the same thing.
>
> Signed-off-by: Doug Anderson<dianders@chromium.org>
> Acked-by: Haojian Zhuang<haojian.zhuang@gmail.com>
> ---
>   drivers/i2c/busses/i2c-pxa.c |    8 +-------
>   1 files changed, 1 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index 1034d93..8ee9fa0 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -1053,16 +1053,10 @@ static int i2c_pxa_probe_dt(struct platform_device *pdev, struct pxa_i2c *i2c,
>   	struct device_node *np = pdev->dev.of_node;
>   	const struct of_device_id *of_id =
>   			of_match_device(i2c_pxa_dt_ids,&pdev->dev);
> -	int ret;
>
>   	if (!of_id)
>   		return 1;
> -	ret = of_alias_get_id(np, "i2c");
> -	if (ret<  0) {
> -		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
> -		return ret;
> -	}
> -	pdev->id = ret;
> +	pdev->id = -1;

I think assignments like this are illegal. At this point the device is
already registered and modifying pdev->id can cause issues at the core
code.

It might be better to have the bus number stored in struct pxa_i2c,
initialized with pdev->id value for non-dt and now with -1 for dt case.

I realize it is not something your patch is intended to deal with,
but since you're touching this code maybe it's worth to fix that issue
as well ?

--

Thanks,
Sylwester
