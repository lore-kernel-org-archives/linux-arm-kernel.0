From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 1 Aug 2010 02:53:28 +0200
Subject: [PATCH] PXA: Fix wakealarm capability for pxa-rtc
In-Reply-To: <87iq3vyx7d.fsf@free.fr>
References: <1280550147-12380-1-git-send-email-marek.vasut@gmail.com>
	<201008010213.24191.marek.vasut@gmail.com> <87iq3vyx7d.fsf@free.fr>
Message-ID: <201008010253.28319.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Ne 1. srpna 2010 02:48:38 Robert Jarzmik napsal(a):
> Marek Vasut <marek.vasut@gmail.com> writes:
> > Dne So 31. ?ervence 2010 23:07:06 Robert Jarzmik napsal(a):
> >> Marek Vasut <marek.vasut@gmail.com> writes:
> >> > Dne So 31. ?ervence 2010 17:38:06 Robert Jarzmik napsal(a):
> >> >> Marek Vasut <marek.vasut@gmail.com> writes:
> >> >> > The wakealarm capability was incorrectly set after the RTC was
> >> >> > registered, which resulted into the sysfs node not being created.
> >> >> 
> >> >> On my platform, without this patch:
> >> >> > cat /sys/devices/platform/pxa-rtc/power/wakeup
> >> >> > enabled
> >> >> 
> >> >> The sysfs node is created. What's the issue you're having ?
> >> > 
> >> > It's not created for me without this patch (and if you read the code,
> >> > it is impossible to be created without this patch).
> 
> Are we talking about the same /sys/devices/platform/pxa-rtc/power/wakeup ?
> Aren't you looking for /sys/class/rtc/rtc0/power/wakeup ?

I'm looking for /sys/class/rtc/rtc0/wakealarm

> 
> Because the code you're showing seems to be related to the class sysfs
> entries, not the driver's unless I'm mistaken.
> 
> I'll join Alessandro to the discussion, he might have some insight for [1].
> 
> Cheers.
> 
> --
> Robert
> 
> >> I read the code, and I see:
> >> rtc_device_register()
> >> 
> >>   -> device_register()
> >>   
> >>     -> device_initialize()
> >>     
> >>       -> device_init_wakeup(dev, 0)
> >> 
> >> So with or without your patch, device_init_wakeup() is called. The
> >> difference is that with your patch, we end up with a disabled wakeup
> >> capability. I showed the code sequence, your turn to show your "if you
> >> read the code".
> > 
> > drivers/rtc/rtc-sysfs.c
> > 
> > 217 static inline int rtc_does_wakealarm(struct rtc_device *rtc)
> > 218 {
> > 219         if (!device_can_wakeup(rtc->dev.parent))
> > 220                 return 0;
> > 221         return rtc->ops->set_alarm != NULL;
> > 222 }
> > 223
> > 224
> > 225 void rtc_sysfs_add_device(struct rtc_device *rtc)
> > 226 {
> > 227         int err;
> > 228
> > 229         /* not all RTCs support both alarms and wakeup */
> > 230         if (!rtc_does_wakealarm(rtc))
> > 231                 return;
> > 232
> > 233         err = device_create_file(&rtc->dev, &dev_attr_wakealarm);
> > 234         if (err)
> > 235                 dev_err(rtc->dev.parent,
> > 236                         "failed to create alarm attribute, %d\n",
> > err); 237 }
> > 
> > For me, it leaves the function on rtc_does_wakealarm(); That's because
> > device_can_wakeup on line 219 returns 0;
> > 
> > include/linux/pm_wakeup.h
> > 45 static inline bool device_can_wakeup(struct device *dev)
> > 46 {
> > 47         return dev->power.can_wakeup;
> > 48 }
> > 
> > This dev->power.can_wakeup is set by:
> > 
> > include/linux/pm_wakeup.h
> > 35 static inline void device_init_wakeup(struct device *dev, bool val)
> > 36 {
> > 37         dev->power.can_wakeup = dev->power.should_wakeup = val;
> > 38 }
> > 
> > But, the rtc_sysfs_add_device is called by:
> > 
> > drivers/rtc/class.c
> > 114 struct rtc_device *rtc_device_register(const char *name, struct
> > device *dev, 115                                         const struct
> > rtc_class_ops *ops, 116                                         struct
> > module *owner) 117 {
> > 
> > So the dev->power.can_wakeup must be set before registering the device.
> > 
> >> Moreover, my platform without your patch prooves that the sysfs entry is
> >> created.
> > 
> > My platform (sharp akita) without this patch doesn't even show the
> > wakealarm sysfs node. So something is certainly wrong in this driver,
> > explain what it is please.
> > 
> >> So unless you prove me wrong, I will reject the patch.
> > 
> > Ok, then I'd like to see you come up with better patch that actually
> > fixes my platform.
> > 
> >> Cheers.
> > 
> > Cheers
