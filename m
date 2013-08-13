From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 13 Aug 2013 09:58:31 +0200
Subject: [PATCH 1/9] PCI: mvebu: move clock enable before register access
In-Reply-To: <1376333215-12885-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376333215-12885-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376333215-12885-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130813075830.GC9316@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 08:46:47PM +0200, Sebastian Hesselbarth wrote:
[...]
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
[...]
> @@ -897,6 +897,16 @@ static int __init mvebu_pcie_probe(struct platform_device *pdev)
>  			continue;
>  		}
>  
> +		port->clk = of_clk_get_by_name(child, NULL);
> +		if (IS_ERR(port->clk)) {
> +			dev_err(&pdev->dev, "PCIe%d.%d: cannot get clock\n",
> +			       port->port, port->lane);
> +			iounmap(port->base);
> +			port->haslink = 0;
> +			continue;
> +		}
> +		clk_prepare_enable(port->clk);

I see that this was already wrong previously, but since you're changing
the line anyway you should probably also check for failure of the
clk_prepare_enable() call and error out if it can't be prepare/enabled.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130813/91abbf9d/attachment.sig>
