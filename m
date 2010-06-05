From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 04 Jun 2010 22:29:11 -0400 (EDT)
Subject: Boot interface for device trees on ARM
In-Reply-To: <201006050933.06714.jeremy.kerr@canonical.com>
References: <201005181054.32325.jeremy.kerr@canonical.com>
	<alpine.LFD.2.00.1005191055180.12758@xanadu.home>
	<AANLkTilhqg270l-_m9raalqAPPRhvLJD9omHe8ysgLjg@mail.gmail.com>
	<201006050933.06714.jeremy.kerr@canonical.com>
Message-ID: <alpine.LFD.2.00.1006042212400.30664@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 5 Jun 2010, Jeremy Kerr wrote:

> All,
> 
> > > With this, the kernel can remain largely backward compatible with the
> > > legacy boot method, requiring _no_ change to the existing code, as the
> > > ID is sufficient to distinguish between both boot types.  The machine
> > > record remains largely relevant even for a DT boot as the majority of
> > > its content is SOC specific anyway, and given a per SOC ID for DT usage
> > > means that the early boot facilities are still usable as is even in the
> > > DT context.  And then the init_machine method in the machine record is
> > > naturally used to parse the device tree and do its work on multiple
> > > machines' behalf instead of relying on compiled-in static data for a
> > > specific machine.
> > 
> > There will still be instances of machine-specific setup code that
> > needs to be chosen at boot (based on the top level 'compatible'
> > property), but init_machine() appears to be early enough to handle
> > this.
> > 
> > hmmm... however, things the device tree blob and the initrd both need
> > to be marked as bootmem at paging_init() time, but init_machine()
> > doesn't run until later.  There will still need to be some hooks for
> > doing early DT processing, but none of that should be either board or
> > SoC specific.
> 
> If we're planning to keep the machine IDs around (even if they are now per-
> SoC), I'd like to know what would be left using them. The only thing that I 
> can see that we currently use is io_pg_offset for the DEBUG_LL builds, and 
> that isn't a convincing case to keep them.

Why not?

Kernel infrastructure backward compatibility means that you need to keep 
struct machine_desc instances around.  Granted, for the DT case, many of 
the members could be NULL or initialized with dummy stubs.  But that is 
very cheap to keep around, and that allows the same kernel binary to be 
able to use both the DT boot and the legacy boot.

In 10 years we might realize that non DT setups are no longer relevant 
and then all we'll have to do is rip out struct machine_desc and ignore 
the r1 value from the bootloader.  Ignoring that now means a flag day. 
And nobody wants a flag day forced upon them.


Nicolas
