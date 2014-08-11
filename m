From: dianders@chromium.org (Doug Anderson)
Date: Mon, 11 Aug 2014 08:13:45 -0700
Subject: [RESEND PATCH 1/1] ARM: exynos_defconfig: Enable SBS battery
 support
In-Reply-To: <1407755198-17568-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1407755198-17568-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <CAD=FV=WD_-_SkixY0pZ7Auoe-kV3EkK6ksDnbe0ApT8-hfnHNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier,

On Mon, Aug 11, 2014 at 4:06 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> Many Exynos5 boards (e.g: Snow, Peach Pit and Pi) have
> a SBS-compliant gas gauge battery. Enable it as module
> so the needed support is available for these boards.
>
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/configs/exynos_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index fc7d168..c390bb9 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -77,6 +77,7 @@ CONFIG_SPI_S3C64XX=y
>  CONFIG_I2C_S3C2410=y
>  CONFIG_DEBUG_GPIO=y
>  CONFIG_POWER_SUPPLY=y
> +CONFIG_BATTERY_SBS=m
>  CONFIG_CHARGER_TPS65090=y
>  # CONFIG_HWMON is not set
>  CONFIG_THERMAL=y

I'm good with this, so:

Reviewed-by: Doug Anderson <dianders@chromium.org>

To address Bartlomiej: =m is what's in ChromeOS for exynos, though I
notice that other platforms in the ChromeOS tree have =y.  I'm not
sure why there is a difference, but it's probably just carelessness.

Normally in ChromeOS we use "=m" for drivers that can afford to wait
until after the UI is up and running.  That helps improve boot time
since the user can use the device sooner (and it's OK if the battery
driver takes a few extra seconds to load).  The only things that
really should be "=y" are drivers that are critical to load early or
that are needed for the user to interact with the system.  In this
case you could argue that loading sbs earlier means that if the system
is low on battery it will get back to "shutdown" sooner.  I'm not sure
getting the shutdown a few seconds earlier is really critical,
though...

-Doug
