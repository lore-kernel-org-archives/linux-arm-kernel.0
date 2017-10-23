From: romain.izard.pro@gmail.com (Romain Izard)
Date: Mon, 23 Oct 2017 17:04:46 +0200
Subject: [PATCH] ARM: add a private asm/unaligned.h
In-Reply-To: <20171020200231.1355569-1-arnd@arndb.de>
References: <20171020200231.1355569-1-arnd@arndb.de>
Message-ID: <CAGkQfmMksDZ_5MK0-9Q87F1XF4Ct=VuMOSRiy0+eXRe=zZCu0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-10-20 22:01 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
> The asm-generic/unaligned.h header provides two different implementations
> for accessing unaligned variables: the access_ok.h version used when
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is set pretends that all pointers
> are in fact aligned, while the le_struct.h version convinces gcc that the
> alignment of a pointer is '1', to make it issue the correct load/store
> instructions depending on the architecture flags.
>
> On ARMv5 and older, we always use the second version, to let the compiler
> use byte accesses. On ARMv6 and newer, we currently use the access_ok.h
> version, so the compiler can use any instruction including stm/ldm and
> ldrd/strd that will cause an alignment trap. This trap can significantly
> impact performance when we have to do a lot of fixups and, worse, has
> led to crashes in the LZ4 decompressor code that does not have a trap
> handler.
>
> This adds an ARM specific version of asm/unaligned.h that uses the
> le_struct.h/be_struct.h implementation unconditionally. This should lead
> to essentially the same code on ARMv6+ as before, with the exception of
> using regular load/store instructions instead of the trapping instructions
> multi-register variants.
>
> The crash in the LZ4 decompressor code was probably introduced by the
> patch replacing the LZ4 implementation, commit 4e1a33b105dd ("lib: update
> LZ4 compressor module"), so linux-4.11 and higher would be affected most.
> However, we probably want to have this backported to all older stable
> kernels as well, to help with the performance issues.
>
> There are two follow-ups that I think we should also work on, but not
> backport to stable kernels, first to change the asm-generic version of
> the header to remove the ARM special case, and second to review all
> other uses of CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS to see if they
> might be affected by the same problem on ARM.
>
> Cc: stable at vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Tested-by: Romain.Izard <romain.izard.pro@gmail.com>

Without this patch, the LZ4 decompression code is invalid in v4.14-rc6,
when compiled with arm-linux-gnueabihf-gcc, version 7.2. The zImage does
not start.

With this patch, the decompression code is valid, and the kernel boots
without a problem. No fixups are reported in /proc/cpu/alignment.

-- 
Romain Izard
