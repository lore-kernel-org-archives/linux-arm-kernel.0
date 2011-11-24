From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 24 Nov 2011 17:05:31 -0500 (EST)
Subject: [PATCH 25/41] ARM: restart: orion5x: use new restart hook
In-Reply-To: <E1RN6pX-0001YH-H9@rmk-PC.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6pX-0001YH-H9@rmk-PC.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1111241702400.17904@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 6 Nov 2011, Russell King - ARM Linux wrote:

> Hook these platforms restart code into the new restart hook rather than
> using arch_reset().
> 
> In addition, convert calls to arm_machine_restart() to orion5x_restart()
> to ensure that they continue to work as intended.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/mach-orion5x/common.c                 |   12 ++++++++++++
>  arch/arm/mach-orion5x/common.h                 |    1 +
>  arch/arm/mach-orion5x/d2net-setup.c            |    2 ++
>  arch/arm/mach-orion5x/db88f5281-setup.c        |    1 +
>  arch/arm/mach-orion5x/dns323-setup.c           |    1 +
>  arch/arm/mach-orion5x/edmini_v2-setup.c        |    1 +
>  arch/arm/mach-orion5x/include/mach/system.h    |   10 ----------
>  arch/arm/mach-orion5x/kurobox_pro-setup.c      |    2 ++
>  arch/arm/mach-orion5x/ls-chl-setup.c           |    3 ++-
>  arch/arm/mach-orion5x/ls_hgl-setup.c           |    3 ++-
>  arch/arm/mach-orion5x/lsmini-setup.c           |    3 ++-
>  arch/arm/mach-orion5x/mss2-setup.c             |    3 ++-
>  arch/arm/mach-orion5x/mv2120-setup.c           |    3 ++-
>  arch/arm/mach-orion5x/net2big-setup.c          |    1 +
>  arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c   |    1 +
>  arch/arm/mach-orion5x/rd88f5181l-ge-setup.c    |    1 +
>  arch/arm/mach-orion5x/rd88f5182-setup.c        |    1 +
>  arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c   |    1 +
>  arch/arm/mach-orion5x/terastation_pro2-setup.c |    1 +
>  arch/arm/mach-orion5x/ts209-setup.c            |    1 +
>  arch/arm/mach-orion5x/ts409-setup.c            |    1 +
>  arch/arm/mach-orion5x/ts78xx-setup.c           |    1 +
>  arch/arm/mach-orion5x/wnr854t-setup.c          |    1 +
>  arch/arm/mach-orion5x/wrt350n-v2-setup.c       |    1 +
>  24 files changed, 41 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
> index 22ace0b..41127e8 100644
> --- a/arch/arm/mach-orion5x/common.c
> +++ b/arch/arm/mach-orion5x/common.c
> @@ -18,6 +18,7 @@
>  #include <linux/mbus.h>
>  #include <linux/mv643xx_i2c.h>
>  #include <linux/ata_platform.h>
> +#include <linux/delay.h>
>  #include <net/dsa.h>
>  #include <asm/page.h>
>  #include <asm/setup.h>
> @@ -304,6 +305,17 @@ void __init orion5x_init(void)
>  	orion5x_wdt_init();
>  }
>  
> +void orion5x_restart(char mode, const char *cmd)
> +{
> +	/*
> +	 * Enable and issue soft reset
> +	 */
> +	orion5x_setbits(RSTOUTn_MASK, (1 << 2));
> +	orion5x_setbits(CPU_SOFT_RESET, 1);
> +	mdelay(200);
> +	orion5x_clrbits(CPU_SOFT_RESET, 1);
> +}
> +
>  /*
>   * Many orion-based systems have buggy bootloader implementations.
>   * This is a common fixup for bogus memory tags.
> diff --git a/arch/arm/mach-orion5x/common.h b/arch/arm/mach-orion5x/common.h
> index 909489f..37ef18d 100644
> --- a/arch/arm/mach-orion5x/common.h
> +++ b/arch/arm/mach-orion5x/common.h
> @@ -39,6 +39,7 @@ void orion5x_spi_init(void);
>  void orion5x_uart0_init(void);
>  void orion5x_uart1_init(void);
>  void orion5x_xor_init(void);
> +void orion5x_restart(char, const char *);
>  
>  /*
>   * PCIe/PCI functions.
> diff --git a/arch/arm/mach-orion5x/d2net-setup.c b/arch/arm/mach-orion5x/d2net-setup.c
> index 8c83009..d75dcfa 100644
> --- a/arch/arm/mach-orion5x/d2net-setup.c
> +++ b/arch/arm/mach-orion5x/d2net-setup.c
> @@ -343,6 +343,7 @@ MACHINE_START(D2NET, "LaCie d2 Network")
>  	.init_irq	= orion5x_init_irq,
>  	.timer		= &orion5x_timer,
>  	.fixup		= tag_fixup_mem32,
> +	.restart	= orion5x_restart,
>  MACHINE_END
>  #endif
>  
> @@ -355,6 +356,7 @@ MACHINE_START(BIGDISK, "LaCie Big Disk Network")
>  	.init_irq	= orion5x_init_irq,
>  	.timer		= &orion5x_timer,
>  	.fixup		= tag_fixup_mem32,
> +	.restart	= orion5x_restart,
>  MACHINE_END
>  #endif
>  
> diff --git a/arch/arm/mach-orion5x/db88f5281-setup.c b/arch/arm/mach-orion5x/db88f5281-setup.c
> index 4b79a80..a104d5a 100644
> --- a/arch/arm/mach-orion5x/db88f5281-setup.c
> +++ b/arch/arm/mach-orion5x/db88f5281-setup.c
> @@ -364,4 +364,5 @@ MACHINE_START(DB88F5281, "Marvell Orion-2 Development Board")
>  	.init_early	= orion5x_init_early,
>  	.init_irq	= orion5x_init_irq,
>  	.timer		= &orion5x_timer,
> +	.restart	= orion5x_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
> index 343f60e..91b0f47 100644
> --- a/arch/arm/mach-orion5x/dns323-setup.c
> +++ b/arch/arm/mach-orion5x/dns323-setup.c
> @@ -736,4 +736,5 @@ MACHINE_START(DNS323, "D-Link DNS-323")
>  	.init_irq	= orion5x_init_irq,
>  	.timer		= &orion5x_timer,
>  	.fixup		= tag_fixup_mem32,
> +	.restart	= orion5x_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-orion5x/edmini_v2-setup.c b/arch/arm/mach-orion5x/edmini_v2-setup.c
> index 70a4e92..355e962 100644
> --- a/arch/arm/mach-orion5x/edmini_v2-setup.c
> +++ b/arch/arm/mach-orion5x/edmini_v2-setup.c
> @@ -258,4 +258,5 @@ MACHINE_START(EDMINI_V2, "LaCie Ethernet Disk mini V2")
>  	.init_irq	= orion5x_init_irq,
>  	.timer		= &orion5x_timer,
>  	.fixup		= tag_fixup_mem32,
> +	.restart	= orion5x_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-orion5x/include/mach/system.h b/arch/arm/mach-orion5x/include/mach/system.h
> index a1d6e46..6677677 100644
> --- a/arch/arm/mach-orion5x/include/mach/system.h
> +++ b/arch/arm/mach-orion5x/include/mach/system.h
> @@ -11,8 +11,6 @@
>  #ifndef __ASM_ARCH_SYSTEM_H
>  #define __ASM_ARCH_SYSTEM_H
>  
> -#include <mach/bridge-regs.h>
> -
>  static inline void arch_idle(void)
>  {
>  	cpu_do_idle();
> @@ -20,14 +18,6 @@ static inline void arch_idle(void)
>  
>  static inline void arch_reset(char mode, const char *cmd)
>  {
> -	/*
> -	 * Enable and issue soft reset
> -	 */
> -	orion5x_setbits(RSTOUTn_MASK, (1 << 2));
> -	orion5x_setbits(CPU_SOFT_RESET, 1);
> -	mdelay(200);
> -	orion5x_clrbits(CPU_SOFT_RESET, 1);
>  }
>  
> -
>  #endif
> diff --git a/arch/arm/mach-orion5x/kurobox_pro-setup.c b/arch/arm/mach-orion5x/kurobox_pro-setup.c
> index d3cd3f6..47587b8 100644
> --- a/arch/arm/mach-orion5x/kurobox_pro-setup.c
> +++ b/arch/arm/mach-orion5x/kurobox_pro-setup.c
> @@ -386,6 +386,7 @@ MACHINE_START(KUROBOX_PRO, "Buffalo/Revogear Kurobox Pro")
>  	.init_irq	= orion5x_init_irq,
>  	.timer		= &orion5x_timer,
>  	.fixup		= tag_fixup_mem32,
> +	.restart	= orion5x_restart,
>  MACHINE_END
>  #endif
>  
> @@ -399,5 +400,6 @@ MACHINE_START(LINKSTATION_PRO, "Buffalo Linkstation Pro/Live")
>  	.init_irq	= orion5x_init_irq,
>  	.timer		= &orion5x_timer,
>  	.fixup		= tag_fixup_mem32,
> +	.restart	= orion5x_restart,
>  MACHINE_END
>  #endif
> diff --git a/arch/arm/mach-orion5x/ls-chl-setup.c b/arch/arm/mach-orion5x/ls-chl-setup.c
> index 9503fff..5272131 100644
> --- a/arch/arm/mach-orion5x/ls-chl-setup.c
> +++ b/arch/arm/mach-orion5x/ls-chl-setup.c
> @@ -140,7 +140,7 @@ static struct mv_sata_platform_data lschl_sata_data = {
>  
>  static void lschl_power_off(void)
>  {
> -	arm_machine_restart('h', NULL);
> +	orion5x_restart('h', NULL);
>  }
>  
>  /*****************************************************************************
> @@ -325,4 +325,5 @@ MACHINE_START(LINKSTATION_LSCHL, "Buffalo Linkstation LiveV3 (LS-CHL)")
>  	.init_irq	= orion5x_init_irq,
>  	.timer		= &orion5x_timer,
>  	.fixup		= tag_fixup_mem32,
> +	.restart	= orion5x_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-orion5x/ls_hgl-setup.c b/arch/arm/mach-orion5x/ls_hgl-setup.c
> index ed6d772..9a8697b 100644
> --- a/arch/arm/mach-orion5x/ls_hgl-setup.c
> +++ b/arch/arm/mach-orion5x/ls_hgl-setup.c
> @@ -186,7 +186,7 @@ static struct mv_sata_platform_data ls_hgl_sata_data = {
>  
>  static void ls_hgl_power_off(void)
>  {
> -	arm_machine_restart('h', NULL);
> +	orion5x_restart('h', NULL);
>  }
>  
>  
> @@ -272,4 +272,5 @@ MACHINE_START(LINKSTATION_LS_HGL, "Buffalo Linkstation LS-HGL")
>  	.init_irq	= orion5x_init_irq,
>  	.timer		= &orion5x_timer,
>  	.fixup		= tag_fixup_mem32,
> +	.restart	= orion5x_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-orion5x/lsmini-setup.c b/arch/arm/mach-orion5x/lsmini-setup.c
> index 743f7f1..09c7365 100644
> --- a/arch/arm/mach-orion5x/lsmini-setup.c
> +++ b/arch/arm/mach-orion5x/lsmini-setup.c
> @@ -186,7 +186,7 @@ static struct mv_sata_platform_data lsmini_sata_data = {
>  
>  static void lsmini_power_off(void)
>  {
> -	arm_machine_restart('h', NULL);
> +	orion5x_restart('h', NULL);
>  }
>  
>  
> @@ -274,5 +274,6 @@ MACHINE_START(LINKSTATION_MINI, "Buffalo Linkstation Mini")
>  	.init_irq	= orion5x_init_irq,
>  	.timer		= &orion5x_timer,
>  	.fixup		= tag_fixup_mem32,
> +	.restart	= orion5x_restart,
>  MACHINE_END
>  #endif
> diff --git a/arch/arm/mach-orion5x/mss2-setup.c b/arch/arm/mach-orion5x/mss2-setup.c
> index 6020e26..65faaa3 100644
> --- a/arch/arm/mach-orion5x/mss2-setup.c
> +++ b/arch/arm/mach-orion5x/mss2-setup.c
> @@ -267,5 +267,6 @@ MACHINE_START(MSS2, "Maxtor Shared Storage II")
>  	.init_early	= orion5x_init_early,
>  	.init_irq	= orion5x_init_irq,
>  	.timer		= &orion5x_timer,
> -	.fixup		= tag_fixup_mem32
> +	.fixup		= tag_fixup_mem32,
> +	.restart	= orion5x_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-orion5x/mv2120-setup.c b/arch/arm/mach-orion5x/mv2120-setup.c
> index 201ae36..c87fde4 100644
> --- a/arch/arm/mach-orion5x/mv2120-setup.c
> +++ b/arch/arm/mach-orion5x/mv2120-setup.c
> @@ -234,5 +234,6 @@ MACHINE_START(MV2120, "HP Media Vault mv2120")
>  	.init_early	= orion5x_init_early,
>  	.init_irq	= orion5x_init_irq,
>  	.timer		= &orion5x_timer,
> -	.fixup		= tag_fixup_mem32
> +	.fixup		= tag_fixup_mem32,
> +	.restart	= orion5x_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-orion5x/net2big-setup.c b/arch/arm/mach-orion5x/net2big-setup.c
> index 6197c79..0180c39 100644
> --- a/arch/arm/mach-orion5x/net2big-setup.c
> +++ b/arch/arm/mach-orion5x/net2big-setup.c
> @@ -426,5 +426,6 @@ MACHINE_START(NET2BIG, "LaCie 2Big Network")
>  	.init_irq	= orion5x_init_irq,
>  	.timer		= &orion5x_timer,
>  	.fixup		= tag_fixup_mem32,
> +	.restart	= orion5x_restart,
>  MACHINE_END
>  
> diff --git a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
> index ebd6767..292038f 100644
> --- a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
> +++ b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
> @@ -175,4 +175,5 @@ MACHINE_START(RD88F5181L_FXO, "Marvell Orion-VoIP FXO Reference Design")
>  	.init_irq	= orion5x_init_irq,
>  	.timer		= &orion5x_timer,
>  	.fixup		= tag_fixup_mem32,
> +	.restart	= orion5x_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
> index 05db2d3..c44eaba 100644
> --- a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
> +++ b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
> @@ -187,4 +187,5 @@ MACHINE_START(RD88F5181L_GE, "Marvell Orion-VoIP GE Reference Design")
>  	.init_irq	= orion5x_init_irq,
>  	.timer		= &orion5x_timer,
>  	.fixup		= tag_fixup_mem32,
> +	.restart	= orion5x_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-orion5x/rd88f5182-setup.c b/arch/arm/mach-orion5x/rd88f5182-setup.c
> index e47fa05..96438b6 100644
> --- a/arch/arm/mach-orion5x/rd88f5182-setup.c
> +++ b/arch/arm/mach-orion5x/rd88f5182-setup.c
> @@ -311,4 +311,5 @@ MACHINE_START(RD88F5182, "Marvell Orion-NAS Reference Design")
>  	.init_early	= orion5x_init_early,
>  	.init_irq	= orion5x_init_irq,
>  	.timer		= &orion5x_timer,
> +	.restart	= orion5x_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
> index 6431725..2c5fab0 100644
> --- a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
> +++ b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
> @@ -128,4 +128,5 @@ MACHINE_START(RD88F6183AP_GE, "Marvell Orion-1-90 AP GE Reference Design")
>  	.init_irq	= orion5x_init_irq,
>  	.timer		= &orion5x_timer,
>  	.fixup		= tag_fixup_mem32,
> +	.restart	= orion5x_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-orion5x/terastation_pro2-setup.c b/arch/arm/mach-orion5x/terastation_pro2-setup.c
> index 29f1526..632a861 100644
> --- a/arch/arm/mach-orion5x/terastation_pro2-setup.c
> +++ b/arch/arm/mach-orion5x/terastation_pro2-setup.c
> @@ -364,4 +364,5 @@ MACHINE_START(TERASTATION_PRO2, "Buffalo Terastation Pro II/Live")
>  	.init_irq	= orion5x_init_irq,
>  	.timer		= &orion5x_timer,
>  	.fixup		= tag_fixup_mem32,
> +	.restart	= orion5x_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-orion5x/ts209-setup.c b/arch/arm/mach-orion5x/ts209-setup.c
> index 31e51f9..62c156b 100644
> --- a/arch/arm/mach-orion5x/ts209-setup.c
> +++ b/arch/arm/mach-orion5x/ts209-setup.c
> @@ -329,4 +329,5 @@ MACHINE_START(TS209, "QNAP TS-109/TS-209")
>  	.init_irq	= orion5x_init_irq,
>  	.timer		= &orion5x_timer,
>  	.fixup		= tag_fixup_mem32,
> +	.restart	= orion5x_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-orion5x/ts409-setup.c b/arch/arm/mach-orion5x/ts409-setup.c
> index 0fbcc14..4e6ff75 100644
> --- a/arch/arm/mach-orion5x/ts409-setup.c
> +++ b/arch/arm/mach-orion5x/ts409-setup.c
> @@ -318,4 +318,5 @@ MACHINE_START(TS409, "QNAP TS-409")
>  	.init_irq	= orion5x_init_irq,
>  	.timer		= &orion5x_timer,
>  	.fixup		= tag_fixup_mem32,
> +	.restart	= orion5x_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
> index 6c75cd3..0a236dd 100644
> --- a/arch/arm/mach-orion5x/ts78xx-setup.c
> +++ b/arch/arm/mach-orion5x/ts78xx-setup.c
> @@ -627,4 +627,5 @@ MACHINE_START(TS78XX, "Technologic Systems TS-78xx SBC")
>  	.init_early	= orion5x_init_early,
>  	.init_irq	= orion5x_init_irq,
>  	.timer		= &orion5x_timer,
> +	.restart	= orion5x_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-orion5x/wnr854t-setup.c b/arch/arm/mach-orion5x/wnr854t-setup.c
> index b8be7d8..078c03f 100644
> --- a/arch/arm/mach-orion5x/wnr854t-setup.c
> +++ b/arch/arm/mach-orion5x/wnr854t-setup.c
> @@ -179,4 +179,5 @@ MACHINE_START(WNR854T, "Netgear WNR854T")
>  	.init_irq	= orion5x_init_irq,
>  	.timer		= &orion5x_timer,
>  	.fixup		= tag_fixup_mem32,
> +	.restart	= orion5x_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-orion5x/wrt350n-v2-setup.c b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
> index faf81a0..46a9778 100644
> --- a/arch/arm/mach-orion5x/wrt350n-v2-setup.c
> +++ b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
> @@ -267,4 +267,5 @@ MACHINE_START(WRT350N_V2, "Linksys WRT350N v2")
>  	.init_irq	= orion5x_init_irq,
>  	.timer		= &orion5x_timer,
>  	.fixup		= tag_fixup_mem32,
> +	.restart	= orion5x_restart,
>  MACHINE_END
> -- 
> 1.7.4.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
