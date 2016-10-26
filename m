From: j.anaszewski@samsung.com (Jacek Anaszewski)
Date: Wed, 26 Oct 2016 16:47:38 +0200
Subject: [PATCH] mfd: qcom-pm8xxx: Clean up PM8XXX namespace
In-Reply-To: <1477487453-15801-1-git-send-email-linus.walleij@linaro.org>
References: <CGME20161026131107eucas1p28d2158fd35e37a8ccde822d4e9a018e9@eucas1p2.samsung.com>
 <1477487453-15801-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <fbb3cfce-2404-d579-9660-75ef1baf221a@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 10/26/2016 03:10 PM, Linus Walleij wrote:
> The Kconfig and file naming for the PM8xxx driver is totally
> confusing:
>
> - Kconfig options MFD_PM8XXX and MFD_PM8921_CORE, some in-kernel
>   users depending on or selecting either at random.
> - A driver file named pm8921-core.c even if it is indeed
>   used by the whole PM8xxx family of chips.
> - An irqchip named pm8xxx since it was (I guess) realized that
>   the driver was generic for all pm8xxx PMICs.
>
> As I may want to add support for PM8901 this is starting to get
> really messy. Fix this situation by:
>
> - Remove the MFD_PM8921_CORE symbol and rely solely on MFD_PM8XXX
>   and convert all users, including LEDs Kconfig and ARM defconfigs
>   for qcom and multi_v7 to use that single symbol.
> - Renaming the driver to qcom-pm8xxx.c to fit along the two
>   other qcom* prefixed drivers.
> - Rename functions withing the driver from 8921 to 8xxx to
>   indicate it is generic.
> - Just drop the =m config from the pxa_defconfig, I have no clue
>   why it is even there, it is not a Qualcomm platform. (Possibly
>   older Kconfig noise from saveconfig.)
>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I do NOT think it is a good idea to try to split this commit up,
> I rather prefer that Lee simply merge it into MFD.
>
> The reason is that files like qcom_defconfig already contain both
> the right symbols, but the MFD_PM8921_CORE symbol cannot be removed
> until this rename has happened, whereas multi_v7_defconfig needs
> it added etc, and this is just a clean nice cut.
>
> Jacek, ARM SoC person: please ACK this patch to get merged into
> MFD.
> ---
[...]

> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 7a628c6516f6..86bb1515a00e 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -645,7 +645,7 @@ config LEDS_VERSATILE
>
>  config LEDS_PM8058
>  	tristate "LED Support for the Qualcomm PM8058 PMIC"
> -	depends on MFD_PM8921_CORE
> +	depends on MFD_PM8XXX
>  	depends on LEDS_CLASS
>  	help
>  	  Choose this option if you want to use the LED drivers in

Acked-by: Jacek Anaszewski <j.anaszewski@samsung.com>

-- 
Best regards,
Jacek Anaszewski
