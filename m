From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 28 Nov 2012 11:12:26 +0000
Subject: [rtc-linux] [PATCH v3 1/5] rtc: OMAP: Add system pm_power_off
 to rtc driver
In-Reply-To: <20121127154239.0efad6d5.akpm@linux-foundation.org>
References: <1353404927-14412-1-git-send-email-anilkumar@ti.com>
 <1353404927-14412-2-git-send-email-anilkumar@ti.com>
 <20121127154239.0efad6d5.akpm@linux-foundation.org>
Message-ID: <20121128111226.GX3332@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 03:42:39PM -0800, Andrew Morton wrote:
> > +	/* Do not allow to execute any other task */
> > +	spin_lock_irqsave(&lock, flags);
> > +	while (1);
> 
> I suspect this doesn't do what you want it to do.
> 
> Firstly, please provide adequate code comments here so that code
> readers do not also need to be mind readers.
> 
> If you want to stop this CPU dead in its tracks (why?) then
> 
> 	local_irq_disable();
> 	while (1)
> 		;		/* Note correct code layout */
> 
> will do it.  But it means that the NMI watchdog (if present) will come
> along and whack the machine in the head a few seconds later.  And this
> does nothing to stop other CPUs.
> 
> But not being a mind reader, I'm really at a loss to suggest what
> should be done here.  

It's hooking into the pm_power_off hook, which is called from kernel/sys.c
via arch code.  We will have already stopped all other CPUs at this point.

Why there's that while (1) there I don't know; when pm_power_off is not
hooked, we don't do anything like that - and what will happen in that
case is we'll return all the way back to sys_reboot(), which will call
do_exit(0) on us.

I don't see a problem with that, and I don't see why we need to spin
(without any power saving too) waiting for some event.  If we've called
sys_reboot with LINUX_REBOOT_CMD_POWER_OFF, we'd better have already
killed most of userspace off by that time anyway.
