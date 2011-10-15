From: pullip.cho@samsung.com (KyongHo Cho)
Date: Sat, 15 Oct 2011 10:55:52 +0900
Subject: [PATCH v5 2/2] iommu/exynos: Add iommu driver for Exynos Platforms
In-Reply-To: <20111014141714.GD2198@amd.com>
References: <000501cc897f$fa0204f0$ee060ed0$%cho@samsung.com>
	<20111014141714.GD2198@amd.com>
Message-ID: <CAHQjnOPsBr5sV=08CaO0bpvjVXA9y_rE5tumVuseRU-N6uHx-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 14, 2011 at 11:17 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
> On Thu, Oct 13, 2011 at 04:13:23AM -0400, KyongHo Cho wrote:
>> +struct exynos_iommu_domain {
>> + ? ? ? struct device *dev;
>> + ? ? ? unsigned long *pgtable;
>> + ? ? ? spinlock_t lock;
>> + ? ? ? spinlock_t pgtablelock;
>> +};
>
> Can you please add comments to document what these spinlocks protect?
>
'lock' protects race condition on the domain private data.
'pgtablelock' does it on the page table of the domain.
Since updating page table does not need to be synchronized with
domain private data, I defined those 2 locks seperately.

I will add this information in the source code as comments.

>> +static int exynos_iommu_attach_device(struct iommu_domain *domain,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct device *dev)
>> +{
>> + ? ? ? struct exynos_iommu_domain *priv = domain->priv;
>> + ? ? ? int ret;
>> +
>> + ? ? ? spin_lock(&priv->lock);
>> +
>> + ? ? ? priv->dev = dev;
>> +
>> + ? ? ? spin_unlock(&priv->lock);
>> +
>> + ? ? ? ret = exynos_iommu_enable(domain);
>> +
>> + ? ? ? return ret;
>> +}
>> +
>> +static void exynos_iommu_detach_device(struct iommu_domain *domain,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct device *dev)
>> +{
>> + ? ? ? struct exynos_iommu_domain *priv = domain->priv;
>> +
>> + ? ? ? spin_lock(&priv->lock);
>> +
>> + ? ? ? if (priv->dev == dev) {
>> + ? ? ? ? ? ? ? priv->dev = NULL;
>> +
>> + ? ? ? ? ? ? ? spin_unlock(&priv->lock);
>> +
>> + ? ? ? ? ? ? ? exynos_iommu_disable(domain);
>> + ? ? ? } else {
>> + ? ? ? ? ? ? ? spin_unlock(&priv->lock);
>> + ? ? ? }
>> +}
>
> That looks weird. As I read this code there is a 1-1 mapping between a
> device and a domain. This breaks semantics of the iommu-api where a
> domain can contain multiple devices.

I agree.
I will implement it soon.


Thank you

KyongHo
