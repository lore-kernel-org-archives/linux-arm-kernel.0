From: matt@genesi-usa.com (Matt Sealey)
Date: Sun, 7 Apr 2013 10:50:32 -0500
Subject: [RFC PATCH] CLK: Allow parent clock and rate to be configured in
 DT.
In-Reply-To: <20130407132623.GP1906@pengutronix.de>
References: <20130319170933.28337.50448.stgit@localhost>
 <CAOMZO5ASkvquyzPCEGObvB5Xh9bDPTJ2zx26eOUJT_Vb36Bn3Q@mail.gmail.com>
 <CAKGA1bkWLrOs15ni=8D__BvuG6kvqkeeLZGOLrVZY9g0q0z4Bg@mail.gmail.com>
 <6581638.FPkNsv6peb@flatron> <20130407132623.GP1906@pengutronix.de>
Message-ID: <CAKGA1b=AcQsA-P-pR+in+9CzqW=XfEBhdoR+AC7QCLYfUhQqJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 7, 2013 at 8:26 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Sat, Apr 06, 2013 at 03:21:19PM +0200, Tomasz Figa wrote:
>> Hi,
>>
>> [RANT]
>>
>> I tend to disagree about this whole hype about device tree usage for other
>> things than pure hardware description. I don't think device tree should be
>> a way to force some kind of new world order, but rather a more convenient
>> and more maintainable (than board files) way of support hardware platforms
>> in Linux kernel.
>
> Honestly I'm annoyed by this aswell. The devicetree contains a nice and
> complete hardware description and it seems convenient to put hardware
> related configuration data there aswell.

It's convenient because it means less work for one person; but I posit
that the work has already been done or the board would have never
passed post-production testing i.e. does this clock output correctly?
If so, then the code was written to make it do so. if it was not
integrated into the bootloader, this is an engineering problem easier
tackled by doing that than creating a whole new device tree binding.

The reason device tree, in my opinion, is not for "telling the OS how
to force reconfiguration of the hardware so it works," is simply
because engineering problems as above do not get tackled at all. If
you can write a completely awful bootloader that mis-configures the
board and causes myriad problems, but then get trapped in a cycle of
"Linux works fine, and we have a deadline, so.. fuck it" then what
you're doing is forcing the kind of awful code that we ended up with
in BSPs, the kind of awful code that existed BEFORE the move to device
tree.

In the case where we could "move the clko setup for SabreLite into the
device tree," this is an impetus we all agree on that we should not be
doing board-specific hacks if we can help it. But you don't move one
hack to another place and suddenly it quits being a hack. It will just
be someone else's responsibility.

> The problem is that hardware description and configuration data are two
> completely different sets of data. The hardware description is static
> for a given board and should (ideally) never change. The configuration
> data instead is often usecase specific and changes over the lifetime of
> a board. The configuration data can only handle a single (or maybe a
> table of) static setup(s). It's a good way to specify a sane default or
> a very special setup, but doesn't handle the case when some OS (or
> version thereof) wants to have a static setup and another wants to
> figure out the same data dynamically.



> For these reasons I am against throwing the two data sets into a single
> pot. Still I also want to have the devicetree way to configure some
> static setup items.

Well as I proposed, instead of having a special magic configuration
data and a backdoor to re-doing work that should be done elsewhere, we
should basically turn one of them into a kind of sanity check - it is
much, much more desirable for Linux to fudge around weirdly described
hardware and warn about it and there are many examples of this in the
Linux kernel. Embarrassingly, two of the examples are for Genesi
platforms on PowerPC, and one that immediately springs to mind is the
one about piix_smbus not finding a configured smbus address. This is a
problem in most VM BIOS implementations, since they do not have fans
to control, they don't bother implementing or virtualizing it or
telling the OS something is there (and it would require supporting a
ton of different fan controllers to figure different operating
systems), but Linux will always, always pop this warning up for me.
And it is correct to do so.. there are real life BIOS implementations
that do not contain any data about where the smbus controller is, and
most "A*** Super Overclock Fan Utility" on Windows are hardcoded for a
very specific PC model to work around this.

The sanity check is, in a properly described clock, you would list
it's suitable parents and the parent you THINK your hardware has set
right now - or, the only one your hardware CAN support. You can hijack
this a little such that if the parent is not the one in the DTB then
it gets set, with a warning (and for nitpickers like me, never turn on
this since we would prefer to fix our bootloader until it doesn't spit
a warning AND everything works).

