From: lkp@intel.com (kbuild test robot)
Date: Sat, 24 Mar 2018 18:28:54 +0800
Subject: [PATCH v2] KVM: arm/arm64 : add lpi info in vgic-debug
In-Reply-To: <1521846074-66914-1-git-send-email-peng.hao2@zte.com.cn>
References: <1521846074-66914-1-git-send-email-peng.hao2@zte.com.cn>
Message-ID: <201803241837.lHpdnlEh%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on kvmarm/next]
[also build test WARNING on v4.16-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Peng-Hao/KVM-arm-arm64-add-lpi-info-in-vgic-debug/20180324-151050
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-debug.c: In function 'vgic_debug_show':
>> arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-debug.c:225:2: warning: 'type' may be used uninitialized in this function [-Wmaybe-uninitialized]
     seq_printf(s, "       %s %4d "
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            "    %2d "
            ~~~~~~~~~~
            "%d%d%d%d%d%d "
            ~~~~~~~~~~~~~~~
            "%8d "
            ~~~~~~
            "%8x "
            ~~~~~~
            " %2x "
            ~~~~~~~
            "%3d "
            ~~~~~~
            "     %2d "
            ~~~~~~~~~~~
            "\n",
            ~~~~~
       type, irq->intid,
       ~~~~~~~~~~~~~~~~~
       (irq->target_vcpu) ? irq->target_vcpu->vcpu_id : -1,
       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       irq->pending_latch,
       ~~~~~~~~~~~~~~~~~~~
       irq->line_level,
       ~~~~~~~~~~~~~~~~
       irq->active,
       ~~~~~~~~~~~~
       irq->enabled,
       ~~~~~~~~~~~~~
       irq->hw,
       ~~~~~~~~
       irq->config == VGIC_CONFIG_LEVEL,
       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       irq->hwintid,
       ~~~~~~~~~~~~~
       irq->mpidr,
       ~~~~~~~~~~~
       irq->source,
       ~~~~~~~~~~~~
       irq->priority,
       ~~~~~~~~~~~~~~
       (irq->vcpu) ? irq->vcpu->vcpu_id : -1);
       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-debug.c:212:8: note: 'type' was declared here
     char *type;
           ^~~~

vim +/type +225 arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-debug.c

10f92c4c Christoffer Dall 2017-01-17  208  
10f92c4c Christoffer Dall 2017-01-17  209  static void print_irq_state(struct seq_file *s, struct vgic_irq *irq,
10f92c4c Christoffer Dall 2017-01-17  210  			    struct kvm_vcpu *vcpu)
10f92c4c Christoffer Dall 2017-01-17  211  {
10f92c4c Christoffer Dall 2017-01-17  212  	char *type;
10f92c4c Christoffer Dall 2017-01-17  213  	if (irq->intid < VGIC_NR_SGIS)
10f92c4c Christoffer Dall 2017-01-17  214  		type = "SGI";
10f92c4c Christoffer Dall 2017-01-17  215  	else if (irq->intid < VGIC_NR_PRIVATE_IRQS)
10f92c4c Christoffer Dall 2017-01-17  216  		type = "PPI";
01d84373 Peng Hao         2018-03-24  217  	else if (irq->intid < VGIC_MAX_SPI)
10f92c4c Christoffer Dall 2017-01-17  218  		type = "SPI";
01d84373 Peng Hao         2018-03-24  219  	else if (irq->intid >= VGIC_MIN_LPI)
01d84373 Peng Hao         2018-03-24  220  		type = "LPI";
10f92c4c Christoffer Dall 2017-01-17  221  
10f92c4c Christoffer Dall 2017-01-17  222  	if (irq->intid ==0 || irq->intid == VGIC_NR_PRIVATE_IRQS)
10f92c4c Christoffer Dall 2017-01-17  223  		print_header(s, irq, vcpu);
10f92c4c Christoffer Dall 2017-01-17  224  
10f92c4c Christoffer Dall 2017-01-17 @225  	seq_printf(s, "       %s %4d "
10f92c4c Christoffer Dall 2017-01-17  226  		      "    %2d "
10f92c4c Christoffer Dall 2017-01-17  227  		      "%d%d%d%d%d%d "
10f92c4c Christoffer Dall 2017-01-17  228  		      "%8d "
10f92c4c Christoffer Dall 2017-01-17  229  		      "%8x "
10f92c4c Christoffer Dall 2017-01-17  230  		      " %2x "
10f92c4c Christoffer Dall 2017-01-17  231  		      "%3d "
10f92c4c Christoffer Dall 2017-01-17  232  		      "     %2d "
10f92c4c Christoffer Dall 2017-01-17  233  		      "\n",
10f92c4c Christoffer Dall 2017-01-17  234  			type, irq->intid,
10f92c4c Christoffer Dall 2017-01-17  235  			(irq->target_vcpu) ? irq->target_vcpu->vcpu_id : -1,
10f92c4c Christoffer Dall 2017-01-17  236  			irq->pending_latch,
10f92c4c Christoffer Dall 2017-01-17  237  			irq->line_level,
10f92c4c Christoffer Dall 2017-01-17  238  			irq->active,
10f92c4c Christoffer Dall 2017-01-17  239  			irq->enabled,
10f92c4c Christoffer Dall 2017-01-17  240  			irq->hw,
10f92c4c Christoffer Dall 2017-01-17  241  			irq->config == VGIC_CONFIG_LEVEL,
10f92c4c Christoffer Dall 2017-01-17  242  			irq->hwintid,
10f92c4c Christoffer Dall 2017-01-17  243  			irq->mpidr,
10f92c4c Christoffer Dall 2017-01-17  244  			irq->source,
10f92c4c Christoffer Dall 2017-01-17  245  			irq->priority,
10f92c4c Christoffer Dall 2017-01-17  246  			(irq->vcpu) ? irq->vcpu->vcpu_id : -1);
10f92c4c Christoffer Dall 2017-01-17  247  

:::::: The code at line 225 was first introduced by commit
:::::: 10f92c4c537794f4e2b5f545a8953790c5445d0f KVM: arm/arm64: vgic: Add debugfs vgic-state file

:::::: TO: Christoffer Dall <christoffer.dall@linaro.org>
:::::: CC: Christoffer Dall <christoffer.dall@linaro.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 37947 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180324/422ba3bd/attachment-0001.gz>
