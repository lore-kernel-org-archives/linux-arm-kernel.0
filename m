From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Oct 2011 16:53:09 +0200
Subject: [PATCH 2/6] drivers/base: add bus for System-on-Chip devices
In-Reply-To: <20111018141520.GA10054@totoro>
References: <1318852378-14180-1-git-send-email-lee.jones@linaro.org>
	<201110181605.12512.arnd@arndb.de> <20111018141520.GA10054@totoro>
Message-ID: <201110181653.09425.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 October 2011, Jamie Iles wrote:
> I can't think of a system where it make sense to have this as a loadable 
> module so can't we just register the bus_type and never unregister it 
> like the platform and spi busses for example?

Good point. At least if we disallow unregistering soc_devices as I
suggested, there is certainly no point making the bus itself modular.

> Also, (and I'm right at the edge of my knowledge here!) wouldn't you 
> also need to add reference counting of the module when 
> creating/destroying a soc device to prevent the module and bus 
> disappearing whilst you had devices with a reference to it?

No, that's not necessary in a case like this: The bus module remains
pinned by the reference of the module calling it on each exported
symbol that is referenced. The reference counting is only needed
if driver module provides function pointers to the bus module
that might be in the middle of getting called while the driver is
removed. We have this case with the ux500_get_process function
that may be called through sysfs, so that would be a bug if the
code calling device_create_file() was in a module.

	Arnd
