From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 25 Jun 2010 15:46:02 -0700
Subject: [PATCH v2 1/3] OMAP: PM: initial runtime PM core support
In-Reply-To: <AANLkTimMnJvOJrRHDiE6PH1BXpRz2-6pY1M9nKHw7vpn@mail.gmail.com>
	(Grant Likely's message of "Fri, 25 Jun 2010 14:08:51 -0600")
References: <1277422991-25350-1-git-send-email-khilman@deeprootsystems.com>
	<1277422991-25350-2-git-send-email-khilman@deeprootsystems.com>
	<AANLkTim4p54brsmph6oaKfoEZwO1GOGfgRNV9vJykOjl@mail.gmail.com>
	<874ogrng3j.fsf@deeprootsystems.com>
	<AANLkTimMnJvOJrRHDiE6PH1BXpRz2-6pY1M9nKHw7vpn@mail.gmail.com>
Message-ID: <876316eno5.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely <grant.likely@secretlab.ca> writes:

> Another way to look at the problem is that these runtime
> customizations are kind of a property of the parent device (the bus,
> not the bus_type).  Would it make sense for parent devices to have
> runtime ops to perform for each child that is suspended/resumed?  That
> would make it simple to register another device that implements the
> bus behaviour and attach it at runtime instead of compile time.

Maybe I didn't fully understand your idea, but the problem here is
devices do not have dev_pm_ops.  Only busses, classes, and types have
dev_pm_ops.

Though I'm horribly unfamiliar with the intended usage of 'struct
device_type', an interesing discovery is that dev->type also has
dev_pm_ops, and it takes precedence over the bus type in the
suspend/resume.  IOW, when suspending, when deciding which dev_pm_ops to
use, it checks class, type, then bus in that order.

I need to explore this 'type' feature a little more, but using that or
the 'class' might be another way to have custom PM ops for certain
platform_devices.

Kevin
