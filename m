From: sre@debian.org (Sebastian Reichel)
Date: Wed, 8 Jan 2014 10:08:08 +0100
Subject: [PATCH v4 1/5] mfd: omap-usb-host: Update DT clock binding
 information
In-Reply-To: <1389161742-10533-2-git-send-email-rogerq@ti.com>
References: <1389161742-10533-1-git-send-email-rogerq@ti.com>
 <1389161742-10533-2-git-send-email-rogerq@ti.com>
Message-ID: <20140108090808.GB16313@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 11:45:38AM +0530, Roger Quadros wrote:
> diff --git a/Documentation/devicetree/bindings/mfd/omap-usb-host.txt b/Documentation/devicetree/bindings/mfd/omap-usb-host.txt
> index b381fa6..5635202 100644
> --- a/Documentation/devicetree/bindings/mfd/omap-usb-host.txt
> +++ b/Documentation/devicetree/bindings/mfd/omap-usb-host.txt
> @@ -32,6 +32,10 @@ Optional properties:
>  - single-ulpi-bypass: Must be present if the controller contains a single
>    ULPI bypass control bit. e.g. OMAP3 silicon <= ES2.1
>  
> +- clocks: phandle to 60MHz functional clock to the USB Host module.
> +
> +- clock-names: must be "init_60m_fclk"
> +
>  Required properties if child node exists:
>  
>  - #address-cells: Must be 1

I have some questions:

What about the other clocks acquired in drivers/mfd/omap-usb-host.c? Shouldn't
all of those be provided by via the DT phandle?

Should the clk_get be changed to of_clk_get()/of_clk_get_by_name() in the
driver? This would potentially remove the need of the init_60m_fclk name.

$ grep clk_get drivers/mfd/omap-usb-host.c
    omap->ehci_logic_fck = clk_get(dev, "ehci_logic_fck");
    omap->utmi_p1_gfclk = clk_get(dev, "utmi_p1_gfclk");
    omap->utmi_p2_gfclk = clk_get(dev, "utmi_p2_gfclk");
    omap->xclk60mhsp1_ck = clk_get(dev, "xclk60mhsp1_ck");
    omap->xclk60mhsp2_ck = clk_get(dev, "xclk60mhsp2_ck");
    omap->init_60m_fclk = clk_get(dev, "init_60m_fclk");
    omap->utmi_clk[i] = clk_get(dev, clkname);
    omap->hsic480m_clk[i] = clk_get(dev, clkname);
    omap->hsic60m_clk[i] = clk_get(dev, clkname);

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/378658d0/attachment.sig>
