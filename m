From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Jan 2015 14:39:26 +0000
Subject: [PATCH] arm64: kill off the libgcc dependency
In-Reply-To: <CAKv+Gu-E=0Fm7woFSWcdBLfmxB+5diGtO91c2zy-t2M1_NTNeg@mail.gmail.com>
References: <1421231934-31720-1-git-send-email-haokexin@gmail.com>
 <3138622.1rQcFu1jAj@wuerfel> <20150114114827.GH4050@arm.com>
 <2438951.7KFuXx85Hp@wuerfel>
 <CAKv+Gu-E=0Fm7woFSWcdBLfmxB+5diGtO91c2zy-t2M1_NTNeg@mail.gmail.com>
Message-ID: <20150114143926.GY12302@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 12:52:49PM +0000, Ard Biesheuvel wrote:
> On 14 January 2015 at 12:38, Arnd Bergmann <arnd@arndb.de> wrote:
> > You have a better control over what is included. On 32-bit architectures,
> > the 64-bit division is notorious here, we really don't want to accidentally
> > call the libgcc implementation but instead have our own do_div() helper.
> >
> > Similarly I'd think that if we get a compiler that uses an external
> > __ffs implementation, we should implement an inline assembly instead
> > of taking the libgcc version.
> >
> > Another problem that has happened in the past is libgcc functions that
> > in turn call glibc functions. To avoid that, you'd really want to build
> > the kernel with -ffreestanding, but that opens another can of worms.
> >
> 
> IMO libgcc.a cannot be used at all in the kernel, as it is not built
> with -mgeneral-regs-only so we have no guarantee that it will leave
> the NEON registers alone.

It's actually exactly issues like this which have prompted the kernel to
use its own libgcc on many architectures.

Not only is it what Arnd says above, but it's also to do with making sure
that we know what goes into the kernel is sane.

Although libgcc is part of the compiler, libgcc is built with the
expectation that it will be running in userland - it expects to link
to a libc.  That's why you can't build libgcc without having the glibc
headers around.

For example, on ARM, libgcc.a may contain calls to __div0, and it may
provide its own __div0 implementation, which invokes various Linux
system calls.

Various functions reference _GLOBAL_OFFSET_TABLE_ which we don't want
to have in the kernel.

Depending on how the compiler was built, libgcc.a may be built for
ARMv4, ARMv5, ARMv6 or ARMv7, and may not be appropriate for linking
with the kernel.  (Eg, you wouldn't want to try to link an ARMv7
libgcc.a in an ARMv5 kernel - and we /really/ don't want the mess
of having different toolchains for different ARM arch versions.)

It may also drag in the userspace exception unwind support.

Meanwhile, having the kernel build the compiler support functions that
it needs ensures that (a) we know what compiler support functions are
being used, (b) we know the implementation of those support functions
are sane for use in the kernel, (c) we can build them with appropriate
compiler flags for best performance, and (d) we remove an unnecessary
dependency on the build toolchain.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
