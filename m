From: dwalker@codeaurora.org (Daniel Walker)
Date: Fri, 10 Sep 2010 14:01:48 -0700
Subject: [PATCH 1/4] arm: Kconfig option for ARCH_MSM_SCORPIONMP
In-Reply-To: <20100910203635.GA13790@n2100.arm.linux.org.uk>
References: <1284062289-10914-1-git-send-email-dwalker@codeaurora.org>
	<1284062289-10914-2-git-send-email-dwalker@codeaurora.org>
	<20100910203635.GA13790@n2100.arm.linux.org.uk>
Message-ID: <1284152508.21256.12.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-09-10 at 21:36 +0100, Russell King - ARM Linux wrote:
> On Thu, Sep 09, 2010 at 12:58:06PM -0700, Daniel Walker wrote:
> > From: Steve Muckle <smuckle@codeaurora.org>
> > 
> > ScorpionMP is a configuration of Scorpion processors. It supports local
> > timers.
> 
> Beware - things have changed around here - relevant hunks from my
> devel branch:

Yeah, that's why I wanted to send out these patches.. I saw an earlier
email that suggested you changed this area. I didn't want to base my
tree off your devel branch tho.

> @@ -1142,13 +1145,13 @@ source "kernel/time/Kconfig"
> 
>  config SMP
>         bool "Symmetric Multi-Processing (EXPERIMENTAL)"
> -       depends on EXPERIMENTAL && (REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP ||\
> -                MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 ||\
> -                ARCH_S5PV310 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4)
> +       depends on EXPERIMENTAL
>         depends on GENERIC_CLOCKEVENTS
> +       depends on REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP || \
> +                MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 ||\
> +                ARCH_S5PV310 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4        select USE_GENERIC_SMP_HELPERS
> -       select HAVE_ARM_SCU if ARCH_REALVIEW || ARCH_OMAP4 || ARCH_S5PV310 ||\
> -                ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4
> +       select HAVE_ARM_SCU
>         help
>           This enables support for systems with more than one CPU. If you have
>           a system with only one CPU, like most personal computers, say N. If
> @@ -1216,12 +1232,9 @@ config HOTPLUG_CPU
> 
>  config LOCAL_TIMERS
>         bool "Use local timer interrupts"
> -       depends on SMP && (REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || \
> -               REALVIEW_EB_A9MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
> -               ARCH_S5PV310 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4)+       depends on SMP
>         default y
> -       select HAVE_ARM_TWD if ARCH_REALVIEW || ARCH_OMAP4 || ARCH_S5PV310 || \
> -               ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS
> +       select HAVE_ARM_TWD
>         help
>           Enable support for local timers on SMP platforms, rather then the
>           legacy IPI broadcast method.  Local timers allows the system
> 
> Basically, everyone who was supporting SMP also supported local timers,
> TWD and SCU, so having the big long lists of dependencies was becoming
> silly.
> 
> If anyone (ever) creates a SMP implementation not using ARMs TWD/GIC/SCU,
> then we can see about changing the way we handle the support for these.

We actually don't have SCU or TWD. So I suppose we can just have
"if !ARCH_MSM" for SCU/TWD , if that's reasonable. How do you want to me
to make changes to this area tho?

Daniel

-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
