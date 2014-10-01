From: pavel@denx.de (Pavel Machek)
Date: Wed, 1 Oct 2014 15:49:17 +0200
Subject: [PATCH 2/2] socfpga: support suspend to ram
In-Reply-To: <1411590449-9794-3-git-send-email-atull@opensource.altera.com>
References: <1411590449-9794-1-git-send-email-atull@opensource.altera.com>
 <1411590449-9794-3-git-send-email-atull@opensource.altera.com>
Message-ID: <20141001134917.GB12750@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Add code that requests that the sdr controller go into
> self-refresh mode.  This code is run from ocram.
> 
> This patch assumes that u-boot has already configured sdr:
>   sdr.ctrlcfg.lowpwreq.selfrfshmask = 3
>   sdr.ctrlcfg.lowpwrtiming.clkdisablecycles = 8
>   sdr.ctrlcfg.dramtiming4.selfrfshexit = 512

I'm not sure if we should make assumptions like that. u-boot is not
the only bootloader.

At the very least, it should go to comment in the code, not to changelog.

> +u32 socfpga_sdram_self_refresh(u32 sdr_base, u32 scu_base);
> +extern unsigned int socfpga_sdram_self_refresh_sz;

_sz -> size.

Is it ok to just copy code around?

> +/* Round up a pointer address to fix aligment for fncpy() */
> +static void *fncpy_align(void *ptr)
> +{
> +	u32 value = (u32)ptr;
> +
> +	if ((value & (FNCPY_ALIGN - 1)) != 0)
> +		value = ((value & ~(FNCPY_ALIGN - 1)) + FNCPY_ALIGN);
> +
> +	return (void *)value;
> +}

Don't we have a nice macro doing aligning?

I guess the if() is not neccessary.

> +static int socfpga_pm_suspend(unsigned long arg)
> +{
> +	u32 ret;
> +
> +	ret = socfpga_sdram_self_refresh_in_ocram((u32)sdr_ctl_base_addr,
> +						  (u32)socfpga_scu_base_addr);
> +
> +	pr_debug("%s self-refresh loops request=%d exit=%d\n", __func__,
> +		 ret & 0xffff, (ret >> 16) & 0xffff);
> +
> +	return 0;
> +}

return ret?


> +	.arch   armv7-a
> +	.text
> +	.align 3
> +
> +	/*
> +	 * socfpga_sdram_self_refresh
> +	 *
> +	 *  r0 : sdr_ctl_base_addr
> +	 *  r1 : socfpga_scu_base_addr
> +	 *  r2 : temp storage of register values
> +	 *  r3 : loop counter
> +	 *  r4 : temp storage of return value
> +	 *
> +	 *  return value: lower 16 bits: loop count going into self refresh
> +	 *                upper 16 bits: loop count exiting self refresh
> +	 */
> +ENTRY(socfpga_sdram_self_refresh)

r0, r1 are the parameters?

> @@ -77,6 +78,15 @@ void __init socfpga_sysmgr_init(void)
>  
>  	np = of_find_compatible_node(NULL, NULL, "altr,rst-mgr");
>  	rst_manager_base_addr = of_iomap(np, 0);
> +
> +	np = of_find_compatible_node(NULL, NULL, "altr,sdr-ctl");
> +	if (!np) {
> +		pr_err("SOCFPGA: Unable to find sdr-ctl\n");
> +		return;
> +	}
> +
> +	sdr_ctl_base_addr = of_iomap(np, 0);
> +	WARN_ON(!sdr_ctl_base_addr);
>  }
>  
>  static void __init socfpga_init_irq(void)

Actually, "sdr-ctl" is quite hard to understand. I guess it means
"sdram-control"? Should we do something like altr,sdram-ctrl-1.0, so
that we have way forward if hardware changes in future?

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
