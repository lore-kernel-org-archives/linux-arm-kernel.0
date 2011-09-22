From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 22 Sep 2011 13:37:41 -0400 (EDT)
Subject: [PATCH] ARM: platform fixups: remove mdesc argument to fixup
	function
In-Reply-To: <E1R6kA4-0002vc-HZ@rmk-PC.arm.linux.org.uk>
References: <E1R6kA4-0002vc-HZ@rmk-PC.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1109221336470.12663@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Sep 2011, Russell King - ARM Linux wrote:

> Get rid of the mdesc pointer in the fixup function call.  No one uses
> the mdesc pointer, it shouldn't be modified anyway, and we can't wrap
> it, so let's remove it.  Updated for 3.1-rc6.
> 
> Platform files found by:
> 
>   $ regexp=$(git grep -h '\.fixup.*=' arch/arm |
> 		sed 's!.*= *\([^,]*\),* *!\1!' | sort -u |
> 		tr '\n' '|' | sed 's,|$,,;s,|,\\|,g')
>   $ git grep $regexp arch/arm
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

> ---
>  arch/arm/include/asm/mach/arch.h         |    3 +--
>  arch/arm/kernel/setup.c                  |    2 +-
>  arch/arm/mach-bcmring/arch.c             |    4 ++--
>  arch/arm/mach-clps711x/clep7312.c        |    3 +--
>  arch/arm/mach-clps711x/edb7211-arch.c    |    3 +--
>  arch/arm/mach-clps711x/fortunet.c        |    3 +--
>  arch/arm/mach-clps711x/p720t.c           |    3 +--
>  arch/arm/mach-footbridge/cats-hw.c       |    3 +--
>  arch/arm/mach-footbridge/netwinder-hw.c  |    3 +--
>  arch/arm/mach-msm/board-halibut.c        |    4 ++--
>  arch/arm/mach-msm/board-mahimahi.c       |    4 ++--
>  arch/arm/mach-msm/board-sapphire.c       |    4 ++--
>  arch/arm/mach-msm/board-trout.c          |    4 ++--
>  arch/arm/mach-orion5x/common.c           |    4 ++--
>  arch/arm/mach-orion5x/common.h           |    4 +---
>  arch/arm/mach-pxa/cm-x300.c              |    4 ++--
>  arch/arm/mach-pxa/corgi.c                |    4 ++--
>  arch/arm/mach-pxa/eseries.c              |    3 +--
>  arch/arm/mach-pxa/eseries.h              |    3 +--
>  arch/arm/mach-pxa/poodle.c               |    4 ++--
>  arch/arm/mach-pxa/spitz.c                |    4 ++--
>  arch/arm/mach-pxa/tosa.c                 |    4 ++--
>  arch/arm/mach-realview/core.c            |    3 +--
>  arch/arm/mach-realview/core.h            |    4 ++--
>  arch/arm/mach-realview/realview_pb1176.c |    3 +--
>  arch/arm/mach-realview/realview_pbx.c    |    6 +++---
>  arch/arm/mach-s3c2412/mach-smdk2413.c    |    3 +--
>  arch/arm/mach-s3c2412/mach-vstms.c       |    5 ++---
>  arch/arm/mach-sa1100/assabet.c           |    3 +--
>  arch/arm/mach-tegra/board-harmony.c      |    4 ++--
>  arch/arm/mach-tegra/board-paz00.c        |    4 ++--
>  arch/arm/mach-tegra/board-trimslice.c    |    4 ++--
>  32 files changed, 50 insertions(+), 66 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
> index 217aa19..c569998 100644
> --- a/arch/arm/include/asm/mach/arch.h
> +++ b/arch/arm/include/asm/mach/arch.h
> @@ -34,8 +34,7 @@ struct machine_desc {
>  	unsigned int		reserve_lp1 :1;	/* never has lp1	*/
>  	unsigned int		reserve_lp2 :1;	/* never has lp2	*/
>  	unsigned int		soft_reboot :1;	/* soft reboot		*/
> -	void			(*fixup)(struct machine_desc *,
> -					 struct tag *, char **,
> +	void			(*fixup)(struct tag *, char **,
>  					 struct meminfo *);
>  	void			(*reserve)(void);/* reserve mem blocks	*/
>  	void			(*map_io)(void);/* IO mapping function	*/
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index e514c76..f10fed0 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -861,7 +861,7 @@ static struct machine_desc * __init setup_machine_tags(unsigned int nr)
>  	}
>  
>  	if (mdesc->fixup)
> -		mdesc->fixup(mdesc, tags, &from, &meminfo);
> +		mdesc->fixup(tags, &from, &meminfo);
>  
>  	if (tags->hdr.tag == ATAG_CORE) {
>  		if (meminfo.nr_banks != 0)
> diff --git a/arch/arm/mach-bcmring/arch.c b/arch/arm/mach-bcmring/arch.c
> index a604b9e..31a1435 100644
> --- a/arch/arm/mach-bcmring/arch.c
> +++ b/arch/arm/mach-bcmring/arch.c
> @@ -136,8 +136,8 @@ static void __init bcmring_init_machine(void)
>  *
>  *****************************************************************************/
>  
> -static void __init bcmring_fixup(struct machine_desc *desc,
> -     struct tag *t, char **cmdline, struct meminfo *mi) {
> +static void __init bcmring_fixup(struct tag *t, char **cmdline,
> +	struct meminfo *mi) {
>  #ifdef CONFIG_BLK_DEV_INITRD
>  	printk(KERN_NOTICE "bcmring_fixup\n");
>  	t->hdr.tag = ATAG_CORE;
> diff --git a/arch/arm/mach-clps711x/clep7312.c b/arch/arm/mach-clps711x/clep7312.c
> index 67b5abb4..0a2e74f 100644
> --- a/arch/arm/mach-clps711x/clep7312.c
> +++ b/arch/arm/mach-clps711x/clep7312.c
> @@ -26,8 +26,7 @@
>  #include "common.h"
>  
>  static void __init
> -fixup_clep7312(struct machine_desc *desc, struct tag *tags,
> -	    char **cmdline, struct meminfo *mi)
> +fixup_clep7312(struct tag *tags, char **cmdline, struct meminfo *mi)
>  {
>  	mi->nr_banks=1;
>  	mi->bank[0].start = 0xc0000000;
> diff --git a/arch/arm/mach-clps711x/edb7211-arch.c b/arch/arm/mach-clps711x/edb7211-arch.c
> index 98ca5b2..725a7a5 100644
> --- a/arch/arm/mach-clps711x/edb7211-arch.c
> +++ b/arch/arm/mach-clps711x/edb7211-arch.c
> @@ -37,8 +37,7 @@ static void __init edb7211_reserve(void)
>  }
>  
>  static void __init
> -fixup_edb7211(struct machine_desc *desc, struct tag *tags,
> -	      char **cmdline, struct meminfo *mi)
> +fixup_edb7211(struct tag *tags, char **cmdline, struct meminfo *mi)
>  {
>  	/*
>  	 * Bank start addresses are not present in the information
> diff --git a/arch/arm/mach-clps711x/fortunet.c b/arch/arm/mach-clps711x/fortunet.c
> index b1cb479..1947b30 100644
> --- a/arch/arm/mach-clps711x/fortunet.c
> +++ b/arch/arm/mach-clps711x/fortunet.c
> @@ -57,8 +57,7 @@ typedef struct tag_IMAGE_PARAMS
>  #define IMAGE_PARAMS_PHYS	0xC01F0000
>  
>  static void __init
> -fortunet_fixup(struct machine_desc *desc, struct tag *tags,
> -		 char **cmdline, struct meminfo *mi)
> +fortunet_fixup(struct tag *tags, char **cmdline, struct meminfo *mi)
>  {
>  	IMAGE_PARAMS *ip = phys_to_virt(IMAGE_PARAMS_PHYS);
>  	*cmdline = phys_to_virt(ip->command_line);
> diff --git a/arch/arm/mach-clps711x/p720t.c b/arch/arm/mach-clps711x/p720t.c
> index cefbce0..3f796e0 100644
> --- a/arch/arm/mach-clps711x/p720t.c
> +++ b/arch/arm/mach-clps711x/p720t.c
> @@ -56,8 +56,7 @@ static struct map_desc p720t_io_desc[] __initdata = {
>  };
>  
>  static void __init
> -fixup_p720t(struct machine_desc *desc, struct tag *tag,
> -	    char **cmdline, struct meminfo *mi)
> +fixup_p720t(struct tag *tag, char **cmdline, struct meminfo *mi)
>  {
>  	/*
>  	 * Our bootloader doesn't setup any tags (yet).
> diff --git a/arch/arm/mach-footbridge/cats-hw.c b/arch/arm/mach-footbridge/cats-hw.c
> index 5b1a8db..206ff2f 100644
> --- a/arch/arm/mach-footbridge/cats-hw.c
> +++ b/arch/arm/mach-footbridge/cats-hw.c
> @@ -76,8 +76,7 @@ __initcall(cats_hw_init);
>   * hard reboots fail on early boards.
>   */
>  static void __init
> -fixup_cats(struct machine_desc *desc, struct tag *tags,
> -	   char **cmdline, struct meminfo *mi)
> +fixup_cats(struct tag *tags, char **cmdline, struct meminfo *mi)
>  {
>  	screen_info.orig_video_lines  = 25;
>  	screen_info.orig_video_points = 16;
> diff --git a/arch/arm/mach-footbridge/netwinder-hw.c b/arch/arm/mach-footbridge/netwinder-hw.c
> index 06e514f..4cbc2e6 100644
> --- a/arch/arm/mach-footbridge/netwinder-hw.c
> +++ b/arch/arm/mach-footbridge/netwinder-hw.c
> @@ -631,8 +631,7 @@ __initcall(nw_hw_init);
>   * the parameter page.
>   */
>  static void __init
> -fixup_netwinder(struct machine_desc *desc, struct tag *tags,
> -		char **cmdline, struct meminfo *mi)
> +fixup_netwinder(struct tag *tags, char **cmdline, struct meminfo *mi)
>  {
>  #ifdef CONFIG_ISAPNP
>  	extern int isapnp_disable;
> diff --git a/arch/arm/mach-msm/board-halibut.c b/arch/arm/mach-msm/board-halibut.c
> index 18a3c97..f81ef1f 100644
> --- a/arch/arm/mach-msm/board-halibut.c
> +++ b/arch/arm/mach-msm/board-halibut.c
> @@ -78,8 +78,8 @@ static void __init halibut_init(void)
>  	platform_add_devices(devices, ARRAY_SIZE(devices));
>  }
>  
> -static void __init halibut_fixup(struct machine_desc *desc, struct tag *tags,
> -				 char **cmdline, struct meminfo *mi)
> +static void __init halibut_fixup(struct tag *tags, char **cmdline,
> +				 struct meminfo *mi)
>  {
>  	mi->nr_banks=1;
>  	mi->bank[0].start = PHYS_OFFSET;
> diff --git a/arch/arm/mach-msm/board-mahimahi.c b/arch/arm/mach-msm/board-mahimahi.c
> index 7a9a03e..1df15aa 100644
> --- a/arch/arm/mach-msm/board-mahimahi.c
> +++ b/arch/arm/mach-msm/board-mahimahi.c
> @@ -53,8 +53,8 @@ static void __init mahimahi_init(void)
>  	platform_add_devices(devices, ARRAY_SIZE(devices));
>  }
>  
> -static void __init mahimahi_fixup(struct machine_desc *desc, struct tag *tags,
> -				 char **cmdline, struct meminfo *mi)
> +static void __init mahimahi_fixup(struct tag *tags, char **cmdline,
> +				  struct meminfo *mi)
>  {
>  	mi->nr_banks = 2;
>  	mi->bank[0].start = PHYS_OFFSET;
> diff --git a/arch/arm/mach-msm/board-sapphire.c b/arch/arm/mach-msm/board-sapphire.c
> index 68f930f..c6e043c 100644
> --- a/arch/arm/mach-msm/board-sapphire.c
> +++ b/arch/arm/mach-msm/board-sapphire.c
> @@ -77,8 +77,8 @@ static struct map_desc sapphire_io_desc[] __initdata = {
>  	}
>  };
>  
> -static void __init sapphire_fixup(struct machine_desc *desc, struct tag *tags,
> -				  char **cmdline, struct meminfo *mi)
> +static void __init sapphire_fixup(struct tag *tags, char **cmdline,
> +				  struct meminfo *mi)
>  {
>  	int smi_sz = parse_tag_smi((const struct tag *)tags);
>  
> diff --git a/arch/arm/mach-msm/board-trout.c b/arch/arm/mach-msm/board-trout.c
> index 8143867..7acd202 100644
> --- a/arch/arm/mach-msm/board-trout.c
> +++ b/arch/arm/mach-msm/board-trout.c
> @@ -48,8 +48,8 @@ static void __init trout_init_irq(void)
>  	msm_init_irq();
>  }
>  
> -static void __init trout_fixup(struct machine_desc *desc, struct tag *tags,
> -				char **cmdline, struct meminfo *mi)
> +static void __init trout_fixup(struct tag *tags, char **cmdline,
> +			       struct meminfo *mi)
>  {
>  	mi->nr_banks = 1;
>  	mi->bank[0].start = PHYS_OFFSET;
> diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
> index 0ab531d..22ace0b 100644
> --- a/arch/arm/mach-orion5x/common.c
> +++ b/arch/arm/mach-orion5x/common.c
> @@ -308,8 +308,8 @@ void __init orion5x_init(void)
>   * Many orion-based systems have buggy bootloader implementations.
>   * This is a common fixup for bogus memory tags.
>   */
> -void __init tag_fixup_mem32(struct machine_desc *mdesc, struct tag *t,
> -			    char **from, struct meminfo *meminfo)
> +void __init tag_fixup_mem32(struct tag *t, char **from,
> +			    struct meminfo *meminfo)
>  {
>  	for (; t->hdr.size; t = tag_next(t))
>  		if (t->hdr.tag == ATAG_MEM &&
> diff --git a/arch/arm/mach-orion5x/common.h b/arch/arm/mach-orion5x/common.h
> index 3e5499d..909489f 100644
> --- a/arch/arm/mach-orion5x/common.h
> +++ b/arch/arm/mach-orion5x/common.h
> @@ -53,11 +53,9 @@ int orion5x_pci_sys_setup(int nr, struct pci_sys_data *sys);
>  struct pci_bus *orion5x_pci_sys_scan_bus(int nr, struct pci_sys_data *sys);
>  int orion5x_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
>  
> -struct machine_desc;
>  struct meminfo;
>  struct tag;
> -extern void __init tag_fixup_mem32(struct machine_desc *, struct tag *,
> -				   char **, struct meminfo *);
> +extern void __init tag_fixup_mem32(struct tag *, char **, struct meminfo *);
>  
>  
>  #endif
> diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
> index b6a5134..d940e8a 100644
> --- a/arch/arm/mach-pxa/cm-x300.c
> +++ b/arch/arm/mach-pxa/cm-x300.c
> @@ -839,8 +839,8 @@ static void __init cm_x300_init(void)
>  	cm_x300_init_bl();
>  }
>  
> -static void __init cm_x300_fixup(struct machine_desc *mdesc, struct tag *tags,
> -				 char **cmdline, struct meminfo *mi)
> +static void __init cm_x300_fixup(struct tag *tags, char **cmdline,
> +				 struct meminfo *mi)
>  {
>  	/* Make sure that mi->bank[0].start = PHYS_ADDR */
>  	for (; tags->hdr.size; tags = tag_next(tags))
> diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
> index 185a37c..3e9483b 100644
> --- a/arch/arm/mach-pxa/corgi.c
> +++ b/arch/arm/mach-pxa/corgi.c
> @@ -705,8 +705,8 @@ static void __init corgi_init(void)
>  	platform_add_devices(devices, ARRAY_SIZE(devices));
>  }
>  
> -static void __init fixup_corgi(struct machine_desc *desc,
> -		struct tag *tags, char **cmdline, struct meminfo *mi)
> +static void __init fixup_corgi(struct tag *tags, char **cmdline,
> +			       struct meminfo *mi)
>  {
>  	sharpsl_save_param();
>  	mi->nr_banks=1;
> diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
> index b4599ec..e4a1f4d 100644
> --- a/arch/arm/mach-pxa/eseries.c
> +++ b/arch/arm/mach-pxa/eseries.c
> @@ -41,8 +41,7 @@
>  #include "clock.h"
>  
>  /* Only e800 has 128MB RAM */
> -void __init eseries_fixup(struct machine_desc *desc,
> -	struct tag *tags, char **cmdline, struct meminfo *mi)
> +void __init eseries_fixup(struct tag *tags, char **cmdline, struct meminfo *mi)
>  {
>  	mi->nr_banks=1;
>  	mi->bank[0].start = 0xa0000000;
> diff --git a/arch/arm/mach-pxa/eseries.h b/arch/arm/mach-pxa/eseries.h
> index 5930f5e..be92196 100644
> --- a/arch/arm/mach-pxa/eseries.h
> +++ b/arch/arm/mach-pxa/eseries.h
> @@ -1,5 +1,4 @@
> -void __init eseries_fixup(struct machine_desc *desc,
> -	struct tag *tags, char **cmdline, struct meminfo *mi);
> +void __init eseries_fixup(struct tag *tags, char **cmdline, struct meminfo *mi);
>  
>  extern struct pxa2xx_udc_mach_info e7xx_udc_mach_info;
>  extern struct pxaficp_platform_data e7xx_ficp_platform_data;
> diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
> index a113ea9..948ce3e 100644
> --- a/arch/arm/mach-pxa/poodle.c
> +++ b/arch/arm/mach-pxa/poodle.c
> @@ -454,8 +454,8 @@ static void __init poodle_init(void)
>  	poodle_init_spi();
>  }
>  
> -static void __init fixup_poodle(struct machine_desc *desc,
> -		struct tag *tags, char **cmdline, struct meminfo *mi)
> +static void __init fixup_poodle(struct tag *tags, char **cmdline,
> +				struct meminfo *mi)
>  {
>  	sharpsl_save_param();
>  	mi->nr_banks=1;
> diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
> index 438c7b5..d8dec91 100644
> --- a/arch/arm/mach-pxa/spitz.c
> +++ b/arch/arm/mach-pxa/spitz.c
> @@ -970,8 +970,8 @@ static void __init spitz_init(void)
>  	spitz_i2c_init();
>  }
>  
> -static void __init spitz_fixup(struct machine_desc *desc,
> -		struct tag *tags, char **cmdline, struct meminfo *mi)
> +static void __init spitz_fixup(struct tag *tags, char **cmdline,
> +			       struct meminfo *mi)
>  {
>  	sharpsl_save_param();
>  	mi->nr_banks = 1;
> diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
> index 9f69a26..402b0c9 100644
> --- a/arch/arm/mach-pxa/tosa.c
> +++ b/arch/arm/mach-pxa/tosa.c
> @@ -960,8 +960,8 @@ static void __init tosa_init(void)
>  	platform_add_devices(devices, ARRAY_SIZE(devices));
>  }
>  
> -static void __init fixup_tosa(struct machine_desc *desc,
> -		struct tag *tags, char **cmdline, struct meminfo *mi)
> +static void __init fixup_tosa(struct tag *tags, char **cmdline,
> +			      struct meminfo *mi)
>  {
>  	sharpsl_save_param();
>  	mi->nr_banks=1;
> diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
> index 5c23450..d5ed5d4 100644
> --- a/arch/arm/mach-realview/core.c
> +++ b/arch/arm/mach-realview/core.c
> @@ -517,8 +517,7 @@ void __init realview_timer_init(unsigned int timer_irq)
>  /*
>   * Setup the memory banks.
>   */
> -void realview_fixup(struct machine_desc *mdesc, struct tag *tags, char **from,
> -		    struct meminfo *meminfo)
> +void realview_fixup(struct tag *tags, char **from, struct meminfo *meminfo)
>  {
>  	/*
>  	 * Most RealView platforms have 512MB contiguous RAM at 0x70000000.
> diff --git a/arch/arm/mach-realview/core.h b/arch/arm/mach-realview/core.h
> index 5c83d1e..47259c8 100644
> --- a/arch/arm/mach-realview/core.h
> +++ b/arch/arm/mach-realview/core.h
> @@ -63,8 +63,8 @@ extern int realview_flash_register(struct resource *res, u32 num);
>  extern int realview_eth_register(const char *name, struct resource *res);
>  extern int realview_usb_register(struct resource *res);
>  extern void realview_init_early(void);
> -extern void realview_fixup(struct machine_desc *mdesc, struct tag *tags,
> -			   char **from, struct meminfo *meminfo);
> +extern void realview_fixup(struct tag *tags, char **from,
> +			   struct meminfo *meminfo);
>  extern void (*realview_reset)(char);
>  
>  #endif
> diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
> index ad5671a..de6b9fa 100644
> --- a/arch/arm/mach-realview/realview_pb1176.c
> +++ b/arch/arm/mach-realview/realview_pb1176.c
> @@ -316,8 +316,7 @@ static void realview_pb1176_reset(char mode)
>  	__raw_writel(REALVIEW_PB1176_SYS_SOFT_RESET, reset_ctrl);
>  }
>  
> -static void realview_pb1176_fixup(struct machine_desc *mdesc,
> -				  struct tag *tags, char **from,
> +static void realview_pb1176_fixup(struct tag *tags, char **from,
>  				  struct meminfo *meminfo)
>  {
>  	/*
> diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
> index 363b0ab..3e1eb2e 100644
> --- a/arch/arm/mach-realview/realview_pbx.c
> +++ b/arch/arm/mach-realview/realview_pbx.c
> @@ -319,8 +319,8 @@ static struct sys_timer realview_pbx_timer = {
>  	.init		= realview_pbx_timer_init,
>  };
>  
> -static void realview_pbx_fixup(struct machine_desc *mdesc, struct tag *tags,
> -			       char **from, struct meminfo *meminfo)
> +static void realview_pbx_fixup(struct tag *tags, char **from,
> +			       struct meminfo *meminfo)
>  {
>  #ifdef CONFIG_SPARSEMEM
>  	/*
> @@ -335,7 +335,7 @@ static void realview_pbx_fixup(struct machine_desc *mdesc, struct tag *tags,
>  	meminfo->bank[2].size = SZ_256M;
>  	meminfo->nr_banks = 3;
>  #else
> -	realview_fixup(mdesc, tags, from, meminfo);
> +	realview_fixup(tags, from, meminfo);
>  #endif
>  }
>  
> diff --git a/arch/arm/mach-s3c2412/mach-smdk2413.c b/arch/arm/mach-s3c2412/mach-smdk2413.c
> index 834cfb6..3391713 100644
> --- a/arch/arm/mach-s3c2412/mach-smdk2413.c
> +++ b/arch/arm/mach-s3c2412/mach-smdk2413.c
> @@ -92,8 +92,7 @@ static struct platform_device *smdk2413_devices[] __initdata = {
>  	&s3c_device_usbgadget,
>  };
>  
> -static void __init smdk2413_fixup(struct machine_desc *desc,
> -				  struct tag *tags, char **cmdline,
> +static void __init smdk2413_fixup(struct tag *tags, char **cmdline,
>  				  struct meminfo *mi)
>  {
>  	if (tags != phys_to_virt(S3C2410_SDRAM_PA + 0x100)) {
> diff --git a/arch/arm/mach-s3c2412/mach-vstms.c b/arch/arm/mach-s3c2412/mach-vstms.c
> index 83544eb..b6ed457 100644
> --- a/arch/arm/mach-s3c2412/mach-vstms.c
> +++ b/arch/arm/mach-s3c2412/mach-vstms.c
> @@ -129,9 +129,8 @@ static struct platform_device *vstms_devices[] __initdata = {
>  	&s3c_device_nand,
>  };
>  
> -static void __init vstms_fixup(struct machine_desc *desc,
> -				  struct tag *tags, char **cmdline,
> -				  struct meminfo *mi)
> +static void __init vstms_fixup(struct tag *tags, char **cmdline,
> +			       struct meminfo *mi)
>  {
>  	if (tags != phys_to_virt(S3C2410_SDRAM_PA + 0x100)) {
>  		mi->nr_banks=1;
> diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
> index 26257df..6290ce2 100644
> --- a/arch/arm/mach-sa1100/assabet.c
> +++ b/arch/arm/mach-sa1100/assabet.c
> @@ -301,8 +301,7 @@ static void __init get_assabet_scr(void)
>  }
>  
>  static void __init
> -fixup_assabet(struct machine_desc *desc, struct tag *tags,
> -	      char **cmdline, struct meminfo *mi)
> +fixup_assabet(struct tag *tags, char **cmdline, struct meminfo *mi)
>  {
>  	/* This must be done before any call to machine_has_neponset() */
>  	map_sa1100_gpio_regs();
> diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
> index 846cd7d..c78ce41 100644
> --- a/arch/arm/mach-tegra/board-harmony.c
> +++ b/arch/arm/mach-tegra/board-harmony.c
> @@ -123,8 +123,8 @@ static struct platform_device *harmony_devices[] __initdata = {
>  	&harmony_audio_device,
>  };
>  
> -static void __init tegra_harmony_fixup(struct machine_desc *desc,
> -	struct tag *tags, char **cmdline, struct meminfo *mi)
> +static void __init tegra_harmony_fixup(struct tag *tags, char **cmdline,
> +	struct meminfo *mi)
>  {
>  	mi->nr_banks = 2;
>  	mi->bank[0].start = PHYS_OFFSET;
> diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
> index ea2f79c..5e6bc77 100644
> --- a/arch/arm/mach-tegra/board-paz00.c
> +++ b/arch/arm/mach-tegra/board-paz00.c
> @@ -84,8 +84,8 @@ static void paz00_usb_init(void)
>  	platform_device_register(&tegra_ehci3_device);
>  }
>  
> -static void __init tegra_paz00_fixup(struct machine_desc *desc,
> -	struct tag *tags, char **cmdline, struct meminfo *mi)
> +static void __init tegra_paz00_fixup(struct tag *tags, char **cmdline,
> +	struct meminfo *mi)
>  {
>  	mi->nr_banks = 1;
>  	mi->bank[0].start = PHYS_OFFSET;
> diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-tegra/board-trimslice.c
> index 89a6d2a..652c340 100644
> --- a/arch/arm/mach-tegra/board-trimslice.c
> +++ b/arch/arm/mach-tegra/board-trimslice.c
> @@ -126,8 +126,8 @@ static void trimslice_usb_init(void)
>  	platform_device_register(&tegra_ehci1_device);
>  }
>  
> -static void __init tegra_trimslice_fixup(struct machine_desc *desc,
> -	struct tag *tags, char **cmdline, struct meminfo *mi)
> +static void __init tegra_trimslice_fixup(struct tag *tags, char **cmdline,
> +	struct meminfo *mi)
>  {
>  	mi->nr_banks = 2;
>  	mi->bank[0].start = PHYS_OFFSET;
> -- 
> 1.7.4.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
