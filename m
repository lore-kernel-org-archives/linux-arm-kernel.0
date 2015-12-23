From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Dec 2015 22:48:07 +0100
Subject: [PATCH v6 12/20] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <20151223183145.GA27193@yury-N73SV>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <201512212331.58152.arnd@arndb.de> <20151223183145.GA27193@yury-N73SV>
Message-ID: <201512232248.07732.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 December 2015, Yury Norov wrote:
> On Mon, Dec 21, 2015 at 11:31:57PM +0100, Arnd Bergmann wrote:
> > On Tuesday 15 December 2015, Yury Norov wrote:
> > > +
> > > +#define compat_sys_open_by_handle_at   sys_open_by_handle_at
> > > +#define compat_sys_openat              sys_openat
> > > +
> > 
> > One more thing I just remembered: I think we want this behavior for all new
> > 32-bit architectures, it was a bug to call compat_sys_openat for the generic
> > syscall table, as we don't support 32-bit off_t.
> > 
> > Could you split this out into a separate patch that does these changes:
> > 
> > - change the default asm-generic/unistd.h to use sys_openat/sys_open_by_handle_at
> > - change tile to override those two to keep the current (suboptimal) behavior
> > - change the force_o_largefile() definition so it defaults to true for all future
> >   architectures. The easiest way is probably to add a Kconfig symbol for this
> >   that gets selected by all 32-bit architectures, so we can use
> > 
> > #define force_o_largefile() ((BITS_PER_LONG != 32) || !IS_ENABLED(CONFIG_ARCH_32BIT_OFF_T))
> > 
> 
> Hi Arnd,
> 
> First two items are OK. The last one... Do you need it to remove
> compat_sys_openat and compat_sys_open_by_handle_at?

It's needed so all future architectures get it right.

> The patch that introduces CONFIG_ARCH_32BIT_OFF_T will affect all
> architectures, and so I need to get ack from each maintainer. 

Just post it to the linux-arch and linux-kernel mailing lists.
You are not actually changing behavior, so my Ack should be sufficient
here, as long as we make sure we handle all architectures the same
way.

> I will also have to ask them to test that change, because I have no
> access to all the hardware. (Even with QEMU, I cannot test them all.)
> I think the only man who is able to success with it is Linus :)...
> 
> Some arches has more than one compat mode. For example ARM64: aarch32
> requires this config enabled, but ilp32 needs it disabled. Now we can
> enable both features, but this will make them mutual exclusive. We can
> instead (un)define __ARCH_WANT_32BIT_OFF_T for each ABI of each platform,
> but it's even more work. And we'd think twice how to do it because
> it's not mechanical work. For example, on aarch64 it will look like:
> 
>         #define __ARCH_WANT_32BIT_OFF_T is_a32_compat_task()
> 
> I have no idea how it will look on x86 or ppc.

arm64 is not affected at all, because it's a 64-bit-only architecture
and force_o_largefile() already returns true here.

> In your previous email (Nov 18) you write that tile is the only user
> of asm-generic/unistd.h that needs compat behaviour. If so, why not
> just to turn it around, as you initially suggested, and fix tile. And
> do nothing with force_o_largefile()?

The first two of the three changes I listed above are for the
compat ABI, and there it is enough to change tile.

The third change has nothing to do with compat mode, but is about
native 32-bit architectures. However, we should change both in sync,
so the next architecture that gets added with both native 32-bit
mode and compat 32-bit mode on a 64-bit kernel behaves the same
way for all 32-bit user space, independent of what the kernel does.

We can have two separate patches to clarify that these don't have to
be done atomically, but we need to do both for consistency.
 
> By the way, is there a comprehensive list of linux platforms/abis, or
> at least ones that use asm-generic/unistd.h?

Just the source code.

	Arnd
