From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue, 28 Feb 2012 20:26:44 -0500
Subject: [PATCH] ARM: boot/compressed/misc.s: Include <linux/bug.h> to
 fix build break
In-Reply-To: <1330372350-6432-1-git-send-email-swarren@nvidia.com>
References: <1330372350-6432-1-git-send-email-swarren@nvidia.com>
Message-ID: <20120229012644.GA4265@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[[PATCH] ARM: boot/compressed/misc.s: Include <linux/bug.h> to fix build break] On 27/02/2012 (Mon 12:52) Stephen Warren wrote:

> Commmit cf86c17 "kernel.h: doesn't explicitly use bug.h, so don't include
> it." caused the following build failure on ARM:
> 
>   CC      arch/arm/boot/compressed/misc.o
> In file included from arch/arm/boot/compressed/misc.c:28:0:
> arch/arm/mach-tegra/include/mach/uncompress.h: In function 'arch_decomp_setup':
> arch/arm/mach-tegra/include/mach/uncompress.h:125:2: error: implicit declaration of function 'BUILD_BUG_ON_ZERO' [-Werror=implicit-function-declaration]
> cc2: some warnings being treated as errors
> 
> Include <linux/bug.h> to fix that.

Hi Stephen,

I wouldn't want to put bug.h in arm/boot/compressed/misc.c simply
because I've built all the arm configs and I don't see this on
running any of the existing arch/arm/config builds.

However, if arch/arm/mach-tegra/include/mach/uncompress.h is using
things from it, then perhaps it needs to include bug.h I think.

Russell is totally correct in saying that uncompress has no business in
calling/linking generic infrastructure functions, but your error message
is a use of _BUILD_ bug stuff.  The early init code clearly can't do
printk or similar, but should still be able to use BUILD_BUG type stuff
that is meant to blow up on the x-compile host and not the target.  Use
of BUILD_BUG is different from use of (runtime) BUG.  Does it warrant a
separate header though?  It could, but I don't think we want to go there.

The other interesting thing here, is that you see this when the kernel.h
stops including bug.h -- so that means you've got an implicit presence
of kernel.h -- which means you can legally (but incorrectly) link to
things like printk() which simply dont make sense at this early stage of
boot.  So I have to think that the exclusion of headers like bug.h to
protect yourself from hurting yourself was already non-functional before
you start.  The way things are currently requires the author to really
think about the context they are operating in regardless.

Using BUG in this context is wrong.  Using BUILD_BUG seems OK to me.

Paul.
--

> 
> This should probably be squashed into commit a3a3a1a "bug.h: add include
> of it to various implicit C users".
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/boot/compressed/misc.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
> index 8e2a8fc..30055be 100644
> --- a/arch/arm/boot/compressed/misc.c
> +++ b/arch/arm/boot/compressed/misc.c
> @@ -18,6 +18,7 @@
>  
>  unsigned int __machine_arch_type;
>  
> +#include <linux/bug.h>
>  #include <linux/compiler.h>	/* for inline */
>  #include <linux/types.h>
>  #include <linux/linkage.h>
> -- 
> 1.7.0.4
> 
