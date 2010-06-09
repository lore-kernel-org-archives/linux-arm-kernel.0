From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 09 Jun 2010 09:09:54 -0400 (EDT)
Subject: Boot interface for device trees on ARM
In-Reply-To: <201006091226.15438.jeremy.kerr@canonical.com>
References: <201005181054.32325.jeremy.kerr@canonical.com>
	<201006050933.06714.jeremy.kerr@canonical.com>
	<alpine.LFD.2.00.1006042212400.30664@xanadu.home>
	<201006091226.15438.jeremy.kerr@canonical.com>
Message-ID: <alpine.LFD.2.00.1006090841310.30664@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Jun 2010, Jeremy Kerr wrote:

> Hi Nicolas,
> 
> > > If we're planning to keep the machine IDs around (even if they are now
> > > per- SoC), I'd like to know what would be left using them. The only
> > > thing that I can see that we currently use is io_pg_offset for the
> > > DEBUG_LL builds, and that isn't a convincing case to keep them.
> > 
> > Why not?
> 
> Because it's something we can justifiably replace with a single compile-time 
> constant, since it's only for low-level debug. I don't see that as a reason 
> for keeping these machine numbers around if that's all they're used for.

it's not only for that.  As I said below:

> > Kernel infrastructure backward compatibility means that you need to keep
> > struct machine_desc instances around.  Granted, for the DT case, many of
> > the members could be NULL or initialized with dummy stubs.  But that is
> > very cheap to keep around, and that allows the same kernel binary to be
> > able to use both the DT boot and the legacy boot.
> 
> ... this is a good point; if it helps with the transition, then this is 
> probably a decent reason to keep it in the interface.
> 
> I'd like to keep my "only use the device tree" value (MACH_TYPE_DT = 
> 0xffffffff) though, so we don't needlessly allocate machine numbers where they 
> aren't actually used.

There isn't such thing as "only use the device tree".  To keep the low 
level code _unmodified_ and _useful_ you'll have to allocate a number 
per machine class otherwise you won't be able to support more than one 
machine class in the same kernel binary at the same time.  You can't 
just say that those machine IDs aren't used.

I don't see the point of crippling that existing support just for the 
sake of using 0xffffffff, if it is only to save you a few machine ID 
registrations.  Because let's be honest, we won't DT-ify old machine 
targets anytime soon.  So only the recent and future machine classes 
will require a number, and that's probably on the order of 2 or 3 new 
IDs per year (meaning less than 5 minutes on RMK's automatic 
registration website).  Certainly much much less than the current 2000+ 
IDs that have been already allocated to date.


Nicolas
