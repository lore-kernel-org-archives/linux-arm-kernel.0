From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 30 Jan 2014 20:39:00 -0800
Subject: recommended action for bootloaders regarding modifying
 device-tree nodes
In-Reply-To: <20140130204558.GC29184@titan.lakedaemon.net>
References: <CAJ+vNU366GiY4k_rnh1Jf0kra+PU99w4tDdM2sNioUAJCiZqOA@mail.gmail.com>
 <20140130204558.GC29184@titan.lakedaemon.net>
Message-ID: <CAJ+vNU2zis+1DUCzmegUFw+Z6XATBEPJ+yqMsttp4ENcckHUYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 12:45 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> Hi Tim,
>
> On Thu, Jan 30, 2014 at 01:11:18AM -0800, Tim Harvey wrote:
>> My approach has been to define a per-baseboard device-tree in Linux
>> for a 'fully loaded' board, then remove nodes which the EEPROM claims
>> are not present in the bootloader before it passes the DTB to the
>> kernel.  I do this by defining aliases in the device-tree for the
>> peripherals that are 'optional' so that the bootloader itself does not
>> need to know the details about how the device is connected.
>
> This is more of a process question:  Is there any information captured
> in your EEPROM that can't be represented in the dtb?  iow, at the point
> when you write the EEPROM, why not write the dtb to it as configured?
>
> You could have pre-configured dtsi fragments for each config option, and
> then dynamically create the board dts from the order.
>
> I only ask because it would solve the problem below.  However, there's a
> lot more to changing a manufacturing process than meets the eye. :)
>

our eeprom config section is only 40 bytes.  It contains a SKU string,
mac addrs, and some bitwise fields for the various optional components
that we can subload.

>> Is it more appropriate for the bootloader to 'remove' nodes for
>> devices that are not physically present or should I be setting their
>> status property to 'disabled' instead?  I'm not clear if either option
>> really has any pros or cons.
>
> That depends on how you have it structured.  Is it a valid dtb?
> Meaning, do you have four nodes all at the same register address?
> Perhaps you could provide an example dts?

yes its a valid dtb - it is just the superset of everything the
baseboard (ie schematic design) can support.

A good example is a custom SKU of a baseboard with ethernet subloaded.
 If the EEPROM says there is no ethernet mac or phy, I would want to
remove or disable the ethernet node from the devicetree.

Another example would be a node for 'gpio-pps' (GPIO based
pulse-per-second) support.  A baseboard design that has a GPS with its
PPS signal tied to a GPIO would define this in the device-tree, but if
the EEPROM says the GPS isn't loaded, I would want to remove or
disable the gps-pps node.

Tim

>
> thx,
>
> Jason.
>
>> Tim Harvey - Principal Software Engineer
>> Gateworks Corporation
>
> btw - one of my first embedded projects was on one of your boards. An
> ixp425 with 4 mini-pci slots.
>
