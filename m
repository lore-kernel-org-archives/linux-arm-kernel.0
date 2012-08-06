From: matt@genesi-usa.com (Matt Sealey)
Date: Mon, 6 Aug 2012 16:31:50 -0500
Subject: [PATCH 2/2] ARM i.MX5: Hard reset the IPU during startup
In-Reply-To: <20120605110834.GQ30400@pengutronix.de>
References: <1338888630-25930-1-git-send-email-s.hauer@pengutronix.de>
 <1338888630-25930-3-git-send-email-s.hauer@pengutronix.de>
 <20429.57208.228315.164637@ipc1.ka-ro> <20120605110834.GQ30400@pengutronix.de>
Message-ID: <CAKGA1bkA3eEHn4sM277mzcRT5OUyipW18-k-X0nK+T9rrotJNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 5, 2012 at 6:08 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Tue, Jun 05, 2012 at 12:29:12PM +0200, Lothar Wa?mann wrote:
>> Hi,
>>
>> Sascha Hauer writes:
>> >
>> How would you implement a seamless transition from a boot logo to the
>> application display when resetting the IPU during startup?
>
> I usually say to Robert: Make the bootloader fast enough so that nobody
> misses a splash from the bootloader. Robert is never happy with that
> answer...
>
> Is there any mainline compatible way to take over an initialized
> graphics core?

No.

There used to be an ATAG for finding the linear framebuffer and it's
details but it got removed. This
was from a long forgotten time when you could initialize a VGA
graphics card and never care that
it had an interrupt or not, since it never got used for your average,
simple linear framebuffer operations.
A device tree would be able to define (based on seeding that
information from the bootloader) this too,
and we have sample code of this working on a PPC system (Pegasos II)
which would initialize a
VGA graphics card using x86 emulation, set up the framebuffer using
faked BIOS calls and put that
information in the device tree for Linux to pick up using ofwfb.

Lothar;

The problem is on the IPU at least, having a running IDMAC channel
kind of means breaking all kinds of
good behavior in the transition between bootloader and kernel -
usually you can assume that
interrupts and caches are disabled, all DMA operations are halted/torn
down, and strange effects
happen obviously if this is not exactly true (on Pegasos II we had an
old firmware which accidentally
left USB running, and when Linux started.. all hell broke loose. At
random.). It would also assume that
the framebuffer memory was preserved, that the OS booting knew how to
use that exact framebuffer
format,

So, unless your LCDC is extremely dumb, and your OS extremely smart,
it can't be done. Robert and
Lothar, you will have to live with it. What some people do is get
clever inside the kernel, i.e. boot your
kernel as fast as possible as you said and then use fancy features
like precompiling the splash image
into the kernel, then using DMA to fill the screen buffer with data so
you have a working splash extremely
early in boot - and while the kernel is probing devices after the bare
minimum you architected, the DMA
unit is putting your penguin on the screen. There's no reason to
expect that display has to be configured
after USB, for example, and you can make your "real" display driver
hand-off much easier between initial
kernel setup and real driver inside the kernel, than trying to handle
it across the loader/kernel transitition.
I saw an article on this (may have been published and peer reviewed,
but also had a youtube video.. :)
that did this exact thing, it was a response to all those "5 second
boot" articles, on how to do it properly
on embedded systems. I'll see if I can find it.

There are plenty of things that you could do in the bootloader like
using DMA for instance (why not
use SDMA for relocation of the kernel if required?) in ways other than
accelerating the disk accesses,
and the same stuff can be done in the kernel to get to the "put a nice
screen up" stage even faster.

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
