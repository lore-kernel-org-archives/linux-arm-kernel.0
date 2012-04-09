From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 09 Apr 2012 09:03:06 -0600
Subject: [PATCH 1/1] pinctrl: add some error checking for user interfaces
In-Reply-To: <1333967409-8168-1-git-send-email-b29396@freescale.com>
References: <1333967409-8168-1-git-send-email-b29396@freescale.com>
Message-ID: <4F82FA2A.3090604@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/2012 04:30 AM, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> This patch can avoid kernel oops in case the mux or config
> function is not supported by driver.
> 
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> ---
>  drivers/pinctrl/pinconf.c |    4 ++++
>  drivers/pinctrl/pinmux.c  |   15 +++++++++++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinconf.c b/drivers/pinctrl/pinconf.c
> index eb3a14f..384dcc1 100644
> --- a/drivers/pinctrl/pinconf.c
> +++ b/drivers/pinctrl/pinconf.c
> @@ -448,8 +448,12 @@ static void pinconf_dump_pin(struct pinctrl_dev *pctldev,
>  static int pinconf_pins_show(struct seq_file *s, void *what)
>  {
>  	struct pinctrl_dev *pctldev = s->private;
> +	const struct pinconf_ops *ops = pctldev->desc->confops;
>  	unsigned i, pin;
>  
> +	if (!ops || !ops->pin_config_get)
> +		return 0;

I don't think this is necessary; it looks like this function (and those
it calls) always checks ops where they're used.

> diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
> index 8849830..ade661d 100644
> --- a/drivers/pinctrl/pinmux.c
> +++ b/drivers/pinctrl/pinmux.c
> @@ -323,6 +323,11 @@ int pinmux_map_to_setting(struct pinctrl_map const *map,
>  	const unsigned *pins;
>  	unsigned num_pins;
>  
> +	if (!pmxops) {
> +		dev_err(pctldev->dev, "dose not support mux functron\n");

s/dose/does/
s/functron/function/
