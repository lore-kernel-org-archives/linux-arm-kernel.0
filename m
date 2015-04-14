From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Apr 2015 11:40:32 +0200
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <332955D5-3122-437B-93A1-E1973BE09FCA@theobroma-systems.com>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
 <2507322.zX46IY7aRK@wuerfel>
 <332955D5-3122-437B-93A1-E1973BE09FCA@theobroma-systems.com>
Message-ID: <10153809.37pl8TnISa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 April 2015 00:58:59 Dr. Philipp Tomsich wrote:
> Arnd,
> 
> > 1. Adding a whole new ABI to the kernel is adding a long-term maintenance
> > burden, and we don't want to do that just because someone thinks it's a cute
> > hack or because it might add a few percent in performance of some low-level
> > benchmark. Please describe in the cover-letter for the patch series
> > specifically what applications you have in mind that would be using this, and
> > what the expected timeframe is before users could move to 64-bit user space.
> 
> There?s a couple of drivers behind getting ILP32 merged on ARM64:
> (a) There?s plenty of applications (i.e. having a large code-base, but not requiring 
> a 64bit address space) that can?t readily be migrated to LP64 (typically networking
> or data-storage applications) because they were written assuming an ILP32 data
> model.  Many of these applications will never become suitable for a LP64 data
> model and will remain locked into ILP32 operating environments.
> (b) A number of SPEC2006 components (i.e. not low-level benchmarks, but test
> cases that have been derived from large application use cases) benefit from 
> having a denser data-representation?this includes the mcf, xalancbmk, astar 
> and  ometpp.  This not an observation specific to ARM64 and can be observed
> on other architectures as well (e.g. [1] contains data for POWER from 2010).
> (c) Using AArch32 (assuming that any given ARMv8 processor supports it),
> is not a real alternative, as 64bit arithmetic is not supported on AArch32 and the
> AArch32 register set is significantly smaller.  Our experience shows that the 
> benefit of having 64bit registers, of a larger register file and of using 64bit 
> arithmetic makes ILP32 a worthwhile improvement over AArch32.
> 
> In summary, we believe that the need for ILP32 will never disappear on ARM64.
> In fact, I rather expect the AArch32 compatibility to eventually disapper from
> further processor designs? which will turn ILP32 into the only option for 
> legacy software.

Ok, this is the kind of text that I was looking for to put in the cover letter,
and eventually into the git changelog when the branch gets merged.

Regarding a), listing specific applications would be helpful. I keep having
trouble coming up with examples that fit in all these categories:

- can be easily ported to a brand new CPU architecture
- is complex enough to to not be portable to 64-bit
- is performance sensitive enough to not work with full emulation
- fits within the memory constraints of a 32-bit task a few years from
  now.
- must run on CPUs that are explicitly designed to not support 32-bit
  (aarch32) tasks.

I have seen a lot of legacy code, but most of it fails at one of the
above. There is also a lot of legacy code (from MS Windows) that
already supports LLP64 but not LP64.


> > The most important aspect here I think is time_t, and while it means starting
> > out with a system call ABI that is not ready for y2038, at the same time the
> > purpose of ILP32 support is to support legacy source code that is not 64-bit
> > safe now, and using 32-bit time_t will make that easier in a lot of ways.
> > Note that I am also leading the effort to make 32-bit Linux ready for using
> > 64-bit time_t on all architectures, so ARM64 ILP32 will be fixed as well, it
> > just won't be any better or worse than the others.
> 
> The decision to use the 64bit time_t actually came out of Andrew?s earliest
> patch-set from late 2013? we based the kernel-side of ILP32 on that one, while
> we focussed on getting all the other components into a working shape.
> 
> Breaking the C specification (by redefining time_t) always remained a 
> controversial issue on our end, as we knew that the day of switching back
> to a 32-bit time_t would eventually have to come.

Well, the reason that x32 uses a 64-bit time_t is because Linus Torvalds
intervened and asked for it to be done that way. I just think that today
we have a better plan for dealing with the issue on the whole.

I'd definitely want to get input from other parties on this. I know that
Rich Felker was particularly against the x32 definition of timespec, and
it using 32-bit time_t would let us avoid the controversy for the moment,
but of course we get to the same point later when we have to fix for
all architectures anyway.

	Arnd
