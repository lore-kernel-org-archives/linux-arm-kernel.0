From: joshc@ni.com (Josh Cartwright)
Date: Thu, 19 Mar 2015 07:44:14 -0500
Subject: [PATCH v2] ARM: zynq: use restart_handler mechanism for slcr reset
In-Reply-To: <BL2FFO11OLC004560F6047881E93573D75E2010@BL2FFO11OLC004.protection.gbl>
References: <1425049769-24929-1-git-send-email-joshc@ni.com>
 <BL2FFO11OLC004560F6047881E93573D75E2010@BL2FFO11OLC004.protection.gbl>
Message-ID: <20150319124414.GG24619@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 11:44:23AM +0100, Michal Simek wrote:
> On 02/27/2015 04:09 PM, Josh Cartwright wrote:
[..]
> > +++ b/arch/arm/mach-zynq/slcr.c
> > @@ -15,6 +15,7 @@
> >   */
> >  
> >  #include <linux/io.h>
> > +#include <linux/reboot.h>
> >  #include <linux/mfd/syscon.h>
> >  #include <linux/of_address.h>
> >  #include <linux/regmap.h>
> > @@ -91,10 +92,9 @@ u32 zynq_slcr_get_device_id(void)
> >  	return val;
> >  }
> >  
> > -/**
> > - * zynq_slcr_system_reset - Reset the entire system.
> > - */
> > -void zynq_slcr_system_reset(void)
> > +static
> > +int zynq_slcr_system_restart(struct notifier_block *nb,
> > +			     unsigned long action, void *data)
> >  {
> 
> First of all sorry for delay.

No problem.  I suspect ZynqMP is keeping you busy.

> Any reason to remove kernel-doc format?

It didn't seem to provide anything meaningful, as it was just a
restatement of the function name, and since this function has become
static, it makes even less sense.

> The rest looks good and I have also tested it.

Great!

> BTW: was also thinking about syscon-reboot option but it doesn't fit to
> our reset sequence. :-(

Because of the code that handles this?

	/*
	 * Clear 0x0F000000 bits of reboot status register to workaround
	 * the FSBL not loading the bitstream after soft-reboot
	 * This is a temporary solution until we know more.
	 */

Has this FSBL bug been addressed?

I suspect we could also drop the zynq_slcr_unlock() as well...we unlock
the SLCR early at boot and don't lock it, AFAICT.

With those two pieces dropped, I think we'd fit the syscon-reboot model.

  Josh
