From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Dec 2015 23:19:05 +0100
Subject: [PATCH v6 12/20] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <20151221183117.GC24894@e104818-lin.cambridge.arm.com>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <2334903.IjsQ1BK3JF@wuerfel>
 <20151221183117.GC24894@e104818-lin.cambridge.arm.com>
Message-ID: <201512212319.06173.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 December 2015, Catalin Marinas wrote:
> On Fri, Dec 18, 2015 at 01:47:55PM +0100, Arnd Bergmann wrote:
> > On Friday 18 December 2015 11:42:19 Catalin Marinas wrote:
> > > 2. Follow the PCS up to glibc and get glibc to zero the top part (not
> > >    always safe with hand-written assembly, though we already do this for
> > >    AArch32 where the PCS only specifies 4 arguments in registers, the
> > >    rest go on the stack)
> > 
> > I assume this needs special handling for syscalls with 64-bit arguments
> > in both glibc and kernel.
> 
> I think glibc only should suffice, if it is its responsibility to zero
> the top 32-bit part.

The kernel still needs to know about whether to call e.g. sys_llseek or
sys_lseek. The default syscall table contains llseek for 32-bit architectures,
but the current patch set uses lseek because that makes more sense when
you have 64-bit registers.

> > > 3. Follow the PCS up to glibc but always pass syscall arguments in W
> > >    registers, like AArch32 compat support (the least preferred option,
> > >    the only advantage is a single wrapper for all syscalls but it would
> > >    be doing unnecessary zeroing even for syscalls where it isn't needed)
> > 
> > This would mean we cannot pass 64-bit arguments in registers, right?
> 
> Not in a single register but two (like we do on AArch32).

Yes, that's what I mean. Essentially we'd use the unmodified 32-bit API
here.

> > > My preference, as stated above, is (1). You can write the wrappers in C
> > > directly and let the compiler upgrade the types when calling the native
> > > syscall. But any other option would be fine (take some inspiration from
> > > other architectures). Unfortunately we don't have COMPAT_SYSCALL_DEFINE
> > > for all functions that we need to wrap, it would have been easier (so we
> > > need to add them but probably in the arch/arm64 code).
> > 
> > It would be nice to have that code architecture-independent, so we can
> > share it with s390 and only need to update one place when new syscalls
> > get added.
> 
> We could indeed move things like:
> 
> COMPAT_SYSCALL_DEFINE3(s390_read, unsigned int, fd, char __user *, buf, compat_size_t, count)
> 
> to the core code and share them between s390 and arm64/ILP32. So let's
> stick to option 1.

Ok.

	Arnd
