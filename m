From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Jan 2011 11:12:31 +0000
Subject: [PATCH 3/6] i2c/pxa2xx: Add PCI support for PXA I2C controller
In-Reply-To: <20110106105051.GA12146@www.tglx.de>
References: <1294246263-31960-1-git-send-email-bigeasy@linutronix.de>
	<1294246263-31960-4-git-send-email-bigeasy@linutronix.de>
	<20110105230342.GO8638@n2100.arm.linux.org.uk>
	<20110105230834.GA26399@suse.de>
	<20110106105051.GA12146@www.tglx.de>
Message-ID: <20110106111231.GD31708@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 06, 2011 at 11:50:51AM +0100, Sebastian Andrzej Siewior wrote:
> which functions are you talking about? I allocated one piece of memory
> which contained a platform device, ressources, platform data. It looked
> better than allocating multiple small chunks. I registered it with
> platform_device_register() and platform_device_unregister() complained
> about a missing ->release function.

Please see my email where I described the lifetime rules.  Let's say
your module is removed.  In doing so, you call platform_device_unregister()
followed by kfree().  After this, your module is removed from the system
and the memory backing the module code is unmapped.

If something holds a reference to the platform device, then that's just
waiting for an OOPS to happen.  When those references are finally given
up, your release function will be called - but the code has been unmapped.
That's one source of OOPS.  The second source of OOPS is that the platform
device will be dereferenced, but as you've already kfree'd it, the memory
could be used for some other purpose - in which case this manipulation of
what we think is still a platform device is going to corrupt some other
user.

If it hasn't been re-used, hopefully it's been poisoned, so you'll get
an OOPS from that instead.
