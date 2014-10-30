From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 30 Oct 2014 16:32:20 +0100
Subject: [PATCH v4 05/12] memory: Add NVIDIA Tegra memory controller
 support
In-Reply-To: <CAOesGMjMcqa_wE7rfA42QyvF7yxAkgjEN+-0UVMuErnjHr4zkA@mail.gmail.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
 <1413196434-5292-5-git-send-email-thierry.reding@gmail.com>
 <CAOesGMjMcqa_wE7rfA42QyvF7yxAkgjEN+-0UVMuErnjHr4zkA@mail.gmail.com>
Message-ID: <20141030153218.GH20072@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 15, 2014 at 03:05:36PM -0700, Olof Johansson wrote:
> Hi,
> 
> On Mon, Oct 13, 2014 at 3:33 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> [...]
> > diff --git a/drivers/memory/tegra/tegra-mc.c b/drivers/memory/tegra/tegra-mc.c
> > new file mode 100644
> > index 000000000000..0f0c8be096d0
> > --- /dev/null
> > +++ b/drivers/memory/tegra/tegra-mc.c
> > @@ -0,0 +1,1061 @@
> > +/*
> > + * Copyright (C) 2014 NVIDIA CORPORATION.  All rights reserved.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/iommu.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> 
> You need a linux/mm.h in here (on 64-bit).

Can you show what build error this fixes? I don't see any build failures
(after fixing up the obvious ones you pointed out below).

> > diff --git a/drivers/memory/tegra/tegra124-mc.c b/drivers/memory/tegra/tegra124-mc.c
> > new file mode 100644
> > index 000000000000..db31c96fc288
> > --- /dev/null
> > +++ b/drivers/memory/tegra/tegra124-mc.c
> 
> [...]
> 
> 
> > @@ -0,0 +1,1028 @@
> > +/*
> > + * Copyright (C) 2014 NVIDIA CORPORATION.  All rights reserved.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/of.h>
> > +#include <linux/mm.h>
> > +
> > +#include <asm/cacheflush.h>
> > +
> > +#include <dt-bindings/memory/tegra124-mc.h>
> > +
> > +#include "tegra-mc.h"
> > +
> > +static const struct tegra_mc_client tegra124_mc_clients[] = {
> > +       {
> > +               .id = 0x00,
> > +               .name = "ptcr",
> > +               .swgroup = TEGRA_SWGROUP_PTC,
> > +       }, {
> > +               .id = 0x01,
> > +               .name = "display0a",
> > +               .swgroup = TEGRA_SWGROUP_DC,
> > +               .smmu = {
> > +                       .reg = 0x228,
> > +                       .bit = 1,
> > +               },
> > +               .latency = {
> > +                       .reg = 0x2e8,
> > +                       .shift = 0,
> > +                       .mask = 0xff,
> > +                       .def = 0xc2,
> > +               },
> > +       }, {
> 
> These are very verbose tables. Having a macro for the initializers
> could help density a lot.

I've tried to use macros here, but I find that it hurts readability:

	...
	}, {
		TEGRA_MC_CLIENT(0x01, "display0a", TEGRA_SWGROUP_DC),
		TEGRA_MC_SMMU_ENABLE(0x228, 1),
		TEGRA_MC_LATENCY(0x2e8, 0, 0xff, 0xc2),
	}, {
	...

The original is more readable because it immediately gives you the
context, whereas with the macros you need to look up what the parameters
refer to.

> > +#ifdef CONFIG_ARCH_TEGRA_132_SOC
> > +static void tegra132_flush_dcache(struct page *page, unsigned long offset,
> > +                                 size_t size)
> > +{
> > +       void *virt = page_address(page) + offset;
> > +
> > +       __flush_dcache_area(virt, size);
> > +}
> > +
> > +static const struct tegra_smmu_ops tegra132_smmu_ops = {
> > +       .flush_dcache = tegra132_flush_dcache,
> > +};
> > +
> > +static const struct tegra_smmu_soc tegra132_smmu_soc = {
> > +       .groups = tegra124_smmu_groups,
> > +       .num_groups = ARRAY_SIZE(tegra124_smmu_groups),
> > +       .clients = tegra124_mc_clients,
> > +       .num_clients = ARRAY_SIZE(tegra124_mc_clients),
> > +       .swgroups = tegra124_swgroups,
> > +       .num_swgroups = ARRAY_SIZE(tegra124_swgroups),
> > +       .supports_round_robin_arbitration = true,
> > +       .supports_request_limit = true,
> > +       .num_address_bits = 34,
> > +       .num_asids = 128,
> > +       .ops = &tegra132_smmu_ops,
> > +};
> > +
> > +const struct tegra_mc_soc tegra132_mc_soc = {
> > +       .clients = tegra124_mc_clients,
> > +       .num_clients = ARRAY_SIZE(tegra124_mc_clients),
> > +       .atom_size = 32,
> > +       .smmu = &tegra132_smmu_soc,
> > +};
> > +#endif /* CONFIG_ARCH_TEGRA_132_SOC */
> 
> 
> This won't compile -- several of the tegra132_smmu_soc members are no
> longer valid. In particular:
> 
> groups
> num_groups

Fixed.

> supports_round_robin_arbitration
> supports_request_limit

In the version that I have these are still part of the tegra_smmu_soc
structure.

I've been thinking of extracting the Tegra132 changes into a separate
patch that can be applied once we have basic Tegra132 SoC support. It
feels wrong to merge Tegra132 SMMU support if there's no support in
arch/arm64 for the SoC yet. Though if nobody else thinks that's a
problem that's fine with me too.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141030/cd26dcf3/attachment-0001.sig>
