From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Wed, 8 Feb 2017 18:00:26 +0000
Subject: [PATCH] ARM: xip: disable PATCH_PHYS_VIRT for ARCH_MULTIPLATFORM
 when XIP
In-Reply-To: <20170208174437.GW27312@n2100.armlinux.org.uk>
References: <20170208172209.31673-1-chris.brandt@renesas.com>
 <20170208174437.GW27312@n2100.armlinux.org.uk>
Message-ID: <SG2PR06MB116573368B09D2E36C5C70F98A420@SG2PR06MB1165.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, February 08, 2017, Russell King wrote:
> On Wed, Feb 08, 2017 at 12:22:09PM -0500, Chris Brandt wrote:
> > Since ARCH_MULTIPLATFORM explicitly selects ARM_PATCH_PHYS_VIRT, even
> > though ARCH_MULTIPLATFORM has 'depends on !XIP_KERNEL',
> > ARM_PATCH_PHYS_VIRT is still forcibly selected. The result is that
> > PHYS_OFFSET depends on !ARM_PATCH_PHYS_VIRT. This means you cannot
> > enter a physical RAM address for an XIP kernel and you cannot build.
> >
> > Given that it is already clear in the Kconfig that ARM_PATCH_PHYS_VIRT
> > and XIP_KERNEL do not go well together (read the help for
> > ARM_PATCH_PHYS_VIRT), adding this condition to ARCH_MULTIPLATFORM is
> > logical and will fix this build issue.
> 
> And, ergo, multiplatform kernels and XIP_KERNEL don't go together either.
> Think about it...
> 
> This is why I regard those who want multiplatform to work with options
> such as XIP_KERNEL and NOMMU to be insane.

It's not so much that I want multiplatform and XIP together (because
absolutely they do not), it's that the SOC I care about is shoved under
the multiplatform umbrella.


> Please, can we stop trying to make multiplatform also cover the situations
> where only a single class of platforms works (iow, the old way we used to
> deal with platforms is the most sensible solution.)
> 
> IMHO multiplatform was done right for multiplatform but at the expense of
> totally breaking stuff like XIP and noMMU.  We need to stop trying to bend
> multiplatform to cover XIP and noMMU, but instead restore the old way of
> handling this _along_ with multiplatform as an additional option.

A while back there was a grandiose idea if it would be great you only selected
1 (and only 1) of the platforms in a multiplatform arch, then and only then
would the XIP option become available for you.
However, I tried everything I could, but the kbuild system just doesn't have
a way to do such a thing. So, I'm back to shoving XIP and multiplatform
together.

So, any ideas on how I can take an ARCH_xxx and make it show up under
both single and multiplatform??

Can I get away with making a separate ARCH_xxx_XIP that selects ARCH_xxx?

Of course I just tested 4.10-rc7 for XIP+MMU and it works fine, but I have
to hack the Kconfig each time.

Chris
