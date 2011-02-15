From: dacohen@gmail.com (David Cohen)
Date: Tue, 15 Feb 2011 16:36:26 +0200
Subject: [PATCH 1/2] OMAP2+: IOMMU: change OMAP2+ error message to
	dev_dbg()
In-Reply-To: <20110215142923.GC11199@n2100.arm.linux.org.uk>
References: <1297776033-8579-1-git-send-email-dacohen@gmail.com>
	<1297776033-8579-2-git-send-email-dacohen@gmail.com>
	<4D5A81D8.2080800@ru.mvista.com>
	<20110215142923.GC11199@n2100.arm.linux.org.uk>
Message-ID: <AANLkTin++DGAGT9-nahy1Qm7ASbGm=JjNuPZWZ6XUbcX@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 4:29 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Feb 15, 2011 at 04:38:32PM +0300, Sergei Shtylyov wrote:
>>> diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
>>> index 14ee686..4244a07 100644
>>> --- a/arch/arm/mach-omap2/iommu2.c
>>> +++ b/arch/arm/mach-omap2/iommu2.c
>>> @@ -163,13 +163,13 @@ static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
>>> ? ? ?da = iommu_read_reg(obj, MMU_FAULT_AD);
>>> ? ? ?*ra = da;
>>>
>>> - ? ?dev_err(obj->dev, "%s:\tda:%08x ", __func__, da);
>>> + ? ?dev_dbg(obj->dev, "%s:\tda:%08x ", __func__, da);
>>
>> ? ?Note that dev_dbg() will only print something if either DEBUG or
>> CONFIG_DYNAMIC_DEBUG are defined...
>>
>>>
>>> ? ? ?for (i = 0; i< ?ARRAY_SIZE(err_msg); i++) {
>>> ? ? ? ? ? ? ?if (stat & (1<< ?i))
>>> - ? ? ? ? ? ? ? ? ? ?printk("%s ", err_msg[i]);
>>> + ? ? ? ? ? ? ? ? ? ?printk(KERN_DEBUG "%s ", err_msg[i]);
>>
>> ? ?... unlike printk(KERN_DEBUG...). You probably want to use pr_debug() instead.
>
> No - this isn't starting a new line. ?pr_cont() here.

But pr_cont() would be wrong in case of DEBUG isn't set, isn't it?

>
>>> ? ? ?}
>>> - ? ?printk("\n");
>>> + ? ?printk(KERN_DEBUG "\n");
>>
>> ? ?Here too... Although wait, it should be KERN_CONT instead! Debug
>> levels are only attributed to the whole lines.
>
> And pr_cont() here too. ?If you care about using KERN_CONT which is
> just a static marker to allow automated printk level checking easier.

The same situation here.

But this patch was dropped in the next version.

Br,

David

>
