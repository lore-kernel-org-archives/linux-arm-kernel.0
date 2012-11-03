From: pavel@denx.de (Pavel Machek)
Date: Sat, 3 Nov 2012 12:26:14 +0100
Subject: [PATCH for soc] socfpga: map uart into virtual address space so
 that early_printk() works
In-Reply-To: <20121029002724.GA27891@elf.ucw.cz>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <201210251458.48528.arnd@arndb.de>
 <20121027115615.GC5912@elf.ucw.cz>
 <201210271539.20156.arnd@arndb.de>
 <20121029002724.GA27891@elf.ucw.cz>
Message-ID: <20121103112614.GA27365@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Early printk code needs UART to be mapped early during
> boot. early_printk() is left there during the start-up; it is useful
> as our emulators are fairly slow.
> 
> Signed-off-by: Pavel Machek <pavel@denx.de>
> Acked-by: Dinh Nguyen <dinguyen@altera.com>

Could we get this one applied? No comments for quite a while... and it
is needed for machine not to crash with early_printk used...
								Pavel

> diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
> index ab81ea9..49fb62b 100644
> --- a/arch/arm/mach-socfpga/socfpga.c
> +++ b/arch/arm/mach-socfpga/socfpga.c
> @@ -37,6 +37,15 @@ static struct map_desc scu_io_desc __initdata = {
>  	.type		= MT_DEVICE,
>  };
>  
> +
> +
> +static struct map_desc uart_io_desc __initdata = {
> +	.virtual	= 0xfec02000,
> +	.pfn		= __phys_to_pfn(0xffc02000),
> +	.length		= SZ_8K,
> +	.type		= MT_DEVICE,
> +};
> +
>  static void __init socfpga_scu_map_io(void)
>  {
>  	unsigned long base;
> @@ -51,6 +60,8 @@ static void __init socfpga_scu_map_io(void)
>  static void __init socfpga_map_io(void)
>  {
>  	socfpga_scu_map_io();
> +	iotable_init(&uart_io_desc, 1);
> +	early_printk("Early printk initialized\n");
>  }
>  
>  const static struct of_device_id irq_match[] = {
> 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
