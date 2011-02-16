From: dacohen@gmail.com (David Cohen)
Date: Wed, 16 Feb 2011 18:28:49 +0200
Subject: [PATCH v2 1/1] OMAP: IOMMU: add support to callback during fault
	handling
In-Reply-To: <AANLkTikK0zAYtSaA1LCdkn2t4_XiTH_DmESEzw8MLvfU@mail.gmail.com>
References: <1297780591-15613-1-git-send-email-dacohen@gmail.com>
	<1297780591-15613-2-git-send-email-dacohen@gmail.com>
	<20110215.164822.811675675026794737.Hiroshi.DOYU@nokia.com>
	<AANLkTikK0zAYtSaA1LCdkn2t4_XiTH_DmESEzw8MLvfU@mail.gmail.com>
Message-ID: <AANLkTikcd9EkgUpm9JMPoiG+O3_CVBGO9T_45Me-qWn3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 5:10 PM, David Cohen <dacohen@gmail.com> wrote:
> On Tue, Feb 15, 2011 at 4:48 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
>> Hi David,
>
> Hi Hiroshi,
>
>>
>> Sorry for a bit late reply....
>
> You're just in time. :)
>
>>
>> From: David Cohen <dacohen@gmail.com>
>> Subject: [PATCH v2 1/1] OMAP: IOMMU: add support to callback during fault handling
>> Date: Tue, 15 Feb 2011 16:36:31 +0200
>>
>>> Add support to register a callback for IOMMU fault situations. Drivers using
>>> IOMMU module might want to be informed when such errors happen in order to
>>> debug it or react.
>>>
>>> Signed-off-by: David Cohen <dacohen@gmail.com>
>>> ---
>>> ?arch/arm/mach-omap2/iommu2.c ? ? ? ? ? ?| ? 21 +++++++++++++--
>>> ?arch/arm/plat-omap/include/plat/iommu.h | ? 15 ++++++++++-
>>> ?arch/arm/plat-omap/iommu.c ? ? ? ? ? ? ?| ? 41 ++++++++++++++++++++++++++++---
>>> ?3 files changed, 69 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
>>> index 14ee686..504310d 100644
>>> --- a/arch/arm/mach-omap2/iommu2.c
>>> +++ b/arch/arm/mach-omap2/iommu2.c
>>> @@ -143,10 +143,10 @@ static void omap2_iommu_set_twl(struct iommu *obj, bool on)
>>> ? ? ? __iommu_set_twl(obj, false);
>>> ?}
>>>
>>> -static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
>>> +static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra, u32 *iommu_errs)
>>> ?{
>>> ? ? ? int i;
>>> - ? ? u32 stat, da;
>>> + ? ? u32 stat, da, errs;
>>> ? ? ? const char *err_msg[] = {
>>> ? ? ? ? ? ? ? "tlb miss",
>>> ? ? ? ? ? ? ? "translation fault",
>>> @@ -157,8 +157,10 @@ static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
>>>
>>> ? ? ? stat = iommu_read_reg(obj, MMU_IRQSTATUS);
>>> ? ? ? stat &= MMU_IRQ_MASK;
>>> - ? ? if (!stat)
>>> + ? ? if (!stat) {
>>> + ? ? ? ? ? ? *iommu_errs = 0;
>>> ? ? ? ? ? ? ? return 0;
>>> + ? ? }
>>>
>>> ? ? ? da = iommu_read_reg(obj, MMU_FAULT_AD);
>>> ? ? ? *ra = da;
>>> @@ -171,6 +173,19 @@ static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
>>> ? ? ? }
>>> ? ? ? printk("\n");
>>>
>>> + ? ? errs = 0;
>>> + ? ? if (stat & MMU_IRQ_TLBMISS)
>>> + ? ? ? ? ? ? errs |= OMAP_IOMMU_ERR_TLB_MISS;
>>> + ? ? if (stat & MMU_IRQ_TRANSLATIONFAULT)
>>> + ? ? ? ? ? ? errs |= OMAP_IOMMU_ERR_TRANS_FAULT;
>>> + ? ? if (stat & MMU_IRQ_EMUMISS)
>>> + ? ? ? ? ? ? errs |= OMAP_IOMMU_ERR_EMU_MISS;
>>> + ? ? if (stat & MMU_IRQ_TABLEWALKFAULT)
>>> + ? ? ? ? ? ? errs |= OMAP_IOMMU_ERR_TBLWALK_FAULT;
>>> + ? ? if (stat & MMU_IRQ_MULTIHITFAULT)
>>> + ? ? ? ? ? ? errs |= OMAP_IOMMU_ERR_MULTIHIT_FAULT;
>>> + ? ? *iommu_errs = errs;
>>> +
>>> ? ? ? iommu_write_reg(obj, stat, MMU_IRQSTATUS);
>>>
>>> ? ? ? return stat;
>>> diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
>>> index 19cbb5e..5a2475f 100644
>>> --- a/arch/arm/plat-omap/include/plat/iommu.h
>>> +++ b/arch/arm/plat-omap/include/plat/iommu.h
>>> @@ -31,6 +31,7 @@ struct iommu {
>>> ? ? ? struct clk ? ? ?*clk;
>>> ? ? ? void __iomem ? ?*regbase;
>>> ? ? ? struct device ? *dev;
>>> + ? ? void ? ? ? ? ? ?*fault_cb_priv;
>>>
>>> ? ? ? unsigned int ? ?refcount;
>>> ? ? ? struct mutex ? ?iommu_lock; ? ? /* global for this whole object */
>>> @@ -48,6 +49,7 @@ struct iommu {
>>> ? ? ? struct mutex ? ? ? ? ? ?mmap_lock; /* protect mmap */
>>>
>>> ? ? ? int (*isr)(struct iommu *obj);
>>> + ? ? void (*fault_cb)(struct iommu *obj, u32 da, u32 iommu_errs, void *priv);
>>
>> What about making use of (*isr)() for fault call back as well?
>>
>> Basic concept is that, client can decide how to deal with iommu
>> fault. For example, for advanced case, client wants daynamic loading of
>> TLB(or PTE), or for ISP case, clients just want more appropriate fault
>> reporting. This (*isr)() could be used in such flexibility.
>
> In this case, it seems we can re-use it.
>
>>
>> ? 785 ? * ? ? ?Device IOMMU generic operations
>> ? 786 ? */
>> ? 787 ?static irqreturn_t iommu_fault_handler(int irq, void *data)
>> ? 788 ?{
>> ? 789 ? ? ? ? ?u32 stat, da;
>> ? 790 ? ? ? ? ?u32 *iopgd, *iopte;
>> ? 791 ? ? ? ? ?int err = -EIO;
>> ? 792 ? ? ? ? ?struct iommu *obj = data;
>> ? 793
>> ? 794 ? ? ? ? ?if (!obj->refcount)
>> ? 795 ? ? ? ? ? ? ? ? ?return IRQ_NONE;
>> ? 796
>> ? 797 ? ? ? ? ?/* Dynamic loading TLB or PTE */
>> ? 798 ? ? ? ? ?if (obj->isr)
>> ? 799 ? ? ? ? ? ? ? ? ?err = obj->isr(obj);
>> ? 800
>> ? 801 ? ? ? ? ?if (!err)
>> ? 802 ? ? ? ? ? ? ? ? ?return IRQ_HANDLED;
>> ? 803
>> ? 804 ? ? ? ? ?clk_enable(obj->clk);
>> ? 805 ? ? ? ? ?stat = iommu_report_fault(obj, &da);
>> ? 806 ? ? ? ? ?clk_disable(obj->clk);
>> ? 807 ? ? ? ? ?if (!stat)
>> ? 808 ? ? ? ? ? ? ? ? ?return IRQ_HANDLED;
>> ? 809
>> ? 810 ? ? ? ? ?iommu_disable(obj);
>>
>> I guess that this modifying the above code could make (*isr)()
>> flexible to be used for any purpose for clients? For me, having both
>> following may be a bit residual.
>

There are few possible issues in this case. (*isr)() is meant to
replace the generic fault handler on iommu, but the fault callback
isn't. Basically fault callback needs to call specific iommu fault
report to know faulty 'da' and iommu errors, so part of the generic
fault handler must be called.

One possible solution is always call specific fault report before
(*isr)(). IMO it makes sense as (*isr)() might want to know at least
the current faults.
But in this case, specific fault report should not print anything else
as only the upper layer and user will know when a fault is actually an
error or not. So, they're responsible for error messages.

I'm sending a v3 with these changes. Comments will be welcome.

Br,

David

> I agree. We need to add 'void *isr_priv' to iommu struct and the
> function to register isr.
> I'll send a v3 soon.
>
> Regards,
>
> David
>
>>
>>> ? ? ? int (*isr)(struct iommu *obj);
>>> + ? ? void (*fault_cb)(struct iommu *obj, u32 da, u32 iommu_errs, void *priv);
>>
>
