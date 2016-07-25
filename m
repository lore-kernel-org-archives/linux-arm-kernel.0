From: ruslan.bilovol@gmail.com (Ruslan Bilovol)
Date: Mon, 25 Jul 2016 17:28:22 +0300
Subject: [PATCH v1.2 3/4] arm64: Add arm64 kexec support
In-Reply-To: <1469048065.2977.124.camel@infradead.org>
References: <cover.1468970114.git.geoff@infradead.org>
 <9ed513fd44a19b2f49b4da99477cedfff7341bf0.1468970114.git.geoff@infradead.org>
 <1469048065.2977.124.camel@infradead.org>
Message-ID: <CAB=otbSObtEE7n4LjWWZZ0G=oA1Xd5QUmHnX44+uyUiWP4qXpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On Wed, Jul 20, 2016 at 11:54 PM, Geoff Levand <geoff@infradead.org> wrote:
> Add kexec reboot support for ARM64 platforms.
>
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---

[snip]

> diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
> new file mode 100644
> index 0000000..d2272c8
> --- /dev/null
> +++ b/kexec/arch/arm64/crashdump-arm64.c
> @@ -0,0 +1,21 @@
> +/*
> + * ARM64 crashdump.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <errno.h>
> +#include <linux/elf.h>
> +
> +#include "kexec.h"
> +#include "crashdump.h"
> +#include "crashdump-arm64.h"
> +#include "kexec-arm64.h"
> +#include "kexec-elf.h"
> +
> +struct memory_ranges usablemem_rgns = {};
> +
> +int is_crashkernel_mem_reserved(void)
> +{
> +       return 0;
> +}

Shouldn't is_crashkernel_mem_reserved() parse iomem and return
true if crashkernel region is reserved?

Due to this issue when I'm trying to validate these patches, I always
get next error:
| Memory for crashkernel is not reserved
| Please reserve memory by passing"crashkernel=X at Y" parameter to kernel
| Then try to loading kdump kernel

My system already has reserved region for crashkernel:
~# cat /proc/iomem | grep Crash
  7f000000-7fffffff : Crash kernel

And I use kexec next way:
kexec --type Image -p /Image --ramdisk=/ramdisk.cpio.gz
--dtb=dtb-arm64.dtb --append="root=/dev/ram0 1 maxcpus=1
reset_devices"

Best regards,
Ruslan Bilovol
