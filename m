From: lkp@intel.com (kbuild test robot)
Date: Wed, 19 Sep 2018 06:24:17 +0800
Subject: [arm-platforms:kvm-arm64/nv-wip 107/116]
 arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c:143:7: error:
 'KVM_VGIC_V2_ADDR_TYPE_GICH' undeclared; did you mean
 'KVM_VGIC_V2_ADDR_TYPE_DIST'?
Message-ID: <201809190614.JRK0l4nJ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/nv-wip
head:   b7b336b71aac5dbb02b53a82e7032524ba292713
commit: a084eec529c389c3599c3fc0a2e0b296d81bca49 [107/116] KVM: arm/arm64: VGIC: Allow userland to set GICV/GICH addresses
config: arm-axm55xx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout a084eec529c389c3599c3fc0a2e0b296d81bca49
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c: In function 'kvm_vgic_addr':
>> arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c:143:7: error: 'KVM_VGIC_V2_ADDR_TYPE_GICH' undeclared (first use in this function); did you mean 'KVM_VGIC_V2_ADDR_TYPE_DIST'?
     case KVM_VGIC_V2_ADDR_TYPE_GICH:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~
          KVM_VGIC_V2_ADDR_TYPE_DIST
   arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c:143:7: note: each undeclared identifier is reported only once for each function it appears in
>> arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c:148:7: error: 'KVM_VGIC_V2_ADDR_TYPE_GICV' undeclared (first use in this function); did you mean 'KVM_VGIC_V2_ADDR_TYPE_GICH'?
     case KVM_VGIC_V2_ADDR_TYPE_GICV:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~
          KVM_VGIC_V2_ADDR_TYPE_GICH

vim +143 arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c

    47	
    48	/**
    49	 * kvm_vgic_addr - set or get vgic VM base addresses
    50	 * @kvm:   pointer to the vm struct
    51	 * @type:  the VGIC addr type, one of KVM_VGIC_V[23]_ADDR_TYPE_XXX
    52	 * @addr:  pointer to address value
    53	 * @write: if true set the address in the VM address space, if false read the
    54	 *          address
    55	 *
    56	 * Set or get the vgic base addresses for the distributor and the virtual CPU
    57	 * interface in the VM physical address space.  These addresses are properties
    58	 * of the emulated core/SoC and therefore user space initially knows this
    59	 * information.
    60	 * Check them for sanity (alignment, double assignment). We can't check for
    61	 * overlapping regions in case of a virtual GICv3 here, since we don't know
    62	 * the number of VCPUs yet, so we defer this check to map_resources().
    63	 */
    64	int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write)
    65	{
    66		int r = 0;
    67		struct vgic_dist *vgic = &kvm->arch.vgic;
    68		phys_addr_t *addr_ptr, alignment;
    69		u64 undef_value = VGIC_ADDR_UNDEF;
    70	
    71		mutex_lock(&kvm->lock);
    72		switch (type) {
    73		case KVM_VGIC_V2_ADDR_TYPE_DIST:
    74			r = vgic_check_type(kvm, KVM_DEV_TYPE_ARM_VGIC_V2);
    75			addr_ptr = &vgic->vgic_dist_base;
    76			alignment = SZ_4K;
    77			break;
    78		case KVM_VGIC_V2_ADDR_TYPE_CPU:
    79			r = vgic_check_type(kvm, KVM_DEV_TYPE_ARM_VGIC_V2);
    80			addr_ptr = &vgic->vgic_cpu_base;
    81			alignment = SZ_4K;
    82			break;
    83		case KVM_VGIC_V3_ADDR_TYPE_DIST:
    84			r = vgic_check_type(kvm, KVM_DEV_TYPE_ARM_VGIC_V3);
    85			addr_ptr = &vgic->vgic_dist_base;
    86			alignment = SZ_64K;
    87			break;
    88		case KVM_VGIC_V3_ADDR_TYPE_REDIST: {
    89			struct vgic_redist_region *rdreg;
    90	
    91			r = vgic_check_type(kvm, KVM_DEV_TYPE_ARM_VGIC_V3);
    92			if (r)
    93				break;
    94			if (write) {
    95				r = vgic_v3_set_redist_base(kvm, 0, *addr, 0);
    96				goto out;
    97			}
    98			rdreg = list_first_entry(&vgic->rd_regions,
    99						 struct vgic_redist_region, list);
   100			if (!rdreg)
   101				addr_ptr = &undef_value;
   102			else
   103				addr_ptr = &rdreg->base;
   104			break;
   105		}
   106		case KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION:
   107		{
   108			struct vgic_redist_region *rdreg;
   109			u8 index;
   110	
   111			r = vgic_check_type(kvm, KVM_DEV_TYPE_ARM_VGIC_V3);
   112			if (r)
   113				break;
   114	
   115			index = *addr & KVM_VGIC_V3_RDIST_INDEX_MASK;
   116	
   117			if (write) {
   118				gpa_t base = *addr & KVM_VGIC_V3_RDIST_BASE_MASK;
   119				u32 count = (*addr & KVM_VGIC_V3_RDIST_COUNT_MASK)
   120						>> KVM_VGIC_V3_RDIST_COUNT_SHIFT;
   121				u8 flags = (*addr & KVM_VGIC_V3_RDIST_FLAGS_MASK)
   122						>> KVM_VGIC_V3_RDIST_FLAGS_SHIFT;
   123	
   124				if (!count || flags)
   125					r = -EINVAL;
   126				else
   127					r = vgic_v3_set_redist_base(kvm, index,
   128								    base, count);
   129				goto out;
   130			}
   131	
   132			rdreg = vgic_v3_rdist_region_from_index(kvm, index);
   133			if (!rdreg) {
   134				r = -ENOENT;
   135				goto out;
   136			}
   137	
   138			*addr = index;
   139			*addr |= rdreg->base;
   140			*addr |= (u64)rdreg->count << KVM_VGIC_V3_RDIST_COUNT_SHIFT;
   141			goto out;
   142		}
 > 143		case KVM_VGIC_V2_ADDR_TYPE_GICH:
   144			r = vgic_check_type(kvm, KVM_DEV_TYPE_ARM_VGIC_V2);
   145			addr_ptr = &vgic->vgic_hyp_base;
   146			alignment = SZ_4K;
   147			break;
 > 148		case KVM_VGIC_V2_ADDR_TYPE_GICV:
   149			r = vgic_check_type(kvm, KVM_DEV_TYPE_ARM_VGIC_V2);
   150			addr_ptr = &vgic->vgic_vcpu_base;
   151			alignment = SZ_4K;
   152			break;
   153		default:
   154			r = -ENODEV;
   155		}
   156	
   157		if (r)
   158			goto out;
   159	
   160		if (write) {
   161			r = vgic_check_ioaddr(kvm, addr_ptr, *addr, alignment);
   162			if (!r)
   163				*addr_ptr = *addr;
   164		} else {
   165			*addr = *addr_ptr;
   166		}
   167	
   168	out:
   169		mutex_unlock(&kvm->lock);
   170		return r;
   171	}
   172	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 20256 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180919/edfee589/attachment-0001.gz>
