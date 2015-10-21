From: puck.chen@hisilicon.com (chenfeng)
Date: Wed, 21 Oct 2015 09:56:54 +0800
Subject: [PATCH V2 2/3] Add iommu driver for hi6220 SoC platform
In-Reply-To: <56265783.5040406@arm.com>
References: <1445330724-129401-1-git-send-email-puck.chen@hisilicon.com>
 <1445330724-129401-2-git-send-email-puck.chen@hisilicon.com>
 <56265783.5040406@arm.com>
Message-ID: <5626F0E6.8090402@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/10/20 23:02, Robin Murphy wrote:
> On 20/10/15 09:45, Chen Feng wrote:
>> iommu/hisilicon: Add hi6220-SoC smmu driver
> 
> A brief description of the smmu and what capabilities it provides wouldn't go amiss here.
> 
ok
>> Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
>> Signed-off-by: Yu Dongbin <yudongbin@hisilicon.com>
>> ---
>>   drivers/iommu/Kconfig        |   8 +
>>   drivers/iommu/Makefile       |   1 +
>>   drivers/iommu/hi6220_iommu.c | 482 +++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 491 insertions(+)
>>   create mode 100644 drivers/iommu/hi6220_iommu.c
>>
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index 4664c2a..9b41708 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -343,6 +343,14 @@ config SPAPR_TCE_IOMMU
>>         Enables bits of IOMMU API required by VFIO. The iommu_ops
>>         is not implemented as it is not necessary for VFIO.
>>
>> +config HI6220_IOMMU
>> +    bool "Hi6220 IOMMU Support"
>> +    depends on ARM64
>> +    select IOMMU_API
>> +    select IOMMU_IOVA
>> +    help
>> +      Enable IOMMU Driver for hi6220 SoC.
>> +
>>   # ARM IOMMU support
>>   config ARM_SMMU
>>       bool "ARM Ltd. System MMU (SMMU) Support"
>> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
>> index c6dcc51..ee4dfef 100644
>> --- a/drivers/iommu/Makefile
>> +++ b/drivers/iommu/Makefile
>> @@ -23,3 +23,4 @@ obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
>>   obj-$(CONFIG_SHMOBILE_IOMMU) += shmobile-iommu.o
>>   obj-$(CONFIG_SHMOBILE_IPMMU) += shmobile-ipmmu.o
>>   obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
>> +obj-$(CONFIG_HI6220_IOMMU) += hi6220_iommu.o
> 
> It would be nice to insert this before CONFIG_INTEL_IOMMU to try to maintain some semblance of order.
> 
ok
>> diff --git a/drivers/iommu/hi6220_iommu.c b/drivers/iommu/hi6220_iommu.c
>> new file mode 100644
>> index 0000000..6c5198d
>> --- /dev/null
>> +++ b/drivers/iommu/hi6220_iommu.c
>> @@ -0,0 +1,482 @@
>> +/*
>> + * Hisilicon Hi6220 IOMMU driver
>> + *
>> + * Copyright (c) 2015 Hisilicon Limited.
>> + *
>> + * Author: Chen Feng <puck.chen@hisilicon.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#define pr_fmt(fmt) "IOMMU: " fmt
>> +
>> +#include <linux/clk.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/iommu.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/list.h>
>> +#include <linux/irq.h>
>> +#include <linux/of.h>
>> +#include <linux/of_iommu.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/slab.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/iova.h>
>> +#include <linux/sizes.h>
> 
> Those last 3 spoil the ordering here. Plus, do you really need linux/interrupt.h twice?
> 
Accept,remove this later.
>> +#define SMMU_CTRL_OFFSET             (0x0000)
>> +#define SMMU_ENABLE_OFFSET           (0x0004)
>> +#define SMMU_PTBR_OFFSET             (0x0008)
>> +#define SMMU_START_OFFSET            (0x000C)
>> +#define SMMU_END_OFFSET              (0x0010)
>> +#define SMMU_INTMASK_OFFSET          (0x0014)
>> +#define SMMU_RINTSTS_OFFSET          (0x0018)
>> +#define SMMU_MINTSTS_OFFSET          (0x001C)
>> +#define SMMU_INTCLR_OFFSET           (0x0020)
>> +#define SMMU_STATUS_OFFSET           (0x0024)
>> +#define SMMU_AXIID_OFFSET            (0x0028)
>> +#define SMMU_CNTCTRL_OFFSET          (0x002C)
>> +#define SMMU_TRANSCNT_OFFSET         (0x0030)
>> +#define SMMU_L0TLBHITCNT_OFFSET      (0x0034)
>> +#define SMMU_L1TLBHITCNT_OFFSET      (0x0038)
>> +#define SMMU_WRAPCNT_OFFSET          (0x003C)
>> +#define SMMU_SEC_START_OFFSET        (0x0040)
>> +#define SMMU_SEC_END_OFFSET          (0x0044)
>> +#define SMMU_VERSION_OFFSET          (0x0048)
>> +#define SMMU_IPTSRC_OFFSET           (0x004C)
>> +#define SMMU_IPTPA_OFFSET            (0x0050)
>> +#define SMMU_TRBA_OFFSET             (0x0054)
>> +#define SMMU_BYS_START_OFFSET        (0x0058)
>> +#define SMMU_BYS_END_OFFSET          (0x005C)
>> +#define SMMU_RAM_OFFSET              (0x1000)
>> +#define SMMU_REGS_MAX                (15)
> 
> This is confusing; I count 24 registers listed above, what is 15 the maximum of?
> 
>> +#define SMMU_REGS_SGMT_END           (0x60)
>> +#define SMMU_CHIP_ID_V100            (1)
>> +#define SMMU_CHIP_ID_V200            (2)
>> +
>> +#define SMMU_REGS_OPS_SEGMT_START    (0xf00)
>> +#define SMMU_REGS_OPS_SEGMT_NUMB     (8)
>> +#define SMMU_REGS_AXI_SEGMT_START    (0xf80)
>> +#define SMMU_REGS_AXI_SEGMT_NUMB     (8)
>> +
>> +#define SMMU_INIT                    (0x1)
>> +#define SMMU_RUNNING                 (0x2)
>> +#define SMMU_SUSPEND                 (0x3)
>> +#define SMMU_STOP                    (0x4)
>> +#define SMMU_CTRL_INVALID            (BIT(10))
>> +#define PAGE_ENTRY_VALID             (0x1)
>> +
>> +#define IOVA_START_PFN               (1)
>> +#define IOPAGE_SHIFT                 (12)
>> +#define IOVA_PFN(addr)               ((addr) >> IOPAGE_SHIFT)
>> +#define IOVA_PAGE_SZ                 (SZ_4K)
>> +#define IOVA_START                   (0x00002000)
> 
> This doesn't match up - surely either IOVA_START_PFN should be 2, or IOVA_START should be 0x1000.
> 

my fault.
>> +#define IOVA_END                     (0x80000000)
>> +
>> +struct hi6220_smmu {
>> +    unsigned int irq;
>> .......................................
>> +static struct hi6220_smmu *smmu_dev_handle;
>> +static unsigned int smmu_regs_value[SMMU_REGS_MAX] = {0};
>> +static struct iova_domain iova_allocator;
> 
> Why can't these be allocated dynamically as part of the appropriate per-smmu-device data structure? You might only have a single smmu device in this particular SoC, but who knows what the future will bring.
> 

The smmu device who share the pagetable use the iova_allocator here to allocate iova address to get different io address.

And the devices can also use their own iova_allocator(not define here,in their own driver) for isolate iova allocate.

>> +static struct hi6220_domain *to_hi6220_domain(struct iommu_domain *dom)
>> +{
>> +    return container_of(dom, struct hi6220_domain, io_domain);
>> +}
>> +
>> +static inline void __smmu_writel(struct hi6220_smmu *smmu_dev, u32 value,
>> +                 unsigned long offset)
>> +{
>> +    writel(value, smmu_dev->reg_base + offset);
>> +}
>> +
>> +static inline u32 __smmu_readl(struct hi6220_smmu *smmu_dev,
>> +                   unsigned long offset)
>> +{
>> +    return readl(smmu_dev->reg_base + offset);
>> +}
>> +
>> +static void __restore_regs(struct hi6220_smmu *smmu_dev)
>> +{
>> +    smmu_regs_value[0] = __smmu_readl(smmu_dev, SMMU_CTRL_OFFSET);
>> +    smmu_regs_value[1] = __smmu_readl(smmu_dev, SMMU_ENABLE_OFFSET);
>> +    smmu_regs_value[2] = __smmu_readl(smmu_dev, SMMU_PTBR_OFFSET);
>> +    smmu_regs_value[3] = __smmu_readl(smmu_dev, SMMU_START_OFFSET);
>> +    smmu_regs_value[4] = __smmu_readl(smmu_dev, SMMU_END_OFFSET);
>> +    smmu_regs_value[5] = __smmu_readl(smmu_dev, SMMU_STATUS_OFFSET);
>> +    smmu_regs_value[6] = __smmu_readl(smmu_dev, SMMU_AXIID_OFFSET);
>> +    smmu_regs_value[7] = __smmu_readl(smmu_dev, SMMU_SEC_START_OFFSET);
>> +    smmu_regs_value[8] = __smmu_readl(smmu_dev, SMMU_SEC_END_OFFSET);
>> +    smmu_regs_value[9] = __smmu_readl(smmu_dev, SMMU_VERSION_OFFSET);
>> +    smmu_regs_value[10] = __smmu_readl(smmu_dev, SMMU_IPTSRC_OFFSET);
>> +    smmu_regs_value[11] = __smmu_readl(smmu_dev, SMMU_IPTPA_OFFSET);
>> +    smmu_regs_value[12] = __smmu_readl(smmu_dev, SMMU_TRBA_OFFSET);
>> +    smmu_regs_value[13] = __smmu_readl(smmu_dev, SMMU_BYS_START_OFFSET);
>> +    smmu_regs_value[14] = __smmu_readl(smmu_dev, SMMU_BYS_END_OFFSET);
>> +}
>> +
>> +static void __reload_regs(struct hi6220_smmu *smmu_dev)
>> +{
>> +    __smmu_writel(smmu_dev, smmu_regs_value[2], SMMU_PTBR_OFFSET);
>> +    __smmu_writel(smmu_dev, smmu_regs_value[5], SMMU_STATUS_OFFSET);
>> +    __smmu_writel(smmu_dev, smmu_regs_value[6], SMMU_AXIID_OFFSET);
>> +    __smmu_writel(smmu_dev, smmu_regs_value[7], SMMU_SEC_START_OFFSET);
>> +    __smmu_writel(smmu_dev, smmu_regs_value[8], SMMU_SEC_END_OFFSET);
>> +    __smmu_writel(smmu_dev, smmu_regs_value[9], SMMU_VERSION_OFFSET);
>> +    __smmu_writel(smmu_dev, smmu_regs_value[10], SMMU_IPTSRC_OFFSET);
>> +    __smmu_writel(smmu_dev, smmu_regs_value[11], SMMU_IPTPA_OFFSET);
>> +    __smmu_writel(smmu_dev, smmu_regs_value[12], SMMU_TRBA_OFFSET);
>> +    __smmu_writel(smmu_dev, smmu_regs_value[13], SMMU_BYS_START_OFFSET);
>> +    __smmu_writel(smmu_dev, smmu_regs_value[14], SMMU_BYS_END_OFFSET);
>> +}
> 
> Huh? If you only reload some of the registers you saved, why bother saving all of them in the first place? If that confusing SMMU_REGS_MAX is just to do with how many registers need to be saved/restored, then it would be better named something like SMMU_NUM_VOLATILE_REGS. Or get rid of the confusion entirely and just use a structure to store each one by name, instead of worrying about array sizes and indices.
> 
ok
>> +static inline void __set_smmu_pte(unsigned int *pte,
>> +                  dma_addr_t phys_addr)
>> +{
>> +    if ((*pte & PAGE_ENTRY_VALID))
>> +        pr_err("set pte[%p]->%x already set!\n", pte, *pte);
>> +
>> +    *pte = (unsigned int)(phys_addr | PAGE_ENTRY_VALID);
>> +}
>> +
>> +static inline void __clear_smmu_pte(unsigned int *pte)
>> +{
>> +    if (!(*pte & PAGE_ENTRY_VALID))
>> +        pr_err("clear pte[%p] %x err!\n", pte, *pte);
>> +
>> +    *pte = 0;
>> +}
>> +
>> +static inline void __invalid_smmu_tlb(struct hi6220_domain *m_domain,
>> +                      unsigned long iova, size_t size)
>> +{
>> +    unsigned long flags;
>> +    unsigned int smmu_ctrl = 0;
>> +    unsigned int inv_cnt = 10000;
>> +    unsigned int start_pfn = 0;
>> +    unsigned int end_pfn   = 0;
>> +    struct hi6220_smmu *smmu_dev = m_domain->smmu_dev;
>> +    dma_addr_t smmu_pgtbl_phy = m_domain->smmu_dev->pgtable_phy;
>> +
>> +    spin_lock_irqsave(&smmu_dev_handle->spinlock, flags);
> 
> Why use the global smmu_dev_handle here? You've just nicely looked up your smmu_dev instance through the domain, after all.
> 
accpet,change this later.
>> +
>> +    start_pfn = IOVA_PFN(iova);
>> +    end_pfn   = IOVA_PFN(iova + size);
>> +
>> +    __smmu_writel(smmu_dev, smmu_pgtbl_phy + start_pfn * sizeof(int),
>> +              SMMU_START_OFFSET);
>> +    __smmu_writel(smmu_dev, smmu_pgtbl_phy + end_pfn  * sizeof(int),
>> +              SMMU_END_OFFSET);
>> +
>> +    smmu_ctrl = __smmu_readl(smmu_dev, SMMU_CTRL_OFFSET);
>> +    smmu_ctrl = smmu_ctrl | SMMU_CTRL_INVALID;
>> +    __smmu_writel(smmu_dev, smmu_ctrl, SMMU_CTRL_OFFSET);
>> +
>> +    do {
>> +        smmu_ctrl = __smmu_readl(smmu_dev, SMMU_CTRL_OFFSET);
>> +        if (0x0 == (smmu_ctrl & SMMU_CTRL_INVALID)) {
>> +            spin_unlock_irqrestore(&smmu_dev_handle->spinlock, flags);
>> +            return;
>> +        }
>> +    } while (inv_cnt--);
> 
> Any reason this couldn't be done with readl_poll_timeout_atomic()?
> 
learned,thanks.
>> +    spin_unlock_irqrestore(&smmu_dev_handle->spinlock, flags);
>> +
>> +    WARN_ON((!inv_cnt) && ((smmu_ctrl & SMMU_CTRL_INVALID) != 0));
> 
> As it is, you can only get here if both those conditions were true anyway. I say were, because the post-decrement as you exit the loop means that inv_cnt is now UINT_MAX, thus this WARN will never fire.
> 
ok.
>> +}
>> +
>> +static int __smmu_enable(struct hi6220_smmu *smmu_dev)
>> +{
>> +    if (clk_prepare_enable(smmu_dev->media_sc_clk)) {
>> +        pr_err("clk_prepare_enable media_sc_clk is falied\n");
>> +        return -ENODEV;
>> +    }
>> +    if (clk_prepare_enable(smmu_dev->smmu_peri_clk)) {
>> +        pr_err("clk_prepare_enable smmu_peri_clk is falied\n");
>> +        return -ENODEV;
>> +    }
>> +    if (clk_prepare_enable(smmu_dev->smmu_clk)) {
>> +        pr_err("clk_prepare_enable smmu_clk is falied\n");
>> +        return -ENODEV;
>> +    }
>> +    return 0;
>> +}
>> +
>> +/**
>> + * interrupt happen when operator error
>> + */
>> +static irqreturn_t hi6220_smmu_isr(int irq, void *data)
>> +{
>> +    int          i;
>> +    unsigned int irq_stat;
>> +    struct hi6220_smmu *smmu_dev = smmu_dev_handle;
> 
> Why not just register the appropriate smmu_dev as data in the first place, then you can use it here?
> 
ok
>> +    irq_stat = __smmu_readl(smmu_dev, SMMU_MINTSTS_OFFSET);
>> +
>> +    __smmu_writel(smmu_dev, 0xff, SMMU_INTCLR_OFFSET);
>> +
>> +    for (i = 0; i < SMMU_REGS_SGMT_END; i += 4)
>> +        pr_err("[%08x] ", __smmu_readl(smmu_dev, i));
>> +
>> +    WARN_ON(irq_stat & 0x3f);
> 
> If interrupts are an exceptional condition indicative of a serious error, then this warrants a much clearer message than just dumping some inscrutable hex digits and a useless stack trace to the log with no explanation.
> 
ok,remvoe this warn later.
>> +
>> +    return IRQ_HANDLED;
>> +}
>> +
>> +static bool hi6220_smmu_capable(enum iommu_cap cap)
>> +{
>> +    return false;
>> +}
> 
> You may as well not have this at all, since iommu_capable() will return false for you if the .capable callback isn't implemented.
> 
learned, thanks.
>> +static struct iommu_domain *hi6220_domain_alloc(unsigned type)
>> +{
>> +    struct hi6220_domain *m_domain;
>> +    struct hi6220_smmu *smmu_dev;
>> +
>> +    if (type != IOMMU_DOMAIN_UNMANAGED)
>> +        return NULL;
>> +
>> +    smmu_dev = smmu_dev_handle;
>> +    if (!smmu_dev)
>> +        return NULL;
>> +
>> +    m_domain = kzalloc(sizeof(*m_domain), GFP_KERNEL);
>> +    if (!m_domain)
>> +        return NULL;
>> +
>> +    m_domain->smmu_dev = smmu_dev_handle;
>> +    m_domain->io_domain.geometry.aperture_start = IOVA_START;
>> +    m_domain->io_domain.geometry.aperture_end = IOVA_END;
>> +    m_domain->io_domain.geometry.force_aperture = true;
>> +
>> +    return &m_domain->io_domain;
>> +}
>> +
>> +static void hi6220_domain_free(struct iommu_domain *domain)
>> +{
>> +    struct hi6220_domain *hi6220_domain = to_hi6220_domain(domain);
>> +
>> +    kfree(hi6220_domain);
>> +}
>> +
>> +static int hi6220_smmu_attach_dev(struct iommu_domain *domain,
>> +                  struct device *dev)
>> +{
>> +    dev->archdata.iommu = &iova_allocator;
> 
> If the hardware doesn't offer any kind of device isolation (i.e. multiple translation contexts), then you should probably have more logic here to ensure only a single domain can ever be active at once.
> 

I don't distinguish device by domain. Different domain just use the same allocator for sharing page-table.

May be my opinion is wrong. The device also can be in a single domain, but I don't know how to ensure the device

get the not-repeat iova address.
>> +    return 0;
>> +}
>> +
>> +static void hi6220_smmu_detach_dev(struct iommu_domain *domain,
>> +                   struct device *dev)
>> +{
>> +    dev->archdata.iommu = NULL;
>> +}
>> +
>> +static inline void dump_pte(unsigned int *pte)
>> +{
>> +    int index;
>> +
>> +    for (index = 0; index < SZ_2M / sizeof(int); index++) {
>> +        if (pte[index])
>> +            pr_info("pte [%p]\t%x\n", &pte[index], pte[index]);
> 
> This should be at most a pr_debug(), if not removed entirely.
> 
ok
>> +    }
>> +}
>> +
>> +static int hi6220_smmu_map(struct iommu_domain *domain,
>> +               unsigned long iova, phys_addr_t pa,
>> +               size_t size, int smmu_prot)
>> +{
>> +    struct hi6220_domain *m_domain = to_hi6220_domain(domain);
>> +    size_t page_size = m_domain->smmu_dev->page_size;
>> +    struct hi6220_smmu *smmu_dev = m_domain->smmu_dev;
>> +    unsigned int *page_table = (unsigned int *)smmu_dev->pgtable_virt;
>> +
>> +    if (size != page_size) {
>> +        pr_err("map size error, only support %zd\n", page_size);
>> +        return -ENOMEM;
>> +    }
> 
> You only advertise one page size, so the IOMMU API will never call you with anything else, therefore this check is completely redundant.
> 
ok.
>> +    __set_smmu_pte(page_table + IOVA_PFN(iova), pa);
>> +
>> +    dump_pte(page_table);
> 
> No.
> 
>> +    __invalid_smmu_tlb(m_domain, iova, size);
>> +
>> +    return 0;
>> +}
>> +
>> +static size_t hi6220_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
>> +                size_t size)
>> +{
>> +    struct hi6220_domain *m_domain = to_hi6220_domain(domain);
>> +    size_t page_size = m_domain->smmu_dev->page_size;
>> +    struct hi6220_smmu *smmu_dev = m_domain->smmu_dev;
>> +    int *page_table = (unsigned int *)smmu_dev->pgtable_virt;
>> +
>> +    if (size != page_size) {
>> +        pr_err("unmap size error, only support %zd\n", page_size);
>> +        return 0;
>> +    }
> 
> Again, this is just dead code.
> 
ok
>> +
>> +    __clear_smmu_pte(page_table + IOVA_PFN(iova));
>> +
>> +    dump_pte(page_table);
> 
> No.
> 
> Nobody wants to see the *entire* page table dumped for every page mapped/unmapped. Besides, I've found that just turning on the debug prints in iommu.c is usually enough to absolutely cripple performance and overflow the log buffer, so how it's bearable to have this here at all I can't imagine.
> 
>> +    __invalid_smmu_tlb(m_domain, iova, size);
>> +
>> +    return page_size;
>> +}
>> +
>> +static const struct iommu_ops hi6220_smmu_ops = {
>> +    .capable = hi6220_smmu_capable,
>> +    .domain_alloc = hi6220_domain_alloc,
>> +    .domain_free = hi6220_domain_free,
>> +    .attach_dev = hi6220_smmu_attach_dev,
>> +    .detach_dev = hi6220_smmu_detach_dev,
>> +    .map = hi6220_smmu_map,
>> +    .unmap = hi6220_smmu_unmap,
>> +    .map_sg = default_iommu_map_sg,
>> +    .pgsize_bitmap = IOVA_PAGE_SZ,
>> +};
> 
> Since you've implemented neither add_device nor of_xlate, I don't see how any of this ever actually gets used. Are the client devices only using carved-out memory regions outside the kernel linear map and doing their own IOVA management and IOMMU API calls?
>
The device use the iommu_attach_device to get the iova_allocator in archdata.iommu, then use this for iova allocate.

