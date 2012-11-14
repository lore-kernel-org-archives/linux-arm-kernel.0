From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Nov 2012 11:19:00 -0800
Subject: [PATCH] ARM: Fix errata 751472 handling on Cortex-A9 r1p*
In-Reply-To: <20121114190137.GD3332@n2100.arm.linux.org.uk>
References: <20121114185335.GU6801@atomide.com>
 <20121114190137.GD3332@n2100.arm.linux.org.uk>
Message-ID: <20121114191859.GW6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [121114 11:03]:
> On Wed, Nov 14, 2012 at 10:53:35AM -0800, Tony Lindgren wrote:
> > Looks like enabling CONFIG_ARM_ERRATA_751472 causes omap4 blaze
> > to not boot when enabled. The ARM core on it is an earlier r1p2:
> > 
> > CPU: ARMv7 Processor [411fc092] revision 2 (ARMv7), cr=10c53c7d
> > 
> > Unfortunately I don't have the details of errata 751472, but I'm
> > guessing we need to disable it for r1p*.
> 
> Fails because it can't write the diagnostic register from non-secure
> mode or fails later?

Hmm good question, it fails a bit later on during the boot just
before __enable_mmu.

But I just tried commenting out the setting of bit 11:

@orrlt	r10, r10, #1 << 11              @ set bit #11

And just trying to write the unmodified diagnostic register
also makes it fail.

So yeah it seems to be related to the secure crap instead :(

Regards,

Tony
