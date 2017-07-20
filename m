From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Jul 2017 17:27:51 +0100
Subject: [RFC WIP PATCH] arm: early console using bootloader framebuffer
In-Reply-To: <2a6c81485f354415a9f91ff1ef28340844396c48.1500566451.git.mirq-linux@rere.qmqm.pl>
References: <2a6c81485f354415a9f91ff1ef28340844396c48.1500566451.git.mirq-linux@rere.qmqm.pl>
Message-ID: <20170720162751.GD31807@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 06:03:51PM +0200, Micha? Miros?aw wrote:
> HACK WARNING:
>  - the asm code is not tested
>  - maybe should use fixmap?
>  - there's something similar called efifb in x86 arch

Hi.

I guess this is useful for some people, but I have concerns.

This shouldn't be done in terms of the "DEBUG_LL" stuff.  The DEBUG_LL
stuff is not designed to be multi-platform, it's designed as a last-ditch
method of debugging when other forms of kernel output have failed.  The
main requirement of the DEBUG_LL stuff is that it's usable from very
early on in the kernel assembly code, like from the first few
instructions in head.S, when the MMU is off.  This imposes quite a few
restrictions on the code.

Your code is not going to work with the MMU off, since you get the
virtual address of the 8x8 font, which is meaningless.

Rather than trying to bolt a framebuffer into the DEBUG_LL stuff,
please instead make the early printk support switchable between a
"DEBUG_LL" implementation and a framebuffer implementation.  It can
then live in early_printk.c rather than being spread around.

It seems that you may have already realised that, but not cleaned the
patch up - it's difficult to tell.  So, I think you need to remove
everything you don't need and re-submit.

> +	.macro	senduart, rd, rx, tmp1, tmp2
> +//	pushbyte \rd, \rx, \tmp1, \tmp2
> +	.endm

This commenting out disables the framebuffer code.

> +static void bootfb_stop(struct bootfd_tmp *info)
> +{
> +	unsigned short *p = info->ctl;
> +	unsigned short y = info->y, xoff = info->xoff;
> +
> +	if (xoff >= LINE_END) {
> +		if (++y >= FB_CHARS_HEIGHT) {
> +			y = 0;
> +			if (CONFIG_DEBUG_BOOTFB_PAGE_DELAY_MS)
> +				mdelay(CONFIG_DEBUG_BOOTFB_PAGE_DELAY_MS);

printk() can be called in non-schedulable contexts, mdelay requires a
context that can schedule.  Therefore, you can't use mdelay() here.

> diff --git a/arch/arm/kernel/debug.S b/arch/arm/kernel/debug.S
> index ea9646cc2a0e..34d961326a1e 100644
> --- a/arch/arm/kernel/debug.S
> +++ b/arch/arm/kernel/debug.S
> @@ -81,7 +81,11 @@ ENTRY(printascii)
>  		addruart_current r3, r1, r2
>  		b	2f
>  1:		waituart r2, r3
> +#ifdef CONFIG_DEBUG_LL_BOOT_FRAMEBUFFER
> +		senduart r1, r3, r2, ip

You can't use ip here.

>  static void early_write(const char *s, unsigned n)
>  {
>  	while (n-- > 0) {
> +#ifdef CONFIG_DEBUG_LL_BOOT_FRAMEBUFFER
> +		if (*s == '\n')
> +			early_bootfb_eol();
> +		else
> +			early_bootfb_write_char(*s);
> +#else

It would be nice if this were boot time selectable between implementations.

> @@ -1102,9 +1107,14 @@ void __init setup_arch(char **cmdline_p)
>  	/* Memory may have been removed so recalculate the bounds. */
>  	adjust_lowmem_bounds();
>  
> +	pr_crit("before early_ioremap_reset()\n");
> +	bootfb_skip_for_pageinit = 1;
> +
>  	early_ioremap_reset();
> +	pr_crit("after early_ioremap_reset()\n");
>  
>  	paging_init(mdesc);
> +	pr_crit("after paging_init()\n");
>  	request_standard_resources(mdesc);

These pr_crit()s clearly don't belong in a production version of the
patch.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
