From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 29 Aug 2016 21:57:20 +0200
Subject: [PATCH 06/33] ARM: pxa/lubbock: add GPIO driver for LUB_MISC_WR
 register
In-Reply-To: <E1beJk4-0000mH-4P@rmk-PC.armlinux.org.uk> (Russell King's
 message of "Mon, 29 Aug 2016 11:24:36 +0100")
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
 <E1beJk4-0000mH-4P@rmk-PC.armlinux.org.uk>
Message-ID: <87a8fve4bj.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King <rmk+kernel@armlinux.org.uk> writes:

..zip...
> diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
> index 7245f3359564..e974d1eb0f88 100644
> --- a/arch/arm/mach-pxa/lubbock.c
> +++ b/arch/arm/mach-pxa/lubbock.c
...zip...

> @@ -110,20 +111,18 @@ static unsigned long lubbock_pin_config[] __initdata = {
>  };
>  
>  #define LUB_HEXLED		__LUB_REG(LUBBOCK_FPGA_PHYS + 0x010)
> -#define LUB_MISC_WR		__LUB_REG(LUBBOCK_FPGA_PHYS + 0x080)
>  
>  void lubbock_set_hexled(uint32_t value)
>  {
>  	LUB_HEXLED = value;
>  }
>  
> +static struct gpio_chip *lubbock_misc_wr_gc;
> +
>  void lubbock_set_misc_wr(unsigned int mask, unsigned int set)
>  {
> -	unsigned long flags;
> -
> -	local_irq_save(flags);
> -	LUB_MISC_WR = (LUB_MISC_WR & ~mask) | (set & mask);
> -	local_irq_restore(flags);
> +	unsigned long m = mask, v = set;
> +	lubbock_misc_wr_gc->set_multiple(lubbock_misc_wr_gc, &m, &v);
If gpio_reg_init() failed (and I know, the probability of a lack of memory at
that stage of the kernel boot is ridiculous), this will end up as an NULL
pointer dereference if either IRDA or PCMCIA is used.

If it's expected, then the the pr_err() below would deserve a pr_crit(). I would
as well take an option on a "panic()" if lubbock_misc_wr_gc allocation fails. If
not, maybe a not-NULL test on lubbock_misc_wr_gc is in order, even if that would
be "hidding under the carpet" and rather difficult to debug later.

Apart this detail point, it's good for me.

Cheers.

-- 
Robert
