From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 28 Jun 2014 00:03:12 +0100
Subject: [musl] Re: Thread pointer changes
In-Reply-To: <20140627222626.GA17988@brightrain.aerifal.cx>
References: <20140610072835.GA8466@brightrain.aerifal.cx>
 <20140611145533.GT179@brightrain.aerifal.cx>
 <53ADC5B1.6080905@amacapital.net>
 <20140627213743.GB16724@brightrain.aerifal.cx>
 <20140627220400.GT32514@n2100.arm.linux.org.uk>
 <20140627222626.GA17988@brightrain.aerifal.cx>
Message-ID: <20140627230312.GW32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 06:26:26PM -0400, Rich Felker wrote:
> Thus, my interest is in ensuring that, whenever the kuser helper page
> is disabled (or, as proposed, moved to a dynamic address), there's a
> safe and efficient way to detect this condition and know what to do to
> work around it.

Let me be clear: we are not going to move it to a dynamic address.
That's far too big a problem for the older architectures since
their caches alias all over the place.  Plus - and more importantly -
it means an ABI breakage across the board.

Let's say we did move it into a randomly mapped page in userspace.
We also need to keep the kuser page in place in order to support
existing libcs as well, but now we have not one but two places to
poke thread local values to - and we now have to flush the cache
line associated with that too, or have the kernel write directly
to that page in userspace.

We can't share those pages, because there's the danger that something
could write to the vectors page, and thus end up taking over the
whole machine.  Even if we did, we still have to flush the cache at
not just one location, but two.

As I've already pointed out, there's easier solutions to this problem
(using the ELF HWCAPS).

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
