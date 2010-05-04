From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 4 May 2010 01:29:15 +0100
Subject: S3C6410 power management support status
In-Reply-To: <20100429145257.GA9592@jeknote.loshitsa1.net>
References: <20100429124509.GA11290@jeknote.loshitsa1.net>
	<20100429140050.GA3410@sirena.org.uk>
	<20100429145257.GA9592@jeknote.loshitsa1.net>
Message-ID: <20100504002915.GS6684@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 29, 2010 at 05:52:57PM +0300, Yauhen Kharuzhy wrote:
> On Thu, Apr 29, 2010 at 03:00:51PM +0100, Mark Brown wrote:
> > On Thu, Apr 29, 2010 at 03:45:09PM +0300, Yauhen Kharuzhy wrote:
> > 
> > > Can anybody explain current status of S3C6410 power management support
> > > in mainline? Suspend-to-RAM looks completely broken in the current
> > > Linus's git tree.
> > 
> > What problems are you experiencing?
> 
> 1. I enabled RTC driver for S3C6410 (it is cannot be enabled without
> modification of Kconfig) and CONFIG_SUSPEND.
> 2. echo +10 > /sys/class/rtc0/wakealarm && echo mem > /sys/power/state.
> 
> System didn't go to sleep with messages:
> 
> ---
> s3c_pm_enter(3)
> s3c_pm_enter: No wake-up sources!
> s3c_pm_enter: Aborting sleep
> ---

Ok, this is interesting, the system shouldn't have allowed the RTC as a
wakeup soruce as the core currently doesn't deal with 64XX non-EINT
sources. However, at-least the core code did the right thing and refused
to go to sleep.

I will look into the RTC/non-EINT wakeup sources for these SoCs today
and see if the changes are easy enough to make.

> This is caused by following code:
> ---
> #define any_allowed(mask, allow) (((mask) & (allow)) != (allow))
> 
>         if (!any_allowed(s3c_irqwake_intmask, s3c_irqwake_intallow) &&
>             !any_allowed(s3c_irqwake_eintmask, s3c_irqwake_eintallow)) {
>                 printk(KERN_ERR "%s: No wake-up sources!\n", __func__);
>                 printk(KERN_ERR "%s: Aborting sleep\n", __func__);
>                 return -EINVAL;
>         }
> ---
> 
> But s3c_irqwake_intallow is defined in arch/arm/mach-s3c64xx/include/mach/pm-core.h
> 
> ---
> /* make these defines, we currently do not have any need to change
>  * the IRQ wake controls depending on the CPU we are running on */
> 
> #define s3c_irqwake_eintallow   ((1 << 28) - 1)
> #define s3c_irqwake_intallow    (0)
> ---

They'll get changed once we have support for the non-eint sources.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
