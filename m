From: yauhen.kharuzhy@promwad.com (Yauhen Kharuzhy)
Date: Thu, 29 Apr 2010 17:52:57 +0300
Subject: S3C6410 power management support status
In-Reply-To: <20100429140050.GA3410@sirena.org.uk>
References: <20100429124509.GA11290@jeknote.loshitsa1.net>
	<20100429140050.GA3410@sirena.org.uk>
Message-ID: <20100429145257.GA9592@jeknote.loshitsa1.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 29, 2010 at 03:00:51PM +0100, Mark Brown wrote:
> On Thu, Apr 29, 2010 at 03:45:09PM +0300, Yauhen Kharuzhy wrote:
> 
> > Can anybody explain current status of S3C6410 power management support
> > in mainline? Suspend-to-RAM looks completely broken in the current
> > Linus's git tree.
> 
> What problems are you experiencing?

1. I enabled RTC driver for S3C6410 (it is cannot be enabled without
modification of Kconfig) and CONFIG_SUSPEND.
2. echo +10 > /sys/class/rtc0/wakealarm && echo mem > /sys/power/state.

System didn't go to sleep with messages:

---
s3c_pm_enter(3)
s3c_pm_enter: No wake-up sources!
s3c_pm_enter: Aborting sleep
---

This is caused by following code:
---
#define any_allowed(mask, allow) (((mask) & (allow)) != (allow))

        if (!any_allowed(s3c_irqwake_intmask, s3c_irqwake_intallow) &&
            !any_allowed(s3c_irqwake_eintmask, s3c_irqwake_eintallow)) {
                printk(KERN_ERR "%s: No wake-up sources!\n", __func__);
                printk(KERN_ERR "%s: Aborting sleep\n", __func__);
                return -EINVAL;
        }
---

But s3c_irqwake_intallow is defined in arch/arm/mach-s3c64xx/include/mach/pm-core.h

---
/* make these defines, we currently do not have any need to change
 * the IRQ wake controls depending on the CPU we are running on */

#define s3c_irqwake_eintallow   ((1 << 28) - 1)
#define s3c_irqwake_intallow    (0)
---


-- 
Yauhen Kharuzhy
-----------------------------------------------------------
Promwad Innovation Company
22, Olshevskogo St.
Office 809
220073, Minsk, Belarus
Phone/Fax: +375 (17) 312-1246
E-mail: yauhen.kharuzhy@promwad.com
Skype: jekhor
Web: www.promwad.com
