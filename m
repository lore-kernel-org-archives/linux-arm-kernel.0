From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 22 Aug 2016 13:48:04 +0800
Subject: [arm-platforms:kvm-arm64/idmap-fixes 1/1]
 arch/arm/kvm/mmu.c:1718:22: warning: comparison between pointer and integer
Message-ID: <201608221301.BMwHRZjX%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/idmap-fixes
head:   ac31b33e179d429278fe12020d3b0c4659457985
commit: ac31b33e179d429278fe12020d3b0c4659457985 [1/1] arm: KVM: Fix idmap overlap detection when the kernel is idmap'ed
config: arm-axm55xx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout ac31b33e179d429278fe12020d3b0c4659457985
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   arch/arm/kvm/mmu.c: In function 'kvm_mmu_init':
>> arch/arm/kvm/mmu.c:1718:22: warning: comparison between pointer and integer
         hyp_idmap_start != __hyp_idmap_text_start) {
                         ^

vim +1718 arch/arm/kvm/mmu.c

  1702		hyp_idmap_start = kvm_virt_to_phys(__hyp_idmap_text_start);
  1703		hyp_idmap_end = kvm_virt_to_phys(__hyp_idmap_text_end);
  1704		hyp_idmap_vector = kvm_virt_to_phys(__kvm_hyp_init);
  1705	
  1706		/*
  1707		 * We rely on the linker script to ensure at build time that the HYP
  1708		 * init code does not cross a page boundary.
  1709		 */
  1710		BUG_ON((hyp_idmap_start ^ (hyp_idmap_end - 1)) & PAGE_MASK);
  1711	
  1712		kvm_info("IDMAP page: %lx\n", hyp_idmap_start);
  1713		kvm_info("HYP VA range: %lx:%lx\n",
  1714			 kern_hyp_va(PAGE_OFFSET), kern_hyp_va(~0UL));
  1715	
  1716		if (hyp_idmap_start >= kern_hyp_va(PAGE_OFFSET) &&
  1717		    hyp_idmap_start <  kern_hyp_va(~0UL) &&
> 1718		    hyp_idmap_start != __hyp_idmap_text_start) {
  1719			/*
  1720			 * The idmap page is intersecting with the VA space,
  1721			 * it is not safe to continue further.
  1722			 */
  1723			kvm_err("IDMAP intersecting with HYP VA, unable to continue\n");
  1724			err = -EINVAL;
  1725			goto out;
  1726		}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 19201 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160822/32c39f57/attachment-0001.obj>
