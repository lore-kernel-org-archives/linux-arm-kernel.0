From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Apr 2015 15:17:32 +0200
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <20150417090156.GH819@e104818-lin.cambridge.arm.com>
References: <025BB233-8D14-457A-B3B2-C6BD6C3B32EF@theobroma-systems.com>
 <2242025.Z9qPVP4zls@wuerfel>
 <20150417090156.GH819@e104818-lin.cambridge.arm.com>
Message-ID: <3365190.ZbiKjUlDk2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 April 2015 10:01:56 Catalin Marinas wrote:
> On Thu, Apr 16, 2015 at 05:21:30PM +0200, Arnd Bergmann wrote:
> > On Thursday 16 April 2015 14:31:34 Catalin Marinas wrote:
> > > On Thu, Apr 16, 2015 at 11:33:49AM +0000, Pinski, Andrew wrote:
> > > > There are only a few places where long should be 32bit rather than
> > > > 64bit. The non-time_t field of timespec is the only one I can think
> > > > of.
> > > 
> > > It may be the only one but we could end up with a non-compliant
> > > timespec. Unless we keep the tv_nsec as 32-bit long and add some
> > > padding, we could work around it by getting the C library to sign-extend
> > > such padding or we do it in a new "compat" layer in the kernel (but both
> > > cases imply copying the structure).
> > > 
> > > However, timerspec is included in other structures, so we'd have to
> > > intercept those as well. Philipp provided a list here:
> > > 
> > > http://article.gmane.org/gmane.linux.kernel/1931497
> > 
> > We're basically in the same boat as x32 then, and should do the same
> > thing on both most importantly, whatever that ends up.
> 
> I'm getting confused ;). I thought you were pushing for a 32-bit time_t
> on AArch64 ILP32.
> 
> I'm not sure we need to be in the same boat as x32. Their decision was
> to primarily use the LP64 ABI and there are performance advantages, not
> only the 2038 issue. The downside, few POSIX incompatibilities that I
> think they are happy to live with. If we are happy to live with them as
> well, we go ahead with the current patchset. We may try to patch some of
> the POSIX incompatibilities (see Philipp's list above) by
> padding/copying/sign-extending the affected structures.

Here is my current line of thinking:

- Using all the aarch32 data structures would be the easiest way, then
  we could use the side of asm-generic/unistd.h and everything should
  work to the same degree as it does today for aarch32 emulation.
  This means 32-bit time_t of course, and it would give us the best
  tradeoff between the amount of work needed and the results we get.
  A few downsides have been mentioned, but I still think it's the
  best approach. This would be the approach e) that you suggested
  earlier.

- If we do not use the exact data structures that we have on aarch32,
  then I think we should make aarch32 emulation and aarch64-ilp32
  emulation mutually exclusive, and provide two separate asm/compat.h
  header files that contain the differences. In this case, we should
  try to come up with an ABI that makes the most sense for the majority
  of the use cases that people are interested in. The two most likely
  choices here would be

  f) create a new ABI that follows exactly what x32 did. This is a
     variation of the earlier b), c), or d), but with the change of
     fixing ioctl support by using a matching asm/compat.h. This
     would not be entirely POSIX compliant, but it would be a nice
     hack to get the highest performance in microbenchmarks, as it
     avoids most of the compat layer. Over time, it can get extended
     to coexist with aarch32 emulation, but that may take a few years.

  g) create a new ABI that does things in exactly the way that we
     would use as the native syscall interface if we had an ilp32
     kernel running on aarch64 with the asm-generic/unistd.h.
     This would mean a 32-bit __kernel_long_t and time_t, but extending
     time_t in the long run, together with aarch32 and i386.
     This one is particularly interesting for people that are interested
     in maximum posix compliance and in having a "nice" ABI, in particular
     if there is a slight chance that within the next decade we have
     reason to support building an arch/arm64 kernel itself in
     aarch64-ilp32 mode.

Between e), f), and g), I'd lean towards e), but I'm fine with the other
two as well and still lack sufficient information on what people want
to do with it in the long run.

> > However, it would be nice to get agreement on the normal 32-bit ABI
> > for time_t and timespec first, and then use the same thing everywhere.
> 
> Do you mean for native 32-bit architectures? I think OpenBSD uses a
> 64-bit time_t already on 32-bit arches, it's doable in Linux as well.

Yes, and I'm working on that for Linux. The first step involves fixing
the kernel, one file at a time, changing all users of time_t to use
some other type (ktime_t or time64_t in most cases) instead, and introducing
additional system calls to handle the boundary to user space without
breaking stuff. See my presentation at http://elinux.org/ELC_2015_Presentations
for more detail.

	Arnd
