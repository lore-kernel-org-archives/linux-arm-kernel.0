From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Feb 2012 09:05:59 +0000
Subject: [PATCH v4 1/2] pxa/hx4700: Add PCMCIA/CF support
In-Reply-To: <1328229586.3847.YahooMailClassic@web29018.mail.ird.yahoo.com>
References: <1328229586.3847.YahooMailClassic@web29018.mail.ird.yahoo.com>
Message-ID: <20120203090559.GH889@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 03, 2012 at 12:39:46AM +0000, Paul Parsons wrote:
> +static int hw_init(struct soc_pcmcia_socket *skt)
> +{
> +	int ret;
> +
> +	ret = gpio_request_array(gpios, ARRAY_SIZE(gpios));
> +	if (ret)
> +		goto out;
> +
> +	irq_set_irq_type(gpio_to_irq(GPIOD4_CF_nCD), IRQ_TYPE_EDGE_BOTH);

You shouldn't need to set the IRQ type for this.

> +
> +	skt->stat[SOC_STAT_CD].gpio = GPIOD4_CF_nCD;
> +	skt->stat[SOC_STAT_CD].name = "PCMCIA CD";
> +	skt->stat[SOC_STAT_RDY].gpio = GPIO60_HX4700_CF_RNB;
> +	skt->stat[SOC_STAT_RDY].name = "PCMCIA Ready";
> +
> +out:
> +	return ret;
> +}
...
> +static void socket_state(struct soc_pcmcia_socket *skt,
> +	struct pcmcia_state *state)
> +{
> +	state->detect = (gpio_get_value(GPIOD4_CF_nCD) == 0);
> +	state->ready = (gpio_get_value(GPIO60_HX4700_CF_RNB) != 0);

soc_common reads these for you before calling your socket_state
function.

> +	state->bvd1 = 1;
> +	state->bvd2 = 1;

If you don't have the BVD signals, soc_common now defaults these to '1'.

> +	state->wrprot = 0;

You don't need to set this - soc_common sets this to zero.

> +	state->vs_3v = 1;
> +	state->vs_Xv = 0;

But you will need these two.

> +}
...
> +static int __init hx4700_pcmcia_init(void)
> +{
> +	struct platform_device *pdev;
> +	int ret;
> +
> +	if (!machine_is_h4700())
> +		return -ENODEV;
> +
> +	pdev = platform_device_alloc("pxa2xx-pcmcia", -1);
> +	if (!pdev)
> +		return -ENOMEM;
> +
> +	ret = platform_device_add_data(pdev,
> +		&hx4700_pcmcia_ops, sizeof(hx4700_pcmcia_ops));
> +	if (ret)
> +		goto out;
> +
> +	ret = platform_device_add(pdev);
> +	if (ret)
> +		goto out;

	pdev = platform_device_register_data(NULL, "pxa2xx-pcmcia", -1,
		&hx4700_pcmcia_ops, sizeof(hx4700_pcmcia_ops));
	if (IS_ERR(pdev))
		return PTR_ERR(pdev);

> +
> +	hx4700_pcmcia_device = pdev;
> +	return 0;
> +
> +out:
> +	platform_device_put(pdev);
> +	return ret;
> +}
