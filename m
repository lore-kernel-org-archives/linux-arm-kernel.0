From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 12 Jul 2017 16:14:21 -0700
Subject: [PATCH 1/2] remoteproc: Add remote processor coredump support
In-Reply-To: <1497463616-19868-1-git-send-email-spjoshi@codeaurora.org>
References: <1497463616-19868-1-git-send-email-spjoshi@codeaurora.org>
Message-ID: <20170712231421.GH20973@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 14 Jun 11:06 PDT 2017, Sarangdhar Joshi wrote:

> The remoteproc framework shuts down and immediately restarts the
> remote processor after fatal events (such as when remote crashes)
> during the recovery path. This makes it lose the state of the
> remote firmware at the point of failure, making it harder to debug
> such events.
> 
> This patch introduces a mechanism for extracting the memory
> contents(where the firmware was loaded) after the remote has stopped
> and before the restart sequence has begun in the recovery path. The
> remoteproc framework stores the dump segments information and uses
> devcoredump interface to read the memory contents for each of the
> segments.
> 
> The devcoredump device provides a sysfs interface
> /sys/class/remoteproc/remoteproc*/devcoredump/data that could be used
> to read this memory contents. This device will be removed either by
> writing to the data node or after a timeout of 5 minutes as defined in
> the devcoredump.c. This feature could be disabled by writing 1 to the
> disabled file under /sys/class/devcoredump/.
> 
> Signed-off-by: Sarangdhar Joshi <spjoshi@codeaurora.org>
> ---
>  drivers/remoteproc/qcom_common.c         |  42 ++++++++
>  drivers/remoteproc/qcom_common.h         |   2 +
>  drivers/remoteproc/remoteproc_core.c     | 168 +++++++++++++++++++++++++++++++
>  drivers/remoteproc/remoteproc_internal.h |  11 ++
>  drivers/soc/qcom/mdt_loader.c            |   3 +-
>  include/linux/remoteproc.h               |  21 ++++
>  include/linux/soc/qcom/mdt_loader.h      |   1 +
>  7 files changed, 247 insertions(+), 1 deletion(-)

I believe the REMOTEPROC core needs to "select WANT_DEV_COREDUMP" as
well.


Also, I think it's better if you introduce the core parts in one patch
and then follow up with a (small) patch adding the Qualcomm parts.

