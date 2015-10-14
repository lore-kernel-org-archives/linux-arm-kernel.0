From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Oct 2015 18:45:03 +0100
Subject: l2c: Kernel panic in l2c310_enable() in non-secure mode
In-Reply-To: <561E6407.6000002@sigmadesigns.com>
References: <561E6407.6000002@sigmadesigns.com>
Message-ID: <20151014174503.GQ32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 04:17:43PM +0200, Marc Gonzalez wrote:
> Hello everyone,
> 
> Internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP ARM
> 
> On my platform, Linux v4.2 running in non-secure mode panics in
> l2c310_enable() with the pc pointing at this instruction:
> 
> c03390cc: ee013f30 mcr 15, 0, r3, cr1, cr0, {1}
> 
> which corresponds to set_auxcr IIUC.
...
> According to the Cortex A9 documentation,
> ACTLR is RO in non-secure mode if NSACR[18]=0 and RW if NSACR[18]=1
> 
> I suppose writing to a RO register cause the exception I see?

It should not, the write should be ignored and no exception should be
raised.

> Commit 8abd259f657d5 ("l2c: provide generic hook to intercept
> writes to secure registers") introduced a mechanism for non-secure
> platforms to define how to write to the L2CC AUXCTRL register.

Wrong register.  This is the _CPU_ auxiliary control register, not the
L2CC auxiliary control register.

> Is there a similar mechanism for asking the firmware to write
> to the CP15 ACTRL?

That's entirely dependent on the secure monitor implementation.  ARM Ltd
didn't listen to me originally when I said there needs to be a spec for
that, so there's no standardised way to talk to it, sorry.

Now, you've quoted one line from the oops, and a load of information that
we already know (because we have access to the manuals).  You've omitted
the rest of the oops, which is information we don't know, and is information
that we, as kernel developers, have decided that the kernel should print
to allow _us_, on the receiving end of an oops, to be able to diagnose
what happened and why.

Please, if you get an oops, include the _full_ dump when reporting
problems, even if you've diagnosed it already.  Not only does it help to
confirm the diagnosis, but it also serves as a source of documentation
if/when we commit a change to solve it.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
