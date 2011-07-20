From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 20 Jul 2011 08:37:19 -0700
Subject: [PATCH] arm/dt: tegra devicetree support
In-Reply-To: <20110719234158.2779.15394.stgit@ponder>
References: <20110719234158.2779.15394.stgit@ponder>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF049EBDEE27@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely wrote at Tuesday, July 19, 2011 5:43 PM:
> Everything required to populate NVIDIA Tegra devices from the device
> tree.  This patch adds a new DT_MACHINE_DESC() which matches against
> a tegra20 device tree.  So far it only registers the on-chip devices,
> but it will be refined in follow on patches to configure clocks and
> pin IO from the device tree also.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
> Hi all,
> 
> Similar to the versatile patch I just posted, this is certainly not
> complete board support, but it is enough to be useful.  I'd like to
> merge this for v3.1.  It should not break any existing board support.

> diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts

tegra-*.dts don't include status="disable" for all the unused controllers.
Should that be added?

> +	sound {
> +		compatible = "nvidia,harmony-sound", "nvidia,tegra-wm8903";

I thought the sound bindings were still somewhat experimental and not
completely agreed upon. One issue I see is that Device Tree is
supposed to represent pure HW, rather than driver-required abstractions,
and at least the compatible name here is pretty Linux-driver-specific.

I think there are some devices missing from the DT file for audio too,
e.g. the ALSA "PCM" (DMA) driver.

Also, the bindings for this aren't documented IIRC.

I'd suggest dropping the audio part of the DT file until the audio side
is more mature.

> +		spkr-en-gpios = <&codec 2 0>;

Should that be "gpio" not "gpios", since there is only one?

> +		hp-det-gpios = <&gpio 178 0>;
> +		int-mic-en-gpios = <&gpio 184 0>;
> +		ext-mic-en-gpios = <&gpio 185 0>;
> +	};

> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
...
> +/ {
...
> +	amba {
> +		compatible = "simple-bus";
...
> +		intc: interrupt-controller at 50041000 {
...
> +		};
> +	};
...
> +	i2c at 7000c000 {

I've always wondered why all the devices aren't included inside the amba
node. Or put another way, if the devices are outside the amba node, why
not move everything outside the amba node and remove the amba node?

> diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
> index 823c703..6d3d695 100644
> --- a/arch/arm/mach-tegra/Makefile
> +++ b/arch/arm/mach-tegra/Makefile
> @@ -30,5 +30,8 @@ obj-${CONFIG_MACH_PAZ00}		+= board-paz00-pinmux.o
>  obj-${CONFIG_MACH_SEABOARD}             += board-seaboard.o
>  obj-${CONFIG_MACH_SEABOARD}             += board-seaboard-pinmux.o
> 
> +obj-${CONFIG_MACH_TEGRA_DT}             += board-dt.o
> +obj-${CONFIG_MACH_TEGRA_DT}             += board-harmony-pinmux.o

You need board-seaboard-pinmux.o here too.

> diff --git a/arch/arm/mach-tegra/board-dt.c b/arch/arm/mach-tegra/board-dt.c
...
> +static __initdata struct tegra_clk_init_table tegra_dt_clk_init_table[] = {
> +	/* name		parent		rate		enabled */
> +	{ "uartd",	"pll_p",	216000000,	true },
> +	{ NULL,		NULL,		0,		0},
> +};

For audio to work, you'll need more clock entries here currently; another
reason I suggested to simply drop the audio stuff for now to keep things
simple.

> +static void __init tegra_dt_init(void)
...
> +	if (of_machine_is_compatible("nvidia,harmony"))
> +		harmony_pinmux_init();
> +	else if (of_machine_is_compatible("nvidia,seaboard"))
> +		seaboard_pinmux_init();

else error, or at least warn?

-- 
nvpublic
