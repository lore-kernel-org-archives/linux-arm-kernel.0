From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 22 Jul 2015 15:35:51 +0800
Subject: [PATCH 1/5] genirq: irqdomain: Use an accessor for the of_node
 field
In-Reply-To: <1437473280-11431-2-git-send-email-marc.zyngier@arm.com>
References: <1437473280-11431-1-git-send-email-marc.zyngier@arm.com>
 <1437473280-11431-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <55AF47D7.8010304@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/21/2015 06:07 PM, Marc Zyngier wrote:
> The struct irq_domain contains a "struct device_node *" field
> (of_node) that is almost the only link between the irqdomain
> and the device tree infrastructure.
>
> In order to prepare for the removal of that field, convert all
> users outside of kernel/irq/irqdomain.c to use an accessor.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   arch/mips/cavium-octeon/octeon-irq.c          | 4 ++--
>   arch/powerpc/platforms/cell/axon_msi.c        | 2 +-
>   arch/powerpc/platforms/cell/spider-pic.c      | 9 ++++++---
>   arch/powerpc/platforms/powernv/opal-irqchip.c | 2 +-
>   arch/powerpc/sysdev/ehv_pic.c                 | 3 ++-
>   arch/powerpc/sysdev/fsl_msi.c                 | 2 +-
>   arch/powerpc/sysdev/i8259.c                   | 3 ++-
>   arch/powerpc/sysdev/ipic.c                    | 3 ++-
>   arch/powerpc/sysdev/mpic.c                    | 3 ++-
>   arch/powerpc/sysdev/mpic_msi.c                | 2 +-
>   arch/powerpc/sysdev/qe_lib/qe_ic.c            | 3 ++-
>   drivers/gpio/gpio-sodaville.c                 | 2 +-
>   drivers/irqchip/exynos-combiner.c             | 2 +-
>   drivers/irqchip/irq-atmel-aic-common.c        | 2 +-
>   drivers/irqchip/irq-crossbar.c                | 4 ++--
>   drivers/irqchip/irq-gic-v2m.c                 | 2 +-
>   drivers/irqchip/irq-gic-v3-its.c              | 2 +-
>   drivers/irqchip/irq-gic-v3.c                  | 2 +-
>   drivers/irqchip/irq-gic.c                     | 2 +-
>   drivers/irqchip/irq-hip04.c                   | 2 +-
>   drivers/irqchip/irq-mtk-sysirq.c              | 2 +-
>   drivers/irqchip/irq-s3c24xx.c                 | 4 ++--
>   drivers/irqchip/irq-tegra.c                   | 4 ++--
>   drivers/irqchip/irq-vf610-mscm-ir.c           | 5 +++--
>   drivers/spmi/spmi-pmic-arb.c                  | 2 +-
>   include/linux/irqdomain.h                     | 5 +++++
>   26 files changed, 46 insertions(+), 32 deletions(-)

It seems to me that some other files missed,
in arch/powerpc/platforms/pasemi/msi.c:

         if (!mpic->irqhost->of_node ||
             !of_device_is_compatible(mpic->irqhost->of_node,
                                      "pasemi,pwrficient-openpic"))
                 return -ENODEV;

If you need more eyes to find all of them, please count me in :)

Thanks
Hanjun
