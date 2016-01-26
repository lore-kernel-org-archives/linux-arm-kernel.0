From: eric.auger@linaro.org (Eric Auger)
Date: Tue, 26 Jan 2016 16:14:23 +0100
Subject: [PATCH 09/10] vfio-pci: create an iommu mapping for msi address
In-Reply-To: <201601262259.1kktHLzi%fengguang.wu@intel.com>
References: <201601262259.1kktHLzi%fengguang.wu@intel.com>
Message-ID: <56A78D4F.9020503@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On 01/26/2016 03:43 PM, kbuild test robot wrote:
> Hi Eric,
> 
> [auto build test WARNING on v4.5-rc1]
> [also build test WARNING on next-20160125]
> [cannot apply to iommu/next]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Eric-Auger/KVM-PCIe-MSI-passthrough-on-ARM-ARM64/20160126-211921
> config: i386-allmodconfig (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/vfio/pci/vfio_pci_intrs.c: In function 'vfio_set_mapped_msi_addr':
>>> drivers/vfio/pci/vfio_pci_intrs.c:324:43: warning: left shift count >= width of type [-Wshift-count-overflow]
>      msi_addr = (phys_addr_t)(msg.address_hi) << 32 |
>                                               ^
>>> drivers/vfio/pci/vfio_pci_intrs.c:333:34: warning: right shift count >= width of type [-Wshift-count-overflow]
>      msg.address_hi = (u32)(msi_iova >> 32);
I definitively need to revisit that code. I Better understand Alex'
comment now :-(

Thanks

Eric
>                                      ^
> 
> vim +324 drivers/vfio/pci/vfio_pci_intrs.c
> 
>    318		dma_addr_t msi_iova;
>    319		struct vfio_group *group = vdev->vfio_group;
>    320		struct msi_msg msg;
>    321		int ret;
>    322	
>    323		get_cached_msi_msg(irq, &msg);
>  > 324		msi_addr = (phys_addr_t)(msg.address_hi) << 32 |
>    325				(phys_addr_t)(msg.address_lo);
>    326	
>    327		ret = vfio_group_alloc_map_reserved_iova(group, msi_addr,
>    328							 IOMMU_WRITE, &msi_iova);
>    329		if (ret)
>    330			goto out;
>    331	
>    332		/* Re-program the msi-address with the iova */
>  > 333		msg.address_hi = (u32)(msi_iova >> 32);
>    334		msg.address_lo = (u32)(msi_iova & 0xffffffff);
>    335		pci_write_msi_msg(irq, &msg);
>    336	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
