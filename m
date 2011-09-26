From: pullip.cho@samsung.com (KyongHo Cho)
Date: Mon, 26 Sep 2011 17:58:49 +0900
Subject: [PATCH 3/4] iommu/exynos: Add iommu driver for Exynos4 Platforms
In-Reply-To: <CAK=WgbYnGjPKs6_nmFRGfMnbh_7wDR-0QcptAGaqDKVOo-x3cg@mail.gmail.com>
References: <15669786.49881316849426265.JavaMail.weblogic@epml24>
	<CAK=WgbYnGjPKs6_nmFRGfMnbh_7wDR-0QcptAGaqDKVOo-x3cg@mail.gmail.com>
Message-ID: <CAHQjnOOtVHUS3KmBz7LdO88fLQyLA6f-w3ye9nAH0Bx+zh38XA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

On Mon, Sep 26, 2011 at 4:59 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> 2011/9/24 ??? <pullip.cho@samsung.com>:
>> This is the System MMU driver and IOMMU API implementation for
>> Exynos4 SOC platforms. Exynos4 platforms has more than 10 System
>> MMUs dedicated for each multimedia accellerators.
>>
>> Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
> ...
>> +static int exynos_iommu_fault_handler(struct iommu_domain *domain,
>> + ? ? ? ? ? ? ? ? ? ? ? struct device *dev, unsigned long iova, int flags)
>> +{
>> + ? ? ? struct exynos_iommu_domain *priv = domain->priv;
>> +
>> + ? ? ? dev_err(priv->dev, "%s occured at %p(Page table base: %p)\n",
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? sysmmu_fault_name[flags], (void *)iova,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? (void *)(__pa(priv->pgtable)));
>> + ? ? ? dev_err(priv->dev, "\t\tGenerating Kernel OOPS...\n");
>> + ? ? ? dev_err(priv->dev, "\t\tbecause it is unrecoverable.\n");
>> + ? ? ? dev_err(priv->dev,
>> + ? ? ? ? ? ? ? "\t\tSet Fault handler with iommu_set_fault_handler().\n");
>> + ? ? ? dev_err(priv->dev, "\t\tto handle System MMU fault.\n");
>> +
>> + ? ? ? BUG();
>> +
>> + ? ? ? return 0;
>> +}
>> +
>> +static int exynos_iommu_domain_init(struct iommu_domain *domain)
>> +{
> ...
>> + ? ? ? iommu_set_fault_handler(domain, &exynos_iommu_fault_handler);
>
> It doesn't make a lot of sense to set an iommu fault handler here; the
> intention of iommu_set_fault_handler() is to allow upper layers to do
> that.

As you've noticed, it is default behavior for iommu fault.
If an upper layer calls iommu_set_fault_handler(),
it is replaced with the new one.
>
> Moreover, exynos_sysmmu_irq() anyway knows whenever a fault occurs, so
> calling report_iommu_fault() just to have it call into the driver
> again seems redundant.
>
I think calling report_iommu_fault() in exynos_sysmmu_irq() is rather simple.
To do the default behavior in exynos_sysmmu_irq(),
it must check if domain->handler is NULL or not.
But the checking is also performed in report_iommu_fault() also.

I think just calling report_iommu_fault() reduces redundancy.

> If you want an exynos-specific behavior to occur whenever there's an
> iommu fault, you should do that in exynos_sysmmu_irq itself. If you
> just want a generic default logging behavior to occur whenever there's
> no other fault handler installed, you might even want to consider
> adding it to the IOMMU core.

It is neither a specific behavior nor a generic logging.

Just a default MMU fault report that can be replaceable with a fault
handler that a device driver provides.

Regards,
Cho KyongHo.
