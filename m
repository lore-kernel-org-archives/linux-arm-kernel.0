From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Nov 2015 16:26:26 +0000
Subject: Grafting old platform drivers onto a new DT kernel
In-Reply-To: <5640B877.4020108@free.fr>
References: <563B3749.50701@free.fr> <20151105151559.GA16666@lunn.ch>
 <CABxcv=k5mzw_TDsD1eQna9+HY9aqCUd03YAc62750Gs--sMozw@mail.gmail.com>
 <5640B877.4020108@free.fr>
Message-ID: <20151109162626.GC8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 09, 2015 at 04:15:03PM +0100, Mason wrote:
> I tried compiling an ancient SDHCI driver on a v4.2 system. It crashes
> all over init because several host->ops functions are required, but the
> old driver does not define them:
> .reset
> .set_clock
> .set_bus_width
> .set_uhs_signaling
> 
> So I downgraded to an older v3.14 kernel, and that problem vanished.

Nothing to do with DT.  Everything to do with improvements happening as
the kernel moves forward, and out of tree drivers suffer because they're
not _in_tree_.

Having stuff out of mainline is painful for this very reason, especially
if no one maintains the driver with each kernel revision - you end up
with a huge delta which is then very time consuming to fix.

However, in this case, all you need to resolve there is to set those
mandatory methods to the appropriate library functions - the changes
which created the ops methods was part of an effort to change the
horrid SDHCI core layer to be more of a library, and to stop it
becoming a driver where every single line is conditional on a quirk
bit being set or clear.

> But I am having a problem with the IRQ setup.
> 
> # cat /proc/interrupts 
>             CPU0       CPU1       
>  18:         93          0      irq0   1 Level     serial
>  55:       2832          0      irq0  38 Level     26000.ethernet
>  60:          0          0      irq0  43 Edge      mmc0
> 211:        319       2603       GIC  29 Edge      twd
> 
> Ethernet is using IRQ 38, as specified in the DT.
> mmc0 is supposed to use IRQ 60.
> 
> I see that the mmc0 has the index 60, so I must have messed up between
> the real irq (hwirq?) and the index Linux uses internally (virq?)
> 
> static struct resource sdhci_resources[] = {
> 	{
> 		.start	= TANGOX_SDIO0_BASE_ADDR,
> 		.end	= TANGOX_SDIO0_BASE_ADDR + 0x1ff,
> 		.flags	= IORESOURCE_MEM,
> 	},
> 	{
> 		.start	= 60,	/* SDHCI0 IRQ */
> 		.flags	= IORESOURCE_IRQ,
> 	},
> };

That tells the kernel to use interrupt 60, which is exactly what it
did.  To get interrupt 60 on the "irq0" controller, you need to look
up that interrupt - this would be a hack though:

+       struct device_node *np;
+
+       np = of_find_node_by_name(NULL, irq_controller_name);
+       if (np) {
+               struct of_phandle_args args;
+
+               args.np = np;
+               args.args[0] = irq - 1;
+               args.args_count = 1;
+
+               irq = irq_create_of_mapping(&args);
+               of_node_put(np);
+       }
+       return irq;

The _easiest_ way to get an old platform driver working at a basic level
with DT is:

1. Declare the device with that compatible value in your DT, with
   appropriate "reg" and "interrupts" properties.

2. If you need platform data for _any_ device, then use a .init_machine
   method in your platform code to call of_platform_populate() instead
   of using the generic version in customize_machine().  Pass the 3rd
   argument a struct of_dev_auxdata table, which allows you to bind
   platform data to the DT-created platform devices.  Set the bus-id
   for the device to the name of the device as it would have been
   originally created (in other words, the driver name, optionally
   followed by a period and a instance number.)

I don't think you have to modify the platform driver at all to make it
work (eg, you don't need an .of_match_table).  I've never used that
stuff, so there may be issues I don't know about.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
