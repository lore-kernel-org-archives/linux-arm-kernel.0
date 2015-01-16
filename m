From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 16 Jan 2015 14:47:38 +0000
Subject: [PATCH] arm64: uapi: expose our struct ucontext to the uapi
 headers
In-Reply-To: <1421416334-12588-1-git-send-email-will.deacon@arm.com>
References: <1421416334-12588-1-git-send-email-will.deacon@arm.com>
Message-ID: <20150116144737.GB10230@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 01:52:14PM +0000, Will Deacon wrote:
> arm64 defines its own ucontext structure which is incompatible with the
> struct defined (and exposed to userspace by) the asm-generic headers.
> 
> glibc carries its own struct definition that is compatible with the
> arm64 definition, but we should expose our format in the uapi headers in
> case other libraries want to make use of the ucontext pushed as part of
> an arm64 sigframe.
> 
> This patch moves the arm64 asm/ucontext.h to the uapi headers, along
> with the necessary #include of linux/types.h.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marcus Shawcroft <marcus.shawcroft@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> 
> I think we also need something similar for arch/arm/ unless we decide
> that exposing the incorrect asm-generic header is harmless.

I'm trying to understand how we got here on arm32 (arm64 pretty much
inherited the behaviour). Before the uapi headers split, we had
arch/arm/include/asm/ucontext.h which has an #ifdef __KERNEL__ and
struct ucontext defined outside this block but we don't seem to have
ever exported this header to user. Luckily, glibc uses its own
definition which matches the kernel one.

At some point the asm-generic gained a ucontext.h which is fine but it
was not ending up in user space as we had an arch ucontext.h. However,
with the uapi headers change and maybe some additional commits, we end
up copying the uapi/asm-generic/ucontext.h to usr/include/asm/ in the
exported headers which differs from the arch ucontext.h as the latter
was never split in uapi/non-uapi parts (it wasn't in the
arch/arm/include/Kbuild).

>  arch/arm64/include/uapi/asm/Kbuild           | 1 +
>  arch/arm64/include/{ => uapi}/asm/ucontext.h | 8 +++++---
>  2 files changed, 6 insertions(+), 3 deletions(-)
>  rename arch/arm64/include/{ => uapi}/asm/ucontext.h (88%)

For this patch:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

For arm32 I think we need to split ucontext.h into uapi and non-uapi
part according to the #ifdef __KERNEL__.

Catalin
