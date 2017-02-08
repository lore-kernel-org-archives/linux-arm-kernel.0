From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Feb 2017 18:52:26 +0000
Subject: [PATCH] ARM: xip: disable PATCH_PHYS_VIRT for ARCH_MULTIPLATFORM
 when XIP
In-Reply-To: <SG2PR06MB116573368B09D2E36C5C70F98A420@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170208172209.31673-1-chris.brandt@renesas.com>
 <20170208174437.GW27312@n2100.armlinux.org.uk>
 <SG2PR06MB116573368B09D2E36C5C70F98A420@SG2PR06MB1165.apcprd06.prod.outlook.com>
Message-ID: <20170208185226.GY27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2017 at 06:00:26PM +0000, Chris Brandt wrote:
> On Wednesday, February 08, 2017, Russell King wrote:
> > On Wed, Feb 08, 2017 at 12:22:09PM -0500, Chris Brandt wrote:
> > > Since ARCH_MULTIPLATFORM explicitly selects ARM_PATCH_PHYS_VIRT, even
> > > though ARCH_MULTIPLATFORM has 'depends on !XIP_KERNEL',
> > > ARM_PATCH_PHYS_VIRT is still forcibly selected. The result is that
> > > PHYS_OFFSET depends on !ARM_PATCH_PHYS_VIRT. This means you cannot
> > > enter a physical RAM address for an XIP kernel and you cannot build.
> > >
> > > Given that it is already clear in the Kconfig that ARM_PATCH_PHYS_VIRT
> > > and XIP_KERNEL do not go well together (read the help for
> > > ARM_PATCH_PHYS_VIRT), adding this condition to ARCH_MULTIPLATFORM is
> > > logical and will fix this build issue.
> > 
> > And, ergo, multiplatform kernels and XIP_KERNEL don't go together either.
> > Think about it...
> > 
> > This is why I regard those who want multiplatform to work with options
> > such as XIP_KERNEL and NOMMU to be insane.
> 
> It's not so much that I want multiplatform and XIP together (because
> absolutely they do not), it's that the SOC I care about is shoved under
> the multiplatform umbrella.

Right, and that's what I hear all the time, but it's not really an
argument that stacks up.

We have the big "ARM system type" choice, one of the options there is
to build for multi-platform.  Historically, it's been to select the
SoC family - where "SoC family" means a group of SoCs that could be
built together into one image without all the fun and games of V:P
patching, auto-zreladdr, etc - _exactly_ the conditions that !MMU
and XIP_KERNEL depended upon[*].

To allow a SOC to be built without multiplatform, you add another
option to that choice statement (exactly as we used to have before
multiplatform).  For the sake of argument, let's say we're talking
about iMX ARMv7 SoCs.  So, let's call it ARM_SOC_IMX_V7.

You add to that all the select statements that multiplatform gives
you that you need for that platform, omitting those that don't make
sense (like virt/phys patching), making it depend on XIP_KERNEL and/or
!MMU.

Then you change the mach-*/Kconfig entry like this:

menuconfig ARCH_MXC
-       bool "Freescale i.MX family"
-       depends on ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7 || ARM_SINGLE_ARMV7M
+       bool "Freescale i.MX family" if !ARM_SOC_IMX_V7
+       depends on ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7 || ARM_SINGLE_ARMV7M ||\
+		ARM_SOC_IMX_V7
+	default ARM_SOC_IMX_V7

and also modify the if ARCH_MULTI_V7 to also allow that section if
ARM_SOC_IMX_V7 is enabled.


* - that's the problem - multiplatform went head-long into the "we
don't like the existing solution, we need to move everyone away, and
let's hope no one wants XIP_KERNEL or !MMU now".  So we went from a
relatively good solution that didn't support building diverse platforms
together to one that rather sucks for XIP_KERNEL and !MMU.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
