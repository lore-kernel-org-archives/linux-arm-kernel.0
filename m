From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 23 Dec 2015 21:31:45 +0300
Subject: [PATCH v6 12/20] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <201512212331.58152.arnd@arndb.de>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <1450215766-14765-13-git-send-email-ynorov@caviumnetworks.com>
 <201512212331.58152.arnd@arndb.de>
Message-ID: <20151223183145.GA27193@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2015 at 11:31:57PM +0100, Arnd Bergmann wrote:
> On Tuesday 15 December 2015, Yury Norov wrote:
> > +
> > +#define compat_sys_open_by_handle_at   sys_open_by_handle_at
> > +#define compat_sys_openat              sys_openat
> > +
> 
> One more thing I just remembered: I think we want this behavior for all new
> 32-bit architectures, it was a bug to call compat_sys_openat for the generic
> syscall table, as we don't support 32-bit off_t.
> 
> Could you split this out into a separate patch that does these changes:
> 
> - change the default asm-generic/unistd.h to use sys_openat/sys_open_by_handle_at
> - change tile to override those two to keep the current (suboptimal) behavior
> - change the force_o_largefile() definition so it defaults to true for all future
>   architectures. The easiest way is probably to add a Kconfig symbol for this
>   that gets selected by all 32-bit architectures, so we can use
> 
> #define force_o_largefile() ((BITS_PER_LONG != 32) || !IS_ENABLED(CONFIG_ARCH_32BIT_OFF_T))
> 

Hi Arnd,

First two items are OK. The last one... Do you need it to remove
compat_sys_openat and compat_sys_open_by_handle_at?

The patch that introduces CONFIG_ARCH_32BIT_OFF_T will affect all
architectures, and so I need to get ack from each maintainer. 

I will also have to ask them to test that change, because I have no
access to all the hardware. (Even with QEMU, I cannot test them all.)
I think the only man who is able to success with it is Linus :)...

Some arches has more than one compat mode. For example ARM64: aarch32
requires this config enabled, but ilp32 needs it disabled. Now we can
enable both features, but this will make them mutual exclusive. We can
instead (un)define __ARCH_WANT_32BIT_OFF_T for each ABI of each platform,
but it's even more work. And we'd think twice how to do it because
it's not mechanical work. For example, on aarch64 it will look like:

        #define __ARCH_WANT_32BIT_OFF_T is_a32_compat_task()

I have no idea how it will look on x86 or ppc.

In your previous email (Nov 18) you write that tile is the only user
of asm-generic/unistd.h that needs compat behaviour. If so, why not
just to turn it around, as you initially suggested, and fix tile. And
do nothing with force_o_largefile()?

By the way, is there a comprehensive list of linux platforms/abis, or
at least ones that use asm-generic/unistd.h?

BR,
Yury.

> 	Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
