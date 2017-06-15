From: spjoshi@codeaurora.org (Sarangdhar Joshi)
Date: Thu, 15 Jun 2017 16:11:54 -0700
Subject: [PATCH 1/2] remoteproc: Add remote processor coredump support
In-Reply-To: <0c2fe4e0-2aee-fcf4-0a49-5651241e1f9e@ti.com>
References: <1497463616-19868-1-git-send-email-spjoshi@codeaurora.org>
 <0c2fe4e0-2aee-fcf4-0a49-5651241e1f9e@ti.com>
Message-ID: <6d3c396a-31c9-6c58-0940-767997d03595@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/15/2017 11:48 AM, Suman Anna wrote:
> Hi Sarangdhar,

Hi Suman,

Thanks for reviewing the patch.

> 
> On 06/14/2017 01:06 PM, Sarangdhar Joshi wrote:
>> The remoteproc framework shuts down and immediately restarts the
>> remote processor after fatal events (such as when remote crashes)
>> during the recovery path. 
> 
> This is the case in production systems, but your statement is not 
> entirely accurate. Have you looked at the remoteproc debugfs 'recovery' 
> variable? You can actually halt the recovery and can do some debugging 
> analysis at the point of failure.

Glad you pointed this out. I wasn't aware of this 'recovery' debug 
feature. However it looks like that feature would be good only for live 
debugging. Whereas, the coredump support that this patch adds, would 
also be useful for offline debugging / analysis.

> 
>  > This makes it lose the state of the
>> remote firmware at the point of failure, making it harder to debug
>> such events.
>>
>> This patch introduces a mechanism for extracting the memory
>> contents(where the firmware was loaded) after the remote has stopped
>> and before the restart sequence has begun in the recovery path. The
>> remoteproc framework stores the dump segments information and uses
>> devcoredump interface to read the memory contents for each of the
>> segments.
>>
>> The devcoredump device provides a sysfs interface
>> /sys/class/remoteproc/remoteproc*/devcoredump/data that could be used
>> to read this memory contents. This device will be removed either by
>> writing to the data node or after a timeout of 5 minutes as defined in
>> the devcoredump.c. This feature could be disabled by writing 1 to the
>> disabled file under /sys/class/devcoredump/.
> 
> Nice concept using the devcoredump, but need some changes to be generic. 
> Please see below based on my quick review.

Thanks, will try to make the change as generic as possible.

> 
>>
>> Signed-off-by: Sarangdhar Joshi <spjoshi@codeaurora.org>
>> ---
>>   drivers/remoteproc/qcom_common.c         |  42 ++++++++
>>   drivers/remoteproc/qcom_common.h         |   2 +
>>   drivers/remoteproc/remoteproc_core.c     | 168 
>> +++++++++++++++++++++++++++++++
>>   drivers/remoteproc/remoteproc_internal.h |  11 ++
>>   drivers/soc/qcom/mdt_loader.c            |   3 +-
>>   include/linux/remoteproc.h               |  21 ++++
>>   include/linux/soc/qcom/mdt_loader.h      |   1 +
> 
> Please add a cover-letter and summarize your changes when submitting 
> multiple patches. Also, split this patch to add the framework to 
> remoteproc core first and then adding the support to your platform 
> driver in separate patch(es).

Sure, will do that. I did enable this support for our platform in a 
separate patch (2/2), however, missed some common functions to move to 
separate patch(es).

