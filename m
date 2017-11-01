From: salyzyn@android.com (Mark Salyzyn)
Date: Wed, 1 Nov 2017 15:14:03 -0700
Subject: [PATCH v4 10/12] arm64: vdso: replace gettimeofday.S with global
 vgettimeofday.C
In-Reply-To: <20171031183306.81375-1-salyzyn@android.com>
References: <20171031183306.81375-1-salyzyn@android.com>
Message-ID: <7775cc5e-4a24-1e33-aae5-6181ca018d80@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2017 11:32 AM, Mark Salyzyn wrote:
> . . .
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index 62c84f7cb01b..0925f8908dcb 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -5,18 +5,26 @@
>   # Heavily based on the vDSO Makefiles for other archs.
>   #
>   
> -obj-vdso := gettimeofday.o note.o sigreturn.o
> +obj-vdso := vgettimeofday.o note.o sigreturn.o
>   
>   # Build rules
>   targets := $(obj-vdso) vdso.so vdso.so.dbg
>   obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
>   
> -ccflags-y := -shared -fno-common -fno-builtin
> +ccflags-y := -shared -fno-common -fno-builtin -fno-stack-protector
> +ccflags-y += -DDISABLE_BRANCH_PROFILING
>   ccflags-y += -nostdlib -Wl,-soname=linux-vdso.so.1 \
>   		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
>   
> +# Force -O2 to avoid libgcc dependencies
> +CFLAGS_REMOVE_vgettimeofday.o = -pg -Os
> +CFLAGS_vgettimeofday.o = -O2 -mcmodel=tiny
> +
This last stanza breaks clang builds. Suggested fix is:

@@ -18,7 +18,11 @@ ccflags-y += -nostdlib -Wl,-soname=linux-vdso.so.1 \

 ?# Force -O2 to avoid libgcc dependencies
 ?CFLAGS_REMOVE_vgettimeofday.o = -pg -Os
+ifeq ($(cc-name),clang)
+CFLAGS_vgettimeofday.o = -O2
+else
 ?CFLAGS_vgettimeofday.o = -O2 -mcmodel=tiny
+endif

 ?# Disable gcov profiling for VDSO code
 ?GCOV_PROFILE := n

Holding off respin or followup patch until after we get a response from 
Jon Masters <jcm@readhat.com> on their QE tests on this patch series.

-- Mark
