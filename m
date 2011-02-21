From: dacohen@gmail.com (David Cohen)
Date: Mon, 21 Feb 2011 23:12:20 +0200
Subject: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during fault
	handling
In-Reply-To: <AANLkTikbjZ7GH7+bx94r6saYuGzCt9aito-Y8NS94SoQ@mail.gmail.com>
References: <1297884951-3019-1-git-send-email-dacohen@gmail.com>
	<1297884951-3019-3-git-send-email-dacohen@gmail.com>
	<AANLkTikbjZ7GH7+bx94r6saYuGzCt9aito-Y8NS94SoQ@mail.gmail.com>
Message-ID: <AANLkTi=rJZo2KwryYznFp6Qq25Oh0+F44OKV-khuQyte@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 21, 2011 at 8:43 PM, Ramirez Luna, Omar <omar.ramirez@ti.com> wrote:
> Hi,

Hi,

Thanks for the comments.

>
> On Wed, Feb 16, 2011 at 1:35 PM, David Cohen <dacohen@gmail.com> wrote:
>> diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
>> index 49a1e5e..adb083e 100644
>> --- a/arch/arm/mach-omap2/iommu2.c
>> +++ b/arch/arm/mach-omap2/iommu2.c
> ...
>>
>> ? ? ? ?da = iommu_read_reg(obj, MMU_FAULT_AD);
>> ? ? ? ?*ra = da;
>>
>> + ? ? ? if (stat & MMU_IRQ_TLBMISS)
>> + ? ? ? ? ? ? ? errs |= OMAP_IOMMU_ERR_TLB_MISS;
>> + ? ? ? if (stat & MMU_IRQ_TRANSLATIONFAULT)
>> + ? ? ? ? ? ? ? errs |= OMAP_IOMMU_ERR_TRANS_FAULT;
>> + ? ? ? if (stat & MMU_IRQ_EMUMISS)
>> + ? ? ? ? ? ? ? errs |= OMAP_IOMMU_ERR_EMU_MISS;
>> + ? ? ? if (stat & MMU_IRQ_TABLEWALKFAULT)
>> + ? ? ? ? ? ? ? errs |= OMAP_IOMMU_ERR_TBLWALK_FAULT;
>> + ? ? ? if (stat & MMU_IRQ_MULTIHITFAULT)
>> + ? ? ? ? ? ? ? errs |= OMAP_IOMMU_ERR_MULTIHIT_FAULT;
>
> I still don't think this adds any value, "generic layer" and omap
> errors are the same thing in this case... OTOH OMAP 1710 (not
> supported by iommu yet) has the following bits:
>
> 3 Prefetch_err
> 2 Perm_fault
> 1 Tlb_miss
> 0 Trans_fault
>
> They don't match any of your "generic layer errors" masks for reading,

Have you noticed:
 0 = OMAP_IOMMU_ERR_TRANS_FAULT
 1 = OMAP_IOMMU_ERR_TLB_MISS

2 and 3 could be added.

> hence more generic errors will need to be defined, and then more OMAP#
> masks... I think we just need to stick with the mach specific errors,
> and let mach code handle its specifics when reporting.

How many are we talking about? I don't think every new OMAP version it
would completely re-invent IOMMU faults.
Generic errors codes make easier to threat possible IOMMU users which
have (partially or totally) common drivers for different OMAP
versions.
Unless it's really an out-of-control number of generic faults, I don't
see it as a real problem.

