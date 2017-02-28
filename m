From: eric.auger@redhat.com (Auger Eric)
Date: Tue, 28 Feb 2017 15:51:41 +0100
Subject: [RFC v2 18/19] KVM: arm64: ITS: Device table save/restore
In-Reply-To: <1486554212-2774-19-git-send-email-eric.auger@redhat.com>
References: <1486554212-2774-1-git-send-email-eric.auger@redhat.com>
 <1486554212-2774-19-git-send-email-eric.auger@redhat.com>
Message-ID: <fa2d17ac-9934-8a2d-c573-11d4e0c8f2f4@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
On 08/02/2017 12:43, Eric Auger wrote:
> This patch flushes the device table entries into guest RAM.
> Both flat table and 2 stage tables are supported.  DeviceId
> indexing is used.
> 
> For each device listed in the device table, we also flush
> the translation table using the vgic_its_flush/restore_itt
> routines.
> 
> On restore, devices are re-allocated and their itte are
> re-built.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v1 -> v2:
> - use 8 byte format for DTE and ITE
> - support 2 stage format
> - remove kvm parameter
> - ITT flush/restore moved in a separate patch
> - use deviceid indexing
> ---
>  virt/kvm/arm/vgic/vgic-its.c | 145 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 143 insertions(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
> index be9e8ed..c1ae85b 100644
> --- a/virt/kvm/arm/vgic/vgic-its.c
> +++ b/virt/kvm/arm/vgic/vgic-its.c
> @@ -1814,6 +1814,7 @@ static int vgic_its_restore_ite(struct vgic_its *its, u32 event_id,
>  		return ret;
>  
>  	update_affinity_ite(kvm, ite);
> +	return 0;
>  }
>  
>  static int vgic_its_flush_itt(struct vgic_its *its, struct its_device *device)
> @@ -1848,12 +1849,137 @@ static int vgic_its_restore_itt(struct vgic_its *its,
>  }
>  
>  /**
> + * vgic_its_flush_dte - Flush a device table entry at a given GPA
> + *
> + * @its: ITS handle
> + * @dev: ITS device
> + * @ptr: GPA
> + */
> +static int vgic_its_flush_dte(struct vgic_its *its,
> +			      struct its_device *dev, gpa_t ptr)
> +{
> +	struct kvm *kvm = its->dev->kvm;
> +	u64 val, itt_addr_field;
> +	int ret;
> +	u32 next_offset;
> +
> +	itt_addr_field = dev->itt_addr >> 8;
> +	next_offset = compute_next_devid_offset(&its->device_list, dev);
> +	val = (((u64)next_offset << 45) | (itt_addr_field << 5) |
> +		(dev->nb_eventid_bits - 1));
> +	val = cpu_to_le64(val);
> +	ret = kvm_write_guest(kvm, ptr, &val, 8);
> +	return ret;
> +}
> +
> +/**
> + * vgic_its_restore_dte - restore a device table entry
> + *
> + * @its: its handle
> + * @id: device id the DTE corresponds to
> + * @ptr: kernel VA where the 8 byte DTE is located
> + * @opaque: unused
> + * @next: offset to the next valid device id
> + *
> + * Return: < 0 on error, 0 otherwise
> + */
> +static int vgic_its_restore_dte(struct vgic_its *its, u32 id,
> +				void *ptr, void *opaque, u32 *next)
> +{
> +	struct its_device *dev;
> +	gpa_t itt_addr;
> +	size_t size;
> +	u64 val, *p = (u64 *)ptr;
> +	int ret;
> +
> +	val = *p;
> +	val = le64_to_cpu(val);
> +
> +	size = val & GENMASK_ULL(4, 0);
> +	itt_addr = (val & GENMASK_ULL(48, 5)) >> 5;
I Just discovered a bug above. 48 should be replaced by 44. With my LPI
setup the restore phase was failing.

I will send a formal fix soon. Please apologize for the inconvenience.

Best Regards

Eric
> +	*next = 1;
> +
> +	if (!itt_addr)
> +		return 0;
> +
> +	/* dte entry is valid */
> +	*next = (val & GENMASK_ULL(63, 45)) >> 45;
> +
> +	ret = vgic_its_alloc_device(its, &dev, id,
> +				    itt_addr, size);
> +	if (ret)
> +		return ret;
> +	ret = vgic_its_restore_itt(its, dev);
> +
> +	return ret;
> +}
> +
> +/**
>   * vgic_its_flush_device_tables - flush the device table and all ITT
>   * into guest RAM
>   */
>  static int vgic_its_flush_device_tables(struct vgic_its *its)
>  {
> -	return -ENXIO;
> +	struct its_device *dev;
> +	u64 baser;
> +
> +	baser = its->baser_device_table;
> +
> +	list_for_each_entry(dev, &its->device_list, dev_list) {
> +		int ret;
> +		gpa_t eaddr;
> +
> +		if (!vgic_its_check_id(its, baser,
> +				       dev->device_id, &eaddr))
> +			return -EINVAL;
> +
> +		ret = vgic_its_flush_itt(its, dev);
> +		if (ret)
> +			return ret;
> +
> +		ret = vgic_its_flush_dte(its, dev, eaddr);
> +		if (ret)
> +			return ret;
> +		}
> +	return 0;
> +}
> +
> +/**
> + * handle_l1_entry - callback used for L1 entries (2 stage case)
> + *
> + * @its: its handle
> + * @id: id
> + * @addr: kernel VA
> + * @opaque: unused
> + * @next_offset: offset to the next L1 entry: 0 if the last element
> + * was found, 1 otherwise
> + */
> +static int handle_l1_entry(struct vgic_its *its, u32 id, void *addr,
> +			   void *opaque, u32 *next_offset)
> +{
> +	u64 *pe = addr;
> +	gpa_t gpa;
> +	int l2_start_id = id * (SZ_64K / 8);
> +	int ret;
> +
> +	*pe = le64_to_cpu(*pe);
> +	*next_offset = 1;
> +
> +	if (!(*pe & BIT_ULL(63)))
> +		return 0;
> +
> +	gpa = *pe & GENMASK_ULL(51, 16);
> +
> +	ret = lookup_table(its, gpa, SZ_64K, 8,
> +			    l2_start_id, vgic_its_restore_dte, NULL);
> +
> +	if (ret == 1) {
> +		/* last entry was found in this L2 table */
> +		*next_offset = 0;
> +		ret = 0;
> +	}
> +
> +	return ret;
>  }
>  
>  /**
> @@ -1862,7 +1988,22 @@ static int vgic_its_flush_device_tables(struct vgic_its *its)
>   */
>  static int vgic_its_restore_device_tables(struct vgic_its *its)
>  {
> -	return -ENXIO;
> +	u64 baser = its->baser_device_table;
> +	int l1_tbl_size = GITS_BASER_NR_PAGES(baser) * SZ_64K;
> +	int l1_esz = GITS_BASER_ENTRY_SIZE(baser);
> +	gpa_t l1_gpa;
> +
> +	l1_gpa = BASER_ADDRESS(baser);
> +	if (!l1_gpa)
> +		return 0;
> +
> +	if (!(baser & GITS_BASER_INDIRECT))
> +		return lookup_table(its, l1_gpa, l1_tbl_size, l1_esz,
> +				    0, vgic_its_restore_dte, NULL);
> +
> +	/* two stage table */
> +	return lookup_table(its, l1_gpa, l1_tbl_size, 8, 0,
> +			    handle_l1_entry, NULL);
>  }
>  
>  static int vgic_its_flush_cte(struct vgic_its *its,
> 
