From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 4 Nov 2018 13:27:55 +0100
Subject: [PATCH 05/15] Platform: OLPC: Move OLPC config symbol out of x86
 tree
In-Reply-To: <20181010172300.317643-6-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-6-lkundrak@v3.sk>
Message-ID: <20181104122755.GZ23864@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2018-10-10 19:22:50, Lubomir Rintel wrote:
> There are ARM OLPC machines that use mostly the same drivers, including
> EC infrastructure, DCON and Battery.
> 
> While at that, fix Kconfig to allow building this as a module.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  arch/x86/Kconfig                  | 11 -----------
>  drivers/input/mouse/Kconfig       |  2 +-
>  drivers/platform/Kconfig          |  2 ++
>  drivers/platform/olpc/Kconfig     | 11 +++++++++++
>  drivers/staging/olpc_dcon/Kconfig |  2 +-
>  5 files changed, 15 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/platform/olpc/Kconfig
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 1a0be022f91d..be6af341a718 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2729,17 +2729,6 @@ config SCx200HR_TIMER
>  	  processor goes idle (as is done by the scheduler).  The
>  	  other workaround is idle=poll boot option.
>  
> -config OLPC
> -	bool "One Laptop Per Child support"
> -	depends on !X86_PAE
> -	select GPIOLIB
> -	select OF
> -	select OF_PROMTREE
> -	select IRQ_DOMAIN
> -	---help---
> -	  Add support for detecting the unique features of the OLPC
> -	  XO hardware.
> -
>  config OLPC_XO1_PM
>  	bool "OLPC XO-1 Power Management"
>  	depends on OLPC && MFD_CS5535 && PM_SLEEP
> diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
> index 566a1e3aa504..58034892a4df 100644
> --- a/drivers/input/mouse/Kconfig
> +++ b/drivers/input/mouse/Kconfig
> @@ -165,7 +165,7 @@ config MOUSE_PS2_TOUCHKIT
>  
>  config MOUSE_PS2_OLPC
>  	bool "OLPC PS/2 mouse protocol extension"
> -	depends on MOUSE_PS2 && OLPC
> +	depends on MOUSE_PS2 && X86 && OLPC
>  	help
>  	  Say Y here if you have an OLPC XO-1 laptop (with built-in
>  	  PS/2 touchpad/tablet device).  The manufacturer calls the
> diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
> index d4c2e424a700..4313d73d3618 100644
> --- a/drivers/platform/Kconfig
> +++ b/drivers/platform/Kconfig
> @@ -10,3 +10,5 @@ source "drivers/platform/goldfish/Kconfig"
>  source "drivers/platform/chrome/Kconfig"
>  
>  source "drivers/platform/mellanox/Kconfig"
> +
> +source "drivers/platform/olpc/Kconfig"
> diff --git a/drivers/platform/olpc/Kconfig b/drivers/platform/olpc/Kconfig
> new file mode 100644
> index 000000000000..7b736c9e67ac
> --- /dev/null
> +++ b/drivers/platform/olpc/Kconfig
> @@ -0,0 +1,11 @@
> +config OLPC
> +	tristate "One Laptop Per Child support"
> +	depends on X86 || ARM || COMPILE_TEST
> +	depends on !X86_PAE
> +	select GPIOLIB
> +	select OF
> +	select OF_PROMTREE if X86
> +	select IRQ_DOMAIN
> +	help
> +	  Add support for detecting the unique features of the OLPC
> +	  XO hardware.
> diff --git a/drivers/staging/olpc_dcon/Kconfig b/drivers/staging/olpc_dcon/Kconfig
> index c91a56f77bcb..07f9f1de8667 100644
> --- a/drivers/staging/olpc_dcon/Kconfig
> +++ b/drivers/staging/olpc_dcon/Kconfig
> @@ -1,6 +1,6 @@
>  config FB_OLPC_DCON
>  	tristate "One Laptop Per Child Display CONtroller support"
> -	depends on OLPC && FB
> +	depends on X86 && OLPC && FB
>  	depends on I2C
>  	depends on (GPIO_CS5535 || GPIO_CS5535=n)
>  	select BACKLIGHT_CLASS_DEVICE

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181104/4a4f1b55/attachment.sig>
