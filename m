From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 25 Feb 2015 11:18:29 +0000
Subject: [PATCH] drivers: cpuidle: Explictly include proc-fns.h for
 cpuidle-arm64
In-Reply-To: <1424827506-12245-1-git-send-email-lauraa@codeaurora.org>
References: <1424827506-12245-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20150225111828.GA9714@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

On Wed, Feb 25, 2015 at 01:25:06AM +0000, Laura Abbott wrote:
> cpuidle-arm64.c fails to compile with CONFIG_ARM64_64K_PAGES=y
> 
> /kernel/drivers/cpuidle/cpuidle-arm64.c: In function "arm64_enter_idle_state"
> /kernel/drivers/cpuidle/cpuidle-arm64.c:42:3: error: implicit declaration of function "cpu_do_idle" [-Werror=implicit-function-declaration]
>    cpu_do_idle();
>    ^
> 
> Explicitly add the header file with the declaration of cpu_do_idle.
> 
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>

I just hit the same problem. The fix looks sane, and it would be nice to
have it queued ASAP.

> ---
> Not sure how long this has been broken, bisect between v3.19 and master showed
> 6b00f7efb5303418c231994c91fb8239f5ada260 as the first bad commit which
> isn't particularly helpful. Probably some header shuffling.
> ---
>  drivers/cpuidle/cpuidle-arm64.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
> index 80704b9..f1d5422 100644
> --- a/drivers/cpuidle/cpuidle-arm64.c
> +++ b/drivers/cpuidle/cpuidle-arm64.c
> @@ -19,6 +19,7 @@
>  #include <linux/of.h>
>  
>  #include <asm/cpuidle.h>
> +#include <asm/proc-fns.h>
>  #include <asm/suspend.h>

I wasn't able to apply this patch atop of v4.0-rc1 or current mainline;
there's no asm/suspend.h include in either of those. Which tree is this
based on?

Mark.
