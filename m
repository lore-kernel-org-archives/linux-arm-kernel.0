From: dinguyen@altera.com (Dinh Nguyen)
Date: Fri, 25 Jan 2013 10:16:18 -0600
Subject: [PATCH 4/4] irqchip: gic: Perform the gic_secondary_init() call
 via CPU notifier
In-Reply-To: <1358963974-5496-5-git-send-email-catalin.marinas@arm.com>
References: <1358963974-5496-1-git-send-email-catalin.marinas@arm.com>
 <1358963974-5496-5-git-send-email-catalin.marinas@arm.com>
Message-ID: <1359130578.32148.1.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Wed, 2013-01-23 at 17:59 +0000, Catalin Marinas wrote:
> All the calls to gic_secondary_init() pass 0 as the first argument.
> Since this function is called on each CPU when starting, it can be done
> in a platform-independent way via a CPU notifier registered by the GIC
> code.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Daniel Walker <dwalker@fifo99.com>
> Cc: Bryan Huntsman <bryanh@codeaurora.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Dinh Nguyen <dinguyen@altera.com>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: Shiraz Hashim <shiraz.hashim@st.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> ---
> 
> Randomly chosen CPU notifier priority. I can add a definition somewhere
> though they don't seem to be used much and cause conflicts.
> 
>  arch/arm/mach-exynos/platsmp.c       |  8 --------
>  arch/arm/mach-highbank/platsmp.c     |  7 -------
>  arch/arm/mach-imx/platsmp.c          | 12 ------------
>  arch/arm/mach-msm/platsmp.c          |  8 --------
>  arch/arm/mach-omap2/omap-smp.c       |  7 -------
>  arch/arm/mach-shmobile/smp-emev2.c   |  7 -------
>  arch/arm/mach-shmobile/smp-r8a7779.c |  7 -------
>  arch/arm/mach-shmobile/smp-sh73a0.c  |  7 -------
>  arch/arm/mach-socfpga/platsmp.c      | 12 ------------

For socfpga, I get this error when I build for sofpga_defconfig:

drivers/gpio/gpio-pl061.c: In function ?pl061_irq_handler?:
drivers/gpio/gpio-pl061.c:183:2: error: implicit declaration of function
?chained_irq_enter? [-Werror=implicit-function-declaration]
drivers/gpio/gpio-pl061.c:192:2: error: implicit declaration of function
?chained_irq_exit? [-Werror=implicit-function-declaration]

Dinh
