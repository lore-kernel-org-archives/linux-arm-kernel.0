From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 29 Apr 2017 20:37:49 -0700
Subject: Updating kernel.org cross compilers?
In-Reply-To: <92b5ff36-ad2b-10bc-de4f-4774babd9625@arm.com>
References: <92b5ff36-ad2b-10bc-de4f-4774babd9625@arm.com>
Message-ID: <36993be3-c40e-3882-5f20-f8ea1a3916bf@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/26/2017 07:14 AM, Andre Przywara wrote:
> Hi!
>
> (Tony: I've seen you redirecting to "Chris" in an older email, but the
> web archive doesn't have his email address)
>
> It seems that many people (even outside the Linux kernel community) use
> the cross compilers provided at kernel.org/pub/tools/crosstool.
> The latest compiler I find there is 4.9.0, which celebrated its third
> birthday at the weekend, also has been superseded by 4.9.4 meanwhile.
>
> So I took Segher's buildall scripts from [1] and threw binutils 2.28 and
> GCC 6.3.0 at them. After removing --enable-sjlj-exceptions from
> build-gcc and adding --disable-multilib (for building x86-64 on a x86-64
> box without 32-bit libs) I was able to build (bare-metal) toolchains for
> all architectures except arc, m68k, tilegx and tilepro.
> Now my understanding is that a baremetal/stage 1 compiler should be
> build with "all-gcc" instead of the implicit "all" make target, and
> "install-gcc" instead of "install". And indeed adding this to build-gcc
> makes all toolchains build now - except arc, which needs an explicit
> "--with-cpu=arc700" on the GCC configure command line.
>
> So after those changes, the sequence:
> $ ./buildall --toolchain
> $ PATH=$PATH:/opt/cross/bin
> $ ./buildall --kernel
> worked reasonably well for me (binutils 2.28, GCC 6.3.0, Linux 4.11-rc8
> on an Intel host with Ubuntu 14.04.5). Just tilegx/pro is still broken
> due to toolchain issues.
>
Those need libgcc, and to build libgcc you'll have to install the kernel
header files. Same is true for cris (and possibly others).

Also, crisv32 builds as well.

> So I wonder what the process is to get those compilers updated?
>
If you find out let me know.

Guenter

> And what is a good build setup, so that the binaries run on as many
> systems as possible?
>
> Also the web page (https://www.kernel.org/pub/tools/crosstool) seems to
> only link outdated builds (4.6.3, mostly), is that on purpose?
>
> Cheers,
> Andre.
>
> [1] http://git.infradead.org/users/segher/buildall.git/
>
