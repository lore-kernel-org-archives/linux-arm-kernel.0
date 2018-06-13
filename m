From: nm@ti.com (Nishanth Menon)
Date: Wed, 13 Jun 2018 08:40:13 -0500
Subject: [PATCH 3/4] ARM: mach-omap2: omap5/dra7: Enable ACTLR[0] (Enable
 invalidates of BTB) to facilitate CVE_2017-5715 WA in OS
In-Reply-To: <780935f6-6506-0915-dfb2-b584c074b70d@gmail.com>
References: <20180612202411.29798-1-nm@ti.com>
 <20180612202411.29798-4-nm@ti.com>
 <780935f6-6506-0915-dfb2-b584c074b70d@gmail.com>
Message-ID: <20180613134013.mqicb2geehv2xu2g@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23:06-20180612, Marek Vasut wrote:
> On 06/12/2018 10:24 PM, Nishanth Menon wrote:
> > Enable CVE_2017_5715 and since we have our own v7_arch_cp15_set_acr
> > function to setup the bits, we are able to override the settings.
> > 
> > Without this enabled, Linux kernel reports:
> > CPU0: Spectre v2: firmware did not set auxiliary control register IBE bit, system vulnerable
> > 
> > With this enabled, Linux kernel reports:
> > CPU0: Spectre v2: using ICIALLU workaround
> > 
> > NOTE: This by itself does not enable the workaround for CPU1 (on
> > OMAP5 and DRA72/AM572 SoCs) and may require additional kernel patches.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> >  arch/arm/mach-omap2/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> > index 3bb1ecb58de0..77820cc8d1e4 100644
> > --- a/arch/arm/mach-omap2/Kconfig
> > +++ b/arch/arm/mach-omap2/Kconfig
> > @@ -53,6 +53,7 @@ config OMAP54XX
> >  	bool "OMAP54XX SoC"
> >  	select ARM_ERRATA_798870
> >  	select SYS_THUMB_BUILD
> > +	select ARM_CORTEX_A15_CVE_2017_5715
> >  	imply NAND_OMAP_ELM
> >  	imply NAND_OMAP_GPMC
> >  	imply SPL_DISPLAY_PRINT
> > 
> 
> Can this be enabled for all CA15 systems somehow ? I am sure there are
> more that are vulnerable.

I just dont know how to make smc call convention generic. This is the
reason why v7_arch_cp15_set_acr is setup as a weak function. you'd have
to implement it specific to SoC (in many newer SoCs, you might
potentially be able to make at least few implementations generic using
PSCI). NOTE: this is the same trouble with erratum 801819 implementation
as well.

-- 
Regards,
Nishanth Menon
