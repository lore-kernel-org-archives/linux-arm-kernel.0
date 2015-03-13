From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Fri, 13 Mar 2015 14:46:35 +0800
Subject: [PATCH 2/2] pinctrl: mediatek: Adjust mt8173 pinctrl kconfig
In-Reply-To: <3011616.9oVy3HN0Pj@wuerfel>
References: <1425623091-30478-1-git-send-email-yingjoe.chen@mediatek.com>
 <1425623091-30478-2-git-send-email-yingjoe.chen@mediatek.com>
 <3011616.9oVy3HN0Pj@wuerfel>
Message-ID: <1426229195.16768.278.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Hi Arnd,

Thanks for your suggestion.

On Mon, 2015-03-09 at 21:36 +0100, Arnd Bergmann wrote:
> On Friday 06 March 2015 14:24:51 Yingjoe Chen wrote:
> > Linus,
> > This one make PINCTRL_MT8173 option user selectable and is based on
> > mtk-staging in your tree. If you think this is OK, please applied or
> > squash this into previous change. Thanks.
> 
> The patch looks good in principle, just two small comments
> 
> > --------------------------------------------------
> 
> To simplify the job for Linus here, please start the line above
> with 
> 
> 8<------
> 
> (a stylized pair if scissors)
> 
> which is the magic that git-am looks for.

Will do next time.


<...>
> You have slightly different logic here: PINCTRL_MT8135 will
> always be enabled when COMPILE_TEST is on, while PINCTRL_MT8173
> is enabled by default in this case, but can be turned off.
> Neither of them is what you really want, which would be
> 
> config PINCTRL_MT8135
> 	bool "Mediatek MT8135 pin control"
> 	depends on MACH_MT8135 || COMPILE_TEST
> 	default MACH_MT8135
> 	select PINCTRL_MTK_COMMON
> 
> config PINCTRL_MT8135
> 	bool "Mediatek MT8173 pin control"
> 	depends on MACH_MT8173 || COMPILE_TEST
> 	default MACH_MT8173
> 	select PINCTRL_MTK_COMMON
> 
> This way, the options are only enabled by default if MACH_MT8135
> or MACH_MT8173 are enabled, but you are free to enable or disable
> them when COMPILE_TEST is set. Alternatively, you can do
> 
> config PINCTRL_MT8135
> 	bool "Mediatek MT8135 pin control" if COMPILE_TEST && !MACH_MT8135
> 	default MACH_MT8135
> 	select PINCTRL_MTK_COMMON
> 
> config PINCTRL_MT8135
> 	bool "Mediatek MT8173 pin control" if COMPILE_TEST && !MACH_MT8173
> 	default MACH_MT8173
> 	select PINCTRL_MTK_COMMON
> 
> which will let you turn on the options if COMPILE_TEST is set, but not
> let you turn them off when the drivers are required.

Yes, this is preferred. Because we don't have MACH_MT8173, so it is
possible a ARM64 + ARCH_MEDIATEK system doesn't need PINCTRL_MT8173, so
we still need 2 slightly different logic. Is it OK if I do this?
Also add some comments so future SoCs can follow the correct template.

# For ARMv7 SoCs
config PINCTRL_MT8135
        bool "Mediatek MT8135 pin control" if COMPILE_TEST && !MACH_MT8135
        default MACH_MT8135
        select PINCTRL_MTK_COMMON

# For ARMv8 SoCs
config PINCTRL_MT8173
        bool "Mediatek MT8173 pin control"
        depends on ARM64 || COMPILE_TEST
        default ARM64
        select PINCTRL_MTK_COMMON

Joe.C
