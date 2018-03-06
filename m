From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Tue, 6 Mar 2018 15:02:01 +0100
Subject: [PATCH 2/2] arm64: defconfig: Raise NR_CPUS to 256
In-Reply-To: <CAK8P3a2ORBU-_7=JeCHSuM8YtC7zeO1VPxQzny_8BrpyVGCKKw@mail.gmail.com>
References: <20180302143737.10788-1-jglauber@cavium.com>
 <20180302143737.10788-2-jglauber@cavium.com>
 <CAK8P3a2ORBU-_7=JeCHSuM8YtC7zeO1VPxQzny_8BrpyVGCKKw@mail.gmail.com>
Message-ID: <20180306140201.GB7428@hc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2018 at 02:12:29PM +0100, Arnd Bergmann wrote:
> On Fri, Mar 2, 2018 at 3:37 PM, Jan Glauber <jglauber@cavium.com> wrote:
> > ThunderX1 dual socket has 96 CPUs and ThunderX2 has 224 CPUs.
> 
> Are you sure about those numbers? From my counting, I would have expected
> twice that number in both cases: 48 cores, 2 chips and 2x SMT for ThunderX
> vs 52 Cores, 2 chips and 4x SMT for ThunderX2.

That's what I have on those machines. I counted SMT as normal CPUs as it
doesn't make a difference for the config. I've not seen SMT on ThunderX.

The ThunderX2 number of 224 is already with 4x SMT (and 2 chips) but
there may be other versions planned that I'm not aware of.

> > Therefore raise the default number of CPUs from 64 to 256
> > by adding an arm64 specific option to override the generic default.
> 
> Regardless of what the correct numbers for your chips are, I'd like
> to hear some other opinions on how high we should raise that default
> limit, both in arch/arm64/Kconfig and in the defconfig file.
> 
> As I remember it, there is a noticeable cost for taking the limit beyond
> BITS_PER_LONG, both in terms of memory consumption and also
> runtime performance (copying and comparing CPU masks).

OK, that explains the default. My unverified assumption is that
increasing the CPU masks wont be a noticable performance hit.

Also, I don't think that anyone who wants performance will use
defconfig. All server distributions would bump up the NR_CPUS anyway
and really small systems will probably need to tune the config
anyway.

For me defconfig should produce a usable system, not with every last
driver configured but with all the basics like CPUs, networking, etc.
fully present.

> I'm sure someone will keep coming up with even larger configurations
> in the future, so we should try to decide how far we can take the
> defaults for the moment without impacting users of the smallest
> systems. Alternatively, you could add some measurements that
> show how much memory and CPU time is used up on a typical
> configuration for a small system (4 cores, no SMT, 512 MB RAM).
> If that's low enough, we could just do it anyway.

OK, I'll take a look.

--Jan
