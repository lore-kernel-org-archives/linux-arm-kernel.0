From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 28 Jun 2017 02:07:39 +0800
Subject: [arm-platforms:kvm-arm64/gicv4-kvm 48/62]
 arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-init.c:334: undefined reference
 to `vgic_v4_teardown'
Message-ID: <201706280237.NZifbiqi%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/gicv4-kvm
head:   362f13c96426700d3e37a921ef6d551f01491992
commit: c486d9614d47b1fcace756427f07983c369b9a78 [48/62] KVM: arm/arm64: GICv4: Wire init/teardown of per-VM support
config: arm-axm55xx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout c486d9614d47b1fcace756427f07983c369b9a78
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/kvm/built-in.o: In function `kvm_vgic_dist_destroy':
>> arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-init.c:334: undefined reference to `vgic_v4_teardown'
   arch/arm/kvm/built-in.o: In function `vgic_init':
>> arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-init.c:291: undefined reference to `vgic_v4_init'

vim +334 arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-init.c

   285		if (ret)
   286			goto out;
   287	
   288		if (vgic_has_its(kvm)) {
   289			dist->msis_require_devid = true;
   290			if (kvm_vgic_global_state.has_gicv4) {
 > 291				ret = vgic_v4_init(kvm);
   292				if (ret)
   293					goto out;
   294			}
   295		}
   296	
   297		kvm_for_each_vcpu(i, vcpu, kvm)
   298			kvm_vgic_vcpu_enable(vcpu);
   299	
   300		ret = kvm_vgic_setup_default_irq_routing(kvm);
   301		if (ret)
   302			goto out;
   303	
   304		vgic_debug_init(kvm);
   305	
   306		dist->initialized = true;
   307	
   308		/*
   309		 * If we're initializing GICv2 on-demand when first running the VCPU
   310		 * then we need to load the VGIC state onto the CPU.  We can detect
   311		 * this easily by checking if we are in between vcpu_load and vcpu_put
   312		 * when we just initialized the VGIC.
   313		 */
   314		preempt_disable();
   315		vcpu = kvm_arm_get_running_vcpu();
   316		if (vcpu)
   317			kvm_vgic_load(vcpu);
   318		preempt_enable();
   319	out:
   320		return ret;
   321	}
   322	
   323	static void kvm_vgic_dist_destroy(struct kvm *kvm)
   324	{
   325		struct vgic_dist *dist = &kvm->arch.vgic;
   326	
   327		dist->ready = false;
   328		dist->initialized = false;
   329	
   330		kfree(dist->spis);
   331		dist->nr_spis = 0;
   332	
   333		if (kvm_vgic_global_state.has_gicv4 && vgic_has_its(kvm))
 > 334			vgic_v4_teardown(kvm);
   335	}
   336	
   337	void kvm_vgic_vcpu_destroy(struct kvm_vcpu *vcpu)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 20100 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170628/4ca1ae85/attachment-0001.gz>
