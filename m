From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 Mar 2014 11:22:03 +0000
Subject: [PATCH 4/8] tty/serial: add generic serial earlycon
In-Reply-To: <1395436128-11244-5-git-send-email-robherring2@gmail.com>
References: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
 <1395436128-11244-5-git-send-email-robherring2@gmail.com>
Message-ID: <20140324112203.GD3850@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 09:08:44PM +0000, Rob Herring wrote:
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> new file mode 100644
> index 0000000..241757a
> --- /dev/null
> +++ b/drivers/tty/serial/earlycon.c
[...]
> +static void __iomem * __init earlycon_map(unsigned long paddr, size_t size)
> +{
> +	void __iomem *base;
> +#ifdef CONFIG_FIX_EARLYCON_MEM
> +	set_fixmap_nocache(FIX_EARLYCON_MEM_BASE, paddr & PAGE_MASK);
> +	base = (void __iomem *)__fix_to_virt(FIX_EARLYCON_MEM_BASE);
> +	base += paddr & ~PAGE_MASK;
> +#else
> +	base = ioremap_nocache(paddr, size);
> +#endif

Just curious why not set_fixmap_io (and plain ioremap)?

> +static int __init parse_options(struct earlycon_device *device,
> +				char *options)
> +{
[...]
> +	if (port->mapbase)
> +		port->membase = earlycon_map(port->mapbase, 64);

I would move the earlycon_map() call in setup_earlycon() (personal
preference, parse_options() implies just parsing the options rather than
having additional side-effects).

-- 
Catalin
