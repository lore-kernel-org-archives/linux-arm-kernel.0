From: achandran@mvista.com (Arun Chandran)
Date: Wed, 30 Jul 2014 19:31:35 +0530
Subject: [PATCH] Arm64: Fix build error while switching from LE to BE
In-Reply-To: <1403775963-9785-1-git-send-email-achandran@mvista.com>
References: <1403775963-9785-1-git-send-email-achandran@mvista.com>
Message-ID: <CAFdej004ma0xyzBHCmijx1r3iQFiWPRMLRgi20ryZDJz5iJZGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 3:16 PM, Arun Chandran <achandran@mvista.com> wrote:
> Building a kernel with CPU_BIG_ENDIAN fails if there are stale objects
> from a !CPU_BIG_ENDIAN build. Due to a missing FORCE prerequisite on an
> if_changed rule in the VDSO Makefile, we attempt to link a stale LE
> object into the new BE kernel. According to Documentation/kbuild/makefiles.txt
> FORCE is required for if_changed rules, and forgetting it is a common mistake
>
> So fix it by 'Forcing' the build of vdso.  Fixes build errors like these:
>
> arch/arm64/kernel/vdso/note.o: compiled for a little endian system and target is big endian
> failed to merge target specific data of file arch/arm64/kernel/vdso/note.o
>
> arch/arm64/kernel/vdso/sigreturn.o: compiled for a little endian system and target is big endian
> failed to merge target specific data of file arch/arm64/kernel/vdso/sigreturn.o
>
> Signed-off-by: Arun Chandran <achandran@mvista.com>
> Tested-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  arch/arm64/kernel/vdso/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index 6d20b7d..a268a9a 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -43,7 +43,7 @@ $(obj)/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
>         $(call if_changed,vdsosym)
>
>  # Assembly rules for the .S files
> -$(obj-vdso): %.o: %.S
> +$(obj-vdso): %.o: %.S FORCE
>         $(call if_changed_dep,vdsoas)
>
>  # Actual build commands
> --
> 1.7.9.5
>

Any update on this?

--Arun
