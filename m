From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 7 Nov 2017 10:36:47 +0000
Subject: [PATCH 06/17] coresight: tmc: Make ETR SG table circular
In-Reply-To: <20171106190712.GA12148@xps15>
References: <20171019171553.24056-1-suzuki.poulose@arm.com>
 <20171019171553.24056-7-suzuki.poulose@arm.com>
 <20171106190712.GA12148@xps15>
Message-ID: <978c66da-1897-191d-7c2d-49b21c9c0a39@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/17 19:07, Mathieu Poirier wrote:
> On Thu, Oct 19, 2017 at 06:15:42PM +0100, Suzuki K Poulose wrote:

...

>> +/*
>> + * tmc_etr_sg_offset_to_table_index : Translate a given data @offset
>> + * to the index of the page table "entry". Data pointers always have
>> + * a fixed location, with ETR_SG_PTRS_PER_PAGE - 1 entries in an
>> + * ETR_SG_PAGE and 1 link entry per (ETR_SG_PTRS_PER_PAGE -1) entries.
>> + */
>> +static inline u32
>> +tmc_etr_sg_offset_to_table_index(u64 offset)
>> +{
>> +	u64 sgpage_idx = offset >> ETR_SG_PAGE_SHIFT;
>> +
>> +	return sgpage_idx + sgpage_idx / (ETR_SG_PTRS_PER_PAGE - 1);
>> +}
> 
> This function is the source of a bizarre linking error when compiling [14/17] on
> armv7 as pasted here:
> 
>    UPD     include/generated/compile.h
>    CC      init/version.o
>    AR      init/built-in.o
>    AR      built-in.o
>    LD      vmlinux.o
>    MODPOST vmlinux.o
> drivers/hwtracing/coresight/coresight-tmc-etr.o: In function
> `tmc_etr_sg_offset_to_table_index':
> /home/mpoirier/work/linaro/coresight/kernel-maint/drivers/hwtracing/coresight/coresight-tmc-etr.c:553:
> undefined reference to `__aeabi_uldivmod'
> /home/mpoirier/work/linaro/coresight/kernel-maint/drivers/hwtracing/coresight/coresight-tmc-etr.c:551:
> undefined reference to `__aeabi_uldivmod'
> /home/mpoirier/work/linaro/coresight/kernel-maint/drivers/hwtracing/coresight/coresight-tmc-etr.c:553:
> undefined reference to `__aeabi_uldivmod'
> drivers/hwtracing/coresight/coresight-tmc-etr.o: In function
> `tmc_etr_sg_table_rotate':
> /home/mpoirier/work/linaro/coresight/kernel-maint/drivers/hwtracing/coresight/coresight-tmc-etr.c:609:
> undefined reference to `__aeabi_uldivmod'
> 
> Please see if you can reproduce on your side.

Uh ! I had gcc-7, which didn't complain about it. But if switch to 4.9, it does.
It looks like division of 64bit entity on arm32 is triggering it. We don't need
this to be u64 above, as it is the page_idx and could simply switch to "unsigned long"
rather than explicitly using div64 helpers.

The following change fixes the issue for me. Please could you check if it solves the problem
for you ?


@@ -551,7 +553,7 @@ static void tmc_etr_sg_table_populate(struct etr_sg_table *etr_table)
  static inline u32
  tmc_etr_sg_offset_to_table_index(u64 offset)
  {
-       u64 sgpage_idx = offset >> ETR_SG_PAGE_SHIFT;
+       unsigned long sgpage_idx = offset >> ETR_SG_PAGE_SHIFT;
  
         return sgpage_idx + sgpage_idx / (ETR_SG_PTRS_PER_PAGE - 1);
  }



Thanks for the testing !

Suzuki
