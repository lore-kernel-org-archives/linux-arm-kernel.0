From: lkp@intel.com (kbuild test robot)
Date: Mon, 21 May 2018 06:12:16 +0800
Subject: [kvmarm:queue 13/29]
 arch/arm/kvm/../../../virt/kvm/arm/arm.c:1598:6: error: implicit declaration
 of function 'system_supports_sve'
Message-ID: <201805210615.tc7bzjhx%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git queue
head:   f2d1aab22d57235b58db391d318727d3e5ef1e89
commit: 61d47b5d95db9a4ce12c50ffaa6918a40619984f [13/29] KVM: arm64: Save host SVE context as appropriate
config: arm-axm55xx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 61d47b5d95db9a4ce12c50ffaa6918a40619984f
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/kvm/../../../virt/kvm/arm/arm.c: In function 'kvm_arch_vcpu_ioctl_run':
   arch/arm/kvm/../../../virt/kvm/arm/arm.c:785:3: error: implicit declaration of function 'kvm_arch_vcpu_ctxsync_fp'; did you mean 'kvm_arch_vcpu_put_fp'? [-Werror=implicit-function-declaration]
      kvm_arch_vcpu_ctxsync_fp(vcpu);
      ^~~~~~~~~~~~~~~~~~~~~~~~
      kvm_arch_vcpu_put_fp
   arch/arm/kvm/../../../virt/kvm/arm/arm.c: In function 'kvm_arch_init':
>> arch/arm/kvm/../../../virt/kvm/arm/arm.c:1598:6: error: implicit declaration of function 'system_supports_sve' [-Werror=implicit-function-declaration]
     if (system_supports_sve() && !has_vhe()) {
         ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/system_supports_sve +1598 arch/arm/kvm/../../../virt/kvm/arm/arm.c

  1564	
  1565	/**
  1566	 * Initialize Hyp-mode and memory mappings on all CPUs.
  1567	 */
  1568	int kvm_arch_init(void *opaque)
  1569	{
  1570		int err;
  1571		int ret, cpu;
  1572		bool in_hyp_mode;
  1573	
  1574		if (!is_hyp_mode_available()) {
  1575			kvm_info("HYP mode not available\n");
  1576			return -ENODEV;
  1577		}
  1578	
  1579		for_each_online_cpu(cpu) {
  1580			smp_call_function_single(cpu, check_kvm_target_cpu, &ret, 1);
  1581			if (ret < 0) {
  1582				kvm_err("Error, CPU %d not supported!\n", cpu);
  1583				return -ENODEV;
  1584			}
  1585		}
  1586	
  1587		/*
  1588		 * VHE is a prerequisite for SVE in the Arm architecture, and
  1589		 * Kconfig ensures that if system_supports_sve() here then
  1590		 * CONFIG_ARM64_VHE is enabled, so if VHE support wasn't already
  1591		 * detected and enabled, the CPU is architecturally
  1592		 * noncompliant.
  1593		 *
  1594		 * Just in case this mismatch is seen, detect it, warn and give
  1595		 * up.  Supporting this forbidden configuration in Hyp would be
  1596		 * pointless.
  1597		 */
> 1598		if (system_supports_sve() && !has_vhe()) {
  1599			kvm_pr_unimpl("SVE system without VHE unsupported.  Broken cpu?");
  1600			return -ENODEV;
  1601		}
  1602	
  1603		err = init_common_resources();
  1604		if (err)
  1605			return err;
  1606	
  1607		in_hyp_mode = is_kernel_in_hyp_mode();
  1608	
  1609		if (!in_hyp_mode) {
  1610			err = init_hyp_mode();
  1611			if (err)
  1612				goto out_err;
  1613		}
  1614	
  1615		err = init_subsystems();
  1616		if (err)
  1617			goto out_hyp;
  1618	
  1619		if (in_hyp_mode)
  1620			kvm_info("VHE mode initialized successfully\n");
  1621		else
  1622			kvm_info("Hyp mode initialized successfully\n");
  1623	
  1624		return 0;
  1625	
  1626	out_hyp:
  1627		if (!in_hyp_mode)
  1628			teardown_hyp_mode();
  1629	out_err:
  1630		return err;
  1631	}
  1632	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 19846 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180521/90c5c740/attachment-0001.gz>
