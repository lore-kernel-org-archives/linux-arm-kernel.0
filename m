From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 1 Oct 2014 13:42:27 +0100
Subject: [PATCH 08/24] Allow a 32bit ABI to use the naming of the 64bit
 ABI syscalls to avoid confusion of not splitting the registers
In-Reply-To: <3318813.yqP9pCQtAB@wuerfel>
References: <1409779158-30963-1-git-send-email-apinski@cavium.com>
 <1409779158-30963-9-git-send-email-apinski@cavium.com>
 <3318813.yqP9pCQtAB@wuerfel>
Message-ID: <20141001124226.GI12702@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 04, 2014 at 11:11:04AM +0100, Arnd Bergmann wrote:
> On Wednesday 03 September 2014 14:19:02 Andrew Pinski wrote:
> > + * For 32bit abis where 64bit can be passed via one
> > + * register, use the same naming as the 64bit ones
> > + * as they will only have a 64 bit off_t.
> >   */
> > -#if __BITS_PER_LONG == 64 && !defined(__SYSCALL_COMPAT)
> > +#if (__BITS_PER_LONG == 64 && !defined(__SYSCALL_COMPAT)) || \
> > +       defined(__ARCH_WANT_64BIT_SYSCALLS)
> 
> I'm not sure if __ARCH_WANT_64BIT_SYSCALLS is the best name for
> this, since it's really only about off_t. It took me a while
> to understand what you are doing here.

I'm not sure I fully get it yet. So with this change, we avoid using
syscall numbers like __NR_ftruncate64 in favour of __NR_ftruncate. Why?
(maybe there's a valid reason, just not getting it).

Either way, ILP32 would still end up calling sys_ftruncate64() (rather
than the native sys_ftruncate()).

-- 
Catalin
