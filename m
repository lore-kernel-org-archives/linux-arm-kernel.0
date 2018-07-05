From: lkp@intel.com (kbuild test robot)
Date: Thu, 5 Jul 2018 18:16:44 +0800
Subject: [PATCH 1/2] ARM: OMAP2+: sleep33/43xx: Make sleep actions
 configurable
In-Reply-To: <1530698757-29807-1-git-send-email-j-keerthy@ti.com>
References: <1530698757-29807-1-git-send-email-j-keerthy@ti.com>
Message-ID: <201807051856.tHeudWfX%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on omap/for-next]
[also build test ERROR on v4.18-rc3 next-20180704]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Keerthy/ARM-OMAP2-sleep33-43xx-Make-sleep-actions-configurable/20180705-010044
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git for-next
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

Note: the linux-review/Keerthy/ARM-OMAP2-sleep33-43xx-Make-sleep-actions-configurable/20180705-010044 HEAD e3afa3d962d9da30f840bc6f95322b0f9aea67d5 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   arch/arm/mach-omap2/sleep33xx.S: Assembler messages:
>> arch/arm/mach-omap2/sleep33xx.S:36: Error: garbage following instruction -- `tst r4,#BIT(0)'
   arch/arm/mach-omap2/sleep33xx.S:68: Error: garbage following instruction -- `tst r4,#BIT(1)'
   arch/arm/mach-omap2/sleep33xx.S:78: Error: garbage following instruction -- `tst r4,#BIT(2)'
   arch/arm/mach-omap2/sleep33xx.S:86: Error: garbage following instruction -- `tst r4,#BIT(1)'
   arch/arm/mach-omap2/sleep33xx.S:103: Error: garbage following instruction -- `tst r4,#BIT(3)'
   arch/arm/mach-omap2/sleep33xx.S:171: Error: garbage following instruction -- `tst r4,#BIT(1)'
   arch/arm/mach-omap2/sleep33xx.S:179: Error: garbage following instruction -- `tst r4,#BIT(0)'
--
   arch/arm/mach-omap2/sleep43xx.S: Assembler messages:
>> arch/arm/mach-omap2/sleep43xx.S:68: Error: garbage following instruction -- `tst r4,#BIT(0)'
   arch/arm/mach-omap2/sleep43xx.S:148: Error: garbage following instruction -- `tst r4,#BIT(1)'
   arch/arm/mach-omap2/sleep43xx.S:158: Error: garbage following instruction -- `tst r4,#BIT(2)'
   arch/arm/mach-omap2/sleep43xx.S:166: Error: garbage following instruction -- `tst r4,#BIT(1)'
   arch/arm/mach-omap2/sleep43xx.S:182: Error: garbage following instruction -- `tst r4,#BIT(3)'
   arch/arm/mach-omap2/sleep43xx.S:256: Error: garbage following instruction -- `tst r4,#BIT(0)'
   arch/arm/mach-omap2/sleep43xx.S:269: Error: garbage following instruction -- `tst r4,#BIT(1)'

