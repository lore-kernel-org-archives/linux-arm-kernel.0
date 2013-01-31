From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 31 Jan 2013 11:25:38 +0000
Subject: [PATCH v2 4/4] irqchip: gic: Perform the gic_secondary_init()
 call via CPU notifier
In-Reply-To: <alpine.LFD.2.02.1301291907340.6300@xanadu.home>
References: <1359476319-23720-1-git-send-email-catalin.marinas@arm.com>
 <1359476319-23720-5-git-send-email-catalin.marinas@arm.com>
 <alpine.LFD.2.02.1301291734140.6300@xanadu.home>
 <20130129231205.GA25176@MacBook-Pro.local>
 <alpine.LFD.2.02.1301291907340.6300@xanadu.home>
Message-ID: <20130131112538.GW23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 07:11:56PM -0500, Nicolas Pitre wrote:
> On Tue, 29 Jan 2013, Catalin Marinas wrote:
> > I would like to get them in as soon as possible (ideally 3.9) as AArch64
> > needs GIC support. I can base them on Rob's branch (already in -next)
> > and send them the same route (the arm-soc tree if Olof/Arnd are ok to
> > take them).
> 
> Well...  I'd prefer if my series was merged by RMK since this is mostly 
> core ARM code.  That is posing dependency issues.
> 
> I think I'll just ignore your change for now and we'll fix things up 
> during the v3.9-rc period.

Given that the ARM kernel seems to be rather broken at the moment, that's
not going to happen until the 32-bit kernel gets some loving attention to
make it work again.

Our primary responsibility is not to stuff the kernel with new features
as quickly as we possibly can.  It's to make sure that the kernel works,
and at the moment, it doesn't.  I'm not talking about ancient architectures.
I'm talking about platforms using ARMv6 and above - platforms with the GIC
which I'd be able to test this change on.

Realview EB (MPCore)
- Various failures yesterday but now works in my tree. Fixes queued for
  the next -rc.  (But the hardware randomly locks up during kernel boot,
  normally around the time when the CLCD is enabled, so this can't really
  be used for testing.)
OMAP4430SDP (Cortex A9)
- Fails to boot even with proper uImage addresses (no idea yet).  No
  kernel output.
OMAP3430LDP (Cortex A8 iirc)
- Ditto.  No kernel output.

I haven't tried Versatile Express yet as it has the TC2 tile on, and I
don't yet a boot loader on it which is capable of TFTP (which makes it
rather useless to me - I've been saying this for a time now but this is
probably the first time publically.)  I'm thinking about putting the
CA9x4 tile back on because that's a lot more functionally useful to me
than TC2.