> 
>>   7 files changed, 247 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/remoteproc/qcom_common.c 
>> b/drivers/remoteproc/qcom_common.c
>> index bb90481..c68368a 100644
>> --- a/drivers/remoteproc/qcom_common.c
>> +++ b/drivers/remoteproc/qcom_common.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/module.h>
>>   #include <linux/remoteproc.h>
>>   #include <linux/rpmsg/qcom_smd.h>
>> +#include <linux/soc/qcom/mdt_loader.h>
>>   #include "remoteproc_internal.h"
>>   #include "qcom_common.h"
>> @@ -45,6 +46,47 @@ struct resource_table 
>> *qcom_mdt_find_rsc_table(struct rproc *rproc,
>>   }
>>   EXPORT_SYMBOL_GPL(qcom_mdt_find_rsc_table);
>> +/**
>> + * qcom_register_dump_segments() - register segments with remoteproc
>> + * framework for coredump collection
>> + *
>> + * @rproc:    remoteproc handle
>> + * @fw:        firmware header
>> + *
>> + * returns 0 on success, negative error code otherwise.
>> + */
>> +int qcom_register_dump_segments(struct rproc *rproc,
>> +                const struct firmware *fw)
>> +{
>> +    struct rproc_dump_segment *segment;
>> +    const struct elf32_phdr *phdrs;
>> +    const struct elf32_phdr *phdr;
>> +    const struct elf32_hdr *ehdr;
>> +    int i;
>> +
>> +    ehdr = (struct elf32_hdr *)fw->data;
>> +    phdrs = (struct elf32_phdr *)(ehdr + 1);
>> +
>> +    for (i = 0; i < ehdr->e_phnum; i++) {
>> +        phdr = &phdrs[i];
>> +
>> +        if (!mdt_phdr_valid(phdr))
>> +            continue;
>> +
>> +        segment = kzalloc(sizeof(*segment), GFP_KERNEL);
>> +        if (!segment)
>> +            return -ENOMEM;
>> +
>> +        segment->da = phdr->p_paddr;
>> +        segment->size = phdr->p_memsz;
>> +
>> +        list_add_tail(&segment->node, &rproc->dump_segments);
>> +    }
>> +
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(qcom_register_dump_segments);
>> +
>>   static int smd_subdev_probe(struct rproc_subdev *subdev)
>>   {
>>       struct qcom_rproc_subdev *smd = to_smd_subdev(subdev);
>> diff --git a/drivers/remoteproc/qcom_common.h 
>> b/drivers/remoteproc/qcom_common.h
>> index db5c826..f658da9 100644
>> --- a/drivers/remoteproc/qcom_common.h
>> +++ b/drivers/remoteproc/qcom_common.h
>> @@ -16,6 +16,8 @@ struct resource_table 
>> *qcom_mdt_find_rsc_table(struct rproc *rproc,
>>                              const struct firmware *fw,
>>                              int *tablesz);
>> +int qcom_register_dump_segments(struct rproc *rproc, const struct 
>> firmware *fw);
>> +
>>   void qcom_add_smd_subdev(struct rproc *rproc, struct 
>> qcom_rproc_subdev *smd);
>>   void qcom_remove_smd_subdev(struct rproc *rproc, struct 
>> qcom_rproc_subdev *smd);
>> diff --git a/drivers/remoteproc/remoteproc_core.c 
>> b/drivers/remoteproc/remoteproc_core.c
>> index 369ba0f..23bf452 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -33,6 +33,7 @@
>>   #include <linux/firmware.h>
>>   #include <linux/string.h>
>>   #include <linux/debugfs.h>
>> +#include <linux/devcoredump.h>
>>   #include <linux/remoteproc.h>
>>   #include <linux/iommu.h>
>>   #include <linux/idr.h>
>> @@ -93,6 +94,21 @@ static int rproc_iommu_fault(struct iommu_domain 
>> *domain, struct device *dev,
>>       return -ENOSYS;
>>   }
>> +/**
>> + * rproc_unregister_segments() - clean up the segment entries from
>> + * dump_segments list
>> + * @rproc: the remote processor handle
>> + */
>> +static void rproc_unregister_segments(struct rproc *rproc)
>> +{
>> +    struct rproc_dump_segment *entry, *tmp;
>> +
>> +    list_for_each_entry_safe(entry, tmp, &rproc->dump_segments, node) {
>> +        list_del(&entry->node);
>> +        kfree(entry);
>> +    }
>> +}
>> +
>>   static int rproc_enable_iommu(struct rproc *rproc)
>>   {
>>       struct iommu_domain *domain;
>> @@ -867,6 +883,12 @@ static int rproc_start(struct rproc *rproc, const 
>> struct firmware *fw)
>>           return ret;
>>       }
>> +    ret = rproc_register_segments(rproc, fw);
>> +    if (ret) {
>> +        dev_err(dev, "Failed to register coredump segments: %d\n", ret);
>> +        return ret;
>> +    }
>> +
>>       /*
>>        * The starting device has been given the rproc->cached_table as 
>> the
>>        * resource table. The address of the vring along with the other
>> @@ -975,6 +997,7 @@ static int rproc_fw_boot(struct rproc *rproc, 
>> const struct firmware *fw)
>>       rproc->cached_table = NULL;
>>       rproc->table_ptr = NULL;
>> +    rproc_unregister_segments(rproc);
>>       rproc_disable_iommu(rproc);
>>       return ret;
>>   }
>> @@ -1039,6 +1062,139 @@ static int rproc_stop(struct rproc *rproc)
>>       return 0;
>>   }
>> +static ssize_t rproc_coredump_dump(char *buffer, loff_t offset, 
>> size_t count,
>> +                   void *data, size_t datalen)
>> +{
>> +    struct rproc *rproc = (struct rproc *)data;
>> +    struct rproc_dump_segment *segment;
>> +    char *header = rproc->dump_header;
>> +    bool out_of_range = true;
>> +    size_t adj_offset;
>> +    void *ptr;
>> +
>> +    if (!count)
>> +        return 0;
>> +
>> +    if (offset < rproc->dump_header_size) {
>> +        if (count > rproc->dump_header_size - offset)
>> +            count = rproc->dump_header_size - offset;
>> +
>> +        memcpy(buffer, header + offset, count);
>> +        return count;
>> +    }
>> +
>> +    adj_offset = offset - rproc->dump_header_size;
>> +
>> +    list_for_each_entry(segment, &rproc->dump_segments, node) {
>> +        if (adj_offset < segment->size) {
>> +            out_of_range = false;
>> +            break;
>> +        }
>> +        adj_offset -= segment->size;
>> +    }
>> +
>> +    /* check whether it's the end of the list */
>> +    if (out_of_range) {
>> +        dev_info(&rproc->dev, "read offset out of range\n");
>> +        return 0;
>> +    }
>> +
>> +    if (count > (segment->size - adj_offset))
>> +        count = segment->size - adj_offset;
>> +
>> +    ptr = rproc_da_to_va(rproc, segment->da, segment->size);
>> +    if (!ptr) {
>> +        dev_err(&rproc->dev, "segment addr outside memory range\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    memcpy(buffer, ptr + adj_offset, count);
>> +    return count;
>> +}
>> +
>> +/**
>> + * rproc_coredump_free() - complete the dump_complete completion
>> + * @data:    rproc handle
>> + *
>> + * This callback will be called when there occurs a write to the
>> + * data node on devcoredump or after the devcoredump timeout.
>> + */
>> +static void rproc_coredump_free(void *data)
>> +{
>> +    struct rproc *rproc = (struct rproc *)data;
>> +
>> +    complete_all(&rproc->dump_complete);
>> +
>> +    /*
>> +     *  We do not need to free the dump_header data here.
>> +     *  We already do it after completing dump_complete
>> +     */
>> +}
>> +
>> +/**
>> + * rproc_coredump_add_header() - add the coredump header information
>> + * @rproc:    rproc handle
>> + *
>> + * Returns 0 on success, negative errno otherwise.
>> + *
>> + * This function creates a devcoredump device associated with rproc
>> + * and registers the read() and free() callbacks with this device.
>> + */
>> +static int rproc_coredump_add_header(struct rproc *rproc)
>> +{
>> +    struct rproc_dump_segment *entry;
>> +    struct elf32_phdr *phdr;
>> +    struct elf32_hdr *ehdr;
>> +    int nsegments = 0;
>> +    size_t offset;
>> +
>> +    list_for_each_entry(entry, &rproc->dump_segments, node)
>> +        nsegments++;
>> +
>> +    rproc->dump_header_size = sizeof(*ehdr) + sizeof(*phdr) * nsegments;
>> +    ehdr = kzalloc(rproc->dump_header_size, GFP_KERNEL);
>> +    rproc->dump_header = (char *)ehdr;
>> +    if (!rproc->dump_header)
>> +        return -ENOMEM;
>> +
>> +    memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
>> +    ehdr->e_ident[EI_CLASS] = ELFCLASS32;
>> +    ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
>> +    ehdr->e_ident[EI_VERSION] = EV_CURRENT;
>> +    ehdr->e_ident[EI_OSABI] = ELFOSABI_NONE;
>> +    ehdr->e_type = ET_CORE;
>> +    ehdr->e_version = EV_CURRENT;
>> +    ehdr->e_phoff = sizeof(*ehdr);
>> +    ehdr->e_ehsize = sizeof(*ehdr);
>> +    ehdr->e_phentsize = sizeof(*phdr);
>> +    ehdr->e_phnum = nsegments;
>> +
>> +    offset = rproc->dump_header_size;
>> +    phdr = (struct elf32_phdr *)(ehdr + 1);
>> +    list_for_each_entry(entry, &rproc->dump_segments, node) {
>> +        phdr->p_type = PT_LOAD;
>> +        phdr->p_offset = offset;
>> +        phdr->p_vaddr = phdr->p_paddr = entry->da;
>> +        phdr->p_filesz = phdr->p_memsz = entry->size;
>> +        phdr->p_flags = PF_R | PF_W | PF_X;
>> +        phdr->p_align = 0;
>> +        offset += phdr->p_filesz;
>> +        phdr++;
>> +    }
>> +
>> +    dev_coredumpm(&rproc->dev, NULL, (void *)rproc, 
>> rproc->dump_header_size,
> 
> Why are you passing NULL for the owner?
> 
>> +              GFP_KERNEL, rproc_coredump_dump, rproc_coredump_free);
>> +
>> +    wait_for_completion_interruptible(&rproc->dump_complete);
> 
> Hmm, is this holding up the recovery? I see this is signaled only in 
> rproc_coredump_free()? You are doing this inline during the recovery or 
> am I missing something?

Yes, that's right. The free() callback will complete the dump_complete 
and then the rest of the recovery will proceed. This free() callback 
gets called either when user writes to the .../devcoredump/data node or 
devcoredump TIMEOUT (i.e. 5 mins) occurs. If CONFIG_DEV_COREDUMP is not 
enabled, then this function will bailout without halting.

> 
>> +
>> +    /* clean up the resources */
>> +    kfree(rproc->dump_header);
>> +    rproc->dump_header = NULL;
>> +    rproc_unregister_segments(rproc);
>> +
>> +    return 0;
>> +}
> 
> This is not generic, remoteproc core can support non-ELF images, and the 
> choice of fw_ops is left to individual platform drivers. The dump logic 
> is dependent on the particular format being used, and so whatever ELF 
> coredump support you are adding should be added through a fw_ops. You 
> can add a default one for regular ELFs, and platform drivers can always 
> customized based on thier own fw_ops.

That's a good point. I think something like below should work

struct rproc_fw_ops {
	...
	int (* rproc_coredump_add_header)(struct rproc);
}

> 
>> +
>>   /**
>>    * rproc_trigger_recovery() - recover a remoteproc
>>    * @rproc: the remote processor
>> @@ -1057,6 +1213,7 @@ int rproc_trigger_recovery(struct rproc *rproc)
>>       dev_err(dev, "recovering %s\n", rproc->name);
>> +    init_completion(&rproc->dump_complete);
>>       init_completion(&rproc->crash_comp);
>>       ret = mutex_lock_interruptible(&rproc->lock);
>> @@ -1070,6 +1227,13 @@ int rproc_trigger_recovery(struct rproc *rproc)
>>       /* wait until there is no more rproc users */
>>       wait_for_completion(&rproc->crash_comp);
>> +    /* set up the coredump */
>> +    ret = rproc_coredump_add_header(rproc);
>> +    if (ret) {
>> +        dev_err(dev, "setting up the coredump failed: %d\n", ret);
>> +        goto unlock_mutex;
>> +    }
>> +
>>       /* load firmware */
>>       ret = request_firmware(&firmware_p, rproc->firmware, dev);
>>       if (ret < 0) {
>> @@ -1234,6 +1398,8 @@ void rproc_shutdown(struct rproc *rproc)
>>       /* clean up all acquired resources */
>>       rproc_resource_cleanup(rproc);
>> +    rproc_unregister_segments(rproc);
>> +
>>       rproc_disable_iommu(rproc);
>>       /* Free the copy of the resource table */
>> @@ -1465,8 +1631,10 @@ struct rproc *rproc_alloc(struct device *dev, 
>> const char *name,
>>       INIT_LIST_HEAD(&rproc->traces);
>>       INIT_LIST_HEAD(&rproc->rvdevs);
>>       INIT_LIST_HEAD(&rproc->subdevs);
>> +    INIT_LIST_HEAD(&rproc->dump_segments);
>>       INIT_WORK(&rproc->crash_handler, rproc_crash_handler_work);
>> +    init_completion(&rproc->dump_complete);
>>       init_completion(&rproc->crash_comp);
>>       rproc->state = RPROC_OFFLINE;
>> diff --git a/drivers/remoteproc/remoteproc_internal.h 
>> b/drivers/remoteproc/remoteproc_internal.h
>> index 1e9e5b3..273b111 100644
>> --- a/drivers/remoteproc/remoteproc_internal.h
>> +++ b/drivers/remoteproc/remoteproc_internal.h
>> @@ -43,6 +43,8 @@ struct rproc_fw_ops {
>>       int (*load)(struct rproc *rproc, const struct firmware *fw);
>>       int (*sanity_check)(struct rproc *rproc, const struct firmware 
>> *fw);
>>       u32 (*get_boot_addr)(struct rproc *rproc, const struct firmware 
>> *fw);
>> +    int (*register_segments)(struct rproc *rproc,
>> +                 const struct firmware *fw);
>>   };
>>   /* from remoteproc_core.c */
>> @@ -94,6 +96,15 @@ u32 rproc_get_boot_addr(struct rproc *rproc, const 
>> struct firmware *fw)
>>   }
>>   static inline
>> +int rproc_register_segments(struct rproc *rproc, const struct 
>> firmware *fw)
>> +{
>> +    if (rproc->fw_ops->register_segments)
>> +        return rproc->fw_ops->register_segments(rproc, fw);
>> +
>> +    return 0;
>> +}
>> +
>> +static inline
>>   int rproc_load_segments(struct rproc *rproc, const struct firmware *fw)
>>   {
>>       if (rproc->fw_ops->load)
>> diff --git a/drivers/soc/qcom/mdt_loader.c 
>> b/drivers/soc/qcom/mdt_loader.c
>> index b4a30fc..bd227bb 100644
>> --- a/drivers/soc/qcom/mdt_loader.c
>> +++ b/drivers/soc/qcom/mdt_loader.c
>> @@ -25,7 +25,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/soc/qcom/mdt_loader.h>
>> -static bool mdt_phdr_valid(const struct elf32_phdr *phdr)
>> +bool mdt_phdr_valid(const struct elf32_phdr *phdr)
>>   {
>>       if (phdr->p_type != PT_LOAD)
>>           return false;
>> @@ -38,6 +38,7 @@ static bool mdt_phdr_valid(const struct elf32_phdr 
>> *phdr)
>>       return true;
>>   }
>> +EXPORT_SYMBOL_GPL(mdt_phdr_valid);
>>   /**
>>    * qcom_mdt_get_size() - acquire size of the memory region needed to 
>> load mdt
>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>> index 81da495..73c2f69 100644
>> --- a/include/linux/remoteproc.h
>> +++ b/include/linux/remoteproc.h
>> @@ -382,6 +382,19 @@ enum rproc_crash_type {
>>   };
>>   /**
>> + * struct rproc_dump_segment - segment info from ELF header
> 
> remoteproc core does have support for non-ELF firmwares as well.

Yes, will modify the comment.

Thanks,
Sarang

> 
>> + * @node: list node related to the rproc segment list
>> + * @da    : address of the segment from the header
> 
> additional whitepace/tab not required

Will do.

> 
>> + * @size: size of the segment from the header
>> + */
>> +struct rproc_dump_segment {
>> +    struct list_head node;
>> +
> 
> no need of the blank line.

will do.

> 
>> +    phys_addr_t da;
>> +    phys_addr_t size;
>> +};
>> +
>> +/**
>>    * struct rproc - represents a physical remote processor device
>>    * @node: list node of this rproc object
>>    * @domain: iommu domain
>> @@ -412,6 +425,10 @@ enum rproc_crash_type {
>>    * @table_ptr: pointer to the resource table in effect
>>    * @cached_table: copy of the resource table
>>    * @has_iommu: flag to indicate if remote processor is behind an MMU
>> + * @dump_segments: list of segments in the firmware
>> + * @dump_header: memory location that points to the header information
>> + * @dump_header_size: size of the allocated memory for header
>> + * @dump_complete: completion to track memory dump of segments
>>    */
>>   struct rproc {
>>       struct list_head node;
>> @@ -444,6 +461,10 @@ struct rproc {
>>       struct resource_table *cached_table;
>>       bool has_iommu;
>>       bool auto_boot;
>> +    struct list_head dump_segments;
>> +    void *dump_header;
>> +    size_t dump_header_size;
>> +    struct completion dump_complete;
>>   };
>>   /**
>> diff --git a/include/linux/soc/qcom/mdt_loader.h 
>> b/include/linux/soc/qcom/mdt_loader.h
>> index ea021b3..33ea322 100644
>> --- a/include/linux/soc/qcom/mdt_loader.h
>> +++ b/include/linux/soc/qcom/mdt_loader.h
>> @@ -10,6 +10,7 @@
>>   struct device;
>>   struct firmware;
>> +bool mdt_phdr_valid(const struct elf32_phdr *phdr);
>>   ssize_t qcom_mdt_get_size(const struct firmware *fw);
>>   int qcom_mdt_load(struct device *dev, const struct firmware *fw,
>>             const char *fw_name, int pas_id, void *mem_region,
>>
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
