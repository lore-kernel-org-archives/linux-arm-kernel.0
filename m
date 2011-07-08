From: rdunlap@xenotime.net (Randy Dunlap)
Date: Fri, 8 Jul 2011 11:16:35 -0700
Subject: [RFC PATCH v2 4/4] Core devices: documentation
In-Reply-To: <1310115250-3859-5-git-send-email-marc.zyngier@arm.com>
References: <1310115250-3859-1-git-send-email-marc.zyngier@arm.com>
	<1310115250-3859-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110708111635.0ce95be2.rdunlap@xenotime.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  8 Jul 2011 09:54:10 +0100 Marc Zyngier wrote:

> Add the documentation file for core devices.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  Documentation/core_devices.txt |  247 ++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 247 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/core_devices.txt
> 
> diff --git a/Documentation/core_devices.txt b/Documentation/core_devices.txt
> new file mode 100644
> index 0000000..5d1581f
> --- /dev/null
> +++ b/Documentation/core_devices.txt
> @@ -0,0 +1,247 @@
> +Core Device Subsystem:
> +=====================
> +
> +There is a small number of devices that the core kernel needs very

   There are

> +early in the boot process, namely an interrupt controller and a timer,
> +long before the driver model is up and running.
> +
> +Most architectures implement this requirement by hardcoding the
> +initialisation of a "well known" piece of hardware which is standard
> +enough to work on any platform.
> +
> +This is very different on the ARM architecture, where platforms have a
> +variety of interrupt controllers and timers. While the same hardcoding
> +is possible (and is actually used), it makes it almost impossible to
> +support several platforms in the same kernel.
> +
> +Though the device tree is helping greatly to solve this problem, some
> +platform won't ever be converted to DT, hence the need to have a
> +mechanism supporting a variety of information source. Early platform

                                                 sources.

> +devices having been deemed unsuitable (complexity, abuse of various
> +subsystems), this subsystem has been designed to provide the very

s/,/;/

> +minimal level of functionality.
> +
> +The "core device subsystem" offers a class based device/driver
> +matching model, doesn't rely on any other subsystem, is very (too?)
> +simple, and support getting information both from DT as well as from

               supports

> +static data provided by the platform. It also gives the opportunity to
> +define the probing order by offering a sorting hook at run-time.
> +
> +As for the Linux driver model, the core device subsystem deals mainly
> +with device and driver objects. It also has the notion of "class" to
> +designate a group of devices implementing the same functionality, and
> +a group of drivers to be matched against the above devices
> +(CORE_DEV_CLASS_TIMER for example).
> +
> +One of the features is that the whole subsystem is discarded once the
> +kernel has booted. No structures can or should be retained after the
> +device has been probed. Of course, no support for module or other

                                      there is no support ...

> +evolved features. Another design feature is that it is *NOT* thread
> +safe. If you need any kind of mutual exclusion, you're probably using
> +core devices for something they are not designed for.
> +
> +* Core Device:
> +  ===========


[snip]


> +* Core driver:
> +  ===========


[snip]


> +* Device/Driver matching:
> +  ======================
> +
> +The core kernel code directly controls when devices and drivers are
> +matched (no matching-at-register-time) by calling:
> +
> +void core_driver_init_class(enum core_device_class class,
> +			    void (*sort)(struct list_head *));
> +
> +Where:
> +- class is one of CORE_DEV_CLASS_IRQ or CORE_DEV_CLASS_TIMER,
> +- sort is a pointer to a function sorting the device list before they
> +  are matched (NULL if unused).
> +

so the sort key ordering is not defined (or is user-defined), right?

> +When this function is called:
> +
> +- All devices registered in "class" are probed with the matching
> +  registered drivers
> +- Once the devices in the class have been tried against the compiled
> +  in drivers, they are removed from the list (whether they have
> +  actually been probed or not).
> +- If core devices have been dynamically allocated (by
> +  of_core_device_populate()), they are freed.
> +
> +For example:

[snip]



---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
