From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Wed, 8 Feb 2017 19:08:52 +0000
Subject: [PATCH] ARM: xip: disable PATCH_PHYS_VIRT for ARCH_MULTIPLATFORM
 when XIP
In-Reply-To: <20170208185226.GY27312@n2100.armlinux.org.uk>
References: <20170208172209.31673-1-chris.brandt@renesas.com>
 <20170208174437.GW27312@n2100.armlinux.org.uk>
 <SG2PR06MB116573368B09D2E36C5C70F98A420@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20170208185226.GY27312@n2100.armlinux.org.uk>
Message-ID: <SG2PR06MB1165A3CC8452CF2901EDDC068A420@SG2PR06MB1165.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Wednesday, February 08, 2017, Russell King wrote:
> We have the big "ARM system type" choice, one of the options there is to
> build for multi-platform.  Historically, it's been to select the SoC
> family - where "SoC family" means a group of SoCs that could be built
> together into one image without all the fun and games of V:P patching,
> auto-zreladdr, etc - _exactly_ the conditions that !MMU and XIP_KERNEL
> depended upon[*].
> 
> To allow a SOC to be built without multiplatform, you add another option
> to that choice statement (exactly as we used to have before multiplatform).
> For the sake of argument, let's say we're talking about iMX ARMv7 SoCs.
> So, let's call it ARM_SOC_IMX_V7.
> 
> You add to that all the select statements that multiplatform gives you
> that you need for that platform, omitting those that don't make sense
> (like virt/phys patching), making it depend on XIP_KERNEL and/or !MMU.
> 
> Then you change the mach-*/Kconfig entry like this:
> 
> menuconfig ARCH_MXC
> -       bool "Freescale i.MX family"
> -       depends on ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7 ||
> ARM_SINGLE_ARMV7M
> +       bool "Freescale i.MX family" if !ARM_SOC_IMX_V7
> +       depends on ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7 ||
> ARM_SINGLE_ARMV7M ||\
> +		ARM_SOC_IMX_V7
> +	default ARM_SOC_IMX_V7
> 
> and also modify the if ARCH_MULTI_V7 to also allow that section if
> ARM_SOC_IMX_V7 is enabled.
> 
> 
> * - that's the problem - multiplatform went head-long into the "we don't
> like the existing solution, we need to move everyone away, and let's hope
> no one wants XIP_KERNEL or !MMU now".  So we went from a relatively good
> solution that didn't support building diverse platforms together to one
> that rather sucks for XIP_KERNEL and !MMU.


So, a quick hack and it seems that works. I get my family of SoC that I
can select XIP_KERNEL.

I'll do some build experiments, and if it looks like it will work, I'll
send off a patch to see how opposes it.
For the most part, if everyone is off playing in the multiplatform pool,
me creating a new ARM V7 single-platform pool won't affect anyone.



Chris
