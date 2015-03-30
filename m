From: mmarek@suse.cz (Michal Marek)
Date: Mon, 30 Mar 2015 14:38:35 +0200
Subject: [RFC PATCH 2/2] Kbuild: avoid partial linking of
 drivers/built-in.o
In-Reply-To: <1427716167-25078-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1427716167-25078-1-git-send-email-ard.biesheuvel@linaro.org>
 <1427716167-25078-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <551943CB.3010303@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-03-30 13:49, Ard Biesheuvel wrote:
> The recursive partial linking of vmlinux can result in a
> drivers/built-in.o that is so huge that it interferes with
> the ability of the linker to emit veneers in the final link
> stage if the symbols are out of reach. This is caused by the
> fact that those veneers, which should be emitted close enough
> to the original call site, can only be emitted after the .text
> section of drivers/built-in.o, whose size pushes those veneers
> out of range.

Is this a limitation of a particular ARM ABI or a limitation of a state
of the art ARM linker or something else? If such a hack is necessary, it
needs to be accompanied with an explanation as to in which environments
it is needed, whether it can be removed at some point in future, what is
the exact error it causes, etc. Also, are you able to gauge the
limitation? Will it at some point affect fs/built-in.o or
drivers/net/built-in.o?


> So instead, avoid building drivers/built-in.o, and instead, add
> the constituent parts to the command line of the final link.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  Makefile | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index e734965b1604..1eb6c246a586 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -558,7 +558,7 @@ scripts: scripts_basic include/config/auto.conf include/config/tristate.conf \
>  
>  # Objects we will link into vmlinux / subdirs we need to visit
>  init-y		:= init/
> -drivers-y	:= drivers/ sound/ firmware/
> +drivers-y	:= sound/ firmware/
>  net-y		:= net/
>  libs-y		:= lib/
>  core-y		:= usr/
> @@ -569,6 +569,16 @@ ifeq ($(dot-config),1)
>  -include include/config/auto.conf
>  
>  ifeq ($(KBUILD_EXTMOD),)
> +
> +# drivers/built-in.o can become huge, which interferes with the linker's
> +# ability to emit stubs for branch targets that are out of reach for the
> +# ordinary relative branch instructions
> +include $(srctree)/drivers/Makefile
> +drivers-y += $(addprefix drivers/,$(sort $(obj-y)))
> +drivers-m += $(addprefix drivers/,$(sort $(obj-m)))

I think this will break should we ever put a .c file in drivers/ directly.

Michal
