From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 16 Apr 2013 12:00:41 +0100
Subject: [RFC PATCH 2/2] ARM: DT: kernel: DT cpu node bindings update
In-Reply-To: <20130416024146.GG28660@verge.net.au>
References: <1366042402-8987-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1366042402-8987-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20130416024146.GG28660@verge.net.au>
Message-ID: <20130416110040.GB19837@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 16, 2013 at 03:41:46AM +0100, Simon Horman wrote:
> On Mon, Apr 15, 2013 at 05:13:22PM +0100, Lorenzo Pieralisi wrote:
> > In order to extend the current cpu nodes bindings to newer CPUs
> > inclusive of AArch64 and to update support for older ARM CPUs this
> > patch updates device tree documentation for the cpu nodes bindings.
> >
> > Main changes:
> >
> > - adds 64-bit bindings (inclusive of cpus node #address-cells updates)
> > - defines behaviour on pre and post v7 uniprocessor systems
> > - adds ARM 11MPcore specific reg property definition
> >
> > DT cpu map parsing code must be made compliant with the latest bindings
> > updates, hence this patch also updates the arm_dt_init_cpu_maps() function
> > with checks and additional parsing rules.
> >
> > Uniprocessor systems predating v7 do not parse the cpus node at all
> > since the reg property is meaningless on those systems.
> >
> > Device trees for 64-bit systems can be taken as device tree input also
> > for 64-bit CPUs running in 32-bit mode. The code checks that the reg entries
> > are zeroed as required in the respective fields and detects automatically
> > the cpus node #address-cells value so that device tree written for
> > 64-bit ARM platforms (cpus #address-cells == 2) can still be taken as
> > input. The correct device tree entries are to be set up by the boot
> > loader, kernel code just checks that device tree entries in the cpus
> > node are as expected for a 32-bit CPU (reg[63:24] == 0).
> >
> > cpu node entries with invalid reg property or containing duplicates are
> > ignored and the device tree parsing is not stopped anymore when such
> > entries are encountered, the device tree cpu entry is just skipped.
> >
> > A device tree with cpu nodes missing the boot CPU MPIDR is considered a
> > hard error and the kernel flags this up as a bug to force firmware updates.
> >
> > The updates to cpus/cpu node bindings for ARM require all in-kernel dts files
> > present in the mainline to be made compliant to the latest specification.
> >
> > This patch also updates ARM in-kernel non-compliant dts files to the latest
> > cpus/cpu nodes bindings specification.
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > ---
> >  Documentation/devicetree/bindings/arm/cpus.txt | 335 +++++++++++++++++++++----
> >  arch/arm/boot/dts/exynos5440.dtsi              |   7 +
> >  arch/arm/boot/dts/omap3.dtsi                   |   4 +
> >  arch/arm/boot/dts/omap4.dtsi                   |   5 +
> >  arch/arm/boot/dts/omap5.dtsi                   |   5 +
> >  arch/arm/boot/dts/r8a7740.dtsi                 |   3 +
> >  arch/arm/boot/dts/sh7372.dtsi                  |   4 +
> 
> I would prefer if the SoC updates, in particular the sh7372 portion,
> was a separate patch.

Ok, I will split the patch accordingly.

Thanks,
Lorenzo
