From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 29 Apr 2012 11:09:36 +0200
Subject: [PATCH v2] ARM: davinci: implement DEBUG_LL port choice
In-Reply-To: <DF0F476B391FA8409C78302C7BA518B63E9EA512@DBDE01.ent.ti.com>
References: <DF0F476B391FA8409C78302C7BA518B631800A8C@DBDE01.ent.ti.com>
 <1332408563-18444-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <DF0F476B391FA8409C78302C7BA518B63E9EA512@DBDE01.ent.ti.com>
Message-ID: <20120429090936.GR20039@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Apr 27, 2012 at 06:06:15PM +0000, Nori, Sekhar wrote:
> > diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> > index e0d236d..4c2fb44 100644
> > --- a/arch/arm/Kconfig.debug
> > +++ b/arch/arm/Kconfig.debug
> > @@ -108,6 +108,22 @@ choice
> >  		bool "Kernel low-level debugging on 9263, 9g45 and cap9"
> >  		depends on HAVE_AT91_DBGU1
> >  
> > +	config DEBUG_DAVINCI_UART0
> > +		bool "Kernel low-level debugging on Davinci using uart0"
> > +		depends on ARCH_DAVINCI_DM644x
> 
> I guess this is meant for the traditional DaVinci DM* devices.
> The correct "depends on" in that case is ARCH_DAVINCI_DMx. DM644x
> is just one of those DaVinci devices. Also, the config is better
> named DEBUG_DAVINCI_DMx_UART0 to remain consistent with the
> corresponding ARCH_ config.
> 
> > +	config DEBUG_DA8XX_UART1
> 
> I would prefer calling this DEBUG_DAVINCI_DA8XX_UART0 for the same
> reason of naming consistency with the corresponding ARCH_ config.
..._UART1, but otherwise ok.

> > +		bool "Kernel low-level debugging on DA8xx using uart1"
> > +		depends on ARCH_DAVINCI_DA8XX
> > +
> > +	config DEBUG_DA8XX_UART2
> > +		bool "Kernel low-level debugging on DA8xx using uart2"
> > +		depends on ARCH_DAVINCI_DA8XX
> > +
> > +	config DEBUG_TNETV107X_UART1
> > +		bool "Kernel low-level debugging on TNETV107x using uart1"
> > +		depends on ARCH_DAVINCI_TNETV107X
> 
> There should be some help text associated with each of these macros.
> 
> [...]
> 
> > diff --git a/arch/arm/mach-davinci/include/mach/debug-macro.S b/arch/arm/mach-davinci/include/mach/debug-macro.S
> 
> > +#ifndef UART_VIRTBASE
> > +#define UART_VIRTBASE IO_ADDRESS(UART_BASE)
> > +#endif
> 
> Prefer using tabs for indentation here..
*shrug*

> > -100:
> > +		.macro addruart, rp, rv, tmp
> > +		ldr     \rp, =UART_BASE
> > +		ldr     \rv, =UART_VIRTBASE
> 
> .. and here (after ldr)
ack

> 
> [...]
> 
> > diff --git a/arch/arm/mach-davinci/include/mach/uncompress.h b/arch/arm/mach-davinci/include/mach/uncompress.h
> 
> > -#define _DEBUG_LL_ENTRY(machine, phys, virt)			\
> > +#define _DEBUG_LL_ENTRY(machine, phys)				\
> >  	if (machine_is_##machine()) {				\
> > -		set_uart_info(phys, virt);			\
> > +		set_uart_info(phys);				\
> >  		break;						\
> >  	}
> 
> So, this throws a checkpatch error:
> 
> ERROR: Macros with complex values should be enclosed in parenthesis
Yeah, but the problem is not new and so it's IMHO right to keep it as
is. YMMV.

> I made changes for these issues and in the process also made sure the
> patch applies cleanly to latest kernel. Here is the updated patch I
> intend to queue for v3.5
> 
> Thanks,
> Sekhar
looks good, thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
