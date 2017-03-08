From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 8 Mar 2017 17:56:35 +0100
Subject: [PATCH 1/3] usb: orion-echi: Add support for the Armada 3700
In-Reply-To: <20170308162423.25553-2-gregory.clement@free-electrons.com>
References: <20170308162423.25553-1-gregory.clement@free-electrons.com>
 <20170308162423.25553-2-gregory.clement@free-electrons.com>
Message-ID: <20170308165635.GB32355@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory

> - Add a new compatoble string for the Armada 3700 SoCs

compatible

> 
> - add sbuscfg support for orion usb controller driver. For the SoCs
>   without hlock, need to program BAWR/BARD/AHBBRST fields in the sbuscfg
>   register to guarantee the AHB master's burst would not overrun or
>   underrun the FIFO.
> 
> - the sbuscfg register has to be set after the usb controller reset,
>   otherwise the value would be overridden to 0. In order to do this, the
>   reset callback is registered.
> 
> [gregory.clement at free-electrons.com: - reword commit and comments
> 				     - fix checkpatch warning]
> Signed-off-by: jinghua <jinghua@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  .../devicetree/bindings/usb/ehci-orion.txt         |  4 ++-
>  drivers/usb/host/ehci-orion.c                      | 39 ++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/ehci-orion.txt b/Documentation/devicetree/bindings/usb/ehci-orion.txt
> index 17c3bc858b86..9dfffc9dffec 100644
> --- a/Documentation/devicetree/bindings/usb/ehci-orion.txt
> +++ b/Documentation/devicetree/bindings/usb/ehci-orion.txt
> @@ -1,7 +1,9 @@
>  * EHCI controller, Orion Marvell variants
>  
>  Required properties:
> -- compatible: must be "marvell,orion-ehci"
> +- compatible: could be one of the following

must, not could.

> +	"marvell,orion-ehci"
> +	"marvell,armada-3700-ehci"
>  - reg: physical base address of the controller and length of memory mapped
>    region.
>  - interrupts: The EHCI interrupt
> diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
> index ee8d5faa0194..cf778e166b90 100644
> --- a/drivers/usb/host/ehci-orion.c
> +++ b/drivers/usb/host/ehci-orion.c
> @@ -47,6 +47,21 @@
>  #define USB_PHY_IVREF_CTRL	0x440
>  #define USB_PHY_TST_GRP_CTRL	0x450
>  
> +#define USB_SBUSCFG		0x90
> +#define	    USB_SBUSCFG_BAWR	    0x6
> +#define	    USB_SBUSCFG_BARD	    0x3
> +#define	    USB_SBUSCFG_AHBBRST	    0x0

These three are all shifts. So i would suggest adding _SHIFT to the
end.

> +
> +/* BAWR = BARD = 3 : Align read/write bursts packets larger than 128 bytes */
> +#define USB_SBUSCFG_BAWR_ALIGN_128B	0x3
> +#define USB_SBUSCFG_BARD_ALIGN_128B	0x3
> +/* AHBBRST = 3	   : Align AHB Burst to INCR16 (64 bytes) */
> +#define USB_SBUSCFG_AHBBRST_INCR16	0x3

You can then apply the shift here.

> +
> +#define USB_SBUSCFG_DEF_VAL ((USB_SBUSCFG_BAWR_ALIGN_128B << USB_SBUSCFG_BAWR) \
> +		     | (USB_SBUSCFG_BARD_ALIGN_128B << USB_SBUSCFG_BARD) \
> +		     | (USB_SBUSCFG_AHBBRST_INCR16 << USB_SBUSCFG_AHBBRST))

and this is then shorted.

    Andrew
