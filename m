From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 15 Apr 2015 12:22:24 +0100
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <2485404.lBlHmzQPKN@wuerfel>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
 <17844053.vZiPCu4un3@wuerfel>
 <20150414144702.GD14546@e104818-lin.cambridge.arm.com>
 <2485404.lBlHmzQPKN@wuerfel>
Message-ID: <20150415112224.GA26099@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 14, 2015 at 05:44:07PM +0200, Arnd Bergmann wrote:
> On Tuesday 14 April 2015 15:47:02 Catalin Marinas wrote:
> > On Tue, Apr 14, 2015 at 12:08:11PM +0200, Arnd Bergmann wrote:
> > > d) don't use the asm-generic/unistd.h table for aarch64-ilp32 at all, but instead
> > >    reuse the table from arch/arm64/include/asm/unistd32.h
> > 
> > IMO, (d) only makes sense if we treat ILP32 as a temporary solution
> > (a.k.a. hack) hoping that such applications will be eventually built for
> > LP64. If we treat native ILP32 as a real long term alternative to LP64,
> > I would rather use the asm-generic/unistd.h for syscalls. For example,
> > use 'openat' instead of 'open' on the native ILP32 (based on the
> > assumption that ILP32 is a long term alternative).
> > 
> > Unless we are aware of performance impact with (a), that's my preferred
> > option with some form of (b) next.
> 
> Ok, let's call that option
> 
> e) Use the existing aarch32 data structures with the asm-generic/unistd.h
> system call numbers.
> 
> This would solve the main problem of the data structures just like option
> d), and the main user-visible change would be that the syscall numbers
> are shifted compared to aarch32, which is a very minor aspect. We could
> also deal with the ucontext better this way than what I suggested.

I think that's the easiest from a kernel perspective. But see the other
sub-thread on the long term view of ILP32 (beyond 2038).

> > The above is mainly about syscall numbers and tables but the ABI goes
> > beyond this. And the key point is whether we go for an AArch32-like ABI
> > (32-bit time_t) or we try to define one close to LP64. If we go for an
> > AArch32-like ABI, we'll have to use the compat layer for some of
> > syscalls and assess how many of the asm/compat.h structures are
> > different from the generic ones (I wouldn't expect many).
> 
> It would be wildly different from the generic data structures, since we
> can only use the compat code if the implementation is the same as on
> aarch32. Essentially we have to define the headers so that all native
> data structures match what is in arch/arm64/include/asm/compat.h,
> which in turn is largely the same as arch/arm/include/uapi/asm/*.h.

What I meant by generic structures is those include/uapi/asm-generic/*.h
structures but compiled in an ILP32 context (exported headers not as
they are compiled in the LP64 kernel). Many of the asm/compat.h had to
be defined so that we can build them in the kernel context but many of
them are the same as the asm-generic ones (when compiled as ILP32).

BTW, we have to sort out the exported headers as well since we can't
rely on AArch32 for this. In the kernel, we'll have to re-use
asm/compat.h or some other asm/ilp32.h.

> > > Finally, there is a certain set of security issues from each new syscall
> > > we introduce. With the aarch32 syscall table, we have a higher degree
> > > of reuse of existing code, so we won't introduce security bugs that
> > > are only in one of the two ilp32 ABIs (aarch32 and aarch64).
> > 
> > Note that the current aarch32 compat ABI assumes that the top 32-bit of
> > every register is either zeroed or preserved by the architecture on
> > exception entry. We know that an AArch32 application cannot access the
> > top 32-bit of an AArch64 register. With native ILP32 however this is no
> > longer the case (it is running in AArch64 mode). I can't immediately
> > think of a problem (information leak) but it needs to be reviewed.
> 
> Hmm, interesting point. I'd have to think about this a bit more, but
> I believe it is already solved:
> 
> - For input arguments, we have the COMPAT_SYSCALL_DEFINE wrappers that
>   are meant to deal with this problem.
> - For output arguments, the kernel controls the register contents,
>   and I don't see a way that the function return value could leak
>   data in the upper bits. All syscall return 'long', so it should
>   be well-defined.

I think you are right. I was more thinking of those routed directly to
the native (non-compat) syscalls. We would need to make sure the return
value (X0 being the only register not restored on return from exception)
has the top 32-bit part zeroed.

-- 
Catalin