vim +36 arch/arm/mach-omap2/sleep33xx.S

    22	
    23		.arm
    24		.align 3
    25	
    26	ENTRY(am33xx_do_wfi)
    27		stmfd	sp!, {r4 - r11, lr}	@ save registers on stack
    28	
    29		/* Save wfi_flags arg to data space */
    30		mov	r4, r0
    31		adr	r3, am33xx_pm_ro_sram_data
    32		ldr	r2, [r3, #AMX3_PM_RO_SRAM_DATA_VIRT_OFFSET]
    33		str	r4, [r2, #AMX3_PM_WFI_FLAGS_OFFSET]
    34	
    35		/* Only flush cache is we know we are losing MPU context */
  > 36		tst	r4, #WFI_FLAG_FLUSH_CACHE
    37		beq	cache_skip_flush
    38	
    39		/*
    40		 * Flush all data from the L1 and L2 data cache before disabling
    41		 * SCTLR.C bit.
    42		 */
    43		ldr	r1, kernel_flush
    44		blx	r1
    45	
    46		/*
    47		 * Clear the SCTLR.C bit to prevent further data cache
    48		 * allocation. Clearing SCTLR.C would make all the data accesses
    49		 * strongly ordered and would not hit the cache.
    50		 */
    51		mrc	p15, 0, r0, c1, c0, 0
    52		bic	r0, r0, #(1 << 2)	@ Disable the C bit
    53		mcr	p15, 0, r0, c1, c0, 0
    54		isb
    55	
    56		/*
    57		 * Invalidate L1 and L2 data cache.
    58		 */
    59		ldr	r1, kernel_flush
    60		blx	r1
    61	
    62		adr	r3, am33xx_pm_ro_sram_data
    63		ldr	r2, [r3, #AMX3_PM_RO_SRAM_DATA_VIRT_OFFSET]
    64		ldr	r4, [r2, #AMX3_PM_WFI_FLAGS_OFFSET]
    65	
    66	cache_skip_flush:
    67		/* Check if we want self refresh */
    68		tst	r4, #WFI_FLAG_SELF_REFRESH
    69		beq	emif_skip_enter_sr
    70	
    71		adr	r9, am33xx_emif_sram_table
    72	
    73		ldr	r3, [r9, #EMIF_PM_ENTER_SR_OFFSET]
    74		blx	r3
    75	
    76	emif_skip_enter_sr:
    77		/* Only necessary if PER is losing context */
    78		tst	r4, #WFI_FLAG_SAVE_EMIF
    79		beq	emif_skip_save
    80	
    81		ldr	r3, [r9, #EMIF_PM_SAVE_CONTEXT_OFFSET]
    82		blx	r3
    83	
    84	emif_skip_save:
    85		/* Only can disable EMIF if we have entered self refresh */
    86		tst     r4, #WFI_FLAG_SELF_REFRESH
    87		beq     emif_skip_disable
    88	
    89		/* Disable EMIF */
    90		ldr     r1, virt_emif_clkctrl
    91		ldr     r2, [r1]
    92		bic     r2, r2, #AM33XX_CM_CLKCTRL_MODULEMODE_DISABLE
    93		str     r2, [r1]
    94	
    95		ldr	r1, virt_emif_clkctrl
    96	wait_emif_disable:
    97		ldr	r2, [r1]
    98		mov	r3, #AM33XX_CM_CLKCTRL_MODULESTATE_DISABLED
    99		cmp	r2, r3
   100		bne	wait_emif_disable
   101	
   102	emif_skip_disable:
   103		tst	r4, #WFI_FLAG_WAKE_M3
   104		beq	wkup_m3_skip
   105	
   106		/*
   107		 * For the MPU WFI to be registered as an interrupt
   108		 * to WKUP_M3, MPU_CLKCTRL.MODULEMODE needs to be set
   109		 * to DISABLED
   110		 */
   111		ldr	r1, virt_mpu_clkctrl
   112		ldr	r2, [r1]
   113		bic	r2, r2, #AM33XX_CM_CLKCTRL_MODULEMODE_DISABLE
   114		str	r2, [r1]
   115	
   116	wkup_m3_skip:
   117		/*
   118		 * Execute an ISB instruction to ensure that all of the
   119		 * CP15 register changes have been committed.
   120		 */
   121		isb
   122	
   123		/*
   124		 * Execute a barrier instruction to ensure that all cache,
   125		 * TLB and branch predictor maintenance operations issued
   126		 * have completed.
   127		 */
   128		dsb
   129		dmb
   130	
   131		/*
   132		 * Execute a WFI instruction and wait until the
   133		 * STANDBYWFI output is asserted to indicate that the
   134		 * CPU is in idle and low power state. CPU can specualatively
   135		 * prefetch the instructions so add NOPs after WFI. Thirteen
   136		 * NOPs as per Cortex-A8 pipeline.
   137		 */
   138		wfi
   139	
   140		nop
   141		nop
   142		nop
   143		nop
   144		nop
   145		nop
   146		nop
   147		nop
   148		nop
   149		nop
   150		nop
   151		nop
   152		nop
   153	
   154		/* We come here in case of an abort due to a late interrupt */
   155	
   156		/* Set MPU_CLKCTRL.MODULEMODE back to ENABLE */
   157		ldr	r1, virt_mpu_clkctrl
   158		mov	r2, #AM33XX_CM_CLKCTRL_MODULEMODE_ENABLE
   159		str	r2, [r1]
   160	
   161		/* Re-enable EMIF */
   162		ldr	r1, virt_emif_clkctrl
   163		mov	r2, #AM33XX_CM_CLKCTRL_MODULEMODE_ENABLE
   164		str	r2, [r1]
   165	wait_emif_enable:
   166		ldr	r3, [r1]
   167		cmp	r2, r3
   168		bne	wait_emif_enable
   169	
   170		/* Only necessary if PER is losing context */
   171		tst	r4, #WFI_FLAG_SELF_REFRESH
   172		beq	emif_skip_exit_sr_abt
   173	
   174		adr	r9, am33xx_emif_sram_table
   175		ldr	r1, [r9, #EMIF_PM_ABORT_SR_OFFSET]
   176		blx	r1
   177	
   178	emif_skip_exit_sr_abt:
   179		tst	r4, #WFI_FLAG_FLUSH_CACHE
   180		beq	cache_skip_restore
   181	
   182		/*
   183		 * Set SCTLR.C bit to allow data cache allocation
   184		 */
   185		mrc	p15, 0, r0, c1, c0, 0
   186		orr	r0, r0, #(1 << 2)	@ Enable the C bit
   187		mcr	p15, 0, r0, c1, c0, 0
   188		isb
   189	
   190	cache_skip_restore:
   191		/* Let the suspend code know about the abort */
   192		mov	r0, #1
   193		ldmfd	sp!, {r4 - r11, pc}	@ restore regs and return
   194	ENDPROC(am33xx_do_wfi)
   195	
   196		.align
   197	ENTRY(am33xx_resume_offset)
   198		.word . - am33xx_do_wfi
   199	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 44060 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180705/90892f41/attachment-0001.gz>
