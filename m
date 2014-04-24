From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 24 Apr 2014 11:05:51 +0200
Subject: [PATCH 34/38] mmc: add support for power-on sequencing through DT
In-Reply-To: <E1Wd2XY-0003wa-3n@rmk-PC.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
 <E1Wd2XY-0003wa-3n@rmk-PC.arm.linux.org.uk>
Message-ID: <20140424090551.GW24905@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, Apr 23, 2014 at 08:09:04PM +0100, Russell King wrote:
> From: Olof Johansson <olof@lixom.net>
> 
> This patch enables support for power-on sequencing of SDIO peripherals through DT.
> 
> In general, it's quite common that wifi modules and other similar
> peripherals have several signals in addition to the SDIO interface that
> needs wiggling before the module will power on. It's common to have a
> reference clock, one or several power rails and one or several lines
> for reset/enable type functions.
> 
> The binding as written today introduces a number of reset gpios,
> a regulator and a clock specifier. The code will handle up to 2 gpio
> reset lines, but it's trivial to increase to more than that if needed
> at some point.
> 
> Implementation-wise, the MMC core has been changed to handle this during
> host power up, before the host interface is powered on. I have not yet
> implemented the power-down side, I wanted people to have a chance for
> reporting back w.r.t. issues (or comments on the bindings) first.
> 
> I have not tested the regulator portion, since the system and module
> I'm working on doesn't need one (Samsung Chromebook with Marvell
> 8797-based wifi). Testing of those portions (and reporting back) would
> be appreciated.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt | 11 +++++++
>  drivers/mmc/core/core.c                       | 42 +++++++++++++++++++++++++++
>  drivers/mmc/core/host.c                       | 30 ++++++++++++++++++-
>  include/linux/mmc/host.h                      |  5 ++++
>  4 files changed, 87 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index 9dce540771fb..b9b534ebc0c5 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -5,6 +5,8 @@ these definitions.
>  Interpreted by the OF core:
>  - reg: Registers location and length.
>  - interrupts: Interrupts used by the MMC controller.
> +- clocks: Clocks needed for the host controller, if any.
> +- clock-names: Goes with clocks above.
>  
>  Card detection:
>  If no property below is supplied, host native card detect is used.
> @@ -39,6 +41,15 @@ If no property below is supplied, host native card detect is used.
>  - mmc-hs200-1_8v: eMMC HS200 mode(1.8V I/O) is supported
>  - mmc-hs200-1_2v: eMMC HS200 mode(1.2V I/O) is supported
>  
> +Card power and reset control:
> +The following properties can be specified for cases where the MMC
> +peripheral needs additional reset, regulator and clock lines. It is for
> +example common for WiFi/BT adapters to have these separate from the main
> +MMC bus:
> +  - card-reset-gpios: Specify GPIOs for card reset (reset active low)

That probably can use the reset frameworks bindings and the reset-gpio
driver Philipp Zabel has been working on.

> +  - card-external-vcc-supply: Regulator to drive (independent) card VCC
> +  - clock with name "card_ext_clock": External clock provided to the card

I'm not sure this is the right path.

This looks pretty harmless for now, but I'm pretty concerned that it's
just going to be an ever-increasing list of properties to deal with
the various corner-cases everyone has, like for example how to enforce
a given frequency for that card_ext_clock, or the fact that it has
several SDIO cards connected to them, each with different
clocks/reset/regulator lines.

While all of this would easily be solved by representing all this as a
bus, like it should, with subdevices grabbing their own clocks and
having whatever property they need.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140424/d03ee267/attachment.sig>
