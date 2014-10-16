From: msalter@redhat.com (Mark Salter)
Date: Thu, 16 Oct 2014 11:24:53 -0400
Subject: [PATCH 42/44] efi: Register poweroff handler with kernel
 poweroff handler
In-Reply-To: <20141016145927.GI14343@console-pimps.org>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-43-git-send-email-linux@roeck-us.net>
 <20141016145927.GI14343@console-pimps.org>
Message-ID: <1413473093.2985.15.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-10-16 at 15:59 +0100, Matt Fleming wrote:
> On Mon, 06 Oct, at 10:28:44PM, Guenter Roeck wrote:
> > Register with kernel poweroff handler instead of setting pm_power_off
> > directly. Register with low priority value of 64 since the efi code
> > states that this is a poweroff handler of last resort.
> > 
> > Cc: Matt Fleming <matt.fleming@intel.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/firmware/efi/reboot.c | 23 +++++++++++++++++++----
> >  1 file changed, 19 insertions(+), 4 deletions(-)
>  
> Looks OK to me. Mark?

Me too.

Acked-by: Mark Salter <msalter@redhat.com>

> 
> > diff --git a/drivers/firmware/efi/reboot.c b/drivers/firmware/efi/reboot.c
> > index 9c59d1c..c082439 100644
> > --- a/drivers/firmware/efi/reboot.c
> > +++ b/drivers/firmware/efi/reboot.c
> > @@ -3,6 +3,8 @@
> >   * Copyright (c) 2014 Red Hat, Inc., Mark Salter <msalter@redhat.com>
> >   */
> >  #include <linux/efi.h>
> > +#include <linux/notifier.h>
> > +#include <linux/pm.h>
> >  #include <linux/reboot.h>
> >  
> >  int efi_reboot_quirk_mode = -1;
> > @@ -38,19 +40,32 @@ bool __weak efi_poweroff_required(void)
> >  	return false;
> >  }
> >  
> > -static void efi_power_off(void)
> > +static int efi_power_off(struct notifier_block *this,
> > +			 unsigned long unused1, void *unused2)
> >  {
> >  	efi.reset_system(EFI_RESET_SHUTDOWN, EFI_SUCCESS, 0, NULL);
> > +
> > +	return NOTIFY_DONE;
> >  }
> >  
> > +static struct notifier_block efi_poweroff_nb = {
> > +	.notifier_call = efi_power_off,
> > +	.priority = 64,
> > +};
> > +
> >  static int __init efi_shutdown_init(void)
> >  {
> > +	int ret = 0;
> > +
> >  	if (!efi_enabled(EFI_RUNTIME_SERVICES))
> >  		return -ENODEV;
> >  
> > -	if (efi_poweroff_required())
> > -		pm_power_off = efi_power_off;
> > +	if (efi_poweroff_required()) {
> > +		ret = register_poweroff_handler(&efi_poweroff_nb);
> > +		if (ret)
> > +			pr_err("efi: Failed to register poweroff handler\n");
> > +	}
> >  
> > -	return 0;
> > +	return ret;
> >  }
> >  late_initcall(efi_shutdown_init);
> > -- 
> > 1.9.1
> 
> 