For magic clock-frequency definition at the device level, this is best
done with power management in mind, the method will work everywhere
and have the same basic concept and binding, but it HAS to be
device-specific - not clock-specific or clock-subsystem specific. I do
not think it is the DTB's place to "tell Linux how to configure the
clock subsystem", just tell it where those clocks are and what the
current hardware settings are if they are not derivable from the
hardware itself. In the case we cannot tell by reading a register what
the current configuration is, or it is fundamentally more complicated
at the time of single clock initialization, then we need to provide
this data in the DTB anyway, and this binding would suit the
complicated version AND all the dirt simple implementations
(complicated version = has distinct benefit by abstracting the
hardware, simple version = effects a sanity check).

If we're dealing with audio codecs, fix the audio codec to accept a
*table* of possible clock values and if that hardware operates
differently per clock value, then add that data in there too (like the
cs42l52 audio codec). Where the software and hardware is a little more
dynamic, the same binding works here - and the usual trick is just
force one configuration possible out of many. The board designer can
look at all the possibilities and choose the one or two or all that
will work with the design, and it can go into the device tree.

In the case where we have a board design here where the clock
frequency MUST be set and MUST be fixed and MUST NEVER be changed
while it is running (i.e. audio codec and camera sharing a master
clock, and glitching the audio clock just to set it to the "right"
frequency would make the camera stop working), I can't approve of
anything proposed so far as it does not take this into account.
Remember, your device may not own the clock it is trying to use, and
you make it more difficult to coordinate between subsystems when
you're basically blanket hardcoding values in places. And I think the
"little overlay with configuration data" makes no sense when this is
entirely a bootloader vs. driver-that-doesn't-do-enough problem.

There are ways around every specific problem we're discussing here
without having magic, forced configuration tables. There will be ways
around having magic, forced configuration tables for everything else,
I guarantee it..

> Also board designers could describe the hardware and give one or more
> usage hints without forcing anybody to actually use them.

Usually the "hint" from a board designer is not really a hint, but the
only way the board was designed to work. You can't just "modify" their
suggestion on what clock to use, or the restrictions in place on
routing, signalling etc. at a whim just because it is configurable at
the SoC level. The device tree serves to tell Linux how the board was
designed, where things have been placed so it can abstract the
thousands upon thousands of lines of duplicated
platform_device_register lines and static data floating around. But
the original concept was that as the firmware booted, and initialized
all the devices capable of being used in the system, it would add each
one with it's post-initialization data to the device tree and pass
this to the OS so that it would not need to guess, or re-perform
initialization. And this is the point I would like to see stick -
Linux should not be manually re-initializing everything, reconfiguring
every little thing when the bootloader so carefully did it already.
There is a use case for catching fundamental flaws in the bootloader
setup and fixing them, but then you have a heady mix of boards which
specify EVERY configuration item possible and some which are very
simply descriptions of valid, usable state at bootloader->kernel
transition time.

That is a weird dichotomy to have and a decision to be made; do we put
all our effort into making the data fit into device tree or do we just
do it in the bootloader (which we would have had to have coded as real
platform test code before the boards passed production testing
anyway)? It is not a world I want to live in where the answer is NOT
to use the code written to pass production test in the bootloader.
Doing it in the device tree just means people who never learned about
board production, low level testing never, ever learn about that, and
those people TEND to make very strange decisions about what data needs
to be in the device tree. We already have with pinctrl - if the
bootloader set up pins already to boot from SD card, why do we specify
those pins again in Linux for it to configure them exactly the same
way, again? I know there are only a couple of blobs in the Babbage DT
that really need setting because U-Boot has already configured them
but they're in there - and Linux sets all those values again. Some of
the things it is setting up again, *IF* (and it is possible) it causes
a glitch in logic or an I/O direction change at any point can put the
board electrically in a completely undesirable state. 50,000 times
later your board is burnt, but how would you ever know this caused it?

I should also note, it is NOT simpler to add an entry to device tree
for configuration, since you need to write a binding that describes it
and a driver on the other side to parse the data the way the binding
describes to implement that configuration. Then you need to add the
entry to the device tree to test it. Why not use the minimal code
required to just set that hardware at a low level to the configuration
you wanted, at Boot ROM or Bootloader time, and describe that with the
bindings that already exist?

--
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
