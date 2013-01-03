From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 3 Jan 2013 15:11:00 +0800
Subject: [PATCH v2 1/3] Input: imx_keypad - Add device tree support
In-Reply-To: <1357010475-7331-1-git-send-email-Ying.Liu@freescale.com>
References: <1357010475-7331-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <20130103071058.GA2566@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 01, 2013 at 11:21:13AM +0800, Liu Ying wrote:
> +#ifdef CONFIG_OF
> +static inline int imx_keypad_check_dt(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +
> +	if (!np)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +#else
> +static inline int imx_keypad_check_dt(struct platform_device *pdev)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
>  static int imx_keypad_probe(struct platform_device *pdev)
>  {
>  	const struct matrix_keymap_data *keymap_data = pdev->dev.platform_data;
>  	struct imx_keypad *keypad;
>  	struct input_dev *input_dev;
>  	struct resource *res;
> -	int irq, error, i;
> +	int irq, error, i, row, col, row_shift;
>  
> -	if (keymap_data == NULL) {
> +	if (keymap_data == NULL && imx_keypad_check_dt(pdev)) {

Shouldn't the following just equally work?
	
	if (keymap_data == NULL && pdev->dev.of_node == NULL) {

Shawn

>  		dev_err(&pdev->dev, "no keymap defined\n");
>  		return -EINVAL;
>  	}
