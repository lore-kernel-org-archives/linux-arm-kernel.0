From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 15 Mar 2015 01:03:41 +0000
Subject: [PATCH v6 0/6] irqchip: Move Tegra LIC to use stacked domains
In-Reply-To: <1426088583-15097-1-git-send-email-marc.zyngier@arm.com>
References: <1426088583-15097-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150315010341.GA4463@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 03:42:57PM +0000, Marc Zyngier wrote:
> This series is extracted from [4], which is trying to remove all
> traces of gic_arch_extn from the tree. As some maintainers are more
> responsive than others (understatement of the year...), I've decided
> to split it per sub-arch, and get it moving, at least partially.
> 
> This series addresses Tegra by moving its legacy interrupt controller
> support to drivers/irqchip and implementing a stacked domain on top of
> the standard GIC.
> 
> It is worth realizing that:
> 
> - I haven't been able to test this as much as I would have wanted to
>   (it's only been tested on tegra2).
> 
> - This actively *breaks* existing setups. Once you boot a new kernel
>   with an old DT, suspend/resume *will* be broken. Old kernels on a
>   new DT won't even boot!
> 
> Based on 4.0-rc1.
> 
> * From v5: [5]
> - Allow interrupt affinity to be changed
> 
> * From v4: [4]
> - Extracted from the full series
> - Rebased on 4.0-rc1
> 
> * From v3 [3]:
> - Rebased on top of the patch working around hardcoded IRQ on OMAP4/5 [4]
> - Fixed more iMX6 DTs (Stephan)
> - Fixed Exynos4/5 DTs
> 
> * From v2 [2]:
> - Addressed numerous comments from Thierry
> - Merged bug fixes from Nishanth
> - Merged bug fix from Stefan
> 
> * From v1 [1]:
> - Rebased on 3.19-rc3
> - Fixed a number of additional platforms
> - Added crossbar conversion to stacked domains
> - Merged bug fixes from Nishanth
> 
> [5]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/325172.html
> [4]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/317531.html
> [3]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315385.html
> [2]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/314041.html
> [1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/307338.html
> 
> 
> Marc Zyngier (6):
>   ARM: tegra: irq: nuke leftovers from non-DT support
>   irqchip: tegra: add DT-based support for legacy interrupt controller
>   ARM: tegra: skip gic_arch_extn setup if DT has a LIC node
>   ARM: tegra: update DTs to expose legacy interrupt controller
>   DT: tegra: add binding for the legacy interrupt controller
>   ARM: tegra: remove old LIC support
> 
>  .../interrupt-controller/nvidia,tegra-ictlr.txt    |  43 +++
>  arch/arm/boot/dts/tegra114.dtsi                    |  16 +-
>  arch/arm/boot/dts/tegra124.dtsi                    |  16 +-
>  arch/arm/boot/dts/tegra20.dtsi                     |  15 +-
>  arch/arm/boot/dts/tegra30.dtsi                     |  16 +-
>  arch/arm/mach-tegra/iomap.h                        |  15 -
>  arch/arm/mach-tegra/irq.c                          | 209 +-----------
>  arch/arm/mach-tegra/irq.h                          |   6 -
>  arch/arm/mach-tegra/tegra.c                        |   1 -
>  drivers/irqchip/Makefile                           |   1 +
>  drivers/irqchip/irq-tegra.c                        | 371 +++++++++++++++++++++
>  11 files changed, 482 insertions(+), 227 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra-ictlr.txt
>  create mode 100644 drivers/irqchip/irq-tegra.c

I've applied this series to irqchip/stacked-tegra to give it some time in
-next.

thx,

Jason.
