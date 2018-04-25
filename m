From: dalias@libc.org (Rich Felker)
Date: Wed, 25 Apr 2018 10:02:01 -0400
Subject: [PATCH 03/11] platform: make support for early platform devices
 conditional
In-Reply-To: <20180424173051.15099-4-brgl@bgdev.pl>
References: <20180424173051.15099-1-brgl@bgdev.pl>
 <20180424173051.15099-4-brgl@bgdev.pl>
Message-ID: <20180425140201.GE3094@brightrain.aerifal.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 07:30:43PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We want to add support for device tree based early platform devices.
> 
> In order not to introduce additional bloat for all users when we extend
> struct device to accomodate early platform DT support, let's make the
> current machine code support conditional.
> 
> The only current user of the early platform infrastructure is SuperH so
> make it select the appropriate Kconfig option.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/sh/Kconfig                 |  1 +
>  drivers/base/Kconfig            |  4 ++++
>  drivers/base/platform.c         |  3 +++
>  include/linux/platform_device.h | 32 ++++++++++++++++++++++++++++++++
>  4 files changed, 40 insertions(+)
> 
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 97fe29316476..1b2c0b2ce402 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -50,6 +50,7 @@ config SUPERH
>  	select HAVE_ARCH_AUDITSYSCALL
>  	select HAVE_FUTEX_CMPXCHG if FUTEX
>  	select HAVE_NMI
> +	select EARLY_PLATFORM_DEVICES
>  	help
>  	  The SuperH is a RISC processor targeted for use in embedded systems
>  	  and consumer electronics; it was also used in the Sega Dreamcast

If SH is the only user and only intended user for this, don't add it.
None of the devices using legacy board files full of platform device
declarations are using device tree yet, and when we do convert them
they should use device tree correctly, not with hacks designed around
OS behavior rather than abstract hardware declaration.

Rich
