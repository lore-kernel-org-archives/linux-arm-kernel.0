From: dacohen@gmail.com (David Cohen)
Date: Tue, 15 Feb 2011 15:44:27 +0200
Subject: [PATCH 1/2] OMAP2+: IOMMU: change OMAP2+ error message to
	dev_dbg()
In-Reply-To: <4D5A81D8.2080800@ru.mvista.com>
References: <1297776033-8579-1-git-send-email-dacohen@gmail.com>
	<1297776033-8579-2-git-send-email-dacohen@gmail.com>
	<4D5A81D8.2080800@ru.mvista.com>
Message-ID: <AANLkTinQX59iyX1La=99Urgh5_JF0iZacBDqQz1VQfhi@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 3:38 PM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.

Hi,

>
> On 15-02-2011 16:20, David Cohen wrote:
>
>> IOMMU upper layer is already printing error message. OMAP2+ specific
>> layer may print error message only for debug purpose.
>
>> Signed-off-by: David Cohen<dacohen@gmail.com>
>> ---
>> ?arch/arm/mach-omap2/iommu2.c | ? ?6 +++---
>> ?1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
>> index 14ee686..4244a07 100644
>> --- a/arch/arm/mach-omap2/iommu2.c
>> +++ b/arch/arm/mach-omap2/iommu2.c
>> @@ -163,13 +163,13 @@ static u32 omap2_iommu_fault_isr(struct iommu *obj,
>> u32 *ra)
>> ? ? ? ?da = iommu_read_reg(obj, MMU_FAULT_AD);
>> ? ? ? ?*ra = da;
>>
>> - ? ? ? dev_err(obj->dev, "%s:\tda:%08x ", __func__, da);
>> + ? ? ? dev_dbg(obj->dev, "%s:\tda:%08x ", __func__, da);
>
> ? Note that dev_dbg() will only print something if either DEBUG or
> CONFIG_DYNAMIC_DEBUG are defined...

That's my plan.

>
>>
>> ? ? ? ?for (i = 0; i< ?ARRAY_SIZE(err_msg); i++) {
>> ? ? ? ? ? ? ? ?if (stat & (1<< ?i))
>> - ? ? ? ? ? ? ? ? ? ? ? printk("%s ", err_msg[i]);
>> + ? ? ? ? ? ? ? ? ? ? ? printk(KERN_DEBUG "%s ", err_msg[i]);
>
> ? ... unlike printk(KERN_DEBUG...). You probably want to use pr_debug()
> instead.
>
>> ? ? ? ?}
>> - ? ? ? printk("\n");
>> + ? ? ? printk(KERN_DEBUG "\n");
>
> ? Here too... Although wait, it should be KERN_CONT instead! Debug levels
> are only attributed to the whole lines.

But your observation is correct. I'll resend it with KERN_CONT instead.

Regards,

David

>
> WBR, Sergei
>
