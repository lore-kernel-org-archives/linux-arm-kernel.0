From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Jul 2015 19:57:22 +0100
Subject: Oops at boot after commit 965278dcb8ab... when using split
 memory region
In-Reply-To: <20150701180618.GI2310@leverpostej>
References: <CAGGh5h061qpus=RK-iDyzbc9xG+dJXy8AosuN=aryEVZCPPhtw@mail.gmail.com>
 <20150701144612.GG2310@leverpostej>
 <20150701145354.GL7557@n2100.arm.linux.org.uk>
 <20150701154007.GH2310@leverpostej>
 <20150701180618.GI2310@leverpostej>
Message-ID: <20150701185722.GN7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 01, 2015 at 07:06:19PM +0100, Mark Rutland wrote:
> On Wed, Jul 01, 2015 at 04:40:07PM +0100, Mark Rutland wrote:
> > Certainly. I did not mean to imply otherwise.
> > 
> > Using a similar command line I can reproduce the issue on TC2, getting a
> > hang when freeing unused kernel memory. I'm digging into that now.
> 
> If I pass mem=56316K at 0${MY_MEM_BASE} (i.e. 55M - 4K), I get hangs with
> and without commit 965278dcb8ab. It looks like we have a latent bug when
> a bank is insufficiently aligned, and my patch increased that necessary
> alignment from 1M to 2M.

It's not a latent bug.  I've _always_ said that memory banks _must_ be
aligned to a section boundary, because that's what the ARM MM layer has
been coded for.

Yes, we've recently been _trying_ to relax that restriction, and what
we're finding is that it's not trivial to do - we're constantly running
into these "it causes the kernel to stop booting on X" bugs, or worse
"fixing X causes plaforms Y to work but causes platforms Z to break."

Maybe we should just stop trying, and instead go back to the old
requirement of requiring banks of memory aligned to a section, and be
done with it.

In any case, to call this a "latent bug" is incorrect - we've merely
been trying so far _unsuccessfully_ to extend the ARM MM layer to accept
something that it's never accepted before.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
