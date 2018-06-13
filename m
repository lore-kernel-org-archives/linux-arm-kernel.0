From: nm@ti.com (Nishanth Menon)
Date: Wed, 13 Jun 2018 16:31:44 -0500
Subject: [PATCH 3/4] ARM: mach-omap2: omap5/dra7: Enable ACTLR[0] (Enable
 invalidates of BTB) to facilitate CVE_2017-5715 WA in OS
In-Reply-To: <330ff593-4663-5393-74b3-55bf1f199561@gmail.com>
References: <20180612202411.29798-1-nm@ti.com>
 <20180612202411.29798-4-nm@ti.com>
 <780935f6-6506-0915-dfb2-b584c074b70d@gmail.com>
 <20180613173634.GC17671@n2100.armlinux.org.uk>
 <330ff593-4663-5393-74b3-55bf1f199561@gmail.com>
Message-ID: <20180613213144.htyg7guzjourkc3r@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20:36-20180613, Marek Vasut wrote:
> On 06/13/2018 07:36 PM, Russell King - ARM Linux wrote:
> > On Wed, Jun 13, 2018 at 01:06:13AM +0200, Marek Vasut wrote:
> >> On 06/12/2018 10:24 PM, Nishanth Menon wrote:
> >>> Enable CVE_2017_5715 and since we have our own v7_arch_cp15_set_acr
> >>> function to setup the bits, we are able to override the settings.
> >>>
> >>> Without this enabled, Linux kernel reports:
> >>> CPU0: Spectre v2: firmware did not set auxiliary control register IBE bit, system vulnerable
> >>>
> >>> With this enabled, Linux kernel reports:
> >>> CPU0: Spectre v2: using ICIALLU workaround
> >>>
> >>> NOTE: This by itself does not enable the workaround for CPU1 (on
> >>> OMAP5 and DRA72/AM572 SoCs) and may require additional kernel patches.
> >>>
> >>> Signed-off-by: Nishanth Menon <nm@ti.com>
> >>> ---
> >>>  arch/arm/mach-omap2/Kconfig | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> >>> index 3bb1ecb58de0..77820cc8d1e4 100644
> >>> --- a/arch/arm/mach-omap2/Kconfig
> >>> +++ b/arch/arm/mach-omap2/Kconfig
> >>> @@ -53,6 +53,7 @@ config OMAP54XX
> >>>  	bool "OMAP54XX SoC"
> >>>  	select ARM_ERRATA_798870
> >>>  	select SYS_THUMB_BUILD
> >>> +	select ARM_CORTEX_A15_CVE_2017_5715
> >>>  	imply NAND_OMAP_ELM
> >>>  	imply NAND_OMAP_GPMC
> >>>  	imply SPL_DISPLAY_PRINT
> >>>
> >>
> >> Can this be enabled for all CA15 systems somehow ? I am sure there are
> >> more that are vulnerable.
> > 
> > I think you're missing the point.
> 
> Please read the patch again.
> 
> This enables it only for a specific SoC. My point being, this should be
> enabled for all SoCs with CA15, not just some select few.
> 

As I had previously responded in
https://marc.info/?l=u-boot&m=152889727127549&w=2

I am not disagreeing this needs to be done for all CA15 based SoCs
(and A8s for previous patches ...), but.. I am not sure what you'd
like me to do here -> I just dont know what the SMC convention is
for all SoCs with CA15! I can help with TI SoCs for sure.. but then,
Russell has a point that this is just one part of the solution -> on
devices that provide secure services, there is definitely a need to
lock the secure entry points down as well. But, specifically to this
patch, do recommend an alternative if one exists.. will gladly follow.

-- 
Regards,
Nishanth Menon
