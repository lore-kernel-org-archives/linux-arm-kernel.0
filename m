From: djkurtz@chromium.org (Daniel Kurtz)
Date: Wed, 24 Jun 2015 20:45:34 +0800
Subject: [PATCH v6] Mediatek SCPSYS power domain support
In-Reply-To: <1435126625-9634-1-git-send-email-s.hauer@pengutronix.de>
References: <1435126625-9634-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CAGS+omChoraBvvdQ5LAbKRqCYfUkdRd_x7ZcokM1O3mOQwDL3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 24, 2015 at 2:17 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Just a small update to this series with a memory corruption bug fixed.
>
> This series adds support for the MediaTek SCPSYS unit.
>
> The SCPSYS unit handles several power management related tasks such
> as thermal measurement, DVFS, interrupt filter and low level sleep
> control.
>
> The initial support only contains the generic power domain handling.
> This is needed to turn on power to the different power domains.
>
> The driver is quite straight forward now. Due to the lack of a better
> place I have put it to drivers/soc/mediatek. As the SCPSYS unit has
> several other tasks that also do not fit into some specific subsystem
> this probably is a good place for this driver.
>
> Please review, any input welcome.

For the series:

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

>
> Sascha
>
> changes since v5:
> - Fix array out of bounds access
> - Fix typo
>
> Changes since v4:
> - move Kconfig dependency "select PM_GENERIC_DOMAINS if PM" from arch/arm64
>   next to the driver which needs this dependency
> - drop unnecessary clk[] array from struct scp and make the array local to
>   the function which needs it.
> - Disable clock when enabling the domain fails
> - Drop error message when devm_clk_get fails. The core already issues a
>   similar warning
> - Add clocks/clock-names description to the binding doc
>
> Changes since v3:
> - Drop unnecessary MODULE_* macros for builtin code
> - introduce scpsys_domain_is_on() function instead of open coding this
>   twice
> - Drop unnecessary initialisation of power_o[ff|n]_latencies. The kernel
>   updates them with the measured values anyway.
>
> changes since v2:
> - Add missing include/linux/soc/mediatek/infracfg.h file
> - rename VDE -> VDEC, VEN -> VENC, DIS -> DISP and VEN2 -> VENC_LT
>   to make the abbreviatons more clear
> - make of_device_id const
> - remove double loop
> - fix hunk in wrong patch
> - Fix order of domains. Some domains depend on other domains. Reorder
>   the domains so that all domains can be turned on in order when
>   CONFIG_PM is disabled. Also fixes earlier mixups in the domain array
> - Do not allow compilation as modules. pm_domains cannot be removed, so
>   compilation as module is not that useful
> - reorder Kconfig items alphabetically
> - reorder #includes alphabetically
> - select MTK_INFRACFG instead of depending on it
> - Use only two clocks as dependencies for the domains. The previously
>   used 5 clocks are not necessary as confirmed by the hardware designers
> - use 'genpd' as variable name for struct generic_pm_domain like done in
>   other pm code
>
> changes since v1:
> - make MFG_ASYNC a subdomain of MFG_2D and MFG_2D a subdomain of MFG
> - Add (now hopefully properly) infracfg register handling again
> - Add clock handling
> - Fix on/off mixup in error message
> - Make readonly data const
> - Fix MODULE_LICENSE to GPL v2
>
> changes since RFC:
>
> - add a commit log to driver patch
> - drop manipulating infracfg registers for now, can be added (properly)
>   later
> - Add warning messages when errors occur
> - add NULL pointer check for kmalloc
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
