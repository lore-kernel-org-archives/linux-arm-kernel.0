From: eric@anholt.net (Eric Anholt)
Date: Tue, 24 Nov 2015 13:43:56 -0800
Subject: [PATCH 2/3] ARM: bcm2835: add rpi power domain driver
In-Reply-To: <1447956490-22930-3-git-send-email-alex.aring@gmail.com>
References: <1447956490-22930-1-git-send-email-alex.aring@gmail.com>
 <1447956490-22930-3-git-send-email-alex.aring@gmail.com>
Message-ID: <87bnajrs2r.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander Aring <alex.aring@gmail.com> writes:

> This patch adds support for RPi several Power Domains and enable support
> to enable the USB Power Domain when it's not enabled before.
>
> This patch based on Eric Anholt's patch to support Power Domains. He had
> an issue about -EPROBE_DEFER inside the power domain subsystem, this
> issue was solved by commit <311fa6a> ("PM / Domains: Return -EPROBE_DEFER
> if we fail to init or turn-on domain").

Glad to see you pick this up!

> It was tested with barebox and the following scripts before booting
> linux:
>
> /env/a_off:
>
>  # cat /env/a_off
>  #turn off which are enabled by default
>  regulator -n bcm2835_mci0 -s disable
>  regulator -n uart0-pl0110 -s disable
>
> /env/a_on:
>
>  # cat /env/a_on
>  #turn off which are enabled by default
>  regulator -n bcm2835_mci0 -s disable
>  regulator -n uart0-pl0110 -s disable
>
>  regulator -n bcm2835_mci0 -s enable
>  regulator -n uart0-pl0110 -s enable
>  regulator -n uart0-pl0111 -s enable
>  regulator -n bcm2835_usb -s enable
>  regulator -n bcm2835_i2c0 -s enable
>  regulator -n bcm2835_i2c1 -s enable
>  regulator -n bcm2835_i2c2 -s enable
>  regulator -n bcm2835_spi -s enable
>  regulator -n bcm2835_ccp2tx -s enable
>  regulator -n bcm2835_dsi -s enable
>
> /env/b:
>
>  # cat /env/b
>  sh /env/a_on
>
>  regulator -n bcm2835_mci0 -s disable
>  regulator -n uart0-pl0110 -s disable
>  regulator -n uart0-pl0111 -s disable
>  regulator -n bcm2835_usb -s disable
>  regulator -n bcm2835_i2c0 -s disable
>  regulator -n bcm2835_i2c1 -s disable
>  regulator -n bcm2835_i2c2 -s disable
>  regulator -n bcm2835_spi -s disable
>  regulator -n bcm2835_ccp2tx -s disable
>  regulator -n bcm2835_dsi -s disable
>
> /env/c:
>
>  # cat /env/c
>  sh ./env/b
>
>  regulator -n bcm2835_mci0 -s enable
>  regulator -n uart0-pl0110 -s enable
>  regulator -n uart0-pl0111 -s enable
>  regulator -n bcm2835_usb -s enable
>  regulator -n bcm2835_i2c0 -s enable
>  regulator -n bcm2835_i2c1 -s enable
>  regulator -n bcm2835_i2c2 -s enable
>  regulator -n bcm2835_spi -s enable
>  regulator -n bcm2835_ccp2tx -s enable
>  regulator -n bcm2835_dsi -s enable
>
> These scripts enables/disable all regulators inside the bootloader. It
> was running with a "hard" and "soft" reset without any issues. These
> testcases should fit to Stephen Warren suggestions:
>
> "(a) before having explicitly turned the power domain on or off at all (b)
> after having turned it on (c) after having turned it off, and for all
> power domains."

I would drop this whole block from the commit message.  It doesn't seem
worth keeping associated with this code (though thanks for testing it!).

> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Eric Anholt <eric@anholt.net>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>

If I'm going to be credited as an author, we should probably keep my:

Signed-off-by: Eric Anholt <eric@anholt.net>

It looks like you've mostly rewritten things, and there's not a whole
lot of meat to this driver so I don't care about getting credit myself,
but best not to give people reasons to be suspicious.

> ---
>  arch/arm/boot/dts/bcm2835-rpi.dtsi          |  11 ++
>  arch/arm/boot/dts/bcm2835.dtsi              |   2 +-
>  arch/arm/mach-bcm/Kconfig                   |  10 ++
>  arch/arm/mach-bcm/Makefile                  |   1 +
>  arch/arm/mach-bcm/raspberrypi-power.c       | 180 ++++++++++++++++++++++++++++
>  include/dt-bindings/arm/raspberrypi-power.h |  14 +++
>  6 files changed, 217 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/mach-bcm/raspberrypi-power.c
>  create mode 100644 include/dt-bindings/arm/raspberrypi-power.h

To merge the patch, the .dtsi changes need to be in a separate commit
which I would pick up in the dt branch.  I'm hoping Ulf or another PM
domains maintainer would be able to pick up the Kconfig/Makefile/.c
patch in their tree, so it can be queued after the uninit function
change.  If they won't, then it would go through my tree, but still on a
different branch from DT changes.

This is the only thing I see needing to change before I can Ack.

> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index 8c53c55..20479d7 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -134,6 +134,16 @@ config ARCH_BCM2835
>  	  This enables support for the Broadcom BCM2835 SoC. This SoC is
>  	  used in the Raspberry Pi and Roku 2 devices.
>  
> +config RASPBERRYPI_POWER
> +	bool "Raspberry Pi power domain driver"
> +	depends on ARCH_BCM2835
> +	depends on RASPBERRYPI_FIRMWARE
> +	select PM_GENERIC_DOMAINS if PM
> +	select PM_GENERIC_DOMAINS_OF if PM
> +	help
> +	  This enables support for the RPi power domains which can be enabled
> +	  or disabled via the RPi firmware.
> +
>  config ARCH_BCM_63XX
>  	bool "Broadcom BCM63xx DSL SoC" if ARCH_MULTI_V7
>  	depends on MMU

I'd love to have this be "depends on ARCH_BCM2835 || COMPILE_TEST" --
that gets us better coverage from automated builders in -next.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151124/eecdb336/attachment.sig>
