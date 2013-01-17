From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Jan 2013 23:40:01 -0500 (EST)
Subject: [PATCH 2/3] ARM: convert platform hotplug inline assembly to C
In-Reply-To: <1358391205-23943-2-git-send-email-robherring2@gmail.com>
References: <1358391205-23943-1-git-send-email-robherring2@gmail.com>
 <1358391205-23943-2-git-send-email-robherring2@gmail.com>
Message-ID: <alpine.LFD.2.02.1301162338420.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Jan 2013, Rob Herring wrote:

> From: Rob Herring <rob.herring@calxeda.com>
> 
> With the addition of set_auxcr/get_auxcr, all the hotplug inline assembly
> code for exynos, imx, realview, spear13xx and vexpress can be converted to
> C code.

That might not be all safe.  Please see
http://article.gmane.org/gmane.linux.ports.arm.kernel/209584


> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: Shiraz Hashim <shiraz.hashim@st.com>
> ---
>  arch/arm/mach-exynos/hotplug.c    |   57 ++++++-------------------------------
>  arch/arm/mach-imx/hotplug.c       |   19 ++++---------
>  arch/arm/mach-realview/hotplug.c  |   32 +++++----------------
>  arch/arm/mach-spear13xx/hotplug.c |   32 +++++----------------
>  arch/arm/mach-vexpress/hotplug.c  |   33 +++++----------------
>  5 files changed, 35 insertions(+), 138 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
> index c3f825b..5548fa3 100644
> --- a/arch/arm/mach-exynos/hotplug.c
> +++ b/arch/arm/mach-exynos/hotplug.c
> @@ -26,69 +26,30 @@
>  
>  static inline void cpu_enter_lowpower_a9(void)
>  {
> -	unsigned int v;
> -
>  	flush_cache_all();
> -	asm volatile(
> -	"	mcr	p15, 0, %1, c7, c5, 0\n"
> -	"	mcr	p15, 0, %1, c7, c10, 4\n"
> +	__flush_icache_all();
> +	dsb();
> +
>  	/*
>  	 * Turn off coherency
>  	 */
> -	"	mrc	p15, 0, %0, c1, c0, 1\n"
> -	"	bic	%0, %0, %3\n"
> -	"	mcr	p15, 0, %0, c1, c0, 1\n"
> -	"	mrc	p15, 0, %0, c1, c0, 0\n"
> -	"	bic	%0, %0, %2\n"
> -	"	mcr	p15, 0, %0, c1, c0, 0\n"
> -	  : "=&r" (v)
> -	  : "r" (0), "Ir" (CR_C), "Ir" (0x40)
> -	  : "cc");
> +	set_auxcr(get_auxcr() & ~0x40);
> +	set_cr(get_cr() & ~CR_C);
>  }
>  
>  static inline void cpu_enter_lowpower_a15(void)
>  {
> -	unsigned int v;
> -
> -	asm volatile(
> -	"	mrc	p15, 0, %0, c1, c0, 0\n"
> -	"	bic	%0, %0, %1\n"
> -	"	mcr	p15, 0, %0, c1, c0, 0\n"
> -	  : "=&r" (v)
> -	  : "Ir" (CR_C)
> -	  : "cc");
> -
> +	set_cr(get_cr() & ~CR_C);
>  	flush_cache_louis();
> +	set_auxcr(get_auxcr() & ~0x40);
>  
> -	asm volatile(
> -	/*
> -	* Turn off coherency
> -	*/
> -	"	mrc	p15, 0, %0, c1, c0, 1\n"
> -	"	bic	%0, %0, %1\n"
> -	"	mcr	p15, 0, %0, c1, c0, 1\n"
> -	: "=&r" (v)
> -	: "Ir" (0x40)
> -	: "cc");
> -
> -	isb();
>  	dsb();
>  }
>  
>  static inline void cpu_leave_lowpower(void)
>  {
> -	unsigned int v;
> -
> -	asm volatile(
> -	"mrc	p15, 0, %0, c1, c0, 0\n"
> -	"	orr	%0, %0, %1\n"
> -	"	mcr	p15, 0, %0, c1, c0, 0\n"
> -	"	mrc	p15, 0, %0, c1, c0, 1\n"
> -	"	orr	%0, %0, %2\n"
> -	"	mcr	p15, 0, %0, c1, c0, 1\n"
> -	  : "=&r" (v)
> -	  : "Ir" (CR_C), "Ir" (0x40)
> -	  : "cc");
> +	set_cr(get_cr() | CR_C);
> +	set_auxcr(get_auxcr() | 0x40);
>  }
>  
>  static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
> diff --git a/arch/arm/mach-imx/hotplug.c b/arch/arm/mach-imx/hotplug.c
> index 3dec962..1470c75 100644
> --- a/arch/arm/mach-imx/hotplug.c
> +++ b/arch/arm/mach-imx/hotplug.c
> @@ -18,24 +18,15 @@
>  
>  static inline void cpu_enter_lowpower(void)
>  {
> -	unsigned int v;
> -
>  	flush_cache_all();
> -	asm volatile(
> -		"mcr	p15, 0, %1, c7, c5, 0\n"
> -	"	mcr	p15, 0, %1, c7, c10, 4\n"
> +	__flush_icache_all();
> +	dsb();
> +
>  	/*
>  	 * Turn off coherency
>  	 */
> -	"	mrc	p15, 0, %0, c1, c0, 1\n"
> -	"	bic	%0, %0, %3\n"
> -	"	mcr	p15, 0, %0, c1, c0, 1\n"
> -	"	mrc	p15, 0, %0, c1, c0, 0\n"
> -	"	bic	%0, %0, %2\n"
> -	"	mcr	p15, 0, %0, c1, c0, 0\n"
> -	  : "=&r" (v)
> -	  : "r" (0), "Ir" (CR_C), "Ir" (0x40)
> -	  : "cc");
> +	set_auxcr(get_auxcr() & ~0x40);
> +	set_cr(get_cr() & ~CR_C);
>  }
>  
>  /*
> diff --git a/arch/arm/mach-realview/hotplug.c b/arch/arm/mach-realview/hotplug.c
> index 53818e5..c17c8c0 100644
> --- a/arch/arm/mach-realview/hotplug.c
> +++ b/arch/arm/mach-realview/hotplug.c
> @@ -18,39 +18,21 @@
>  
>  static inline void cpu_enter_lowpower(void)
>  {
> -	unsigned int v;
> -
>  	flush_cache_all();
> -	asm volatile(
> -	"	mcr	p15, 0, %1, c7, c5, 0\n"
> -	"	mcr	p15, 0, %1, c7, c10, 4\n"
> +	__flush_icache_all();
> +	dsb();
> +
>  	/*
>  	 * Turn off coherency
>  	 */
> -	"	mrc	p15, 0, %0, c1, c0, 1\n"
> -	"	bic	%0, %0, #0x20\n"
> -	"	mcr	p15, 0, %0, c1, c0, 1\n"
> -	"	mrc	p15, 0, %0, c1, c0, 0\n"
> -	"	bic	%0, %0, %2\n"
> -	"	mcr	p15, 0, %0, c1, c0, 0\n"
> -	  : "=&r" (v)
> -	  : "r" (0), "Ir" (CR_C)
> -	  : "cc");
> +	set_auxcr(get_auxcr() & ~0x40);
> +	set_cr(get_cr() & ~CR_C);
>  }
>  
>  static inline void cpu_leave_lowpower(void)
>  {
> -	unsigned int v;
> -
> -	asm volatile(	"mrc	p15, 0, %0, c1, c0, 0\n"
> -	"	orr	%0, %0, %1\n"
> -	"	mcr	p15, 0, %0, c1, c0, 0\n"
> -	"	mrc	p15, 0, %0, c1, c0, 1\n"
> -	"	orr	%0, %0, #0x20\n"
> -	"	mcr	p15, 0, %0, c1, c0, 1\n"
> -	  : "=&r" (v)
> -	  : "Ir" (CR_C)
> -	  : "cc");
> +	set_cr(get_cr() | CR_C);
> +	set_auxcr(get_auxcr() | 0x40);
>  }
>  
>  static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
> diff --git a/arch/arm/mach-spear13xx/hotplug.c b/arch/arm/mach-spear13xx/hotplug.c
> index a7d2dd1..a38a087 100644
> --- a/arch/arm/mach-spear13xx/hotplug.c
> +++ b/arch/arm/mach-spear13xx/hotplug.c
> @@ -19,39 +19,21 @@
>  
>  static inline void cpu_enter_lowpower(void)
>  {
> -	unsigned int v;
> -
>  	flush_cache_all();
> -	asm volatile(
> -	"	mcr	p15, 0, %1, c7, c5, 0\n"
> -	"	dsb\n"
> +	__flush_icache_all();
> +	dsb();
> +
>  	/*
>  	 * Turn off coherency
>  	 */
> -	"	mrc	p15, 0, %0, c1, c0, 1\n"
> -	"	bic	%0, %0, #0x20\n"
> -	"	mcr	p15, 0, %0, c1, c0, 1\n"
> -	"	mrc	p15, 0, %0, c1, c0, 0\n"
> -	"	bic	%0, %0, %2\n"
> -	"	mcr	p15, 0, %0, c1, c0, 0\n"
> -	: "=&r" (v)
> -	: "r" (0), "Ir" (CR_C)
> -	: "cc", "memory");
> +	set_auxcr(get_auxcr() & ~0x40);
> +	set_cr(get_cr() & ~CR_C);
>  }
>  
>  static inline void cpu_leave_lowpower(void)
>  {
> -	unsigned int v;
> -
> -	asm volatile("mrc	p15, 0, %0, c1, c0, 0\n"
> -	"	orr	%0, %0, %1\n"
> -	"	mcr	p15, 0, %0, c1, c0, 0\n"
> -	"	mrc	p15, 0, %0, c1, c0, 1\n"
> -	"	orr	%0, %0, #0x20\n"
> -	"	mcr	p15, 0, %0, c1, c0, 1\n"
> -	: "=&r" (v)
> -	: "Ir" (CR_C)
> -	: "cc");
> +	set_cr(get_cr() | CR_C);
> +	set_auxcr(get_auxcr() | 0x40);
>  }
>  
>  static inline void spear13xx_do_lowpower(unsigned int cpu, int *spurious)
> diff --git a/arch/arm/mach-vexpress/hotplug.c b/arch/arm/mach-vexpress/hotplug.c
> index a141b98..74a9eb5 100644
> --- a/arch/arm/mach-vexpress/hotplug.c
> +++ b/arch/arm/mach-vexpress/hotplug.c
> @@ -18,40 +18,21 @@
>  
>  static inline void cpu_enter_lowpower(void)
>  {
> -	unsigned int v;
> -
>  	flush_cache_all();
> -	asm volatile(
> -		"mcr	p15, 0, %1, c7, c5, 0\n"
> -	"	mcr	p15, 0, %1, c7, c10, 4\n"
> +	__flush_icache_all();
> +	dsb();
> +
>  	/*
>  	 * Turn off coherency
>  	 */
> -	"	mrc	p15, 0, %0, c1, c0, 1\n"
> -	"	bic	%0, %0, %3\n"
> -	"	mcr	p15, 0, %0, c1, c0, 1\n"
> -	"	mrc	p15, 0, %0, c1, c0, 0\n"
> -	"	bic	%0, %0, %2\n"
> -	"	mcr	p15, 0, %0, c1, c0, 0\n"
> -	  : "=&r" (v)
> -	  : "r" (0), "Ir" (CR_C), "Ir" (0x40)
> -	  : "cc");
> +	set_auxcr(get_auxcr() & ~0x40);
> +	set_cr(get_cr() & ~CR_C);
>  }
>  
>  static inline void cpu_leave_lowpower(void)
>  {
> -	unsigned int v;
> -
> -	asm volatile(
> -		"mrc	p15, 0, %0, c1, c0, 0\n"
> -	"	orr	%0, %0, %1\n"
> -	"	mcr	p15, 0, %0, c1, c0, 0\n"
> -	"	mrc	p15, 0, %0, c1, c0, 1\n"
> -	"	orr	%0, %0, %2\n"
> -	"	mcr	p15, 0, %0, c1, c0, 1\n"
> -	  : "=&r" (v)
> -	  : "Ir" (CR_C), "Ir" (0x40)
> -	  : "cc");
> +	set_cr(get_cr() | CR_C);
> +	set_auxcr(get_auxcr() | 0x40);
>  }
>  
>  static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
> -- 
> 1.7.10.4
> 
