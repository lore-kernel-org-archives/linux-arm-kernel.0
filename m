From: holt@sgi.com (Robin Holt)
Date: Thu, 9 May 2013 10:59:31 -0500
Subject: [PATCH -v8 11/11] Move arch/x86 reboot= handling to generic
 kernel.
In-Reply-To: <20130509133643.GU18614@n2100.arm.linux.org.uk>
References: <1367937595-32241-1-git-send-email-holt@sgi.com>
 <1367937595-32241-12-git-send-email-holt@sgi.com>
 <20130508103956.GA7677@gmail.com>
 <20130508182007.GO18614@n2100.arm.linux.org.uk>
 <518A9A83.5010306@zytor.com> <20130509112048.GT3672@sgi.com>
 <20130509130120.GW3672@sgi.com>
 <20130509133643.GU18614@n2100.arm.linux.org.uk>
Message-ID: <20130509155931.GY3672@sgi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 09, 2013 at 02:36:43PM +0100, Russell King - ARM Linux wrote:
> On Thu, May 09, 2013 at 08:01:20AM -0500, Robin Holt wrote:
> > diff --git a/include/linux/reboot.h b/include/linux/reboot.h
> > index 26cf11b..bc77231 100644
> > --- a/include/linux/reboot.h
> > +++ b/include/linux/reboot.h
> > @@ -15,6 +15,23 @@ enum reboot_mode {
> > +extern enum reboot_type reboot_type;
> > +
> > +extern int reboot_default;
> > +extern int reboot_cpu;
> > +extern int reboot_force;
> 
> Okay, these are globals...
> 
> > diff --git a/kernel/reboot.c b/kernel/reboot.c
> > index 0a97794..ff08af2 100644
> > --- a/kernel/reboot.c
> > +++ b/kernel/reboot.c
> > @@ -87,7 +88,7 @@ EXPORT_SYMBOL(unregister_reboot_notifier);
> >  static void migrate_to_reboot_cpu(void)
> >  {
> >  	/* The boot cpu is always logical cpu 0 */
> > -	int reboot_cpu = 0;
> > +	int reboot_cpu = reboot_cpu;
> 
> Hmm, are you sure about that?

Again, I am an idiot.  I will fix this.  Thank you.

> > @@ -343,3 +344,80 @@ int orderly_poweroff(bool force)
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(orderly_poweroff);
> > +
> > +int reboot_default;
> > +enum reboot_mode reboot_mode = REBOOT_COLD;
> > +int reboot_cpu;
> > +enum reboot_type reboot_type = BOOT_ACPI;
> > +int reboot_force;
> 
> As you seem to want to reference these above, wouldn't it make sense to
> move them higher in the file?
> 
> > +		case 'c':
> > +		case 'h':
> > +			reboot_mode = REBOOT_COLD;
> > +			break;
> 
> I'm still not entirely convinced by making "hard" and "cold" mean the
> same thing, likewise "soft" and "warm".  As I previously explained but
> everyone seems to have ignored, solely focusing on the 's' problem
> instead.

OK.  I took your earlier comments to mean you would tolerate this patch
as is.  I will make the -v9 introduce REBOOT_HARD, REBOOT_SOFT and make
their meaning consistent with what is there now.

Thanks,
Robin
