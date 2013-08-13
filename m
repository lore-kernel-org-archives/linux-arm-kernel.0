From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 13 Aug 2013 09:11:06 +0200
Subject: [PATCH 1/9] PCI: mvebu: move clock enable before register access
In-Reply-To: <1376333215-12885-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376333215-12885-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376333215-12885-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130813091106.326c562a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian Hesselbarth,

On Mon, 12 Aug 2013 20:46:47 +0200, Sebastian Hesselbarth wrote:

> +		port->clk = of_clk_get_by_name(child, NULL);
> +		if (IS_ERR(port->clk)) {
> +			dev_err(&pdev->dev, "PCIe%d.%d: cannot get clock\n",
> +			       port->port, port->lane);
> +			iounmap(port->base);

You shouldn't iounmap() here in case of error, since the register
mapping hasn't been done yet.

> +			port->haslink = 0;
> +			continue;
> +		}
> +		clk_prepare_enable(port->clk);

Nitpick, an empty new line between the closing } and the
clk_prepare_enable() line would be nice.

> +
>  		port->base = mvebu_pcie_map_registers(pdev, child, port);
>  		if (!port->base) {
>  			dev_err(&pdev->dev, "PCIe%d.%d: cannot map registers\n",
> @@ -916,22 +926,9 @@ static int __init mvebu_pcie_probe(struct platform_device *pdev)
>  				 port->port, port->lane);

and maybe here you could unprepare+release the clock if we haven't
managed to remap registers?

>  		}
>  
> -		port->clk = of_clk_get_by_name(child, NULL);
> -		if (IS_ERR(port->clk)) {
> -			dev_err(&pdev->dev, "PCIe%d.%d: cannot get clock\n",
> -			       port->port, port->lane);
> -			iounmap(port->base);
> -			port->haslink = 0;
> -			continue;
> -		}
> -
>  		port->dn = child;
> -
> -		clk_prepare_enable(port->clk);
>  		spin_lock_init(&port->conf_lock);
> -
>  		mvebu_sw_pci_bridge_init(port);
> -
>  		i++;
>  	}
>  

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
