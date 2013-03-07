From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 7 Mar 2013 12:55:41 -0700
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130307201133.42a6c44b@skate>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306202710.15a6aa2c@skate>
 <20130306202447.GA4916@obsidianresearch.com>
 <201303070337.43288.arnd@arndb.de> <20130307115817.3b3cad20@skate>
 <20130307173736.GA20840@obsidianresearch.com>
 <20130307201133.42a6c44b@skate>
Message-ID: <20130307195541.GA20695@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 08:11:33PM +0100, Thomas Petazzoni wrote:

>> The reason for this is quite simply to avoid this ugly boiler plate in
>> every mbus driver:

> Come on "ugly" ? It's three line of basic set up code, and it avoids
> hard-coding base addresses in the Device Tree. Not having hard-coded

It is ugly because it doesn't belong in a device driver, it is bus
specific setup code and leaking it out of the bus abstraction is bad.

> With your idea, the guy writing the board .dts file will have to think
> about what is the layout of the physical address space to find where
> to map his FPGA or its big NOR.

Bear in mind that an optimal allocator that doesn't leave any address
space holes and considers the power-of-two size restriction is midly
complex.

Building an optimal allocator is actually impossible if each device
driver does its own allocate_resources - you have to call
allocate_resources in the right order to get an optimal placement
(usually sorted from largest to smallest alignment)

Address allocation/assignment is bus specific nonsense and does not
belong in device drivers.

> I know you're proposing to make things dynamic by having the mbus
> driver patch the Device Tree once the driver figures out an available
> range to map a given device. But that doesn't make any sense: why write
> in the DT something that will anyway be overwritten later on?

Simply because the DT is supposed to have the address map for the
elements it describes. An OF node in the DT is expected to resolve
back to the the correct CPU address,

Stuff in the kernel depends on it, eg the sysfs names are constructed
using the address map:

$ ls -l /sys/bus/platform/devices/
lrwxrwxrwx    1 root     root            0 Mar  7 19:43 f1010078.thermal -> ../../../devices/platform/internal.0/f1010078.thermal
lrwxrwxrwx    1 root     root            0 Mar  7 19:43 f1010100.gpio -> ../../../devices/platform/internal.0/f1010100.gpio
lrwxrwxrwx    1 root     root            0 Mar  7 19:43 f1010140.gpio -> ../../../devices/platform/internal.0/f1010140.gpio
[..]

So if you don't have correct address mapping through the DT then
addressing used by the core OF code is wrong, and the mechanism it
uses to avoid name conflicts is broken. Subtle Badness!

The 'DT must describe the hardware' litany is 90% correct but misses
that a critical function of DT is to describe the *address map*.

So you need to leave a placeholder in the DT for the right value to
get stuffed in. Ranges is a logical place to do that. You can't do it in
the device driver because it that is too late. It must be done before
calling of_populate... - ie by the mbus driver, and the mbus driver
cannot be a simple-bus, like Arnd alluded to.

As far as the placeholder goes, the driver could could ignore it
completely, or try to use it as a default - falling back to dynamic,
and maybe interpret 0/-1 as 'do dynamic always'.

> Adding description of windows in the Device Tree can be added later on,
> in a completely DT backward compatible way, and the mvebu-devbus driver
> can be adjusted accordingly.

Hmm.. You could make a new DT that is compatible with an older kernel,
but once the mvebu_mbus_add_window is moved into the mbus driver it
would require an updated DT.

Jason
