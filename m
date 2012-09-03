From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 3 Sep 2012 14:10:50 +0000
Subject: [RFC/PATCH] ARM: PRIMA2: initial support for SiRFmarco dual-core
 SoC
In-Reply-To: <1346409312-16778-1-git-send-email-Barry.Song@csr.com>
References: <1346409312-16778-1-git-send-email-Barry.Song@csr.com>
Message-ID: <201209031410.50729.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 31 August 2012, Barry Song wrote:

> +		l2-cache-controller at c0030000 {
> +			compatible = "arm,pl310-cache", "sirf,marco-pl310-cache";
> +			reg = <0xc0030000 0x1000>;
> +			interrupts = <0 59 0>;
> +			arm,tag-latency = <1 1 1>;
> +			arm,data-latency = <1 1 1>;
> +			arm,filter-ranges = <0x40000000 0xc0000000>;
> +		};
> +
> +                gic: interrupt-controller at c0011000 {
> +                        compatible = "arm,cortex-a9-gic";
> +                        interrupt-controller;
> +                        #interrupt-cells = <3>;
> +                        reg = <0xc0011000 0x1000>,
> +                              <0xc0010100 0x0100>;
> +                };

The indentation here looks broken. Just use tabs instead of sapces everywhere.

> +		 rstc-iobg {
> +			compatible = "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0xc2000000 0xc2000000 0x10000>;
> +
> +			reset-controller at c2000000 {
> +				compatible = "sirf,marco-rstc";
> +				reg = <0xc2000000 0x10000>;
> +			};
> +		};
> +
> +		sys-iobg {
> +			compatible = "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0xc3000000 0xc3000000 0x30000>;

It looks to me that the sub-buses all have a size of 0x1000000, so I would
recommend listing that one in the ranges, rather than only enough to
provide the devices that you actually use.

> +			uart0: uart at cc050000 {
> +				cell-index = <0>;
> +				compatible = "sirf,marco-uart";
> +				reg = <0xcc050000 0x1000>;
> +				interrupts = <0 17 0>;
> +				fifosize = <128>;
> +			};
> +
> +			uart1: uart at cc060000 {
> +				cell-index = <1>;
> +				compatible = "sirf,marco-uart";
> +				reg = <0xcc060000 0x1000>;
> +				interrupts = <0 18 0>;
> +				fifosize = <32>;
> +			};

For the uart, as well as any other device that only provides a connection
to the board rather than being useful by itself, we commonly put a 
'status = "disabled"' property in each node in the .dtsi file, and then
override them from the board specific .dts file with 'status= "ok"'. That
way, only the devices that are actually populated on a particular board
and up being registered as platform_devices in Linux.

> +
> +			spi0: spi at cc0D0000 {
> +				cell-index = <0>;
> +				compatible = "sirf,marco-spi";
> +				reg = <0xcc0D0000 0x10000>;
> +				interrupts = <0 15 0>;
> +				sirf,spi-num-chipselects = <1>;
> +				cs-gpios = <&gpio 0 0>;
> +			};
> +
> +			spi1: spi at cc170000 {
> +				cell-index = <1>;
> +				compatible = "sirf,marco-spi";
> +				reg = <0xcc170000 0x10000>;
> +				interrupts = <0 16 0>;
> +				sirf,spi-num-chipselects = <1>;
> +				cs-gpios = <&gpio 0 0>;
> +			};
> +
> +			i2c0: i2c at cc0e0000 {
> +				cell-index = <0>;
> +				compatible = "sirf,marco-i2c";
> +				reg = <0xcc0e0000 0x10000>;
> +				interrupts = <0 24 0>;
> +			};
> +
> +			i2c1: i2c at cc0f0000 {
> +				cell-index = <1>;
> +				compatible = "sirf,marco-i2c";
> +				reg = <0xcc0f0000 0x10000>;
> +				interrupts = <0 25 0>;
> +			};

Same thing here.


> +			pci-iobg {
> +				compatible = "sirf,marco-pciiobg", "simple-bus";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0xcD000000 0xcD000000 0x1000000>;
> +
> +				sd0: sdhci at cD000000 {
> +					cell-index = <0>;
> +					compatible = "sirf,marco-sdhc";
> +					reg = <0xcD000000 0x100000>;
> +					interrupts = <0 38 0>;
> +				};
> +
> +				sd1: sdhci at cD100000 {
> +					cell-index = <1>;
> +					compatible = "sirf,marco-sdhc";
> +					reg = <0xcD100000 0x100000>;
> +					interrupts = <0 38 0>;
> +				};

And here. Note that these you are probably missing the gpio lines for
card detect and write protect as well as the required "bus-width" property.

> diff --git a/arch/arm/configs/marcocb_defconfig b/arch/arm/configs/marcocb_defconfig
> new file mode 100644
> index 0000000..1a9829d
> --- /dev/null
> +++ b/arch/arm/configs/marcocb_defconfig

Can you make the defconfig a superset of prima2 and marco? We are trying
to keep the number of distinct defconfig files low, while trying to also
have build coverage over many drivers.

> diff --git a/arch/arm/mach-prima2/hotplug.c b/arch/arm/mach-prima2/hotplug.c
> new file mode 100644
> index 0000000..7d5febe
> --- /dev/null
> +++ b/arch/arm/mach-prima2/hotplug.c

> +extern volatile int pen_release;
> +
> +static inline void platform_do_lowpower(unsigned int cpu)
> +{
> +	flush_cache_all();

This file will get a merge conflict when we also integrate the
patch series to let us abstract the SMP operations into a run-time
selectable structure.

> diff --git a/arch/arm/mach-prima2/timer-marco.c b/arch/arm/mach-prima2/timer-marco.c
> new file mode 100644
> index 0000000..eb5adad
> --- /dev/null
> +++ b/arch/arm/mach-prima2/timer-marco.c

> diff --git a/arch/arm/mach-prima2/timer.c b/arch/arm/mach-prima2/timer-prima2.c
> similarity index 98%
> rename from arch/arm/mach-prima2/timer.c
> rename to arch/arm/mach-prima2/timer-prima2.c
> index d95bf25..305cbcc 100644
> --- a/arch/arm/mach-prima2/timer.c
> +++ b/arch/arm/mach-prima2/timer-prima2.c

Both of these files should now be moved out of the platform directory into
drivers/clocksource/.

	Arnd
