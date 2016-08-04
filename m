From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 04 Aug 2016 12:15:05 -0700
Subject: [PATCH] ARM: dts: da850: Add basic DTS for the L138/C6748 Dev Kit
In-Reply-To: <20160804144332.4841-1-kbeldan@baylibre.com> (Karl Beldan's
 message of "Thu, 4 Aug 2016 14:43:32 +0000")
References: <20160804144332.4841-1-kbeldan@baylibre.com>
Message-ID: <m2popopcqu.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Sekhar

Hi Karl,

Karl Beldan <kbeldan@baylibre.com> writes:

> The LCDK is the successor to the late Hawkboard and has the same machine
> number.

Machine number is only relevant for legacy (non-DT) boot and this is DT
boot, so the machine number bit really relevant for this changelog.

BTW, have you tried legacy boot on LCDK with board-omapl138-hawk.c?  I
assume it mostly works?

> Among the differences are the flash (16bits vs 8bits) and some pins
> (MMC, LEDs, buttons, some external connectors), however the main
> components remain the same (eth. PHY, Audio Codec, Video decoder and
> DAC) except for the main PMIC, different and hard-wired on the LCDK (the
> LDOs and DCDCs are always ON).
> A DT-only boot with this addition gives functional uart, reboot via
> watchdog, rtc, ethernet and MMC (I added the CD gpio for the MMC
> although davinci_mmc doesn't call yet the mmc core OF facilities).
>
> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>

Tested with v4.7 on my LCDK board.

Tested-by: Kevin Hilman <khilman@baylibre.com>

Note that I also needed CONFIG_RTC_DRV_OMAP=m enabled in
davinci_all_defconfig for the RTC driver. Could you add a patch for that
to this series as well?

Also, plese Cc the co-maintainer Sekhar Nori (now Cc'd) on all future
davinci patches.

> ---
>  Documentation/devicetree/bindings/arm/davinci.txt |  4 ++
>  arch/arm/boot/dts/Makefile                        |  1 +
>  arch/arm/boot/dts/omapl138-lcdk.dts               | 71 +++++++++++++++++++++++

I think this should be called da850-lcdk.dts.

The OMAP prefix in the DT directory is just going to cause confusion,
and the other DTs using this same SoC are already called da850.

Sekhar do you have any opinion here?

[...]

> +/ {
> +	model = "DA850/AM1808/OMAP-L138 LCDK";
> +	compatible = "ti,omapl138-lcdk", "ti,da850";
> +
> +	aliases {
> +		serial2 = &serial2;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS2,115200n8 earlycon";

earlycon is kind of a debug option, so probably should be left out of
the default DT.

> +		stdout-path = "serial2:115200n8";
> +	};

Kevin
