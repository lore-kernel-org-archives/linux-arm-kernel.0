From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 23:08:28 +0100
Subject: [PATCH v2 1/3] ARM: qcom: Make an option for qcom clocksource
 platforms
In-Reply-To: <1448485478-21699-2-git-send-email-sboyd@codeaurora.org>
References: <1448485478-21699-1-git-send-email-sboyd@codeaurora.org>
 <1448485478-21699-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <6140735.DAZiajTbh1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 November 2015 13:04:36 Stephen Boyd wrote:
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 2c2b28ee4811..999d523ac09f 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -148,8 +148,7 @@ textofs-$(CONFIG_PM_H1940)      := 0x00108000
>  ifeq ($(CONFIG_ARCH_SA1100),y)
>  textofs-$(CONFIG_SA1111) := 0x00208000
>  endif
> -textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
> -textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
> +textofs-$(CONFIG_HAVE_CLKSRC_QCOM) := 0x00208000
>  textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
>  
>  # Machine directory name.  This list is sorted alphanumerically
> diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
> index 2256cd1e25d1..35a03967d9c2 100644
> --- a/arch/arm/mach-qcom/Kconfig
> +++ b/arch/arm/mach-qcom/Kconfig
> @@ -10,6 +10,14 @@ menuconfig ARCH_QCOM
>  
>  if ARCH_QCOM
>  
> +config HAVE_CLKSRC_QCOM
> +       bool "Support platforms with qcom clocksource"
> +       default y
> +       select CLKSRC_QCOM
> +       help
> +         Select this option if you want to support platforms
> +         with the qcom clocksource such as MSM8660 and MSM8960.

Hmm, if we use the option for two things, I think it could use
a different identifier and title, as it seems counterintuitive
to make the text offset based on the clocksource driver.

Is there any common way to classify these, e.g. calling them
'pre-2013 models' or 'Snapdragon S4' as a way to identify them?

The way it appears in Kconfig also still needs to reflect how
this is a subset of the supported platforms (as your current
patch does correctly).

	Arnd
