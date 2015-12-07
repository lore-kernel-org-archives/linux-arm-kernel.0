From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 07 Dec 2015 15:35:10 -0800
Subject: [PATCH v2 3/5] ARM: bcm2835: add rpi power domain driver
In-Reply-To: <1449251148-19344-4-git-send-email-eric@anholt.net> (Eric
 Anholt's message of "Fri, 4 Dec 2015 09:45:46 -0800")
References: <1449251148-19344-1-git-send-email-eric@anholt.net>
 <1449251148-19344-4-git-send-email-eric@anholt.net>
Message-ID: <7hmvtln87l.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Anholt <eric@anholt.net> writes:

> From: Alexander Aring <alex.aring@gmail.com>
>
> This patch adds support for several power domains on Raspberry Pi,
> including USB (so it can be enabled even if the bootloader didn't do
> it), and graphics.
>
> This patch is the combined work of Eric Anholt (who wrote USB support
> inside of the Raspberry Pi firmware driver, and wrote the non-USB
> domain support) and Alexander Aring (who separated the original USB
> work out from the firmware driver).
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>
> v2: Add support for power domains other than USB, using the new
>     firmware interface, reword commit message (changes by Eric)

[...]

> +/*
> + * Firmware indices for the old power domains interface.  Only a few
> + * of them were actually implemented.
> + */
> +#define RPI_OLD_POWER_DOMAIN_USB		3
> +#define RPI_OLD_POWER_DOMAIN_V3D		10
> +

Is "old" the right word here?  Are there firmware versions that could be
used instead?  What happens when the firwmware is updated next time?

[...]

> +	/*
> +	 * Use the old firmware interface for USB power, so that we
> +	 * can turn it on even if the firmware hasn't been updated.
> +	 */
> +	rpi_init_old_power_domain(rpi_domains, RPI_POWER_DOMAIN_USB,
> +				  RPI_OLD_POWER_DOMAIN_USB, "USB");

This seems a bit restrictive.

To me, it seems that determining "old" or "new" (or revision of fw
interface to use) should be described in DT, not hard-coded in the power
domain driver.

What about an additional DT property to describe that? or possibly
another cell in the domain which could be used to optionally set
old/legacy.

Kevin
