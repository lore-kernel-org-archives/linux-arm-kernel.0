From: panand@redhat.com (Pratyush Anand)
Date: Fri, 27 May 2016 17:04:45 +0530
Subject: [PATCH kexec-tools 25/32] arm: crashdump needs boot alias of
 crash kernel region
In-Reply-To: <E1axXU1-0004jO-4q@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXU1-0004jO-4q@e0050434b2927.dyn.arm.linux.org.uk>
Message-ID: <CAHB_GuqCmBOSQJeQZTCjy4edEe+p5LPvQAVF7gZY+Sc6uZFzuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2016 at 3:53 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> When crashdumping, we need the boot memory alias of the crash kernel
> region rather than the system view.  Arrange to check for the boot
> alias of the crash kernel region first, and if found, use it instead
> of the main alias.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kexec/arch/arm/kexec-zImage-arm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
> index 4755f06..fdd2910 100644
> --- a/kexec/arch/arm/kexec-zImage-arm.c
> +++ b/kexec/arch/arm/kexec-zImage-arm.c
> @@ -20,6 +20,7 @@
>  #include "kexec-arm.h"
>  #include "../../fs2dt.h"
>  #include "crashdump-arm.h"
> +#include "iomem.h"
>
>  #define BOOT_PARAMS_SIZE 1536
>
> @@ -446,7 +447,8 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
>                  * We put the dump capture kernel at the start of crashkernel
>                  * reserved memory.
>                  */
> -               if (parse_iomem_single("Crash kernel\n", &start, &end)) {
> +               if (parse_iomem_single(CRASH_KERNEL_BOOT, &start, &end) &&
> +                   parse_iomem_single(CRASH_KERNEL, &start, &end)) {
>                         /*
>                          * No crash kernel memory reserved. We cannot do more
>                          * but just bail out.
> --
> 1.9.1
>
