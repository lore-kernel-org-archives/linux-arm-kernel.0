From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Jan 2018 17:46:25 +0000
Subject: [PATCH v2 0/6] ARM branch predictor hardening
In-Reply-To: <BE82ED38-B07B-47AE-8D9D-0320E25F6CCF@gmail.com>
References: <20180108185533.9698-1-marc.zyngier@arm.com>
 <BE82ED38-B07B-47AE-8D9D-0320E25F6CCF@gmail.com>
Message-ID: <20180109174625.GM17719@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 09:13:37AM -0800, Florian Fainelli wrote:
> On January 8, 2018 10:55:27 AM PST, Marc Zyngier <marc.zyngier@arm.com> wrote:
> >This small series implements some basic BP hardening by invalidating
> >the BTB on CPUs that are known to be susceptible to aliasing attacks.
> >
> >These patches are closely modelled against what we do on arm64,
> >although simpler as we can rely on an architected instruction to
> >perform the invalidation. The notable exception is Cortex-A15, where
> >BTB invalidation behaves like a NOP, and the only way to shoot the
> >predictor down is to invalidate the icache *and* to have ACTLR[0] set
> >to 1 (which is a secure-only operation).
> 
> Is there a publicly available test case/exploit that we could use to
> regress test this against? I will follow up with the Brahma-B15
> patches after you send your v3.

While there are some x86 programs as part of the original information
release, this is something that I've been concerned about, and over
the days since I've been working hard at researching the bugs on the
various ARM CPUs.

The first thing I need to say is that the original x86 programs have
several issues that make them unreliable even on x86 hardware - for
example, running them on a Core 2 Duo after replacing "rdtscp" with
"lfence; rdtsc" results in failures - partly because they're a slower
processor, but also because the exploits are not particularly well
written.

The whole idea is that you speculatively drag a cache line in and
identify which cache line was dragged in - particularly in the
spectre case, where we are trying to identify one of 256 cache lines.

This really gets messed up if the cache line for the zero or 255
byte value always gets loaded due to the compiler laying the data
out such that (eg) "temp" shares the same cache line as "array2"!

Hence, I'm really not impressed by these exploits - a failure with
them does not mean there isn't an issue, it just means that they
didn't identify an issue which could be due to bugs within the
exploit programs themselves!

So, I've been putting together a set of better exploit programs
which work on x86-64, x86-32, ARM64, and various ARM32 machines.

This has lead me to some interesting observations that I'm not yet
ready to share all the details of publicly, some of them lead me
to question whether flushing the BTB can be deemed to really
mitigate the problem.

This is why I've been fairly quiet on public forums about this so
far.

Please bear in mind that the release of this problem has not been
managed particularly well (the fact that there aren't fixes already
prepared and lined up to go tells you that) and there's quite a
panic to (a) understand and (b) come up with proper fixes at the
moment.

It is quite understandable that people want answers and fixes as a
top priority, but I believe that rushing ahead without a full and
proper understanding of the issues here would be very foolhardy,
and /could/ end up making exploitation easier rather than harder.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
