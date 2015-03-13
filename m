From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Mar 2015 11:08:37 +0100
Subject: [PATCH 2/2] pinctrl: mediatek: Adjust mt8173 pinctrl kconfig
In-Reply-To: <1426229195.16768.278.camel@mtksdaap41>
References: <1425623091-30478-1-git-send-email-yingjoe.chen@mediatek.com>
 <3011616.9oVy3HN0Pj@wuerfel> <1426229195.16768.278.camel@mtksdaap41>
Message-ID: <3229743.TnQsZfzpM9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 March 2015 14:46:35 Yingjoe Chen wrote:
> > which will let you turn on the options if COMPILE_TEST is set, but not
> > let you turn them off when the drivers are required.
> 
> Yes, this is preferred. Because we don't have MACH_MT8173, so it is
> possible a ARM64 + ARCH_MEDIATEK system doesn't need PINCTRL_MT8173, so
> we still need 2 slightly different logic. Is it OK if I do this?
> Also add some comments so future SoCs can follow the correct template.
> 
> # For ARMv7 SoCs
> config PINCTRL_MT8135
>         bool "Mediatek MT8135 pin control" if COMPILE_TEST && !MACH_MT8135
>         default MACH_MT8135
>         select PINCTRL_MTK_COMMON
> 
> # For ARMv8 SoCs
> config PINCTRL_MT8173
>         bool "Mediatek MT8173 pin control"
>         depends on ARM64 || COMPILE_TEST
>         default ARM64
>         select PINCTRL_MTK_COMMON
> 

Looks good with one modification: please make it

	default ARM64 && ARCH_MEDIATEK

so the driver does not get turned on by default for ARM64 configurations that
do not contain support for mediatek chips.

	Arnd
