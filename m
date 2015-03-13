From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Mar 2015 17:02:51 +0000
Subject: read_cpuid_id() in arch/arm/kernel/setup.c
In-Reply-To: <20150313165600.GB9603@leverpostej>
References: <55030A68.6070002@free.fr>
 <20150313165600.GB9603@leverpostej>
Message-ID: <20150313170250.GX8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 04:56:00PM +0000, Mark Rutland wrote:
> In the presence of big.LITTLE the comment and premise of the
> optimisation here is wrong. A thread can migrate between cores of
> differing microarchitectures.
> 
> So __attribute_const__ is simply broken, and we probably need to do
> something like the black magic SP hazarding hack we do for the tpidr
> percpu accesses (only expecting this to be called in non-preemptible
> context) if it makes sense to allow the value to be cached.

Yes, it's true that with big.LITTLE, lots of stuff is broken in this
regard, and you are partially right, but you are not entirely right
either.

It's not the reading of the CPU ID which is the problem, it's the
reading _and_ use of derived results which is a problem.

What this basically means is that in the presence of big.LITTLE, we
need __get_cpu_architecture() as a whole, and whatever makes use of
its return value to /all/ be non-preemptible... and probably a lot
more code too.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
