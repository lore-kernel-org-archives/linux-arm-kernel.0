From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Mon, 21 Feb 2011 11:51:23 +0200 (EET)
Subject: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during
	fault handling
In-Reply-To: <AANLkTimdWknRuk+QSV3bFU=qQGMsmmH-dj6a_QaTp49r@mail.gmail.com>
References: <1297884951-3019-3-git-send-email-dacohen@gmail.com>
	<20110221.101856.76372714451194378.Hiroshi.DOYU@nokia.com>
	<AANLkTimdWknRuk+QSV3bFU=qQGMsmmH-dj6a_QaTp49r@mail.gmail.com>
Message-ID: <20110221.115123.739189211216197016.Hiroshi.DOYU@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: ext David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during fault handling
Date: Mon, 21 Feb 2011 11:07:01 +0200

> On Mon, Feb 21, 2011 at 10:18 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
>> From: David Cohen <dacohen@gmail.com>
>> Subject: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during fault handling
>> Date: Wed, 16 Feb 2011 21:35:51 +0200
>>
>>> Add support to register an isr for IOMMU fault situations and adapt it
>>> to allow such (*isr)() to be used as fault callback. Drivers using IOMMU
>>> module might want to be informed when errors happen in order to debug it
>>> or react.
>>>
>>> Signed-off-by: David Cohen <dacohen@gmail.com>
>>> ---
>>> ?arch/arm/mach-omap2/iommu2.c ? ? ? ? ? ?| ? 17 +++++++++-
>>> ?arch/arm/plat-omap/include/plat/iommu.h | ? 14 ++++++++-
>>> ?arch/arm/plat-omap/iommu.c ? ? ? ? ? ? ?| ? 52 ++++++++++++++++++++++---------
>>> ?3 files changed, 65 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
>>> index 49a1e5e..adb083e 100644
>>> --- a/arch/arm/mach-omap2/iommu2.c
>>> +++ b/arch/arm/mach-omap2/iommu2.c
>>> @@ -146,18 +146,31 @@ static void omap2_iommu_set_twl(struct iommu *obj, bool on)
>>> ?static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
>>> ?{
>>> ? ? ? u32 stat, da;
>>> + ? ? u32 errs = 0;
>>>
>>> ? ? ? stat = iommu_read_reg(obj, MMU_IRQSTATUS);
>>> ? ? ? stat &= MMU_IRQ_MASK;
>>> - ? ? if (!stat)
>>> + ? ? if (!stat) {
>>> + ? ? ? ? ? ? *ra = 0;
>>> ? ? ? ? ? ? ? return 0;
>>> + ? ? }
>>>
>>> ? ? ? da = iommu_read_reg(obj, MMU_FAULT_AD);
>>> ? ? ? *ra = da;
>>>
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
>>> ? ? ? iommu_write_reg(obj, stat, MMU_IRQSTATUS);
>>>
>>> - ? ? return stat;
>>> + ? ? return errs;
>>> ?}
>>>
>>> ?static void omap2_tlb_read_cr(struct iommu *obj, struct cr_regs *cr)
>>> diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
>>> index 19cbb5e..174f1b9 100644
>>> --- a/arch/arm/plat-omap/include/plat/iommu.h
>>> +++ b/arch/arm/plat-omap/include/plat/iommu.h
>>> @@ -31,6 +31,7 @@ struct iommu {
>>> ? ? ? struct clk ? ? ?*clk;
>>> ? ? ? void __iomem ? ?*regbase;
>>> ? ? ? struct device ? *dev;
>>> + ? ? void ? ? ? ? ? ?*isr_priv;
>>
>> Ideally I'd like to avoid having "isr_priv" in iommu since it's not
>> used for iommu but client needs the place to pass its info to its
>> custom handler. Any better idea?
> 
> (*isr)() relies in the same situation, as it belongs to the client.
> Without this priv_data, it's necessary to create a global variable to
> store client's private data on client side. IMO, it is worse.

Ok, I see. Let's go with this. Thanks.
