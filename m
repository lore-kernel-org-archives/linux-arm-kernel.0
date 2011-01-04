From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 4 Jan 2011 11:41:17 -0700 (MST)
Subject: [PATCH 2/5] omap2plus: prm: Trvial build break fix for undefined
	reference to 'omap2_prm_read_mod_reg'
In-Reply-To: <1294165576-15628-3-git-send-email-santosh.shilimkar@ti.com>
References: <1294165576-15628-1-git-send-email-santosh.shilimkar@ti.com>
	<1294165576-15628-2-git-send-email-santosh.shilimkar@ti.com>
	<1294165576-15628-3-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <alpine.DEB.2.00.1101041139110.19319@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

On Tue, 4 Jan 2011, Santosh Shilimkar wrote:

> omap2plus_defocnfig build breaks when customised with only ARCH_OMAP4
> selected. This is because common files make references to the functions
> which are defined only for omap2xxx and omap3xxx.
> 
>  LD      .tmp_vmlinux1
> arch/arm/mach-omap2/built-in.o: In function `pm_dbg_regset_store':
> arch/arm/mach-omap2/pm-debug.c:335: undefined reference to `omap2_prm_read_mod_reg'
> arch/arm/mach-omap2/built-in.o: In function `omap2_pm_dump':
> arch/arm/mach-omap2/pm-debug.c:121: undefined reference to `omap2_prm_read_mod_reg'
> arch/arm/mach-omap2/pm-debug.c:123: undefined reference to `omap2_prm_read_mod_reg'
> arch/arm/mach-omap2/pm-debug.c:124: undefined reference to `omap2_prm_read_mod_reg'
> arch/arm/mach-omap2/pm-debug.c:125: undefined reference to `omap2_prm_read_mod_reg'
> arch/arm/mach-omap2/built-in.o: In function `omap_prcm_arch_reset':
> arch/arm/mach-omap2/prcm.c:106: undefined reference to `omap2_prm_set_mod_reg_bits'
> arch/arm/mach-omap2/prcm.c:108: undefined reference to `omap2_prm_read_mod_reg'
> arch/arm/mach-omap2/built-in.o: In function `omap_prcm_get_reset_sources':
> arch/arm/mach-omap2/prcm.c:53: undefined reference to `omap2_prm_read_mod_reg'
> arch/arm/mach-omap2/built-in.o: In function `clkdm_clear_all_wkdeps':
> arch/arm/mach-omap2/clockdomain.c:545: undefined reference to `omap2_prm_clear_mod_reg_bits'
> arch/arm/mach-omap2/built-in.o: In function `clkdm_del_wkdep':
> arch/arm/mach-omap2/clockdomain.c:475: undefined reference to `omap2_prm_clear_mod_reg_bits'
> arch/arm/mach-omap2/built-in.o: In function `clkdm_read_wkdep':
> arch/arm/mach-omap2/clockdomain.c:511: undefined reference to `omap2_prm_read_mod_bits_shift'
> arch/arm/mach-omap2/built-in.o: In function `clkdm_add_wkdep':
> arch/arm/mach-omap2/clockdomain.c:440: undefined reference to `omap2_prm_set_mod_reg_bits'
> make: *** [.tmp_vmlinux1] Error 1
> 
> This patch adds stubs for these functions so that build continues to work.
> 
> Probably alternately  the build can be fixed as below but that not seems to
> be the right way.

Since these functions now return 0, maybe it would be better to call 
WARN() or BUG() in these functions for OMAP4.  Otherwise, they are going 
to silently do the wrong thing, and someone needs to fix any usage of 
these functions where they shouldn't be used.  e.g., in mach-omap2/prcm.c 
or mach-omap2/pm-debug.c ...


- Paul
