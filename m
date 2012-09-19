From: omar.luna@linaro.org (Omar Ramirez Luna)
Date: Tue, 18 Sep 2012 19:53:34 -0500
Subject: [PATCH v2 7/9] ARM: OMAP: iommu: optimize save and restore
 routines
In-Reply-To: <20120918180430.GV11762@atomide.com>
References: <1347479152-588-1-git-send-email-omar.luna@linaro.org>
 <1347479152-588-8-git-send-email-omar.luna@linaro.org>
 <20120918180430.GV11762@atomide.com>
Message-ID: <CALLhW=6p1kJ4PpB-SBnj-mJ+b-e+pAo-ApZhp0edtkD+229FpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 18 September 2012 13:04, Tony Lindgren <tony@atomide.com> wrote:
> * Omar Ramirez Luna <omar.luna@linaro.org> [120912 12:47]:
>> --- a/arch/arm/plat-omap/include/plat/iommu.h
>> +++ b/arch/arm/plat-omap/include/plat/iommu.h
>> @@ -27,6 +27,13 @@ struct iotlb_entry {
>>       };
>>  };
>>
>> +/* context registers */
>> +struct iommu_regs {
>> +     u32 irqen;
>> +     u32 cntl;
>> +     u32 ttb;
>> +};
>> +
>>  struct omap_iommu {
>>       const char      *name;
>>       struct module   *owner;
>> @@ -50,7 +57,8 @@ struct omap_iommu {
>>       struct list_head        mmap;
>>       struct mutex            mmap_lock; /* protect mmap */
>>
>> -     void *ctx; /* iommu context: registres saved area */
>> +     struct iommu_regs context;
>> +     int ctx_loss_cnt;
>>       u32 da_start;
>>       u32 da_end;
>>  };
>> --- a/arch/arm/plat-omap/include/plat/iommu2.h
>> +++ b/arch/arm/plat-omap/include/plat/iommu2.h
>> @@ -35,8 +35,6 @@
>>  #define MMU_READ_RAM         0x6c
>>  #define MMU_EMU_FAULT_AD     0x70
>>
>> -#define MMU_REG_SIZE         256
>> -
>>  /*
>>   * MMU Register bit definitions
>>   */
>
> These headers should be moved to include/linux/platform_data/iommu-omap.h
> or something like that. Care to take care of that too?
>
> I guess there's no reason to have both iommu.h and iommuh2.h?

Agree, can this be made as part of a separate cleanup series? I was
hoping these could make it for 3.7 so we could have a usable rpmsg for
omap4.

Regards,

Omar
