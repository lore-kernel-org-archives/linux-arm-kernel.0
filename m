From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Jan 2012 17:50:28 +0000
Subject: [PATCH] ARM: PXA: Zipit Z2: Fix oops in z2_power_off
In-Reply-To: <201201091725.04631.marek.vasut@gmail.com>
References: <1326011616-3546-1-git-send-email-anarsoul@gmail.com>
 <201201091338.29680.marek.vasut@gmail.com>
 <20120109132100.GO21765@n2100.arm.linux.org.uk>
 <201201091725.04631.marek.vasut@gmail.com>
Message-ID: <20120109175028.GA7795@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2012 at 05:25:04PM +0100, Marek Vasut wrote:
> > On Mon, Jan 09, 2012 at 01:38:29PM +0100, Marek Vasut wrote:
> > > > On Mon, Jan 09, 2012 at 01:13:31PM +0100, Marek Vasut wrote:
> > > > > > 2012/1/9 Marek Vasut <marek.vasut@gmail.com>:
> > > > > > >> Nope, it does not work. Looks like device disables power on
> > > > > > >> memory in deepsleep.
> > > > > > > 
> > > > > > > Why?
> > > > > > 
> > > > > > In deepsleep PXA27x deasserts SYS_EN pin, and looks like when it's
> > > > > > deasserted there's no power on SDRAM (on Zipit). Just guess.
> > > > > 
> > > > > Then maybe implement suspend-to-disk ? There was a patch for omap on
> > > > > the list, maybe it's even merged.
> > > > 
> > > > What are hell you going on about?
> > > 
> > > Cool your jets Russell.
> > > 
> > > > Why would someone want to even try
> > > > implementing suspend-to-disk in the power off hook?
> > > 
> > > I'm not talking about the powerdown hook anymore, but a way how to avoid
> > > it as much as possible via standard means.
> > 
> > Maybe you should state that you are deviating from the subject of this
> > email thread to aid your readers understanding?
> 
> I think it was pretty clear already. OK

Sigh, stop fucking arguing Marek.  Plainly it wasn't, because YOUR READER
(in other words me) did not notice your spontaneous context switch.  It
might have been clear to you - you know your line of thought - but you
COMPLETELY FAILED to communicate it in effectively your email message.

> > > > Why would you even
> > > > want to try to preserve the system state in a power off hook?
> > > 
> > > Not in poweroff hook. Btw. I'm still convinced the bootloader should
> > > handle this -- the powerdown should just reset the thing and tell
> > > bootloader to deepsleep it.
> > 
> > Why should the boot loader be involved?  The boot loader is all about
> > bringing the system _up_, not taking it down.
> 
> Why would you bloat kernel with non-standard crap? The firmware should handle 
> this if the hardware is broken (and even if this sounds acpi-ish, I still 
> consider this particular thing should be handled by firmware). Especially since 
> what the device does in the end is simply restart anyway.

You talk about bloat, but I wonder if you've actually thought about what
you're proposing - I don't think you have.

Let's see: if we want to force people to add stuff to their boot loaders
to allow deep sleep power-off, then we need to have a way to tell the
boot loader to do that.

We're going to have to _add_ code to the kernel to find some way to tell
the boot loader that we want it to go to sleep.  We're going to have to
_add_ _more_ code to the kernel make a power off event cause a reboot.
Code is also going to have to be added to the boot loader to allow it to
understand that and implement the low power mode.

That's in addition to one simple function causing this problem, which is
already in the kernel, but gets discarded after init time:

int __init pxa27x_set_pwrmode(unsigned int mode)
{
        switch (mode) {
        case PWRMODE_SLEEP:
        case PWRMODE_DEEPSLEEP:
                pwrmode = mode;
                return 0;
        }

        return -EINVAL;
}

and this function equates to _less_ code than the solution you're proposing -
probably weighing in at around 8 instructions and probably one literal
pool entry.

No way are you going to implement functionality to tell the boot loader
what to do _and_ get the kernel to reboot in 8 instructions.

And you talk about bloat?  You really need to stand back and look at the
bigger picture, understand that what you're being completely unreasonable
with your demands - and trying to justify your ideas with arguments which
just don't stack up.

The z2 code stands.  I'm sure Eric will take a patch to remove the __init
attributation for it.  I'll even take such a patch into my fixes branch
for it.  It's a kernel oops bug, and _fixing_ it is worthwhile _even_ if
there isn't agreement with the method being used.
