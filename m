From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 14 Jun 2010 11:32:22 -0600
Subject: Platform data with function pointers
In-Reply-To: <-71663801230973480@unknownmsgid>
References: <-71663801230973480@unknownmsgid>
Message-ID: <AANLkTikqONUs722_ev6hqfpJiehUq2qAGWGhmxg6WkTs@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[cc'ing devicetree-discuss - this conversation should be kept on-list]

Hi Lorenzo,

On Mon, Jun 14, 2010 at 4:42 AM, Lorenzo Pieralisi
<Lorenzo.Pieralisi@arm.com> wrote:
> Hi Grant,
>
> Sorry to bother you, we had a chat about this at UDS, but I wanted to make sure I am doing it the PPC way.

Well, I wouldn't call it the PPC way.  PPC doesn't have a great
solution either.  A new approach is needed.  See below...

> When a platform_data pointer is initialized statically to a struct like e.g. the following:
> struct flash_platform_data {
> ? ? ? ?const char ? ? ?*map_name;
> ? ? ? ?const char ? ? ?*name;
> ? ? ? ?unsigned int ? ?width;
> ? ? ? ?int ? ? ? ? ? ? (*init)(void);
> ? ? ? ?void ? ? ? ? ? ?(*exit)(void);
> ? ? ? ?void ? ? ? ? ? ?(*set_vpp)(int on);
> ? ? ? ?void ? ? ? ? ? ?(*mmcontrol)(struct mtd_info *mtd, int sync_read);
> ? ? ? ?struct mtd_partition *parts;
> ? ? ? ?unsigned int ? ?nr_parts;
> };
>
> static struct flash_platform_data v2m_flash_data = {
> ? ? ? ?.map_name ? ? ? = "cfi_probe",
> ? ? ? ?.width ? ? ? ? ?= 4,
> ? ? ? ?.init ? ? ? ? ? = v2m_flash_init,
> ? ? ? ?.exit ? ? ? ? ? = v2m_flash_exit,
> ? ? ? ?.set_vpp ? ? ? ?= v2m_flash_set_vpp,
> };
>
> I think that the driver depending on a compatible property should initialize the platform_data pointer from FDT accordingly
> (dynamically, but there are function pointers in there, so they are not _really_ data). But how ? Do we compile in all existing
> static struct and pick off one depending on the compatible string ? Is there an example I can check in the PPC tree to port drivers
> the _proper_ way ?

There isn't a full example, partially because powerpc has mostly
avoided anonymous function pointers up to this point, and partially
because we don't have a good mechanism for handling it.

To start with, I must state that I really dislike platform data
because it is an anonymous pointer passed from mach code to the device
driver.  There is absolutely no type checking, and lots of opportunity
for a mismatch between the provided structure and what the driver
things it is provided.  I'm far more interested in passing parseable
data to the driver.

That being said, I completely understand the need to pass
mach-specific function pointers to a driver, and there are situations
where it must be done.

There is no single _proper_ way, but there are a number of options
depending on the situation.

One option is to build the mach specific functions into the
of_match_table for the driver.  Almost exactly like your suggestion of
compiling them in and choosing the correct one based on the matched
compatible value.  This works best if the mach code is well contained
and doesn't have to interact with other parts of mach code..  It also
works well if a lot of machines share the same hooks.  It keeps all
the driver code together, but it can get very unwieldy if a lot of
platforms need to add their custom code to a driver.  An example of
this can be seen in drivers/char/xilinx_hwicap/xilinx_hwicap.c.  Look
for the hwicap_of_match table.

If the function pointer truly is a one-off that isn't going to be
shared by other mach code, then I see two options (in both cases, I'm
assuming that the normal OF mechanisms are used to register the
devices).

1) Create a global function pointer to be populated by mach code.
Drivers would call the function at .probe() time and pass in a pointer
to the data structure.  Machine-specific code can then populate it
with the correct driver data including the function pointers.  This
works, and it preserves type safety, but it also lacks taste.  It
feels like an ugly hack to me.

2) In mach code, register a bus notifier before calling
of_platform_bus_probe().  Doing so ensures that the mach callback gets
called before a driver gets bound to the device.  Then mach code can
allocate and attach the correct platform data.  (See device_add() in
driver/base/core.c.  The bus notifiers get called before the driver is
probed with bus_probe_device()).  This solution is more elegant to me,
but it still has the problem of no type safety on the platform_data
pointer.

I'm open to other ideas on this if anyone else has a suggestion.

g.
