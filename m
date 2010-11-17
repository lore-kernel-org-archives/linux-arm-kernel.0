From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 17 Nov 2010 21:56:29 -0200
Subject: [PATCH 46/51] ARM: mx3: dynamically allocate mxc_rnga devices
In-Reply-To: <1290029419-21435-46-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
	<1290029419-21435-46-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <AANLkTi=EG-zHQT4rw4b1oOju=Zekk+kXJY_LCJPX0MVS@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2010/11/17 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> +#define imx_mxc_rnga_data_entry_single(soc, _size) ? ? ? ? ? ? ? ? ? ? \
> + ? ? ? { ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> + ? ? ? ? ? ? ? .iobase = soc ## _RNGA_BASE_ADDR, ? ? ? ? ? ? ? ? ? ? ? \
> + ? ? ? }

_size is not used here. I think you should add .iosize = _size

> +#ifdef CONFIG_SOC_IMX31
> +static const struct imx_mxc_rnga_data imx31_mxc_rnga_data __initconst =
> + ? ? ? imx_mxc_rnga_data_entry_single(MX31, SZ_4K);

This should be SZ_16K,

> +#endif /* ifdef CONFIG_SOC_IMX31 */
> +
> +static struct platform_device *__init imx_add_mxc_rnga(
> + ? ? ? ? ? ? ? const struct imx_mxc_rnga_data *data)
> +{
> + ? ? ? struct resource res[] = {
> + ? ? ? ? ? ? ? {
> + ? ? ? ? ? ? ? ? ? ? ? .start = data->iobase,
> + ? ? ? ? ? ? ? ? ? ? ? .end = data->iobase + SZ_16K - 1,

Then here you should do:

 .end = data->iobase + data->iosize - 1,

Regards,

Fabio Estevam
