From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 11 Oct 2012 15:18:54 +0200
Subject: [PATCH 5/6] ARM: EXYNOS: Add support for Exynos secure firmware
In-Reply-To: <20121010160027.GA582@quad.lixom.net>
References: <1348496913-25422-1-git-send-email-t.figa@samsung.com>
 <1348496913-25422-6-git-send-email-t.figa@samsung.com>
 <20121010160027.GA582@quad.lixom.net>
Message-ID: <2052356.3jlgOizW0Z@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Wednesday 10 of October 2012 09:00:27 Olof Johansson wrote:
> Hi,
> 
> On Mon, Sep 24, 2012 at 04:28:32PM +0200, Tomasz Figa wrote:
> > Some Exynos-based boards contain secure firmware and must use firmware
> > operations to set up some hardware.
> > 
> > This patch adds firmware operations for Exynos secure firmware and a
> > way
> > for board code and device tree to specify that they must be used.
> > 
> > Example of use:
> > 
> > In board code:
> > 	...MACHINE_START(...)
> > 	
> > 		/* ... */
> > 		.init_early	= exynos_firmware_init,
> > 		/* ... */
> > 	
> > 	MACHINE_END
> > 
> > In device tree:
> > 	/ {
> > 	
> > 		/* ... */
> > 		
> > 		firmware {
> > 		
> > 			compatible = "samsung,secure-firmware";
> > 		
> > 		};
> > 		
> > 		/* ... */
> > 	
> > 	};
> > 
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> > ---
> > 
> >  .../devicetree/bindings/arm/samsung-boards.txt     |  8 ++++
> >  arch/arm/mach-exynos/Makefile                      |  1 +
> >  arch/arm/mach-exynos/common.h                      |  2 +
> >  arch/arm/mach-exynos/firmware.c                    | 54
> >  ++++++++++++++++++++++ arch/arm/mach-exynos/mach-exynos4-dt.c        
> >      |  1 +
> >  5 files changed, 66 insertions(+)
> >  create mode 100644 arch/arm/mach-exynos/firmware.c
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/samsung-boards.txt
> > b/Documentation/devicetree/bindings/arm/samsung-boards.txt index
> > 0bf68be..f447059 100644
> > --- a/Documentation/devicetree/bindings/arm/samsung-boards.txt
> > +++ b/Documentation/devicetree/bindings/arm/samsung-boards.txt
> > 
> > @@ -6,3 +6,11 @@ Required root node properties:
> >      - compatible = should be one or more of the following.
> >      
> >          (a) "samsung,smdkv310" - for Samsung's SMDKV310 eval board.
> >          (b) "samsung,exynos4210"  - for boards based on Exynos4210
> >          SoC.
> > 
> > +
> > +Optional:
> > +    - firmware node, specifying presence and type of secure firmware,
> > currently +        supported value of compatible property is
> > "samsung,secure-firmware": +
> > +	firmware {
> > +		compatible = "samsung,secure-firmware";
> > +	};
> 
> If you require the binding to specify the memory area, then you at least
> allow for future work to move to a dynamic mapping without updating the
> binding and all device trees. So, please do that even if the code is
> hardcoded to the static address today.

All right.

> For extra credit, make sure that the reg property is matching the static
> mapping when you setup your firmware interface on your platform.

Hmm, do you know a way to look up physical address of such static mapping, 
given only the virtual address? Additional problem is that the code is 
executed very early (in init_early callback), before most of VM 
initialization code.

I could do something like

	if (soc_is_exynos4210())
		paddr = EXYNOS4210_PA_SYSRAM_NS;
	else if (soc_is_exynos4212() || soc_is_exynos4412())
		paddr = EXYNOS4x12_PA_SYSRAM_NS;
	...

and compare paddr with address received from device tree, but I don't 
really like this construct.
 
> > +static int exynos_cpu_boot_reg(int cpu, void __iomem **ptr)
> > +{
> > +	*ptr = S5P_VA_SYSRAM_NS + 0x1c + 4*cpu;
> > +	return 0;
> > +}
> 
> It would be nice to get a memory map for the SMC area in documentation
> somewhere, but that can be done separately later.

OK.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
