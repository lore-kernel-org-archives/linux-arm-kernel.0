From: panand@redhat.com (Pratyush Anand)
Date: Fri, 27 May 2016 17:04:20 +0530
Subject: [PATCH kexec-tools 24/32] arm: add support for platforms with
 boot memory aliases
In-Reply-To: <E1axXTv-0004jI-UH@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXTv-0004jI-UH@e0050434b2927.dyn.arm.linux.org.uk>
Message-ID: <CAHB_Gurpw4QyE73THdM=TWft3xmwDTMJx0Q06rrCxKJwdg4gaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2016 at 3:53 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> The kexec API deals with boot-view addresses, rather than normal system
> view addresses.  This causes problems for platforms such as Keystone 2,
> where the boot view is substantially different from the normal system
> view.
>
> This is because Keystone 2 boots from a memory alias in the lower 4GiB,
> before switching to a high alias at 32GiB.
>
> We handle this in a generic way by introducing boot alias resources in
> /proc/iomem:
>
> 80000000-dfffffff : System RAM (boot alias)
>   9f800000-9fffffff : Crash kernel (boot alias)
> 800000000-85fffffff : System RAM
>   800008000-800790e37 : Kernel code
>   8007ec000-8008b856f : Kernel data
>   81f800000-81fffffff : Crash kernel
>
> To allow kexec to load a kernel, we need to add the boot alias of RAM
> to the memory ranges returned by get_memory_ranges().  Parse the
> system RAM boot alias into the memory ranges.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kexec/arch/arm/iomem.h     | 2 ++
>  kexec/arch/arm/kexec-arm.c | 4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kexec/arch/arm/iomem.h b/kexec/arch/arm/iomem.h
> index 81c593d..85f958e 100644
> --- a/kexec/arch/arm/iomem.h
> +++ b/kexec/arch/arm/iomem.h
> @@ -2,6 +2,8 @@
>  #define IOMEM_H
>
>  #define SYSTEM_RAM             "System RAM\n"
> +#define SYSTEM_RAM_BOOT                "System RAM (boot alias)\n"
>  #define CRASH_KERNEL           "Crash kernel\n"
> +#define CRASH_KERNEL_BOOT      "Crash kernel (boot alias)\n"
>
>  #endif
> diff --git a/kexec/arch/arm/kexec-arm.c b/kexec/arch/arm/kexec-arm.c
> index eeb27b4..2194b7c 100644
> --- a/kexec/arch/arm/kexec-arm.c
> +++ b/kexec/arch/arm/kexec-arm.c
> @@ -18,6 +18,7 @@
>  #include "kexec-arm.h"
>  #include <arch/options.h>
>  #include "../../fs2dt.h"
> +#include "iomem.h"
>
>  #define MAX_MEMORY_RANGES 64
>  #define MAX_LINE 160
> @@ -52,7 +53,8 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
>                         continue;
>                 str = line + consumed;
>
> -               if (memcmp(str, "System RAM\n", 11) == 0) {
> +               if (memcmp(str, SYSTEM_RAM_BOOT, strlen(SYSTEM_RAM_BOOT)) == 0 ||
> +                   memcmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)) == 0) {
>                         type = RANGE_RAM;
>                 }
>                 else if (memcmp(str, "reserved\n", 9) == 0) {
> --
> 1.9.1
>
