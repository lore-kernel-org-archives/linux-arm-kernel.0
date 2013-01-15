From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 15 Jan 2013 11:53:49 +0100
Subject: Early kernel hang with big DTB appended
In-Reply-To: <alpine.LFD.2.02.1301141655570.6300@xanadu.home>
References: <7811936.npteFbuYu2@amdc1227>
 <20130111164531.GC13025@pengutronix.de>
 <alpine.LFD.2.02.1301141655570.6300@xanadu.home>
Message-ID: <20130115105349.GK1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 05:13:09PM -0500, Nicolas Pitre wrote:
> On Fri, 11 Jan 2013, Sascha Hauer wrote:
> 
> > On Thu, Jan 03, 2013 at 04:55:00PM +0100, Tomasz Figa wrote:
> > > Hi,
> > > 
> > > I'm observing strange behavior when booting 3.8-rc1 and -rc2 with appended 
> > > DTB. The kernel hangs very early when the DTB is bigger than some 
> > > threshold somewhere around 24 KiB. With fullest possible low level UART 
> > > debugging (and printk patched to use printascii) I'm receiving following 
> > > output:
> > > 
> > > Uncompressing Linux... done, booting the kernel.
> > > Booting Linux on physical CPU 0xa00
> > > Linux version 3.8.0-rc1-00073-gdf6efca-dirty (t.figa at amdc1227) (gcc 
> > > version 4.5.2 (Gentoo 4.5.2 p1.2, pie-0.4.5) ) #2 SMP PREEMPT Thu Jan 3 
> > > 15:37:35 CET 2013
> > > CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c53c7d
> > > CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> > > 
> > > I tested on two Exynos-based boards (exynos4210-trats and one internal 
> > > exynos4412-based board) and same happens on both.
> > > 
> > > Do you have any ideas?
> > 
> > Another thing besides the things already mentioned is that the dtb may
> > not cross a 1MiB boundary. The Kernel uses a single 1Mib section
> > (aligned to 1Mib) to initially map the dtb. Once you cross that boundary
> > parts of the dtb won't be accessible for the Kernel anymore.
> 
> Crap.  You're right.  This patch should fix this issue.

Just successfully tested with a devicetree explicitly located just before a 1MiB
boundary, so:

Tested-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> 
> @Tomasz: please could you confirm this fixes your initial problem?
> 
> 
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index 4eee351f46..61fcb18c7e 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -246,6 +246,7 @@ __create_page_tables:
>  
>  	/*
>  	 * Then map boot params address in r2 if specified.
> +	 * We map 2 sections in case the ATAGs/DTB crosses a section boundary.
>  	 */
>  	mov	r0, r2, lsr #SECTION_SHIFT
>  	movs	r0, r0, lsl #SECTION_SHIFT
> @@ -253,6 +254,8 @@ __create_page_tables:
>  	addne	r3, r3, #PAGE_OFFSET
>  	addne	r3, r4, r3, lsr #(SECTION_SHIFT - PMD_ORDER)
>  	orrne	r6, r7, r0
> +	strne	r6, [r3], #1 << PMD_ORDER
> +	addne	r6, r6, #1 << SECTION_SHIFT
>  	strne	r6, [r3]
>  
>  #ifdef CONFIG_DEBUG_LL
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
