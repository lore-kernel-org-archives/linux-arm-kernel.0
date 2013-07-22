From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Jul 2013 17:31:55 +0100
Subject: [GIT PULL] ARM: kernel mode NEON support
In-Reply-To: <CAKv+Gu_0XXdCw4-V6LLHCiaH4Wc+=4DTzP6gwgV_h-Qb90gYTA@mail.gmail.com>
References: <CAKv+Gu_0XXdCw4-V6LLHCiaH4Wc+=4DTzP6gwgV_h-Qb90gYTA@mail.gmail.com>
Message-ID: <20130722163155.GN24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 08, 2013 at 11:23:11PM +0100, Ard Biesheuvel wrote:
> The following changes since commit 8bb495e3f02401ee6f76d1b1d77f3ac9f079e376:
> 
>   Linux 3.10 (2013-06-30 15:13:29 -0700)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/ardbiesheuvel/linux-arm.git for-rmk
> 
> for you to fetch changes up to 7d11965ddb9b9b1e0a5d13c58345ada1ccbc663b:
> 
>   lib/raid6: add ARM-NEON accelerated syndrome calculation (2013-07-08
> 22:09:18 +0100)

I'm assuming that the comments in your previous postings are valid as I've
included those in the merge commit:

    I have included two use cases that I have been using, XOR and RAID-6
    checksumming. The former gets a 60% performance boost on the NEON, the
    latter over 400%.

    ARM: add support for kernel mode NEON

    Adds kernel_neon_begin/end (renamed from kernel_vfp_begin/end in the
    previous version to de-emphasize the VFP part as VFP code that needs
    software assistance is not supported currently.)

    Introduces <asm/neon.h> and the Kconfig symbol KERNEL_MODE_NEON. This
    has been aligned with Catalin for arm64, so any NEON code that does
    not use assembly but intrinsics or the GCC vectorizer (such as my
    examples) can potentially be shared between arm and arm64 archs.

    ARM: move VFP init to an earlier boot stage

    This is needed so the NEON is enabled when the XOR and RAID-6 algo
    boot time benchmarks are run.

    ARM: be strict about FP exceptions in kernel mode

    This adds a check to vfp_support_entry() to flag unsupported uses of
    the NEON/VFP in kernel mode. FP exceptions (bounces) are flagged as
    a BUG(), this is because of their potentially intermittent nature.
    Exceptions caused by the fact that kernel_neon_begin has not been
    called are just routed through the undef handler.

    ARM: crypto: add NEON accelerated XOR implementation

    This is the xor_blocks() implementation built with -ftree-vectorize,
    60% faster than optimized ARM code. It calls in_interrupt() to check
    whether the NEON flavor can be used: this should really not be
    necessary, but due to xor_blocks'squite generic nature, there is no
    telling how exactly people may be using it in the real world.

    lib/raid6: add ARM-NEON accelerated syndrome calculation

    This is a port of the RAID-6 checksumming code in altivec.uc ported
    to use NEON intrinsics. It is about 4x faster than the sequential
    code.
