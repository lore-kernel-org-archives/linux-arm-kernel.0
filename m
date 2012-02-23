From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 23 Feb 2012 04:26:18 +0100
Subject: [PATCH v2 03/19] ARM: at91: make matrix register base soc
 independent
In-Reply-To: <4F456997.50500@gmail.com>
References: <1329903585-30738-1-git-send-email-nicolas.ferre@atmel.com>
 <4b71fdf7ee746a09b7ee468aa3bc60d6c34d4c20.1329903206.git.nicolas.ferre@atmel.com>
 <4F456997.50500@gmail.com>
Message-ID: <20120223032618.GB20176@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:17 Thu 23 Feb     , Ryan Mallon wrote:
> On 22/02/12 20:39, Nicolas Ferre wrote:
> 
> > From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > 
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Cc: linux-usb at vger.kernel.org
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> 
> Looks okay, one comment (for future) below, but otherwise:
> 
> Reviewed-by: Ryan Mallon <rmallon@gmail.com>
> 
> <snip>
> 
> > diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
> > index 8bdba2a..5fd6fe8 100644
> > --- a/arch/arm/mach-at91/at91sam9263.c
> > +++ b/arch/arm/mach-at91/at91sam9263.c
> > @@ -306,6 +306,7 @@ static void __init at91sam9263_ioremap_registers(void)
> >  	at91sam926x_ioremap_pit(AT91SAM9263_BASE_PIT);
> >  	at91sam9_ioremap_smc(0, AT91SAM9263_BASE_SMC0);
> >  	at91sam9_ioremap_smc(1, AT91SAM9263_BASE_SMC1);
> > +	at91_ioremap_matrix(AT91SAM9263_BASE_MATRIX);
> 
> 
> Not necessarily for this patch set, but this list of functions is
> getting long enough that it could be abstracted away by a table.
> Something like:
> 
>   struct at91_sys_device {
> 	const char *name;
> 	void __iomem **base;
> 	const unsigned long mem_start;
> 	const unsigned long mem_size;
>   };
> 
>   ...
> 
>   static const struct
>   at91_sys_device at91sam9263_sys_devices[] __initconst = {
> 	{"PIT",	&at91_pit_base,
> 	 AT91SAM9263_BASE_PIT, AT91_PIT_SIZE},
> 	...
> 	{"matrix", &at91_matrix_base,
> 	 AT91SAM9263_BASE_MATRIX, AT91_MATRIX_SIZE},
>   }
> 
>   ...
> 
>   void __init
>   at91_ioremap_sys_devices(const struct at91_sys_device *devices,
> 			   int nr_devices)
>   {
> 	int i;
> 
> 	for (i = 0; i < nr_devices; i++) {
> 		void __iomem *base = *(dev[i].base);
> 
> 		base = ioremap(dev[i].mem_start, dev[i].mem_size);
> 		if (!base)
> 			panic("Impossible to ioremap AT91 %s\n",
> 			      dev[i].name);
>   }
we switch to the DT no need

Best Regards,
J.
