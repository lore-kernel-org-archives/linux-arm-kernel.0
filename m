From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Aug 2014 09:11:47 +0200
Subject: [PATCH v2 3/5] ARM: BCM63XX: add BCM63138 minimal Device Tree
In-Reply-To: <1408061487-20984-4-git-send-email-f.fainelli@gmail.com>
References: <1408061487-20984-1-git-send-email-f.fainelli@gmail.com>
 <1408061487-20984-4-git-send-email-f.fainelli@gmail.com>
Message-ID: <2248656.tvg1indprx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 August 2014 17:11:25 Florian Fainelli wrote:
> Add a very minimalistic BCM63138 Device Tree include file which
> describes the BCM63138 SoC with only the basic set of required
> peripherals:
> 
> - Cortex A9 CPUs
> - ARM GIC
> - ARM SCU
> - PL310 Level-2 cache controller
> - ARM TWD & Global timers
> - ARM TWD watchdog
> - legacy MIPS bus (UBUS)
> - BCM6345-style UARTs (disabled by default)
> 
> Since the PL310 L2 cache controller does not come out of reset with
> correct default values, we need to override the 'cache-sets' and
> 'cache-size' properties to get its geometry right.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Looks all good to me except one tiny detail:

> +	/* Legacy UBUS base */
> +	ubus at fffe8000 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0xfffe8000 0x8100>;
> +
> +		serial0: uart at 600 {
> +			compatible = "brcm,bcm6345-uart";
> +			reg = <0x600 0x1b>;
> +			interrupts = <GIC_SPI 32 0>;
> +			clocks = <&periph_clk>;
> +			clock-names = "periph";
> +			status = "disabled";
> +		};

The recommended name for a uart is serial at 600, not uart at 600.
We are highly inconsistent with the existing dts files, so I'm
not blaming you, I'm just trying to make new files do it the
right way.

	Arnd
