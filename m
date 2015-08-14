From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 14 Aug 2015 16:11:59 +0200
Subject: [PATCH] ARM: keystone: add a work around to handle asynchronous
 external abort
In-Reply-To: <55CDF579.4050408@ti.com>
References: <1439320409-20084-1-git-send-email-m-karicheri2@ti.com>
 <55CDF579.4050408@ti.com>
Message-ID: <1439561519.13210.55.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 14.08.2015, 10:04 -0400 schrieb Murali Karicheri:
> On 08/11/2015 03:13 PM, Murali Karicheri wrote:
> > Currently on some devices, an asynchronous external abort exception
> > happens during boot up when exception handlers are enabled in kernel
> > before switching to user space. This patch adds a workaround to handle
> > this once during boot. Many customers are already using this
> > with out any issues and is required to workaround the above issue.
> >
> > Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> > ---
> >   arch/arm/mach-keystone/keystone.c | 26 ++++++++++++++++++++++++++
> >   1 file changed, 26 insertions(+)
> >
> > diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
> > index e2880105..c1d0fe5 100644
> > --- a/arch/arm/mach-keystone/keystone.c
> > +++ b/arch/arm/mach-keystone/keystone.c
> > @@ -15,6 +15,7 @@
> >   #include <linux/of_platform.h>
> >   #include <linux/of_address.h>
> >   #include <linux/memblock.h>
> > +#include <linux/signal.h>
> >
> >   #include <asm/setup.h>
> >   #include <asm/mach/map.h>
> > @@ -52,6 +53,24 @@ static struct notifier_block platform_nb = {
> >   	.notifier_call = keystone_platform_notifier,
> >   };
> >
> > +static bool ignore_first = true;
> > +static int keystone_async_ext_abort_fault(unsigned long addr, unsigned int fsr,
> > +					  struct pt_regs *regs)
> > +{
> > +	/*
> > +	 * if first time, ignore this as this is a asynchronous external abort
> > +	 * happening only some devices that couldn't be root caused and we add
> > +	 * this work around to handle this first time.
> > +	 */
> > +	if (ignore_first) {
> > +		ignore_first = false;
> > +		return 0;
> > +	}
> > +
> > +	/* Subsequent ones should be handled as fault */
> > +	return 1;
> > +}
> > +
> >   static void __init keystone_init(void)
> >   {
> >   	if (PHYS_OFFSET >= KEYSTONE_HIGH_PHYS_START) {
> > @@ -61,6 +80,13 @@ static void __init keystone_init(void)
> >   	}
> >   	keystone_pm_runtime_init();
> >   	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> > +
> > +	/*
> > +	 * Add a one time exception handler to catch asynchronous external
> > +	 * abort
> > +	 */
> > +	hook_fault_code(17, keystone_async_ext_abort_fault, SIGBUS, 0,
> > +			"async external abort handler");
> >   }
> >
> >   static phys_addr_t keystone_virt_to_idmap(unsigned long x)
> >
> Can this be applied if it looks good?
> 
The keystone PCIe host driver already hooks the same fault code. Those
hooks are no chain, but a simple pointer, so one of those handlers is
going to loose out.

This likely isn't what you intended.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
