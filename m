From: pullip.cho@samsung.com (KyongHo Cho)
Date: Wed, 7 Mar 2012 15:22:33 +0900
Subject: [PATCH v10 3/3] iommu/exynos: Add iommu driver for Exynos
 Platforms
In-Reply-To: <CAAQKjZNJHeApuiyh467w8wGaY8VFb_PqLrvHGUxmE8-+a4yRTA@mail.gmail.com>
References: <002201ccfb73$93311520$b9933f60$%cho@samsung.com>
 <CAAQKjZNJHeApuiyh467w8wGaY8VFb_PqLrvHGUxmE8-+a4yRTA@mail.gmail.com>
Message-ID: <CAHQjnOOQKS1EU-3zWDDq2sLxPucY9CRZyrnaT5cyyrSa9-k9Nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 7, 2012 at 2:28 PM, InKi Dae <daeinki@gmail.com> wrote:
>> +static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
>> +{
>> + ? ? ? /* SYSMMU is in blocked when interrupt occurred. */
>> + ? ? ? struct sysmmu_drvdata *data = dev_id;
>> + ? ? ? struct resource *irqres;
>> + ? ? ? struct platform_device *pdev;
>> + ? ? ? enum EXYNOS_SYSMMU_INTERRUPT_TYPE itype;
>
> how about to change EXYNOS_SYSMMU_INTERRUPT_TYPE to small letter? just
> for code clean.
>
I will. please refer to the my reply to Kyungmin Park.

>> + ? ? ? unsigned long addr = -1;
>> +
>> + ? ? ? int i, ret = -ENOSYS;
>> +
>> + ? ? ? read_lock(&data->lock);
>> +
>> + ? ? ? WARN_ON(!is_sysmmu_active(data));
>> +
>> + ? ? ? pdev = to_platform_device(data->sysmmu);
>> + ? ? ? for (i = 0; i < pdev->num_resources; i++) {
>> + ? ? ? ? ? ? ? irqres = platform_get_resource(pdev, IORESOURCE_IRQ, i);
>> + ? ? ? ? ? ? ? if (irqres && ((int)irqres->start == irq))
>> + ? ? ? ? ? ? ? ? ? ? ? break;
>> + ? ? ? }
>
> is there any reason that it should get irq resources in interrupt
> handler? if not so then how about to move it into probe()?
>
The platform device of ISP has a lot of IRQ sources.
The above for clause determines which IRQ source (System MMU)
generated the interrupt.

>> +
>> + ? ? ? if (i == pdev->num_resources) {
>> + ? ? ? ? ? ? ? itype = SYSMMU_FAULT_UNKNOWN;
>> + ? ? ? } else {
>> + ? ? ? ? ? ? ? i /= 2;
>> +
>> + ? ? ? ? ? ? ? itype = (enum EXYNOS_SYSMMU_INTERRUPT_TYPE)
>
> ditto.
>

Thank you.

Cho KyongHo.
