From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Sun, 02 Jun 2013 17:24:27 -0700 (PDT)
Subject: [PATCH v8 2/3] ARM: shmobile: r8a7778: add USB support
In-Reply-To: <201306020210.37520.sergei.shtylyov@cogentembedded.com>
References: <201306020206.47199.sergei.shtylyov@cogentembedded.com>
 <201306020210.37520.sergei.shtylyov@cogentembedded.com>
Message-ID: <87bo7ooxc9.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi


> Add USB clock and EHCI, OHCI, and USB PHY platform devices for R8A7778 SoC;  add
> a function to register PHY device with board-specific platform data and register
> EHCI and OHCI platfrom devices from the init_late() board method.
> 
> Also,  don't forget to enable CONFIG_ARCH_HAS_[EO]HCI options for R8A7778 SoC in
> Kconfig...
> 
> The patch has been tested on the BOCK-W board.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> ---
(snip)
> +void __init r8a7778_add_usb_phy_device(struct rcar_phy_platform_data *pdata)
> +{
> +	platform_device_register_resndata(&platform_bus, "rcar_usb_phy", -1,
> +					  usb_phy_resources,
> +					  ARRAY_SIZE(usb_phy_resources),
> +					  pdata, sizeof(*pdata));
> +}
(snip)
> +void __init r8a7778_init_late(void)
> +{
> +	phy = usb_get_phy(USB_PHY_TYPE_USB2);
> +
> +	platform_device_register_full(&ehci_info);
> +	platform_device_register_full(&ohci_info);
> +}

This means ehci/ohci device registration happened compulsorily if Soc/platform calls r8a7778_init_late().
but, usb phy isn't registered without r8a7778_add_usb_phy_device().

The ohci/ehci resource will be  used vainly if platform doesn't have USB

ohci/ehci and phy should be registered in same time/function.

Best regards
---
Kuninori Morimoto
