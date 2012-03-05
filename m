From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 5 Mar 2012 09:33:51 -0800
Subject: [PATCH v3 04/10] arm/tegra: Fix PWM clock programming
In-Reply-To: <20120303224751.GB6661@avionic-0098.mockup.avionic-design.de>
References: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
 <1329923841-32017-5-git-send-email-thierry.reding@avionic-design.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF1E52@HQMAIL01.nvidia.com>
 <20120303224751.GB6661@avionic-0098.mockup.avionic-design.de>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BE861C2E@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry Reding wrote at Saturday, March 03, 2012 3:48 PM:
> * Stephen Warren wrote:
> > Thierry Reding wrote at Wednesday, February 22, 2012 8:17 AM:
> > > PWM clock source registers in Tegra 2 have different clock source selection bit
> > > fields than other registers.  PWM clock source bits in CLK_SOURCE_PWM_0 register
> > > are located at bit field bit[30:28] while others are at bit field bit[31:30] in
> > > their respective clock source register.
> > >
> > > This patch updates the clock programming to correctly reflect that, by adding a
> > > flag to indicate the alternate bit field format and checking for it when
> > > selecting a clock source (parent clock).
> >
> > tegra30_clocks.c needs this change too, although on Tegra30, it's bits
> > 29:28 for the PWM, and bits 31:30 for non-PWM.
> 
> Okay, I'll add code for Tegra30 in the next version. I won't be able to test
> that at all because I don't have any Tegra30 hardware.

It looks like Tegra30 is already taken care of; see periph_clk_source_mask()
in tegra30_clocks.c, assuming that tegra_list_clks[] has the correct flags
set of each entry anyway. PWM does at least.

> > > diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c
> >
> > +#define PERIPH_CLK_SOURCE_4BIT_MASK	(7<<28)
> > +#define PERIPH_CLK_SOURCE_4BIT_SHIFT	28
> >
> > Why is this (and the flag that enables it) called "4 bit"; the existing
> > code supports a 2-bit mux field (4-values), whereas this new code supports
> > a 3-bit field (potentially 8 values, but only 5 actually assigned).
> > Can this be renamed something more accurate, especially since on Tegra30
> > the difference is only the bit position of the field, not the number of
> > bits in the field.
> 
> This is taken directly from the Chromium tree, so I don't really know why
> that name was chosen. But since the PWM clock source register seems to be the
> only exception, how about calling the flag PWM_CLK and prefix the shift and
> mask with PWM_CLK_SOURCE_ instead?

That sounds reasonable.

-- 
nvpublic
