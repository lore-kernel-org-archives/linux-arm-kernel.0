From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Feb 2017 17:44:38 +0000
Subject: [PATCH] ARM: xip: disable PATCH_PHYS_VIRT for ARCH_MULTIPLATFORM
 when XIP
In-Reply-To: <20170208172209.31673-1-chris.brandt@renesas.com>
References: <20170208172209.31673-1-chris.brandt@renesas.com>
Message-ID: <20170208174437.GW27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2017 at 12:22:09PM -0500, Chris Brandt wrote:
> Since ARCH_MULTIPLATFORM explicitly selects ARM_PATCH_PHYS_VIRT, even
> though ARCH_MULTIPLATFORM has 'depends on !XIP_KERNEL', ARM_PATCH_PHYS_VIRT
> is still forcibly selected. The result is that PHYS_OFFSET depends on
> !ARM_PATCH_PHYS_VIRT. This means you cannot enter a physical RAM address
> for an XIP kernel and you cannot build.
> 
> Given that it is already clear in the Kconfig that ARM_PATCH_PHYS_VIRT and
> XIP_KERNEL do not go well together (read the help for ARM_PATCH_PHYS_VIRT),
> adding this condition to ARCH_MULTIPLATFORM is logical and will fix this
> build issue.

And, ergo, multiplatform kernels and XIP_KERNEL don't go together either.
Think about it...

This is why I regard those who want multiplatform to work with options
such as XIP_KERNEL and NOMMU to be insane.

Please, can we stop trying to make multiplatform also cover the situations
where only a single class of platforms works (iow, the old way we used to
deal with platforms is the most sensible solution.)

IMHO multiplatform was done right for multiplatform but at the expense of
totally breaking stuff like XIP and noMMU.  We need to stop trying to
bend multiplatform to cover XIP and noMMU, but instead restore the old
way of handling this _along_ with multiplatform as an additional option.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
