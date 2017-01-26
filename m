From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 26 Jan 2017 10:43:20 +0100
Subject: [PATCH v3 01/13] soc: samsung: pmu: Provide global function to
 get PMU regmap
In-Reply-To: <1484833733-16082-2-git-send-email-m.szyprowski@samsung.com>
References: <CGME20170119134904eucas1p153a1d5b2ff9826c88293b6a8fe5140bc@eucas1p1.samsung.com>
 <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
 <1484833733-16082-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CACRpkdYyOgpAhAY=7QrXiEB2oDgs0azt_Tb80iO4vjzk1obemQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 2:48 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:

> PMU is something like a SoC wide service, so add a helper function to get
> PMU regmap. This will be used by other Exynos device drivers. This way it
> can be avoided to model this dependency in device tree (as phandles to PMU
> node) for almost every device in the SoC.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>

But why? I could understand it as a local header in
drivers/soc/samsung/*.h for those files.

For the global kernel scope we usually look up the syscon
regmap we need using a phandle, DT node or even
compatible string directly from the device tree.

Just
#include <linux/mfd/syscon.h>

syscon_node_to_regmap()
syscon_regmap_lookup_by_compatible()
syscon_regmap_lookup_by_pdevname()
syscon_regmap_lookup_by_phandle()

what is wrong with just using one of these?

Introducing a special header just creates compile time problems
with global interfaces when merging code and just litter the kernel
for no good reason.

Can you explain why this necessarily different approach is
needed?

I guess I should have said this earlier, mea culpa.

Yours,
Linus Walleij
