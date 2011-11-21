From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Mon, 21 Nov 2011 09:11:01 +0100
Subject: [PATCH 1/3] ARM: iommu: tegra/common: Initial support for IOVMM
 driver
In-Reply-To: <20111117203202.GB20889@avionic-0098.mockup.avionic-design.de>
References: <1321527667-12923-1-git-send-email-hdoyu@nvidia.com><1321527667-12923-2-git-send-email-hdoyu@nvidia.com><20111117203202.GB20889@avionic-0098.mockup.avionic-design.de>
Message-ID: <20111121.101101.272842631528669512.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 1/3] ARM: iommu: tegra/common: Initial support for IOVMM driver
Date: Thu, 17 Nov 2011 21:32:02 +0100
Message-ID: <20111117203202.GB20889@avionic-0098.mockup.avionic-design.de>

> * PGP Signed by an unknown key
> 
> I'm not very knowledgeable about IOMMUs in general, so my comments are more
> about general style.

Thank you for your review. Mostly I'll take them in the next version
of patchset.

> * hdoyu at nvidia.com wrote:
> > From: Hiroshi DOYU <hdoyu@nvidia.com>
> >
> > This is the tegra specific IOMMU framework, independent of H/W. H/W
> 
> You should keep the spelling of "Tegra" consistent.
> 
> > dependent modules are to be registered to this framework so that this
> > can support different IOMMU H/Ws among Tegra generations, Tegra2/GART,
> > and Tegra3/SMMU H/Ws.
> >
> > Most of this part could be replaced with a generic IOMMU
> > framework. This is expected to ease finding similarities with
> > different platforms, with the intention of solving problems once in a
> > generic framework which everyone can use.
> >
> > Signed-off-by: Hiroshi DOYU <hdoyu@nvidia.com>
> > Cc: Hiro Sugawara <hsugawara@nvidia.com>
> > Cc: Krishna Reddy <vdumpa@nvidia.com>
> > ---
> >  arch/arm/mach-tegra/include/mach/iovmm.h |  283 +++++++++
> >  drivers/iommu/Kconfig                    |    6 +
> >  drivers/iommu/Makefile                   |    1 +
> >  drivers/iommu/tegra-iovmm.c              |  936 ++++++++++++++++++++++++++++++
> >  4 files changed, 1226 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-tegra/include/mach/iovmm.h
> >  create mode 100644 drivers/iommu/tegra-iovmm.c
> >
> > diff --git a/arch/arm/mach-tegra/include/mach/iovmm.h b/arch/arm/mach-tegra/include/mach/iovmm.h
> > new file mode 100644
> > index 0000000..6fd0bb6
> > --- /dev/null
> > +++ b/arch/arm/mach-tegra/include/mach/iovmm.h
> > @@ -0,0 +1,283 @@
> > +/*
> > + * Copyright (c) 2010-2011, NVIDIA Corporation.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed i the hope that it will be useful, but WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public License along
> > + * with this program; if not, write to the Free Software Foundation, Inc.,
> > + * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
> > + */
> > +
> > +#include <linux/list.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/miscdevice.h>
> > +#include <linux/rbtree.h>
> > +#include <linux/rwsem.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/types.h>
> > +
> > +#ifndef _MACH_TEGRA_IOVMM_H_
> > +#define _MACH_TEGRA_IOVMM_H_
> > +
> > +typedef u32 tegra_iovmm_addr_t;
> > +
> > +struct tegra_iovmm_device_ops;
> > +
> > +/* each I/O virtual memory manager unit should register a device with
> > + * the iovmm system
> > + */
> 
> Generally, multi-line comments have the starting /* and ending */ on separate
> lines. Also since this API is public it may be better to document it using
> kerneldoc.

I'll leave this kerneldoc out for a while since those public API may
be replaced with geneic IOMMU ones.
