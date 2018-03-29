From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 29 Mar 2018 17:06:46 +0200
Subject: [PATCH] watchdog: Add support for Armada 37xx CPU watchdog
In-Reply-To: <20180323164422.27959-1-marek.behun@nic.cz> ("Marek
 =?utf-8?Q?Beh=C3=BAn=22's?=
 message of "Fri, 23 Mar 2018 17:44:22 +0100")
References: <20180323164422.27959-1-marek.behun@nic.cz>
Message-ID: <871sg2udix.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,
 
 On ven., mars 23 2018, Marek Beh?n <marek.behun@nic.cz> wrote:

> This adds support for the CPU watchdog found on Marvell Armada 37xx
> SoCs.
>
> There are 4 counters which can be set as CPU watchdog counters.
> This driver uses the second counter (ID 1, counting from 0)
> (Marvell's Linux also uses second counter by default).
> In the future it could be adapted to use other counters, with
> definition in the device tree.
>
> Signed-off-by: Marek Behun <marek.behun@nic.cz>

You can add my:

Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>

However, I have one concern about this patch and the device tree
binding.


> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi |   7 +
>  drivers/watchdog/Kconfig                     |  11 +
>  drivers/watchdog/Makefile                    |   1 +
>  drivers/watchdog/armada_37xx_wdt.c           | 356 +++++++++++++++++++++++++++
>  4 files changed, 375 insertions(+)
>  create mode 100644 drivers/watchdog/armada_37xx_wdt.c
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index 8c0cf7efac65..fcd2186e869c 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -139,6 +139,13 @@
>  				status = "disabled";
>  			};
>  
> +			wdt: watchdog-timer at 8300 {
> +				compatible = "marvell,armada-3700-wdt";
> +				reg = <0xd064 0x4>,
> +				      <0x8300 0x40>;

The first reg is actually part of a bigger ranges of register called
"CPU Miscellaneous Register Summary ". It start at 0xd000 and its size
is 0xd8. Here there are registers related to ROM, AXI, watchdog,
timers...

Could you create a syscon for this set of registers and then use a
phandle from the watchdog node to use it ? In the driver it could be done
using regamp.

The rest of the patch looks OK, at least for the point of view of the
SoC. For the watchdog part I let the maintainer review it.

Thanks,

Gregory


-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
