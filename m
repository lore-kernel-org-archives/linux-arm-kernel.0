From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 06 Nov 2009 16:02:17 +0100
Subject: [PATCH 02/17] ARM: S5PC1XX: registers rename
In-Reply-To: <20091106031845.GG3913@prithivi.gnumonks.org>
References: <1255421482-26455-1-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-2-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-3-git-send-email-m.szyprowski@samsung.com>
	<20091106031845.GG3913@prithivi.gnumonks.org>
Message-ID: <000401ca5ef2$24a09240$6de1b6c0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday, November 06, 2009 4:19 AM, Harald Welte wrote:
 
> Hi Marek,
> 
> On Tue, Oct 13, 2009 at 10:11:07AM +0200, Marek Szyprowski wrote:
> 
> > S5PC110 and S5PC100 register maps differs in many places, rename all
> > defined registers to be S5PC100 specific. System map has been also updated
> > to cover more integrated peripherals.
> 
> The general idea of this patch is fine.  However, I have some questions:
> 
> >  /* System */
> > -#define S5PC100_PA_SYS		(0xE0100000)
> > -#define S5PC100_PA_CLK		(S5PC100_PA_SYS + 0x0)
> > -#define S5PC100_PA_PWR		(S5PC100_PA_SYS + 0x8000)
> > +#define S5PC100_PA_CLK		(0xE0100000)
> > +#define S5PC100_PA_CLK_OTHER	(0xE0200000)
> > +#define S5PC100_PA_PWR		(0xE0108000)
> 
> this is more like a rename.  Why was this done?  It would be good to explain in
> the commitlog

I renamed these registers to better match the chip specification. The 'SYS'
register name was borrowed from S3C64XX series and is a bit inadequate in C100.
 
> > +/* GPIO */
> > +#define S5PC100_PA_GPIO		(0xE0300000)
> > +#define S5PC1XX_PA_GPIO		S5PC100_PA_GPIO
> > +#define S5PC1XX_VA_GPIO		S3C_ADDR(0x00500000)
> 
> If the address is different for c100 and c110: why do we need a S5CP1XX_*
> definition?  In my personal opinion, all those compile-time defines are a
> kludge and we should not introduce more of them.  They will bite us in the back
> if we ever in the future want to build a kernel that can boot on both c100 and
> c110.

These C1XX defines were the first step to prepare the code for C110 support. 

S5PC110 register map differs completely from the S5PC100 one. These two SOCs
cannot be easily handled by the same kernel binary image without some hacks and
runtime fixups if we place them in the one kernel platform. Creating yet another
kernel platform just because of these differences would unnecessarily duplicate
a lot of code and would not use the potential of the current kernel
infrastructure (separate include directories, resource&device driver model, etc).

My idea was to introduce a sub-platforms in plat-s5pc1xx. Such sub-platforms
would be exclusive - one for C100 and one for C110. Each of the sub-platforms would
have its own include files (in mach-s5pc100 and mach-s5pc110 directories
respectively) and most of the chip differences can be handled in compile time by
proper macros. Macros for the common resources would use 'C1XX' names. In this
approach common resources (GPIO, DMA, io space and so on) can be easily defined
with C1XX defines. This also perfectly matches the current convention of common
S3C_XXX defines (i.e. S3C_PA_UART, S3C_PA_FB, S3C_VA_VICn, S3C_PA_HSMMCn, and so
on), so most of the code from arch/arm/plat-s3c/ can be reused without any
modifications. I assume that the S3C prefix would be renamed to SAMSUNG sometime
later.

Sub-platform can be easily defined by a simple choice command in
arch/arm/plat-s5pc1xx/Kconfig:

+choice
+        prompt "S5PC1xx SoC Type"
+        default ARCH_S5PC100
+
+config ARCH_S5PC100
+        bool "S5PC100"
+
+config ARCH_S5PC110
+        bool "S5PC110"
+
+endchoice

Then each sub-platform can be easily defined basing on the CONFIG_ARCH_S5PC100
and CONFIG_ARCH_S5PC110 defines.

Similar approach is used in OMAP platform (there is only one platform directory,
and the chip series is defined by a Kconfig choice option).

> >  	.io_pg_offst	= (((u32)S5PC1XX_VA_UART) >> 18) & 0xfffc,
> > -	.boot_params	= S5PC100_PA_SDRAM + 0x100,
> > +	.boot_params	= S5PC1XX_PA_SDRAM + 0x100,
> 
> This is the wrong kind of change, from my point of view.  We don't know yet
> if all future s5pc1xx products will also have the same address, do we?

Right, I missed this one.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
