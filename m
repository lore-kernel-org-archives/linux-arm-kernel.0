From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 2 Mar 2012 15:07:56 +0000
Subject: [GIT PULL] i.MX3 patches
In-Reply-To: <20120302080105.GJ3852@pengutronix.de>
References: <20120302080105.GJ3852@pengutronix.de>
Message-ID: <201203021507.57409.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 March 2012, Sascha Hauer wrote:
> Hi Arnd,
> 
> Please pull the following i.MX3 specific patches for -next. Note
> that 1/2 depends on your imx/cleanup branch since it includes
> crmregs-imx3.h which is created in this branch.
> 
> The following changes since commit d65b4e98d7ea3038b767b70fe8be959b2913f16d:
> 
>   Linux 3.3-rc3 (2012-02-08 19:21:53 -0800)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/imx/linux-2.6.git features/imx3

Pulled into next/soc. 

I got a merge conflict against Nico's 4a3ea244 "ARM: plat-mxc: hook special idle
handlers to arm_pm_idle" and did the obvious merge below. Please complain
if this needs some other resolution.

Thanks,

	Arnd

diff --cc arch/arm/mach-imx/mm-imx3.c
index 8404ee7,35ce8b5..b23bd3f
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@@ -34,29 -34,33 +34,31 @@@ static void imx3_idle(void
  {
  	unsigned long reg = 0;
  
+ 	mx3_cpu_lp_set(MX3_WAIT);
+ 
 -	if (!need_resched())
 -		__asm__ __volatile__(
 -			/* disable I and D cache */
 -			"mrc p15, 0, %0, c1, c0, 0\n"
 -			"bic %0, %0, #0x00001000\n"
 -			"bic %0, %0, #0x00000004\n"
 -			"mcr p15, 0, %0, c1, c0, 0\n"
 -			/* invalidate I cache */
 -			"mov %0, #0\n"
 -			"mcr p15, 0, %0, c7, c5, 0\n"
 -			/* clear and invalidate D cache */
 -			"mov %0, #0\n"
 -			"mcr p15, 0, %0, c7, c14, 0\n"
 -			/* WFI */
 -			"mov %0, #0\n"
 -			"mcr p15, 0, %0, c7, c0, 4\n"
 -			"nop\n" "nop\n" "nop\n" "nop\n"
 -			"nop\n" "nop\n" "nop\n"
 -			/* enable I and D cache */
 -			"mrc p15, 0, %0, c1, c0, 0\n"
 -			"orr %0, %0, #0x00001000\n"
 -			"orr %0, %0, #0x00000004\n"
 -			"mcr p15, 0, %0, c1, c0, 0\n"
 -			: "=r" (reg));
 -	local_irq_enable();
 +	__asm__ __volatile__(
 +		/* disable I and D cache */
 +		"mrc p15, 0, %0, c1, c0, 0\n"
 +		"bic %0, %0, #0x00001000\n"
 +		"bic %0, %0, #0x00000004\n"
 +		"mcr p15, 0, %0, c1, c0, 0\n"
 +		/* invalidate I cache */
 +		"mov %0, #0\n"
 +		"mcr p15, 0, %0, c7, c5, 0\n"
 +		/* clear and invalidate D cache */
 +		"mov %0, #0\n"
 +		"mcr p15, 0, %0, c7, c14, 0\n"
 +		/* WFI */
 +		"mov %0, #0\n"
 +		"mcr p15, 0, %0, c7, c0, 4\n"
 +		"nop\n" "nop\n" "nop\n" "nop\n"
 +		"nop\n" "nop\n" "nop\n"
 +		/* enable I and D cache */
 +		"mrc p15, 0, %0, c1, c0, 0\n"
 +		"orr %0, %0, #0x00001000\n"
 +		"orr %0, %0, #0x00000004\n"
 +		"mcr p15, 0, %0, c1, c0, 0\n"
 +		: "=r" (reg));
  }
  
  static void __iomem *imx3_ioremap(unsigned long phys_addr, size_t size,
