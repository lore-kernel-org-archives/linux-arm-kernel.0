From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 17 Apr 2015 15:46:57 +0100
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <3365190.ZbiKjUlDk2@wuerfel>
References: <025BB233-8D14-457A-B3B2-C6BD6C3B32EF@theobroma-systems.com>
 <2242025.Z9qPVP4zls@wuerfel>
 <20150417090156.GH819@e104818-lin.cambridge.arm.com>
 <3365190.ZbiKjUlDk2@wuerfel>
Message-ID: <20150417144656.GQ819@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even more options below ;). I'll add mine.

On Fri, Apr 17, 2015 at 02:17:32PM +0100, Arnd Bergmann wrote:
> Here is my current line of thinking:
> 
> - Using all the aarch32 data structures would be the easiest way, then
>   we could use the side of asm-generic/unistd.h and everything should
>   work to the same degree as it does today for aarch32 emulation.
>   This means 32-bit time_t of course, and it would give us the best
>   tradeoff between the amount of work needed and the results we get.
>   A few downsides have been mentioned, but I still think it's the
>   best approach. This would be the approach e) that you suggested
>   earlier.

See my comment below on point g). I don't think there are lots of
similarities between the AArch32 structures and the generic ones (you
can look in arch/arm/include/uapi/asm/* rather than the arm64
asm/compat.h).

> - If we do not use the exact data structures that we have on aarch32,
>   then I think we should make aarch32 emulation and aarch64-ilp32
>   emulation mutually exclusive, and provide two separate asm/compat.h
>   header files that contain the differences. In this case, we should
>   try to come up with an ABI that makes the most sense for the majority
>   of the use cases that people are interested in. The two most likely
>   choices here would be
> 
>   f) create a new ABI that follows exactly what x32 did. This is a
>      variation of the earlier b), c), or d), but with the change of
>      fixing ioctl support by using a matching asm/compat.h. This
>      would not be entirely POSIX compliant, but it would be a nice
>      hack to get the highest performance in microbenchmarks, as it
>      avoids most of the compat layer. Over time, it can get extended
>      to coexist with aarch32 emulation, but that may take a few years.

Even in this case, we could enable AArch32 compat knowing that ioctls
wouldn't work. If this is important, we can add an option to enable
ioctl support for ILP32 and re-target the asm/compat.h definitions.

>   g) create a new ABI that does things in exactly the way that we
>      would use as the native syscall interface if we had an ilp32
>      kernel running on aarch64 with the asm-generic/unistd.h.
>      This would mean a 32-bit __kernel_long_t and time_t, but extending
>      time_t in the long run, together with aarch32 and i386.
>      This one is particularly interesting for people that are interested
>      in maximum posix compliance and in having a "nice" ABI, in particular
>      if there is a slight chance that within the next decade we have
>      reason to support building an arch/arm64 kernel itself in
>      aarch64-ilp32 mode.

I don't think there is a much difference between g) and e). The reason
we re-define many structures in asm/compat.h is because we don't have a
generic compat_* definition (e.g. compat_timespec, compat_timeval,
compat_flock, compat_flock64; anyway, I think some of these may not even
be needed with the canonical set of syscalls). The signal related
structures need to be handled differently for AArch32 and AArch64-ILP32
anyway because of the difference in the register set.

I would add a variation of g):

  h) create a new ABI that uses asm-generic/unistd.h and generic types
     with 32-bit __kernel_long_t and 64-bit time_t. This would be POSIX
     compliant and we don't have to worry about extending time_t in the
     future. We would have to duplicate some of the generic structures
     in asm/compat.h so that we can use the compat layer. However, at
     least in the short term, we don't have an easy way to enable both
     AArch32 and AArch64 ILP32 in the same kernel (they would be
     exclusive).

> Between e), f), and g), I'd lean towards e), but I'm fine with the other
> two as well and still lack sufficient information on what people want
> to do with it in the long run.

I guess we could wait to see a set of patches implementing e) or g) and
choose between afterwards.

> > > However, it would be nice to get agreement on the normal 32-bit ABI
> > > for time_t and timespec first, and then use the same thing everywhere.
> > 
> > Do you mean for native 32-bit architectures? I think OpenBSD uses a
> > 64-bit time_t already on 32-bit arches, it's doable in Linux as well.
> 
> Yes, and I'm working on that for Linux. The first step involves fixing
> the kernel, one file at a time, changing all users of time_t to use
> some other type (ktime_t or time64_t in most cases) instead, and introducing
> additional system calls to handle the boundary to user space without
> breaking stuff. See my presentation at http://elinux.org/ELC_2015_Presentations
> for more detail.

The approach here is primarily to fix the problem for existing 32-bit
architectures by adding a new syscall and that's fine. But what if we
enforce 64-bit time_t for all _new_ architectures?

-- 
Catalin
