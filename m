From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 6 Jun 2013 12:11:23 +0100
Subject: [PATCH] ARM: tegra: add basic SecureOS support
In-Reply-To: <1740292.8Sz57ytBcM@flatron>
References: <1370503687-17767-1-git-send-email-acourbot@nvidia.com>
 <1740292.8Sz57ytBcM@flatron>
Message-ID: <20130606111122.GB3320@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 06, 2013 at 12:17:02PM +0200, Tomasz Figa wrote:
> Hi Alex,
> 
> On Thursday 06 of June 2013 16:28:07 Alexandre Courbot wrote:
> > Boot loaders on some Tegra devices can be unlocked but do not let the
> > system operate without SecureOS. SecureOS prevents access to some
> > registers and requires the operating system to perform certain
> > operations through Secure Monitor Calls instead of directly accessing
> > the hardware.
> > 
> > This patch introduces basic SecureOS support for Tegra. SecureOS support
> > can be enabled by adding a "nvidia,secure-os" property to the "chosen"
> > node of the device tree.
> > 
> > Currently, only the bringup of secondary CPUs is performed by SMCs, but
> > more operations will be added later.
> > 
> > Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> > ---
> >  Documentation/devicetree/bindings/arm/tegra.txt |  8 +++
> >  arch/arm/configs/tegra_defconfig                |  1 +
> >  arch/arm/mach-tegra/Kconfig                     | 11 ++++
> >  arch/arm/mach-tegra/Makefile                    |  2 +
> >  arch/arm/mach-tegra/common.c                    |  2 +
> >  arch/arm/mach-tegra/reset.c                     | 30 +++++++----
> >  arch/arm/mach-tegra/secureos.c                  | 70
> > +++++++++++++++++++++++++ arch/arm/mach-tegra/secureos.h               
> >   | 31 +++++++++++ 8 files changed, 145 insertions(+), 10 deletions(-)
> >  create mode 100644 arch/arm/mach-tegra/secureos.c
> >  create mode 100644 arch/arm/mach-tegra/secureos.h
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/tegra.txt
> > b/Documentation/devicetree/bindings/arm/tegra.txt index
> > ed9c853..b543091 100644
> > --- a/Documentation/devicetree/bindings/arm/tegra.txt
> > +++ b/Documentation/devicetree/bindings/arm/tegra.txt
> > @@ -32,3 +32,11 @@ board-specific compatible values:
> >    nvidia,whistler
> >    toradex,colibri_t20-512
> >    toradex,iris
> > +
> > +Global properties
> > +-------------------------------------------
> > +
> > +The following properties can be specified into the "chosen" root
> > +node:
> > +
> > +  nvidia,secure-os: enable SecureOS.
> 
> Hmm, on Exynos we had something like
> 
> 	firmware at 0203F000 {
> 		compatible = "samsung,secure-firmware";
> 		reg = <0x0203F000 0x1000>;
> 	};
> 
> but your solution might be actually the proper one, since firmware is not 
> a hardware block. (The address in reg property is pointing to SYSRAM 
> memory, which is an additional communication channel with the firmware.)

Calling to SecureOS doesn't sound like a "choice" to me.  It's part of the
platform, and if it's present then you have to use it, otherwise major
functionality (i.e., SMP) broken.

Having a proper node still makes sense, because you can put a
"compatible" property on it to track interface compatibility etc.  This
was the view taken for PSCI (though in practice, we do have additional
information to put in the DT for that anyway).

Cheers
---Dave
