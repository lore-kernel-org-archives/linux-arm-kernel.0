From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 16 May 2013 09:57:20 +0200 (CEST)
Subject: [PATCH v3 09/20] ARM: shmobile: r8a7790: Add GPIO controller
 devices to device tree
In-Reply-To: <1368577100-3530-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1368577100-3530-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1368577100-3530-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <Pine.LNX.4.64.1305160951040.21125@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent

On Wed, 15 May 2013, Laurent Pinchart wrote:

> Add GPIO controller nodes to the r8a7790 core device tree.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/boot/dts/r8a7790.dtsi | 54 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index ee21061..b5fe51da 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -44,6 +44,60 @@
>  		};
>  	};
>  
> +	gpio0: gpio at ffc40000 {
> +		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
> +		reg = <0xffc40000 0x2c>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 4 0x4>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +	};

I'm testing your patches on Lager and GPIOs don't seem to get registered:

/ # ls /sys/class/gpio/
export    unexport
/ #

And this is easy to trace back: sh_pfc_probe() calls 
sh_pfc_register_gpiochip(), where a check

	if (pfc->info->data_regs == NULL)
		return 0;

successfully fails GPIO initialisation :) Is this known and there are 
still some pieces missing, or you weren't aware of this?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