>> +static int hi6220_smmu_probe(struct platform_device *pdev)
>> +{
>> +    int ret;
>> +    int irq;
>> +    struct hi6220_smmu *smmu_dev  = NULL;
>> +    struct resource *res = NULL;
>> +
>> +    smmu_dev = devm_kzalloc(&pdev->dev, sizeof(*smmu_dev), GFP_KERNEL);
>> +
>> +    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +    smmu_dev->reg_base = devm_ioremap_resource(&pdev->dev, res);
>> +    if (IS_ERR(smmu_dev->reg_base))
>> +        return PTR_ERR(smmu_dev->reg_base);
>> +
>> +    smmu_dev->media_sc_clk = devm_clk_get(&pdev->dev, "media_sc_clk");
>> +    smmu_dev->smmu_peri_clk  = devm_clk_get(&pdev->dev, "smmu_peri_clk");
>> +    smmu_dev->smmu_clk  = devm_clk_get(&pdev->dev, "smmu_clk");
>> +    if (IS_ERR(smmu_dev->media_sc_clk) || IS_ERR(smmu_dev->smmu_peri_clk) ||
>> +        IS_ERR(smmu_dev->media_sc_clk)) {
>> +        pr_err("clk is not ready!\n");
> 
> ...yet it's safe to carry on probing anyway?
> 
ok, fix this later.
>> +    }
>> +
>> +    irq = platform_get_irq(pdev, 0);
>> +
>> +    ret = devm_request_irq(&pdev->dev, irq, hi6220_smmu_isr, 0,
>> +                   dev_name(&pdev->dev), smmu_dev);
> 
> Oh, so you *do* register the smmu_dev as the callback data. In that case there's really no need for hi6220_smmu_isr() to be using that global pointer after all.
> 
ok
>> +    if (ret) {
>> +        pr_err("Unabled to register handler of irq %d\n", irq);
>> +        return ret;
>> +    }
>> +
>> +    smmu_dev->irq = irq;
>> +    smmu_dev->smmu_isr = hi6220_smmu_isr;
> 
> Why is .smmu_isr needed? It's never used anywhere.
> 
>> +    smmu_dev->page_size = IOVA_PAGE_SZ;
> 
> Similarly, what's the point of .page_size? You already have hi6220_smmu_ops.pgsize_bitmap, and even if the places which refer to page_size were not largely redundant, they could just as well use the constant directly.
> 
>> +    spin_lock_init(&smmu_dev->spinlock);
>> +
>> +    __smmu_enable(smmu_dev);
>> +
>> +    iommu_iova_cache_init();
> 
> This function doesn't exist since 4.3-rc4.
> 
>> +    init_iova_domain(&iova_allocator, IOVA_PAGE_SZ,
>> +             IOVA_START_PFN, IOVA_PFN(DMA_BIT_MASK(32)));
> 
> Why DMA_BIT_MASK(32) and not IOVA_END?
> 
ok
>> +
>> +    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>> +    smmu_dev->pgtable_virt = dma_alloc_coherent(&pdev->dev, SZ_2M,
>> +                            &smmu_dev->pgtable_phy,
>> +                            GFP_KERNEL);
>> +    memset(smmu_dev->pgtable_virt, 0, SZ_2M);
> 
> Just use dma_zalloc_coherent(). Also, 2MB is pretty big for a single contiguous allocation, so you should be prepared to handle failure here.
> 
>> +    platform_set_drvdata(pdev, smmu_dev);
>> +    bus_set_iommu(&platform_bus_type, &hi6220_smmu_ops);
>> +    smmu_dev_handle = smmu_dev;
>> +
>> +    return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int hi6220_smmu_suspend(struct platform_device *pdev,
>> +                   pm_message_t state)
>> +{
>> +    struct hi6220_smmu *smmu_dev = dev_get_drvdata(&pdev->dev);
>> +
>> +    __restore_regs(smmu_dev);
>> +
>> +    if (smmu_dev->smmu_clk)
>> +        clk_disable_unprepare(smmu_dev->smmu_clk);
>> +    if (smmu_dev->media_sc_clk)
>> +        clk_disable_unprepare(smmu_dev->media_sc_clk);
>> +    if (smmu_dev->smmu_peri_clk)
>> +        clk_disable_unprepare(smmu_dev->smmu_peri_clk);
>> +
>> +    return 0;
>> +}
>> +
>> +static int hi6220_smmu_resume(struct platform_device *pdev)
>> +{
>> +    struct hi6220_smmu *smmu_dev = dev_get_drvdata(&pdev->dev);
>> +
>> +    __smmu_enable(smmu_dev);
>> +    __reload_regs(smmu_dev);
>> +    return 0;
>> +}
>> +
>> +#else
>> +
>> +#define hi6220_smmu_suspend NULL
>> +#define hi6220_smmu_resume NULL
> 
> Are these necessary? They're not externally visible, and the only references in here are also covered by #ifdef CONFIG_PM.
> 
learned.
>> +#endif /* CONFIG_PM */
>> +
>> +static const struct of_device_id of_smmu_match_tbl[] = {
>> +    {
>> +        .compatible = "hisilicon,hi6220-smmu",
>> +    },
>> +    { }
>> +};
>> +
>> +static struct platform_driver hi6220_smmu_driver = {
>> +    .driver  = {
>> +        .name = "smmu-hi6220",
>> +        .of_match_table = of_smmu_match_tbl,
>> +    },
>> +    .probe  =  hi6220_smmu_probe,
>> +#ifdef CONFIG_PM
>> +    .suspend = hi6220_smmu_suspend,
>> +    .resume  = hi6220_smmu_resume,
>> +#endif
>> +};
>> +
>> +static int __init hi6220_smmu_init(void)
>> +{
>> +    int ret;
>> +
>> +    ret = platform_driver_register(&hi6220_smmu_driver);
>> +    return ret;
>> +}
>> +
>> +subsys_initcall(hi6220_smmu_init);
> 
> The binding in patch 1/3 says #iommu-cells must be 1, which implies you expect client devices to have some kind of ID via the generic IOMMU bindings, but I've now got to the end of the patch without seeing any code for handling master IDs, or indeed anything to even find the client devices in the first place (since you don't implement of_xlate to let the of_iommu code handle that for you). Either this driver isn't finished, or you've got some weird usage model which needs explaining.
> 
	............
        struct iommu_domain *domain = iommu_domain_alloc(m_dev->bus);
        iommu_attach_device(domain, m_dev);
        struct iova_domain *iovad = (struct iova_domain *)m_dev->archdata.iommu;
        struct iova * t_iova = alloc_iova(iovad, size, max, aligned);
	iommu_map(domain, t_iova->pfn_lo << 12, paddr, size, 0);
	............
> Robin.
> 
> 
> .
> 