> 
> diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
> index bb90481..c68368a 100644
> --- a/drivers/remoteproc/qcom_common.c
> +++ b/drivers/remoteproc/qcom_common.c
> @@ -20,6 +20,7 @@
>  #include <linux/module.h>
>  #include <linux/remoteproc.h>
>  #include <linux/rpmsg/qcom_smd.h>
> +#include <linux/soc/qcom/mdt_loader.h>
>  
>  #include "remoteproc_internal.h"
>  #include "qcom_common.h"
> @@ -45,6 +46,47 @@ struct resource_table *qcom_mdt_find_rsc_table(struct rproc *rproc,
>  }
>  EXPORT_SYMBOL_GPL(qcom_mdt_find_rsc_table);
>  
> +/**
> + * qcom_register_dump_segments() - register segments with remoteproc
> + * framework for coredump collection
> + *
> + * @rproc:	remoteproc handle
> + * @fw:		firmware header
> + *
> + * returns 0 on success, negative error code otherwise.
> + */
> +int qcom_register_dump_segments(struct rproc *rproc,
> +				const struct firmware *fw)
> +{
> +	struct rproc_dump_segment *segment;
> +	const struct elf32_phdr *phdrs;
> +	const struct elf32_phdr *phdr;
> +	const struct elf32_hdr *ehdr;
> +	int i;
> +
> +	ehdr = (struct elf32_hdr *)fw->data;
> +	phdrs = (struct elf32_phdr *)(ehdr + 1);
> +
> +	for (i = 0; i < ehdr->e_phnum; i++) {
> +		phdr = &phdrs[i];
> +
> +		if (!mdt_phdr_valid(phdr))
> +			continue;
> +
> +		segment = kzalloc(sizeof(*segment), GFP_KERNEL);
> +		if (!segment)
> +			return -ENOMEM;
> +
> +		segment->da = phdr->p_paddr;
> +		segment->size = phdr->p_memsz;
> +
> +		list_add_tail(&segment->node, &rproc->dump_segments);

I would prefer that the memory and list management is kept in the core,
so please move this into a helper function like:

int rproc_coredump_add_segment(struct rproc *rproc, phys_addr_t da, size_t size);

> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(qcom_register_dump_segments);
> +
>  static int smd_subdev_probe(struct rproc_subdev *subdev)
>  {
>  	struct qcom_rproc_subdev *smd = to_smd_subdev(subdev);
> diff --git a/drivers/remoteproc/qcom_common.h b/drivers/remoteproc/qcom_common.h
> index db5c826..f658da9 100644
> --- a/drivers/remoteproc/qcom_common.h
> +++ b/drivers/remoteproc/qcom_common.h
> @@ -16,6 +16,8 @@ struct resource_table *qcom_mdt_find_rsc_table(struct rproc *rproc,
>  					       const struct firmware *fw,
>  					       int *tablesz);
>  
> +int qcom_register_dump_segments(struct rproc *rproc, const struct firmware *fw);
> +
>  void qcom_add_smd_subdev(struct rproc *rproc, struct qcom_rproc_subdev *smd);
>  void qcom_remove_smd_subdev(struct rproc *rproc, struct qcom_rproc_subdev *smd);
>  
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 369ba0f..23bf452 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -33,6 +33,7 @@
>  #include <linux/firmware.h>
>  #include <linux/string.h>
>  #include <linux/debugfs.h>
> +#include <linux/devcoredump.h>
>  #include <linux/remoteproc.h>
>  #include <linux/iommu.h>
>  #include <linux/idr.h>
> @@ -93,6 +94,21 @@ static int rproc_iommu_fault(struct iommu_domain *domain, struct device *dev,
>  	return -ENOSYS;
>  }
>  
> +/**
> + * rproc_unregister_segments() - clean up the segment entries from
> + * dump_segments list

"clean up dump_segments list" captures the content and keeps you on a
single line.

> + * @rproc: the remote processor handle
> + */
> +static void rproc_unregister_segments(struct rproc *rproc)
> +{
> +	struct rproc_dump_segment *entry, *tmp;
> +
> +	list_for_each_entry_safe(entry, tmp, &rproc->dump_segments, node) {
> +		list_del(&entry->node);
> +		kfree(entry);
> +	}
> +}
> +
>  static int rproc_enable_iommu(struct rproc *rproc)
>  {
>  	struct iommu_domain *domain;
> @@ -867,6 +883,12 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>  		return ret;
>  	}
>  
> +	ret = rproc_register_segments(rproc, fw);
> +	if (ret) {
> +		dev_err(dev, "Failed to register coredump segments: %d\n", ret);
> +		return ret;
> +	}
> +

I think the natural place for registering segments is the ELF parser (or
whatever other load function one might have), so I don't think we need
to introduce another op for this.

>  	/*
>  	 * The starting device has been given the rproc->cached_table as the
>  	 * resource table. The address of the vring along with the other
> @@ -975,6 +997,7 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>  	rproc->cached_table = NULL;
>  	rproc->table_ptr = NULL;
>  
> +	rproc_unregister_segments(rproc);
>  	rproc_disable_iommu(rproc);
>  	return ret;
>  }
> @@ -1039,6 +1062,139 @@ static int rproc_stop(struct rproc *rproc)
>  	return 0;
>  }
>  
> +static ssize_t rproc_coredump_dump(char *buffer, loff_t offset, size_t count,
> +				   void *data, size_t datalen)
> +{
> +	struct rproc *rproc = (struct rproc *)data;
> +	struct rproc_dump_segment *segment;
> +	char *header = rproc->dump_header;
> +	bool out_of_range = true;
> +	size_t adj_offset;
> +	void *ptr;
> +
> +	if (!count)
> +		return 0;
> +

As you calculate the offset for the ELF header I suggest that you store
the file offset back into the segment entries, as you can easily compare
the requested offset with this number (called segment->offset below).

In addition to this I prefer if you do something like this, rather than
only taking a single segment each pass:

size_t written = 0;

if (offset < rproc->dump_header_size) {
	len = min_t(count, rproc->dump_header_size - offset);

	memcpy(buffer + written, rproc->dump_header + offset, len);

	offset += len;
	written += len;
	count -= len;
}

list_for_each_entry(segment, &rproc->dump_segments, node) {
	if (!count || offset > segment->offset)
		break;

	if (offset < segment->offset) {
		offset += segment->size;
		continue;
	}
	
	ptr = rproc_da_to_va(rproc, segment->da, segment->size);
	if (!ptr) {
		dev_err(&rproc->dev, "segment addr outside memory range\n");
		return -EINVAL;
	}

	seg_offset = offset - segment->offset;
	len = min_t(count, segment->size - seg_offset);

	memcpy(buffer + written, ptr + seg_offset, len);

	offset += len;
	written += len;
	count -= len;
}

return written;

> +	if (offset < rproc->dump_header_size) {
> +		if (count > rproc->dump_header_size - offset)
> +			count = rproc->dump_header_size - offset;
> +
> +		memcpy(buffer, header + offset, count);
> +		return count;
> +	}
> +
> +	adj_offset = offset - rproc->dump_header_size;
> +
> +	list_for_each_entry(segment, &rproc->dump_segments, node) {
> +		if (adj_offset < segment->size) {
> +			out_of_range = false;
> +			break;
> +		}
> +		adj_offset -= segment->size;
> +	}
> +
> +	/* check whether it's the end of the list */
> +	if (out_of_range) {
> +		dev_info(&rproc->dev, "read offset out of range\n");
> +		return 0;
> +	}
> +
> +	if (count > (segment->size - adj_offset))
> +		count = segment->size - adj_offset;
> +
> +	ptr = rproc_da_to_va(rproc, segment->da, segment->size);
> +	if (!ptr) {
> +		dev_err(&rproc->dev, "segment addr outside memory range\n");
> +		return -EINVAL;
> +	}
> +
> +	memcpy(buffer, ptr + adj_offset, count);
> +	return count;
> +}
> +
> +/**
> + * rproc_coredump_free() - complete the dump_complete completion
> + * @data:	rproc handle
> + *
> + * This callback will be called when there occurs a write to the
> + * data node on devcoredump or after the devcoredump timeout.
> + */
> +static void rproc_coredump_free(void *data)
> +{
> +	struct rproc *rproc = (struct rproc *)data;
> +
> +	complete_all(&rproc->dump_complete);
> +
> +	/*
> +	 *  We do not need to free the dump_header data here.
> +	 *  We already do it after completing dump_complete
> +	 */

You can omit this comment.

> +}
> +
> +/**
> + * rproc_coredump_add_header() - add the coredump header information

Looks like this once was separate from the actual caller of
dev_coredumpm(), but now this would better be called just
"rproc_coredump() - perform coredump"

> + * @rproc:	rproc handle
> + *
> + * Returns 0 on success, negative errno otherwise.
> + *
> + * This function creates a devcoredump device associated with rproc
> + * and registers the read() and free() callbacks with this device.

This function will generate an ELF header for the registered segments
and create a devcoredump device associated with rproc.

> + */
> +static int rproc_coredump_add_header(struct rproc *rproc)
> +{
> +	struct rproc_dump_segment *entry;
> +	struct elf32_phdr *phdr;
> +	struct elf32_hdr *ehdr;
> +	int nsegments = 0;
> +	size_t offset;
> +
> +	list_for_each_entry(entry, &rproc->dump_segments, node)
> +		nsegments++;
> +
> +	rproc->dump_header_size = sizeof(*ehdr) + sizeof(*phdr) * nsegments;
> +	ehdr = kzalloc(rproc->dump_header_size, GFP_KERNEL);
> +	rproc->dump_header = (char *)ehdr;

dump_header is void *, so casting to char * here is wrong. I would
suggest assigning ehdr = rproc->dump_header after the check.

> +	if (!rproc->dump_header)
> +		return -ENOMEM;
> +
> +	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
> +	ehdr->e_ident[EI_CLASS] = ELFCLASS32;
> +	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
> +	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
> +	ehdr->e_ident[EI_OSABI] = ELFOSABI_NONE;
> +	ehdr->e_type = ET_CORE;

Just for the record, I think some of these needs to be configurable by
the remoteproc drivers; but would prefer to take that in an incremental
patch anyways.

> +	ehdr->e_version = EV_CURRENT;
> +	ehdr->e_phoff = sizeof(*ehdr);
> +	ehdr->e_ehsize = sizeof(*ehdr);
> +	ehdr->e_phentsize = sizeof(*phdr);
> +	ehdr->e_phnum = nsegments;
> +
> +	offset = rproc->dump_header_size;
> +	phdr = (struct elf32_phdr *)(ehdr + 1);
> +	list_for_each_entry(entry, &rproc->dump_segments, node) {
> +		phdr->p_type = PT_LOAD;
> +		phdr->p_offset = offset;

entry->offset = offset;

This ensures that rather than expecting the math to give us the same
offset in the read function we will compare with this very value.

> +		phdr->p_vaddr = phdr->p_paddr = entry->da;
> +		phdr->p_filesz = phdr->p_memsz = entry->size;
> +		phdr->p_flags = PF_R | PF_W | PF_X;
> +		phdr->p_align = 0;
> +		offset += phdr->p_filesz;
> +		phdr++;
> +	}
> +
> +	dev_coredumpm(&rproc->dev, NULL, (void *)rproc, rproc->dump_header_size,

"owner" should be THIS_MODULE, not NULL.

Do you need to type cast rproc here?

> +		      GFP_KERNEL, rproc_coredump_dump, rproc_coredump_free);
> +
> +	wait_for_completion_interruptible(&rproc->dump_complete);
> +
> +	/* clean up the resources */
> +	kfree(rproc->dump_header);
> +	rproc->dump_header = NULL;
> +	rproc_unregister_segments(rproc);
> +
> +	return 0;
> +}
> +
>  /**
>   * rproc_trigger_recovery() - recover a remoteproc
>   * @rproc: the remote processor
> @@ -1057,6 +1213,7 @@ int rproc_trigger_recovery(struct rproc *rproc)
>  
>  	dev_err(dev, "recovering %s\n", rproc->name);
>  
> +	init_completion(&rproc->dump_complete);
>  	init_completion(&rproc->crash_comp);
>  
>  	ret = mutex_lock_interruptible(&rproc->lock);
> @@ -1070,6 +1227,13 @@ int rproc_trigger_recovery(struct rproc *rproc)
>  	/* wait until there is no more rproc users */
>  	wait_for_completion(&rproc->crash_comp);
>  
> +	/* set up the coredump */
> +	ret = rproc_coredump_add_header(rproc);
> +	if (ret) {
> +		dev_err(dev, "setting up the coredump failed: %d\n", ret);
> +		goto unlock_mutex;
> +	}
> +
>  	/* load firmware */
>  	ret = request_firmware(&firmware_p, rproc->firmware, dev);
>  	if (ret < 0) {
> @@ -1234,6 +1398,8 @@ void rproc_shutdown(struct rproc *rproc)
>  	/* clean up all acquired resources */
>  	rproc_resource_cleanup(rproc);
>  
> +	rproc_unregister_segments(rproc);
> +
>  	rproc_disable_iommu(rproc);
>  
>  	/* Free the copy of the resource table */
> @@ -1465,8 +1631,10 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  	INIT_LIST_HEAD(&rproc->traces);
>  	INIT_LIST_HEAD(&rproc->rvdevs);
>  	INIT_LIST_HEAD(&rproc->subdevs);
> +	INIT_LIST_HEAD(&rproc->dump_segments);
>  
>  	INIT_WORK(&rproc->crash_handler, rproc_crash_handler_work);
> +	init_completion(&rproc->dump_complete);
>  	init_completion(&rproc->crash_comp);
>  
>  	rproc->state = RPROC_OFFLINE;
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index 1e9e5b3..273b111 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -43,6 +43,8 @@ struct rproc_fw_ops {
>  	int (*load)(struct rproc *rproc, const struct firmware *fw);
>  	int (*sanity_check)(struct rproc *rproc, const struct firmware *fw);
>  	u32 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
> +	int (*register_segments)(struct rproc *rproc,
> +				 const struct firmware *fw);
>  };
>  
>  /* from remoteproc_core.c */
> @@ -94,6 +96,15 @@ u32 rproc_get_boot_addr(struct rproc *rproc, const struct firmware *fw)
>  }
>  
>  static inline
> +int rproc_register_segments(struct rproc *rproc, const struct firmware *fw)
> +{
> +	if (rproc->fw_ops->register_segments)
> +		return rproc->fw_ops->register_segments(rproc, fw);
> +
> +	return 0;
> +}
> +
> +static inline
>  int rproc_load_segments(struct rproc *rproc, const struct firmware *fw)
>  {
>  	if (rproc->fw_ops->load)
> diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> index b4a30fc..bd227bb 100644
> --- a/drivers/soc/qcom/mdt_loader.c
> +++ b/drivers/soc/qcom/mdt_loader.c
> @@ -25,7 +25,7 @@
>  #include <linux/slab.h>
>  #include <linux/soc/qcom/mdt_loader.h>
>  
> -static bool mdt_phdr_valid(const struct elf32_phdr *phdr)
> +bool mdt_phdr_valid(const struct elf32_phdr *phdr)
>  {
>  	if (phdr->p_type != PT_LOAD)
>  		return false;
> @@ -38,6 +38,7 @@ static bool mdt_phdr_valid(const struct elf32_phdr *phdr)
>  
>  	return true;
>  }
> +EXPORT_SYMBOL_GPL(mdt_phdr_valid);
>  
>  /**
>   * qcom_mdt_get_size() - acquire size of the memory region needed to load mdt
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 81da495..73c2f69 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -382,6 +382,19 @@ enum rproc_crash_type {
>  };
>  
>  /**
> + * struct rproc_dump_segment - segment info from ELF header
> + * @node: list node related to the rproc segment list
> + * @da	: address of the segment from the header

Don't indent the ':'

> + * @size: size of the segment from the header
> + */
> +struct rproc_dump_segment {
> +	struct list_head node;
> +
> +	phys_addr_t da;
> +	phys_addr_t size;

"size" should be size_t

> +};
> +
> +/**
>   * struct rproc - represents a physical remote processor device
>   * @node: list node of this rproc object
>   * @domain: iommu domain
> @@ -412,6 +425,10 @@ enum rproc_crash_type {
>   * @table_ptr: pointer to the resource table in effect
>   * @cached_table: copy of the resource table
>   * @has_iommu: flag to indicate if remote processor is behind an MMU
> + * @dump_segments: list of segments in the firmware
> + * @dump_header: memory location that points to the header information

This is not "header information", it is the header. So I would suggest
changing this to "temporary reference to coredump header".

> + * @dump_header_size: size of the allocated memory for header
> + * @dump_complete: completion to track memory dump of segments
>   */
>  struct rproc {
>  	struct list_head node;
> @@ -444,6 +461,10 @@ struct rproc {
>  	struct resource_table *cached_table;
>  	bool has_iommu;
>  	bool auto_boot;
> +	struct list_head dump_segments;
> +	void *dump_header;
> +	size_t dump_header_size;
> +	struct completion dump_complete;
>  };
>  

Regards,
Bjorn
