From: lkp@intel.com (kbuild test robot)
Date: Tue, 3 Apr 2018 12:32:58 +0800
Subject: [PATCH 4/5] powerpc/pm: add sleep and deep sleep on QorIQ SoCs
In-Reply-To: <20180329013143.22527-4-ran.wang_1@nxp.com>
References: <20180329013143.22527-4-ran.wang_1@nxp.com>
Message-ID: <201804031240.brTuyqu6%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ran,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on powerpc/next]
[also build test WARNING on v4.16 next-20180329]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ran-Wang/powerpc-pm-Fix-suspend-n-in-menuconfig-for-e500mc-platforms/20180330-072848
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-ppc64e_defconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All warnings (new ones prefixed by >>):

   arch/powerpc/platforms/85xx/sleep.S: Assembler messages:
>> arch/powerpc/platforms/85xx/sleep.S:1174: Warning: invalid register expression

vim +1174 arch/powerpc/platforms/85xx/sleep.S

  1137	
  1138	_GLOBAL(fsl_booke_deep_sleep_resume)
  1139		/* disable interrupts */
  1140		FSL_DIS_ALL_IRQ
  1141	
  1142		/* switch to 64-bit mode */
  1143		bl	.enable_64b_mode
  1144	
  1145		/* set TOC pointer */
  1146		bl	.relative_toc
  1147	
  1148		/* setup initial TLBs, switch to kernel space ... */
  1149		bl	.start_initialization_book3e
  1150	
  1151		/* address space changed, set TOC pointer again */
  1152		bl	.relative_toc
  1153	
  1154		/* call a cpu state restore handler */
  1155		LOAD_REG_ADDR(r23, cur_cpu_spec)
  1156		ld	r23,0(r23)
  1157		ld	r23,CPU_SPEC_RESTORE(r23)
  1158		cmpdi	0,r23,0
  1159		beq	1f
  1160		ld	r23,0(r23)
  1161		mtctr	r23
  1162		bctrl
  1163	1:
  1164		LOAD_REG_ADDR(r3, regs_buffer)
  1165		bl	e5500_cpu_state_restore
  1166	
  1167		/* Load each CAM entry */
  1168		LOAD_REG_ADDR(r3, tlbcam_index)
  1169		lwz	r3, 0(r3)
  1170		mtctr	r3
  1171		li	r0, 0
  1172	3:	mr	r3, r0
  1173		bl	loadcam_entry
> 1174		addi	r0, r0, 1
  1175		bdnz	3b
  1176	
  1177		/* restore return address */
  1178		LOAD_REG_ADDR(r3, buf_tmp)
  1179		ld	r4, 16(r3)
  1180		mtspr	SPRN_TCR, r4
  1181		ld	r4, 0(r3)
  1182		mtlr	r4
  1183		ld	r4, 8(r3)
  1184		mtmsr	r4
  1185		ld	r4, 24(r3)
  1186		mtcr	r4
  1187	
  1188		blr
  1189	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 21649 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180403/ea7e7515/attachment-0001.gz>
