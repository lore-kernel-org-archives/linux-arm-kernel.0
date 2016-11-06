From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sat, 5 Nov 2016 21:34:36 -0600
Subject: [PATCH v3] ARM: bcm2835: Add names for the Raspberry Pi GPIO lines
In-Reply-To: <20161027165246.23936-1-eric@anholt.net>
References: <20161027165246.23936-1-eric@anholt.net>
Message-ID: <7a5c1318-de70-bcfc-648d-fd5a43c2fac5@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2016 10:52 AM, Eric Anholt wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
>
> The idea is to give useful names to GPIO lines that an implementer
> will be using from userspace, e.g. for maker type projects.  These are
> user-visible using tools/gpio/lsgpio.c

>  arch/arm/boot/dts/bcm2835-rpi-a-plus.dts | 65 +++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/bcm2835-rpi-a.dts      | 67 ++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/bcm2835-rpi-b-plus.dts | 66 +++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts | 66 +++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/bcm2835-rpi-b.dts      | 67 ++++++++++++++++++++++++++++++++

Aren't the A and B rev 2 pinouts the same. If so, why duplicate the 
content between the files instead of creating an inclue file? Same for 
A+, B+, Pi 2, and Pi 3. Shouldn't this patch update the Pi 2 and Pi 3 
DTs too?

> diff --git a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts

>  &gpio {
> +	/*
> +	 * This is based on the unreleased schematic for the Model A+.
> +	 *
> +	 * Legend:
> +	 * "NC" = not connected (no rail from the SoC)
> +	 * "FOO" = GPIO line named "FOO" on the schematic
> +	 * "FOO_N" = GPIO line named "FOO" on schematic, active low
> +	 */
> +	gpio-line-names = "SDA0",
> +			  "SCL0",

> diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts

>  &gpio {
> +	/*
> +	 * Taken from Raspberry-Pi-B-Plus-V1.2-Schematics.pdf
> +	 * RPI-BPLUS sheet 1
> +	 *
> +	 * Legend:
> +	 * "NC" = not connected (no rail from the SoC)
> +	 * "FOO" = GPIO line named "FOO" on the schematic
> +	 * "FOO_N" = GPIO line named "FOO" on schematic, active low
> +	 */
> +	gpio-line-names = "ID_SD",
> +			  "ID_SC",

I think the whole point of naming GPIOs is to give users the same 
experience across the different boards where the same semantics exist in 
HW. Both the A+ and B+ use GPIO0/1 (a/k/a ID_SD/ID_SC a/k/a SDA0/SCL0) 
for the same semantic purpose and are exposed in the same externally 
visible way (same pins on the expansion header); the board ID EEPROM. 
Therefore I assert the names of these GPIOs should be identical on all 
boards that use them for that purpose, to allow SW (or human knowledge) 
portability between the boards.

> +			  "GPIO17",

This pin is known as GPIO_GEN0 on the expansion header. Given the 
expansion header is all end-users likely care about, and other pins 
(e.g. SPI_CE1_N) are named after the expansion header, shouldn't this 
patch use the GPIO expansion header naming for all pins that are routed 
to that header?
