From: segher@kernel.crashing.org (Segher Boessenkool)
Date: Sun, 30 Apr 2017 00:29:57 -0500
Subject: Updating kernel.org cross compilers?
In-Reply-To: <92b5ff36-ad2b-10bc-de4f-4774babd9625@arm.com>
References: <92b5ff36-ad2b-10bc-de4f-4774babd9625@arm.com>
Message-ID: <20170430052957.GJ19687@gate.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Apr 26, 2017 at 03:14:16PM +0100, Andre Przywara wrote:
> It seems that many people (even outside the Linux kernel community) use
> the cross compilers provided at kernel.org/pub/tools/crosstool.
> The latest compiler I find there is 4.9.0, which celebrated its third
> birthday at the weekend, also has been superseded by 4.9.4 meanwhile.
> 
> So I took Segher's buildall scripts from [1] and threw binutils 2.28 and
> GCC 6.3.0 at them.

Happy to see people are still using these!

> After removing --enable-sjlj-exceptions from build-gcc

This was needed to build some targets.  It does prevent aarch64 from
building without patch.

> and adding --disable-multilib (for building x86-64 on a x86-64
> box without 32-bit libs)

Why is this needed?  What error are you seeing.

> I was able to build (bare-metal) toolchains for
> all architectures except arc, m68k, tilegx and tilepro.

arc needs a more recent GCC; the other probably as well.  GCC 7 should
be out very soon, you probably want to wait for that :-)

> $ ./buildall --toolchain
> $ PATH=$PATH:/opt/cross/bin
> $ ./buildall --kernel

You should have the target dir in your PATH before doing anything else.
Is this not documented?  Hrm I guess not, let me fix that.

> And what is a good build setup, so that the binaries run on as many
> systems as possible?

Run contrib/download_prerequisites in the gcc source dir: this will
make GMP, MPFR, MPC statically linked, and use a version of each that
is known to work (and work correctly).

> [1] http://git.infradead.org/users/segher/buildall.git/

I'll push some changes that make aarch64 work out-of-the-box in a
minute.  It does some other things as well (e.g., make ia64 work again
after *that* change); more changes are still needed to make sh4 work
without patches.


Segher
