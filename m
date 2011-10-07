From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 7 Oct 2011 11:04:34 -0700
Subject: [PATCH v7 3/3] arm/tegra: device tree support for ventana board
In-Reply-To: <1317647918-22694-4-git-send-email-pdeschrijver@nvidia.com>
References: <1317647918-22694-1-git-send-email-pdeschrijver@nvidia.com>
	<1317647918-22694-4-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173B23B2FA@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Monday, October 03, 2011 7:19 AM:

...
> diff --git a/arch/arm/boot/dts/tegra-ventana.dts b/arch/arm/boot/dts/tegra-ventana.dts
...
> +	chosen {
> +		bootargs = "vmalloc=192M video=tegrafb console=ttyS0,115200n8 root=/dev/ram rdinit=/sbin/init";

It might be nice to make this identical to what Harmony and Seaboard have here.

Still, it doesn't matter a lot, since I (and I imagine most people) have
to edit this command-line to point at the correct partition for my disks
anyway; eventually, U-Boot should be providing/re-writing this property
too.

...
> diff --git a/arch/arm/mach-tegra/board-dt.c b/arch/arm/mach-tegra/board-dt.c
...
> -	if (of_machine_is_compatible("nvidia,harmony"))
> -		harmony_pinmux_init();
> -	else if (of_machine_is_compatible("nvidia,seaboard"))
> -		seaboard_pinmux_init();
> +	for (i = 0; i < ARRAY_SIZE(pinmux_configs); i++) {
> +		if (of_machine_is_compatible(pinmux_configs[i].machine)) {
> +			pinmux_configs[i].init();
> +			break;
> +		}
> +	}
> +
> +	if (i == ARRAY_SIZE(pinmux_configs))
> +		printk(KERN_WARNING "Unknown platform! Pinmuxing not initialized\n");

Should that be WARN() instead of printk?

-- 
nvpublic
