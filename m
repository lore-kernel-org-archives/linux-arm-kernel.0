From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 6 Sep 2011 15:35:48 +0300
Subject: [Linaro-mm-sig] [PATCH 2/2] ARM: Samsung: update/rewrite Samsung
	SYSMMU (IOMMU) driver
In-Reply-To: <CAHQjnONHr-Ao_KLjdRKgVQQUKtOmmoyqFwdkSZCDsE6hx1q-Ug@mail.gmail.com>
References: <1314971786-15140-1-git-send-email-m.szyprowski@samsung.com>
	<1314971786-15140-3-git-send-email-m.szyprowski@samsung.com>
	<CAHQjnONHr-Ao_KLjdRKgVQQUKtOmmoyqFwdkSZCDsE6hx1q-Ug@mail.gmail.com>
Message-ID: <CADMYwHzTe7WcqjCOSdgnbFsHm6gtV7Bf1154WHXiTnffGSAYRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 6, 2011 at 1:27 PM, KyongHo Cho <pullip.cho@samsung.com> wrote:
> On Fri, Sep 2, 2011 at 10:56 PM, Marek Szyprowski
>> +static int s5p_sysmmu_map(struct iommu_domain *domain, unsigned long iova,
>> + ? ? ? ? ? ? ? ? ? ? ? ? phys_addr_t paddr, int gfp_order, int prot)
>> +{
>> + ? ? ? struct s5p_sysmmu_domain *s5p_domain = domain->priv;
>> + ? ? ? int flpt_idx = flpt_index(iova);
>> + ? ? ? size_t len = 0x1000UL << gfp_order;
>> + ? ? ? void *flpt_va, *slpt_va;
>> +
>> + ? ? ? if (len != SZ_16M && len != SZ_1M && len != SZ_64K && len != SZ_4K) {
>> + ? ? ? ? ? ? ? sysmmu_debug(3, "bad order: %d\n", gfp_order);
>> + ? ? ? ? ? ? ? return -EINVAL;
>> + ? ? ? }
>
> Likewise, I think this driver need to support mapping 128KiB aligned,
> 128KiB physical memory, for example.
>
> Otherwise, it is somewhat restrictive than we expect.

That's actually OK, because the IOMMU core will split physically
contiguous memory regions to pages on behalf of its drivers (drivers
will just have to advertise the page sizes their hardware supports);
this way you don't duplicate the logic in every IOMMU driver.

Take a look:

http://www.spinics.net/lists/linux-omap/msg56660.html
