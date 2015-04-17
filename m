From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 17 Apr 2015 16:13:15 +0100
Subject: [PATCH v4 04/13] arm64: use fixmap region for permanent FDT
 mapping
In-Reply-To: <1429112064-19952-5-git-send-email-ard.biesheuvel@linaro.org>
References: <1429112064-19952-1-git-send-email-ard.biesheuvel@linaro.org>
 <1429112064-19952-5-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150417151315.GH21904@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 15, 2015 at 04:34:15PM +0100, Ard Biesheuvel wrote:
> Currently, the FDT blob needs to be in the same 512 MB region as
> the kernel, so that it can be mapped into the kernel virtual memory
> space very early on using a minimal set of statically allocated
> translation tables.
>
> Now that we have early fixmap support, we can relax this restriction,
> by moving the permanent FDT mapping to the fixmap region instead.
> This way, the FDT blob may be anywhere in memory.
>
> This also moves the vetting of the FDT to mmu.c, since the early
> init code in head.S does not handle mapping of the FDT anymore.
> At the same time, fix up some comments in head.S that have gone stale.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  Documentation/arm64/booting.txt | 13 +++++----
>  arch/arm64/include/asm/boot.h   | 14 +++++++++
>  arch/arm64/include/asm/fixmap.h | 15 ++++++++++
>  arch/arm64/include/asm/mmu.h    |  1 +
>  arch/arm64/kernel/head.S        | 39 +------------------------
>  arch/arm64/kernel/setup.c       | 32 +++++++-------------
>  arch/arm64/mm/Makefile          |  2 ++
>  arch/arm64/mm/init.c            |  1 -
>  arch/arm64/mm/mmu.c             | 65 +++++++++++++++++++++++++++++++++++++++++
>  9 files changed, 117 insertions(+), 65 deletions(-)
>  create mode 100644 arch/arm64/include/asm/boot.h
>
> diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
> index f3c05b5f9f08..53f18e13d51c 100644
> --- a/Documentation/arm64/booting.txt
> +++ b/Documentation/arm64/booting.txt
> @@ -45,11 +45,14 @@ sees fit.)
>
>  Requirement: MANDATORY
>
> -The device tree blob (dtb) must be placed on an 8-byte boundary within
> -the first 512 megabytes from the start of the kernel image and must not
> -cross a 2-megabyte boundary. This is to allow the kernel to map the
> -blob using a single section mapping in the initial page tables.
> -
> +The device tree blob (dtb) must be placed on an 8-byte boundary and must
> +not exceed 2 megabytes in size. Since the dtb will be mapped cacheable using
> +blocks of up to 2 megabytes in size, it should not be placed within 2 megabytes
> +of memreserves or other special carveouts that may be mapped with non-matching
> +attributes.

Nit: memreserves are always permitted to be mapped cacheable (following
the ePAPR definition and the de-facto Linux implementation on everything
other than PPC), so those should be fine.

How about:

The device tree blob (dtb) must be placed on an 8-byte boundary and must
not exceed 2 megabytes in size. Since the dtb will be mapped cacheable
using blocks of up to 2 megabytes in size, it must not be placed within
any 2M region which must be mapped with any specific attributes.

As an aside, we perhaps need a more formal definition of /memreserve/
semantics.

The code itself looks good to me. I'll try to give that a go with some
padded DTBs at some point next week.

Mark.