>
> But anyway it is just me...
>
>> diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
>> index f55f458..b0e0efc 100644
>> --- a/arch/arm/plat-omap/iommu.c
>> +++ b/arch/arm/plat-omap/iommu.c
>> @@ -780,25 +780,19 @@ static void iopgtable_clear_entry_all(struct iommu *obj)
>> ?*/
>> ?static irqreturn_t iommu_fault_handler(int irq, void *data)
>> ?{
>> - ? ? ? u32 stat, da;
>> + ? ? ? u32 da, errs;
>> ? ? ? ?u32 *iopgd, *iopte;
>> - ? ? ? int err = -EIO;
>> ? ? ? ?struct iommu *obj = data;
>>
>> ? ? ? ?if (!obj->refcount)
>> ? ? ? ? ? ? ? ?return IRQ_NONE;
>>
>> - ? ? ? /* Dynamic loading TLB or PTE */
>> - ? ? ? if (obj->isr)
>> - ? ? ? ? ? ? ? err = obj->isr(obj);
>> -
>> - ? ? ? if (!err)
>> - ? ? ? ? ? ? ? return IRQ_HANDLED;
>> -
>> ? ? ? ?clk_enable(obj->clk);
>> - ? ? ? stat = iommu_report_fault(obj, &da);
>> + ? ? ? errs = iommu_report_fault(obj, &da);
>> ? ? ? ?clk_disable(obj->clk);
>> - ? ? ? if (!stat)
>> +
>> + ? ? ? /* Fault callback or TLB/PTE Dynamic loading */
>> + ? ? ? if (obj->isr && !obj->isr(obj, da, errs, obj->isr_priv))
>> ? ? ? ? ? ? ? ?return IRQ_HANDLED;
>
> BTW, why not changing the name isr for cb, it is confusing since there
> is another fault_isr called by mmu, AFAIK nobody uses obj->isr

The main purpose of this function is to be an ISR, not only callback.
But as you noticed, nobody is using it yet, but OMAP3 ISP should start
to use it soon.

>
>> ? ? ? ?iommu_disable(obj);
>> @@ -806,15 +800,16 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
>> ? ? ? ?iopgd = iopgd_offset(obj, da);
>>
>> ? ? ? ?if (!iopgd_is_table(*iopgd)) {
>> - ? ? ? ? ? ? ? dev_err(obj->dev, "%s: da:%08x pgd:%p *pgd:%08x\n", obj->name,
>> - ? ? ? ? ? ? ? ? ? ? ? da, iopgd, *iopgd);
>> + ? ? ? ? ? ? ? dev_err(obj->dev, "%s: errs:0x%08x da:0x%08x pgd:0x%p "
>> + ? ? ? ? ? ? ? ? ? ? ? "*pgd:px%08x\n", obj->name, errs, da, iopgd, *iopgd);
>> ? ? ? ? ? ? ? ?return IRQ_NONE;
>> ? ? ? ?}
>>
>> ? ? ? ?iopte = iopte_offset(iopgd, da);
>>
>> - ? ? ? dev_err(obj->dev, "%s: da:%08x pgd:%p *pgd:%08x pte:%p *pte:%08x\n",
>> - ? ? ? ? ? ? ? obj->name, da, iopgd, *iopgd, iopte, *iopte);
>> + ? ? ? dev_err(obj->dev, "%s: errs:0x%08x da:0x%08x pgd:0x%p *pgd:0x%08x "
>> + ? ? ? ? ? ? ? "pte:0x%p *pte:0x%08x\n", obj->name, errs, da, iopgd, *iopgd,
>> + ? ? ? ? ? ? ? iopte, *iopte);
>>
>> ? ? ? ?return IRQ_NONE;
>> ?}
>> @@ -917,6 +912,33 @@ void iommu_put(struct iommu *obj)
>> ?}
>> ?EXPORT_SYMBOL_GPL(iommu_put);
>>
>> +int iommu_set_isr(const char *name,
>> + ? ? ? ? ? ? ? ? int (*isr)(struct iommu *obj, u32 da, u32 iommu_errs,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ?void *priv),
>> + ? ? ? ? ? ? ? ? void *isr_priv)
>
> So I think the following will be bad practice:
>
> ? ? ? ?mmu = iommu_get("iva2");
> ? ? ? ?if (!IS_ERR(mmu))
> ? ? ? ? ? ? ? ?mmu->isr = mmu_fault_callback;
>
> Shall we think anything to prevent such mis-usage?

Well, the IOMMU user has access to IOMMU obj, so it can not only
change the (*isr)() but to mess with a lot of other stuff. The only
way to prevent it is to avoid user to have obj. But then, this fix (or
issue) does not belong to this patch.

Br,

David

>
> Regards,
>
> Omar
>
