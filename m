From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 09 Jan 2015 09:47:44 +0000
Subject: [PATCH v20 01/11] ARM: probes: move all probe code to dedicate
 directory
In-Reply-To: <1420769989-29208-1-git-send-email-wangnan0@huawei.com>
References: <1420457350-77053-1-git-send-email-wangnan0@huawei.com>
 <1420769989-29208-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1420796864.4160.6.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-01-09 at 10:19 +0800, Wang Nan wrote:
> In discussion on LKML (https://lkml.org/lkml/2014/11/28/158), Russell
> King suggests to move all probe related code to arch/arm/probes. This
> patch does the work. Due to dependency on 'arch/arm/kernel/patch.h', this
> patch also moves patch.h to 'arch/arm/include/asm/patch.h', and related
> '#include' directives are also midified to '#include <asm/patch.h>'.
> 
> Following is an overview of this patch:
> 
>  ./arch/arm/kernel/               ./arch/arm/probes/
>  |-- Makefile                     |-- Makefile
>  |-- probes-arm.c          ==>    |-- decode-arm.c
>  |-- probes-arm.h          ==>    |-- decode-arm.h
>  |-- probes-thumb.c        ==>    |-- decode-thumb.c
>  |-- probes-thumb.h        ==>    |-- decode-thumb.h
>  |-- probes.c              ==>    |-- decode.c
>  |-- probes.h              ==>    |-- decode.h
>  |                                |-- kprobes
>  |                                |   |-- Makefile
>  |-- kprobes-arm.c         ==>    |   |-- actions-arm.c
>  |-- kprobes-common.c      ==>    |   |-- actions-common.c
>  |-- kprobes-thumb.c       ==>    |   |-- actions-thumb.c
>  |-- kprobes.c             ==>    |   |-- core.c
>  |-- kprobes.h             ==>    |   |-- core.h
>  |-- kprobes-test-arm.c    ==>    |   |-- test-arm.c
>  |-- kprobes-test.c        ==>    |   |-- test-core.c
>  |-- kprobes-test.h        ==>    |   |-- test-core.h
>  |-- kprobes-test-thumb.c  ==>    |   `-- test-thumb.c
>  |                                `-- uprobes
>  |                                    |-- Makefile
>  |-- uprobes-arm.c         ==>        |-- actions-arm.c
>  |-- uprobes.c             ==>        |-- core.c
>  |-- uprobes.h             ==>        `-- core.h
>  |
>  `-- patch.h               ==>    arch/arm/include/asm/patch.h
> 
> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> Acked-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> ---

Might have been good to mention what's changed in this version, I worked
out its kgdb.c, comments below...

[...]

> diff --git a/arch/arm/kernel/kgdb.c b/arch/arm/kernel/kgdb.c
> index 07db2f8..f3eb83f 100644
> --- a/arch/arm/kernel/kgdb.c
> +++ b/arch/arm/kernel/kgdb.c
> @@ -16,7 +16,7 @@
>  
>  #include <asm/traps.h>
>  
> -#include "patch.h"
> +#include <asm/patch.h>

To keep alphabetical ordering of headers this should be above the
#include <asm/traps.h>

Don't bother resending the patch, I'll just update the patch in the git
branch I'm putting together.

-- 
Tixy
 
