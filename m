From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Apr 2015 10:00:24 +0100
Subject: Two new breakages since Thursday
In-Reply-To: <20150405080645.GE13898@n2100.arm.linux.org.uk>
References: <20150405080645.GE13898@n2100.arm.linux.org.uk>
Message-ID: <20150411090024.GL12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

And almost a week later, and most of these are _still_ present.

Given that the merge window is potentially opening on Sunday, this
is _very_ poor, because it means that we've had a week of failing
builds in the week before the merge window - the week where we
_should_ be stabilising the code and getting it ready for submission
to Linus.

Right now, arm-soc is *NOT* ready for submission to Linus.

Please fix this as a top priority.

On Sun, Apr 05, 2015 at 09:06:45AM +0100, Russell King - ARM Linux wrote:
> Two new breakages have appeared since Thursday.  The first affects both
> ARM and ARM64 builds (a missing file), the second only ARM builds.
> 
> arch/arm64/boot/dts/mediatek/mt8173-pinfunc.h:18:40: fatal error: dt-bindings/pinctrl/mt65xx.h: No such file or directory
> arch/arm/boot/dts/mt8135-pinfunc.h:18:40: fatal error: dt-bindings/pinctrl/mt65xx.h: No such file or directory
> arch/arm/mach-at91/pm_suspend.S:143: Error: selected processor does not support ARM mode `dsb'
> 
> ARM64 breaks on a defconfig build, ARM breaks with these errors on
> an allmodconfig build.
> 
> The first two are due to the mediatek patches merged via the arm-soc
> tree.  The second is due to:
> 
> commit 20567658b8f010eea287087bfdbeb25757801aed
> Author: Wenyou Yang <wenyou.yang@atmel.com>
> Date:   Mon Mar 9 11:53:46 2015 +0800
> 
>     ARM: at91/pm_suspend: add the WFI instruction support for ARMv7
> 
> which looks to me like completely the wrong solution:
> 
> +       .macro at91_cpu_idle
> +
> +#if defined(CONFIG_CPU_V7)
> +       mov     tmp1, #AT91_PMC_PCK
> +       str     tmp1, [pmc, #AT91_PMC_SCDR]
> +
> +       dsb
> +
> +       wfi             @ Wait For Interrupt
> +#else
> +       mcr     p15, 0, tmp1, c7, c0, 4
> +#endif
> +
> +       .endm
> 
> So, if we build a kernel with ARMc6 and ARMv7 CPUs, AT91 ends up using
> ARMv7-only instructions in this function, which will cause an illegal
> instruction exception on ARMv6 CPUs.
> 
> -- 
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
