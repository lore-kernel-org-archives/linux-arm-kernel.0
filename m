From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 3 Nov 2017 23:41:57 +0300
Subject: [PATCH 08/15] arm64: don't pass -maarch64linux to GNU gold
In-Reply-To: <20171103171203.107569-10-samitolvanen@google.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103171203.107569-10-samitolvanen@google.com>
Message-ID: <20171103204157.o3y7gapsvulb7kmt@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sami,

Very interesting reading, thank you.

On Fri, Nov 03, 2017 at 10:11:53AM -0700, Sami Tolvanen wrote:
> This change fixes the following error message when linking with GNU
> gold:
> 
>   ld.gold: error: unrecognized emulation aarch64linux
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index eb6f3c9ec6cb..c16bd1ab37f8 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -64,14 +64,18 @@ KBUILD_CPPFLAGS	+= -mbig-endian
>  CHECKFLAGS	+= -D__AARCH64EB__
>  AS		+= -EB
>  LD		+= -EB
> +ifneq ($(ld-name),gold)
>  LDFLAGS		+= -maarch64linuxb
> +endif
>  UTS_MACHINE	:= aarch64_be
>  else
>  KBUILD_CPPFLAGS	+= -mlittle-endian
>  CHECKFLAGS	+= -D__AARCH64EL__
>  AS		+= -EL
>  LD		+= -EL
> +ifneq ($(ld-name),gold)
>  LDFLAGS		+= -maarch64linux
> +endif
>  UTS_MACHINE	:= aarch64
>  endif

-maarch64linux was added to LDFLAGS, and -mabi=lp64 was added to CFLAGS
at the same patch to ensure that kernel will be compiled and linked in
lp64 mode, even if toolchain by default compiles and links targets in
ilp32 mode. So I think that simple removing this flag looks inaccurate.

Also, IIUC, this patch is not related to LTO, because if ld.gold doesn't
recognize -maarch64linux with LTO, it will not recognize it in non-LTO
build. Am I right?

I think that more correct way to do it would be either:
 - add maarch64linux to ld.gold, if possible. In discussion to other
   patches people talk that they need very fresh clang to build kernel
   properly, so this may be considered as similar issue;
 - if ld.gold understands some synonyms like -mabi=lp64, it should be
   passed to LDFLAGS here;
 - if ld.gold can link only lp64 objects, it should be commented here.
   But in this case I don't understand for example how to build vdso
   for ilp32 userspace...

Thanks,
Yury
