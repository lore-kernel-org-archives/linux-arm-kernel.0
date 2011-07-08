From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Fri, 8 Jul 2011 13:37:27 +0200
Subject: [RFC PATCH v2 0/4] Core device subsystem
In-Reply-To: <1310115250-3859-1-git-send-email-marc.zyngier@arm.com>
References: <1310115250-3859-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAHXqBFJiovYq5x_JDAxikvFs-t1To6yC-1uajBJFRX_jwjvejA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/8 Marc Zyngier <marc.zyngier@arm.com>:
> There is a small number of devices that the core kernel needs very
> early in the boot process, namely an interrupt controller and a timer,
> long before the driver model is up and running.
>
> Most architectures implement this requirement by hardcoding the
> initialisation of a "well known" piece of hardware which is standard
> enough to work on any platform.
>
> This is very different on the ARM architecture, where platforms have a
> variety of interrupt controllers and timers. While the same hardcoding
> is possible (and is actually used), it makes it almost impossible to
> support several platforms in the same kernel.
>
> Though the device tree is helping greatly to solve this problem, some
> platform won't ever be converted to DT, hence the need to have a
> mechanism supporting a variety of information source. Early platform
> devices having been deemed unsuitable (complexity, abuse of various
> subsystems), this subsystem has been designed to provide the very
> minimal level of functionality.
>
> The "core device subsystem" offers a class based device/driver
> matching model, doesn't rely on any other subsystem, is very (too?)
> simple, and support getting information both from DT as well as from
> static data provided by the platform. It also gives the opportunity to
> define the probing order by offering a sorting hook at run-time.
[...]

I gave it some thought and it looks like your idea can be modified to
make it even less demanding on machine setup code.

For the DT case, all this can work without adding a single
board-specific code (even machine_desc->init_irq() is not needed).

of_init_core_device_class(class)
{
  int ids_count = 0;
  struct of_device_id *ids, *p;

  for_each_core_device_driver(drv, class)
    for_each_core_device_id(id, drv)
      ++ids_count;

  p = ids = kzalloc(...);

  for_each_core_device_driver(drv, class)
    for_each_core_device_id(id, drv) {
      p->compatible = id->name;
      p->data = drv;
    }

  // generate matching device list from devicetree

  if (class == CORE_DEV_CLASS_IRQ)
    // sort the list (for intc class)

  core_driver_init_class(class);
  // call above could use matched ids' data field for finding
  // driver struct instead of traversing the driver list again
}

For non-DT case, the board code would need to provide the devices with
core_device_register() in init_irq() or wherever is apropriate.

For simplicity I thing mixing static and DT initialization should not
be allowed (for a single machine) - then static/DT initialization
order won't matter.

I hope this is useful for you. :)

Best Regards,
Micha? Miros?aw
