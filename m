From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 4 Nov 2011 08:37:56 -0700
Subject: [PATCH 2/2] USB: ehci-tegra: add probing through device tree
In-Reply-To: <1320377174-28047-2-git-send-email-olof@lixom.net>
References: <1320377174-28047-1-git-send-email-olof@lixom.net>
	<1320377174-28047-2-git-send-email-olof@lixom.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173F9A4CBC@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Thursday, November 03, 2011 9:26 PM:
> Rely on platform_data being passed through auxdata for now; more elaborate
> bindings for phy config and tunings to be added.
...
> diff --git a/arch/arm/mach-tegra/board-dt.c b/arch/arm/mach-tegra/board-dt.c
...
>  static __initdata struct tegra_clk_init_table tegra_dt_clk_init_table[] = {
>  	/* name		parent		rate		enabled */
>  	{ "uartd",	"pll_p",	216000000,	true },
> +	{ "usbd",	"clk_m",	12000000,	false },
> +	{ "usb3",	"clk_m",	12000000,	false },
>  	{ NULL,		NULL,		0,		0},
>  };

As woglinde mentioned on IRC, I think you do want to add "usb2" to the
table here; it's in board-paz00.c at least. It shouldn't hurt other boards.

> diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
...
> @@ -590,6 +617,13 @@ static int tegra_ehci_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
> 
> +	if (!pdev->dev.dma_mask)
> +		pdev->dev.dma_mask = &tegra_ehci_dma_mask;

Should this come from DT, or is it some more system-level/internal thing
that doesn't make sense to represent there?

> +
> +	vbus_gpio = of_get_named_gpio(pdev->dev.of_node, "nvidia,vbus-gpio", 0);

of_get_named_gpio() does check for NULL node pointer in practice, but is
it defined to? I wonder if this needs to be conditional of of_node!=NULL
or not?

> +	if (vbus_gpio > 0)

Should that use gpio_is_valid()?

> +		setup_vbus_gpio(pdev, vbus_gpio);

-- 
nvpublic
