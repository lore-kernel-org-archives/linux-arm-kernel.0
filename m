From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 26 Jun 2014 10:29:46 +0100
Subject: [PATCH] Arm64: Fix build error while switching from LE to BE
In-Reply-To: <1403765204-17617-1-git-send-email-achandran@mvista.com>
References: <1403765204-17617-1-git-send-email-achandran@mvista.com>
Message-ID: <20140626092946.GL15240@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 07:46:44AM +0100, Arun Chandran wrote:
> Selecting CPU_BIG_ENDIAN and building the kernel fails just after
> building it for little endian. According to Documentation/kbuild/makefiles.txt,
> it is a common mistake to forget 'FORCE' while using 'if_changed'

This is a little confusing, because we jump from the high level problem
to a very specific problem detail with nothing to link the two.

How about:

Building a kernel with CPU_BIG_ENDIAN fails if there are stale objects
from a !CPU_BIG_ENDIAN build. Due to a missing FORCE prerequisite on an
if_changed rule in the VDSO Makefile, we attempt to link a stale LE
object into the new BE kernel. According to
Documentation/kbuild/makefiles.txt FORCE is required for if_changed
rules, and forgetting it is a common mistake.

> So fix it by 'Forcing' the build of vdso.  Fixes build errors like these:
> 
> arch/arm64/kernel/vdso/note.o: compiled for a little endian system and target is big endian
> failed to merge target specific data of file arch/arm64/kernel/vdso/note.o
> 
> arch/arm64/kernel/vdso/sigreturn.o: compiled for a little endian system and target is big endian
> failed to merge target specific data of file arch/arm64/kernel/vdso/sigreturn.o
> 
> Signed-off-by: Arun Chandran <achandran@mvista.com>

Any reason for bot picking up my Tested-by [1]? The patch seems to be
the same.

Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/266571.html

> ---
>  arch/arm64/kernel/vdso/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index 6d20b7d..a268a9a 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -43,7 +43,7 @@ $(obj)/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
>  	$(call if_changed,vdsosym)
>  
>  # Assembly rules for the .S files
> -$(obj-vdso): %.o: %.S
> +$(obj-vdso): %.o: %.S FORCE
>  	$(call if_changed_dep,vdsoas)
>  
>  # Actual build commands
> -- 
> 1.7.9.5
> 
> 
