From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Wed, 21 Dec 2011 15:52:02 +0100
Subject: [PATCH] ARM: imx6q: build pm code only when CONFIG_PM selected
In-Reply-To: <1324478303-3899-1-git-send-email-eric.miao@linaro.org>
References: <1324478303-3899-1-git-send-email-eric.miao@linaro.org>
Message-ID: <20209.62098.146087.510816@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Eric Miao writes:
[...]
> diff --git a/arch/arm/mach-imx/head-v7.S b/arch/arm/mach-imx/head-v7.S
> index 6229efb..a59cae7 100644
> --- a/arch/arm/mach-imx/head-v7.S
> +++ b/arch/arm/mach-imx/head-v7.S
> @@ -71,6 +71,7 @@ ENTRY(v7_secondary_startup)
>  ENDPROC(v7_secondary_startup)
>  #endif
>  
> +#ifdef CONFIG_PM
>  /*
>   * The following code is located into the .data section.  This is to
>   * allow phys_l2x0_saved_regs to be accessed with a relative load
> @@ -97,3 +98,4 @@ ENDPROC(v7_cpu_resume)
>  	.globl	phys_l2x0_saved_regs
>  phys_l2x0_saved_regs:
>          .long   0
> +#endif
>
While you are changing mach-imx/head-v7.S you could also fix a build
error with 'CONFIG_CACHE_L2x0' disabled.
I just found this, but sending a patch now would conflict with your
patch:

diff --git a/arch/arm/mach-imx/head-v7.S b/arch/arm/mach-imx/head-v7.S
index 6229efb..830b5c8 100644
--- a/arch/arm/mach-imx/head-v7.S
+++ b/arch/arm/mach-imx/head-v7.S
@@ -80,12 +80,14 @@ ENDPROC(v7_secondary_startup)
 	.align
 
 	.macro	pl310_resume
+#ifdef CONFIG_CACHE_L2X0
 	ldr	r2, phys_l2x0_saved_regs
 	ldr	r0, [r2, #L2X0_R_PHY_BASE]	@ get physical base of l2x0
 	ldr	r1, [r2, #L2X0_R_AUX_CTRL]	@ get aux_ctrl value
 	str	r1, [r0, #L2X0_AUX_CTRL]	@ restore aux_ctrl
 	mov	r1, #0x1
 	str	r1, [r0, #L2X0_CTRL]		@ re-enable L2
+#endif
 	.endm
 
 ENTRY(v7_cpu_resume)
@@ -94,6 +96,8 @@ ENTRY(v7_cpu_resume)
 	b	cpu_resume
 ENDPROC(v7_cpu_resume)
 
+#ifdef CONFIG_CACHE_L2X0
 	.globl	phys_l2x0_saved_regs
 phys_l2x0_saved_regs:
         .long   0
+#endif


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
