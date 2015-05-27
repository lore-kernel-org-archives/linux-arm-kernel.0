From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 27 May 2015 13:41:26 +0100
Subject: some question about arm64 smp_spin_table.c
In-Reply-To: <CADUS3okgaMGYfKkY7eBWjVvdKyfGjyp5hx0uaRWj5a1Y98+ocQ@mail.gmail.com>
References: <CADUS3o=4b9zfKtyiZ2CKgC2AA9ntkFLo91pJug17t1Xz2jM34w@mail.gmail.com>
 <20150527103644.GE8439@leverpostej>
 <CADUS3okgaMGYfKkY7eBWjVvdKyfGjyp5hx0uaRWj5a1Y98+ocQ@mail.gmail.com>
Message-ID: <20150527124126.GH8439@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 27, 2015 at 01:24:04PM +0100, yoma sophian wrote:
> hi Mark:
> 
> 2015-05-27 18:36 GMT+08:00 Mark Rutland <mark.rutland@arm.com>:
> > On Wed, May 27, 2015 at 10:47:09AM +0100, yoma sophian wrote:
> >> hi all:
> >
> > Hi,
> >
> >> in arm64/kernel/smp_spin_table.c
> >>     --> smp_spin_table_prepare_cpu,
> >> we suppose the cpu_release_addr[cpu] is located in kernel logical memory.
> >>
> >> in Arm plarform, this part is implement by each platform driver, since
> >> they register its own smp_operations.
> >>
> >> And in Arm64, once other platform use different area, such as register
> >> or device memory, to put cpu_release_addr[cpu], shall we use ioremap
> >> to get the va like below patch?
> >
> > Platforms need to place the release address in memory which can be
> > mapped with cacheable attributes. That is required by the semantics of
> > memreserve (which implies a cacheable mapping is fine).
> >
> > Since commit 113954c6463d1d80 ("arm64: spin-table: handle unmapped
> > cpu-release-addrs") we allowed for cpu-release-addrs which did not fall
> > in the linear mapping, by using ioremap_cache. This still requires that
> > the memory can be mapped cacheable.
> Oops, I use kernel 3.10 and that is why I didn't see your patch before :)
> 
> BTW, as I explained to Arnd, in booting.txt, it didn't mentioned the
> cpu-release-addrs has to be cacheable.

Unfortunately booting.txt misses lots of details that may have been
obvious to those writing it, but not so obvious to others.

> why we need the address mapped as cacheable?

There are a few reasons, including:

* The cpu-release-addr may fall inside the linear mapping, and hence
  there may be a cacheable alias anyway that we have to account for.

* The cpu-release-addr may previously have been mapped with a cacheable
  mapping, so cache maintenance is potentially necessary regardless of
  how the kernel maps the region.

* The CPUs spinning may have mapped the memory with cacheable
  attributes, so cache maintenance is potentially necessary regardless
  of how the kernel maps the memory.

* Any memory described in a /memreserve/ must be available to be mapped
  with cacheable attributes (following on from the rules in ePAPR). The
  original definition of spin-table required that the cpu-release-addr
  fell within memory and was forbidden from general allocation via a
  /memreserve/. The precise set of those attributes is not well-defined
  for the ARM architecture.

Any OS and/or spin-table implementation must function with all of these
constraints in mind.

The easiest way of getting that right from Linux is to map the region
with cacheable attributes and perform cache maintenance. The easiest
way to get this right from the firmware side is to not map memory with
cacheable attributes, and place the cpu-release-addr in main memory,
with an appropriate /memreserve/.

> > As Arnd says, if the cpu-release-addr is not in memory which can be
> > mapped as cacheable, then you're arguably not implementing spin-table.
> > There are a whole slew of coherency issues that the current
> > implementation avoids by being very simple, and I'm not keen about
> > prospect of changing that.
> is there any special requirement we need to follow when using spin-table mode?

I'm not entirely sure what you're asking. Perhaps you're asking about
some of the things I mention above?

> > Is there any particular reason that you do not wish to place your
> > cpu-release-addrs in memory?
> for not make address with a hole to put spin address and put that area
> as seperate power domain.

I don't see why you'd need a separate power domain for the
cpu-release-addr if this were in a (reserved) region of memory. Surely
all of your DRAM is in the same power domain?

> we use registers for other core spin jumping address.

It sound like you either need to make those CPUs poll a cpu-release-addr
in memory, or you could use PSCI instead (which would also give you CPU
hotplug, idle, and so on). Have you looked at the ARM Trusted Firmware?

Thanks,
Mark.
