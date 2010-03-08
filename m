From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 8 Mar 2010 10:55:37 +0100
Subject: Compile problem due to compressor changes, UART referenced in
	section .txt
In-Reply-To: <4B9408ED.4060901@bluewatersys.com>
References: <Prayer.1.3.2.1003071719080.2280@hermes-2.csi.cam.ac.uk>
	<4B9408ED.4060901@bluewatersys.com>
Message-ID: <20100308095537.GC27502@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Mar 08, 2010 at 09:13:33AM +1300, Ryan Mallon wrote:
> J.I. Cameron wrote:
> > Dear  All,
> >
> > Ran into the following problem on a pxa stargate2 platform (I think it
> > will
> > effect a number of others).
> >
> > `UART' referenced in section `.text' of
> > arch/arm/boot/compressed/misc.o: defined in discarded section `.data'
> > of arch/arm/boot/compressed/misc.o `UART' referenced in section
> > `.text' of arch/arm/boot/compressed/misc.o: defined in discarded
> > section `.data' of arch/arm/boot/compressed/misc.o
> >
> > There is a hack in mach-pxa/include/mach/uncompress.h
> > that changes the primary uart for some platforms:
> >
> > static inline void arch_decomp_setup(void)
> > {
> >     if (machine_is_littleton() || machine_is_intelmote2()
> >         || machine_is_csb726() || machine_is_stargate2()
> >       || machine_is_cm_x300() || machine_is_balloon3())
> >     UART = STUART;
> > }
> >
> > Simply changing the initial assignment of UART and commenting this
> > function
> > out acts as a work around.  I'm not entirely sure how to fix the problem
> > properly.
> Perhaps something like this untested patch:
> 
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
> ---
> 
> diff --git a/arch/arm/mach-pxa/include/mach/uncompress.h b/arch/arm/mach-pxa/include/mach/uncompress.h
> index 237734b..efd9c0d 100644
> --- a/arch/arm/mach-pxa/include/mach/uncompress.h
> +++ b/arch/arm/mach-pxa/include/mach/uncompress.h
> @@ -15,7 +15,16 @@
>  
>  #define __REG(x)       ((volatile unsigned long *)x)
>  
> +#if defined(CONFIG_MACH_LITTLETON)  ||	\
> +    defined(CONFIG_MACH_INTELMOTE2) ||	\
> +    defined(CONFIG_MACH_CSB726)     ||	\
> +    defined(CONFIG_MACH_STARGATE2)  ||	\
> +    defined(CONFIG_MACH_CM_X300)    ||	\
> +    defined(CONFIG_MACH_BALLOON3)
> +static volatile unsigned long *UART = STUART;
> +#else
>  static volatile unsigned long *UART = FFUART;
> +#endif
This doesn't work for kernels that have support for both types of
machines.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
