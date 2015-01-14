From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Jan 2015 13:38:08 +0100
Subject: [PATCH] arm64: kill off the libgcc dependency
In-Reply-To: <20150114114827.GH4050@arm.com>
References: <1421231934-31720-1-git-send-email-haokexin@gmail.com>
 <3138622.1rQcFu1jAj@wuerfel> <20150114114827.GH4050@arm.com>
Message-ID: <2438951.7KFuXx85Hp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 January 2015 11:48:27 Will Deacon wrote:
> On Wed, Jan 14, 2015 at 11:35:22AM +0000, Arnd Bergmann wrote:
> > On Wednesday 14 January 2015 10:48:26 Will Deacon wrote:
> > > On Wed, Jan 14, 2015 at 10:38:54AM +0000, Kevin Hao wrote:
> > > > The arm64 doesn't depend on the libgcc to build the vmlinux image.
> > > 
> > > Yes it does; we make use of __builtin_* for our bitops, for example.
> > > The compiler guys don't guarantee that these will be inlined.
> > 
> > Is that an architecture-specific statement?
> 
> I think the inlining guarantees apply to all architectures, but it affects
> the arm64 kernel because we include <asm-generic/bitops/builtin-*>.

Is it realistic to expect those to ever be implemented out of line?
I would expect them to behave like assembler intrinsics, at least
with the normal optimization level.

> > The debate has been going on for ages in Linux, most architecture
> > maintainers however decided against using libgcc and copy the functions
> > that are actually needed into the kernel sources.
> 
> What's the benefit of copying them?

You have a better control over what is included. On 32-bit architectures,
the 64-bit division is notorious here, we really don't want to accidentally
call the libgcc implementation but instead have our own do_div() helper.

Similarly I'd think that if we get a compiler that uses an external
__ffs implementation, we should implement an inline assembly instead
of taking the libgcc version.

Another problem that has happened in the past is libgcc functions that
in turn call glibc functions. To avoid that, you'd really want to build
the kernel with -ffreestanding, but that opens another can of worms.

	Arnd
