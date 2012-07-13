From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Fri, 13 Jul 2012 02:49:54 -0700
Subject: [PATCH 0/6] KGDB/KDB FIQ (NMI) debugger
In-Reply-To: <CAMbhsRTeWgWyf2gcjr_TSr99Z6wL8bLmMGPYsTsVXoL-+A2Cyg@mail.gmail.com>
References: <20120705231034.GA16931@lizard>
 <CAMbhsRTeWgWyf2gcjr_TSr99Z6wL8bLmMGPYsTsVXoL-+A2Cyg@mail.gmail.com>
Message-ID: <20120713094954.GA12917@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2012 at 05:02:12PM -0700, Colin Cross wrote:
[...]
> KGDB can obviously only be enabled on development
> devices, although perhaps a more limited KDB could be left enabled.

Um, I would argue about 'obviously'. :-) It doesn't require
CONFIG_DEBUG_INFO (-g) or something like this, so if the concern is
the size (which is about 30..40 KB), then it is all manageable. If we
want it to be smaller, we should just work on making KGDB/KDB more
modular, so that we can exclude non-production features.

> > The FIQ debugger is a facility that can be used to debug situations
> > when the kernel stuck in uninterruptable sections, e.g. the kernel
> > infinitely loops or deadlocked in an interrupt or with interrupts
> > disabled. On some development boards there is even a special NMI
> > button, which is very useful for debugging weird kernel hangs.
> >
> > And FIQ is basically an NMI, it has a higher priority than IRQs, and
> > upon IRQ exception FIQs are not disabled. It is still possible to
> > disable FIQs (as well as some "NMIs" on other architectures), but via
> > special means.
> >
> > So, here FIQs and NMIs are synonyms, but in the code I use NMI term
> > for arch-independent code, and FIQs for ARM code.
> 
> Unfortunately, FIQs have been repurposed as secure interrupts on every
> ARM SoC that supports TrustZone, which is basically all of the latest
> generation, as well as a few of the previous generation.  When an FIQ
> arrives, the cpu traps into the secure mode, generally running a
> separate secure OS written by a 3rd party vendor.  We've tried to get
> some SoC secure implementations to drop out of secure mode and into
> the FIQ exception vector for specific irqs, with the registers set up
> to allow the FIQ handler to return back to the original execution
> point, but it's been successful.

It's pity, and this just shows that recent SOCs have a somewhat limited
debugging facilities. There are countless times when I was able to debug
a hang simply by hitting an NMI button on a reference board (not ARM,
tho) and just reading the trace.

Having any (even a watchdog) NMI connected to a kernel would be enough
to make things better. Btw, these patches' approach works even if we
can't reroute arbitrary interrupts to FIQs (like we do for serial lines).

[...]
> >   This might look as a drastic change, but it is not. There is actually
> >   no difference whether you have sync or async shell, or at least I
> >   couldn't find any use-case where this would matter at all. Anyways,
> >   it is still possible to do async shell in KDB, just don't see any
> >   need for this.
> 
> I think it could be an issue if KDB stopped execution whenever it
> received any character.  Serial ports are often noisy, especially when
> muxed over another port (we often use serial over the headset
> connector).  Noise on the async command line just causes characters
> that are ignored, on a command line that blocked execution noise would
> be catastrophic.

Aha, that's the real use-case, thanks! I started hacking the KDB
to add the async shell support, but then I realized that we still
don't need all the complexity. If the only purpose is to be safe from
the noise, then we can just do "knocking" before entering the debugger.

The thing is, we even have a standard sequence for entering KDB,
it is GDB-protocol command $3#33, so it actually makes sense to
implement this. This would be the only async command, and it doesn't
affect anything but the new code. I prepared a separate patch for this.

[...]
> One of the nice features in FIQ debugger is the "console" command,
> which causes all incoming serial characters to get passed to a console
> device provided by the FIQ debugger, and characters from the console
> to go out the serial port (when it is enabled).  That way you can
> still have the console when you want it, but only one driver talking
> to the hardware.

This is surely a nice feature, and we have a chance to make it work
with this scheme too. For example, we can reroute FIQ to IRQ, and
reinitialize the tty device, so that it would grab the IRQ, then we
can give uart back. Surely there are some implementation details
that makes it not that easy, but it is definitely doable.

Thanks!

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
