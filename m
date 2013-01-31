From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 31 Jan 2013 12:32:13 +0000
Subject: [PATCH 2/4] ARM: mach-shmobile: r8a7779: Allow initialisation
 of GIC by DT
In-Reply-To: <1359597051-32700-3-git-send-email-horms+renesas@verge.net.au>
References: <1359597051-32700-1-git-send-email-horms+renesas@verge.net.au>
 <1359597051-32700-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130131123213.GB7235@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Thu, Jan 31, 2013 at 01:50:49AM +0000, Simon Horman wrote:
> This allows the GIC interrupt controller of the  r8a7779 SoC to be
> initialised using a flattened device tree blob.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/boot/dts/r8a7779.dtsi               |   40 ++++++++++++++++++++++++++
>  arch/arm/mach-shmobile/include/mach/common.h |    1 +
>  arch/arm/mach-shmobile/intc-r8a7779.c        |   27 +++++++++++++----
>  3 files changed, 62 insertions(+), 6 deletions(-)
>  create mode 100644 arch/arm/boot/dts/r8a7779.dtsi
> 
> diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
> new file mode 100644
> index 0000000..eadc12e
> --- /dev/null
> +++ b/arch/arm/boot/dts/r8a7779.dtsi
> @@ -0,0 +1,40 @@
> +/*
> + * Device Tree Source for Renesas r8a7740
> + *
> + * Copyright (C) 2013 Renesas Solutions Corp.
> + * Copyright (C) 2013 Simon Horman
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	compatible = "renesas,r8a7779";
> +
> +	cpus {
> +		cpu at 0 {
> +			compatible = "arm,cortex-a9";
> +		};
> +		cpu at 1 {
> +			compatible = "arm,cortex-a9";
> +		};
> +		cpu at 2 {
> +			compatible = "arm,cortex-a9";
> +		};
> +		cpu at 3 {
> +			compatible = "arm,cortex-a9";
> +		};
> +	};

Sorry to sound like a broken record, but it'd be good to see reg and
device_type set here.

> +
> +        gic: interrupt-controller at f0001000 {
> +                compatible = "arm,cortex-a9-gic";
> +                #interrupt-cells = <3>;
> +                #address-cells = <1>;

Why is #address-cells needed here (and without #size-cells)? I see it's in the
binding document example, but I can't figure out why.

> +                interrupt-controller;
> +                reg = <0xf0001000 0x1000>,
> +                      <0xf0000100 0x100>;
> +        };
> +};

[...]

Thanks,
Mark.
