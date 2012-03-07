From: daeinki@gmail.com (InKi Dae)
Date: Wed, 7 Mar 2012 14:28:13 +0900
Subject: [PATCH v10 3/3] iommu/exynos: Add iommu driver for Exynos
 Platforms
In-Reply-To: <002201ccfb73$93311520$b9933f60$%cho@samsung.com>
References: <002201ccfb73$93311520$b9933f60$%cho@samsung.com>
Message-ID: <CAAQKjZNJHeApuiyh467w8wGaY8VFb_PqLrvHGUxmE8-+a4yRTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
> +{
> + ? ? ? /* SYSMMU is in blocked when interrupt occurred. */
> + ? ? ? struct sysmmu_drvdata *data = dev_id;
> + ? ? ? struct resource *irqres;
> + ? ? ? struct platform_device *pdev;
> + ? ? ? enum EXYNOS_SYSMMU_INTERRUPT_TYPE itype;

how about to change EXYNOS_SYSMMU_INTERRUPT_TYPE to small letter? just
for code clean.

> + ? ? ? unsigned long addr = -1;
> +
> + ? ? ? int i, ret = -ENOSYS;
> +
> + ? ? ? read_lock(&data->lock);
> +
> + ? ? ? WARN_ON(!is_sysmmu_active(data));
> +
> + ? ? ? pdev = to_platform_device(data->sysmmu);
> + ? ? ? for (i = 0; i < pdev->num_resources; i++) {
> + ? ? ? ? ? ? ? irqres = platform_get_resource(pdev, IORESOURCE_IRQ, i);
> + ? ? ? ? ? ? ? if (irqres && ((int)irqres->start == irq))
> + ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? }

is there any reason that it should get irq resources in interrupt
handler? if not so then how about to move it into probe()?

> +
> + ? ? ? if (i == pdev->num_resources) {
> + ? ? ? ? ? ? ? itype = SYSMMU_FAULT_UNKNOWN;
> + ? ? ? } else {
> + ? ? ? ? ? ? ? i /= 2;
> +
> + ? ? ? ? ? ? ? itype = (enum EXYNOS_SYSMMU_INTERRUPT_TYPE)

ditto.

> + ? ? ? ? ? ? ? ? ? ? ? __ffs(__raw_readl(data->sfrbases[i] + REG_INT_STATUS));
> + ? ? ? ? ? ? ? if (WARN_ON(!((itype >= 0) && (itype < SYSMMU_FAULT_UNKNOWN))))
> + ? ? ? ? ? ? ? ? ? ? ? itype = SYSMMU_FAULT_UNKNOWN;
> + ? ? ? ? ? ? ? else
> + ? ? ? ? ? ? ? ? ? ? ? addr = __raw_readl(
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? data->sfrbases[i] + fault_reg_offset[itype]);
> + ? ? ? }
> +
