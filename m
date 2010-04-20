From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 20 Apr 2010 12:58:34 -0400 (EDT)
Subject: [patch 4/4] ARM: kirkwood: Add Datong DTCOMMOD machine definition
In-Reply-To: <20100420092725.687664503@fluff.org.uk>
References: <20100420092617.075835456@fluff.org.uk>
	<20100420092725.687664503@fluff.org.uk>
Message-ID: <alpine.LFD.2.00.1004201251400.7232@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Apr 2010, Ben Dooks wrote:

> +static void __init dtcommod_init(void)
> +{
> +	kirkwood_init();
> +	kirkwood_mpp_conf(dtcommod_mpp_config);
> +
> +	kirkwood_uart0_init();
> +	/* need to init nand, but we have RnB line */

What's the purpose of that comment there?

> +
> +	kirkwood_ge00_init(&dtcommod_ge0_data);
> +	kirkwood_ge01_init(&dtcommod_ge1_data);
> +	kirkwood_sata_init(&dtcommod_sata_data);
> +	kirkwood_sdio_init(&dtcommod_mvsdio_data);
> +
> +	i2c_register_board_info(0, dtcommod_i2c_devs,
> +				ARRAY_SIZE(dtcommod_i2c_devs));
> +
> +	gpio_request(GPIO_RNB, "NAND RnB");
> +	gpio_direction_input(GPIO_RNB);
> +
> +	gpio_request(GPIO_SDPWR, "SD Power Enable");
> +	gpio_direction_output(GPIO_SDPWR, 0);
> +
> +	kirkwood_nand_init_rnb(ARRAY_AND_SIZE(dtcommod_nand_parts),
> +			       dtcommod_nand_rnb);
> +
> +	/* add the i2c bus info */
> +
> +	kirkwood_ehci_init();
> +	kirkwood_i2c_init();

And isn't that comment misplaced too?

> +}
> +
> +static int __init dtcommod_pci_init(void)
> +{
> +	if (machine_is_dtcommod())
> +		kirkwood_pcie_init();
> +
> +	return 0;
> +}

You do have a PCIe slot/device, right?

Other than that, ACK.


Nicolas
