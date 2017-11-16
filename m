From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu, 16 Nov 2017 13:55:41 +0300
Subject: [PATCH v2 05/18] arm64: fix -m for GNU gold
In-Reply-To: <20171115213428.22559-6-samitolvanen@google.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-6-samitolvanen@google.com>
Message-ID: <20171116105541.fqf3zgrqnbug7deq@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 15, 2017 at 01:34:15PM -0800, Sami Tolvanen wrote:
> GNU gold supports different emulations than bfd. Use aarch64_elf64_*_vec
> instead of aarch64linux.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Acked-by: Yury Norov <ynorov@caviumnetworks.com>

> ---
>  arch/arm64/Makefile | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index ecd5ed11c764..6059c8169513 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -70,14 +70,22 @@ KBUILD_CPPFLAGS	+= -mbig-endian
>  CHECKFLAGS	+= -D__AARCH64EB__
>  AS		+= -EB
>  LD		+= -EB
> +ifeq ($(ld-name),gold)
> +LDFLAGS		+= -maarch64_elf64_be_vec
> +else
>  LDFLAGS		+= -maarch64linuxb
> +endif
>  UTS_MACHINE	:= aarch64_be
>  else
>  KBUILD_CPPFLAGS	+= -mlittle-endian
>  CHECKFLAGS	+= -D__AARCH64EL__
>  AS		+= -EL
>  LD		+= -EL
> +ifeq ($(ld-name),gold)
> +LDFLAGS		+= -maarch64_elf64_le_vec
> +else
>  LDFLAGS		+= -maarch64linux
> +endif
>  UTS_MACHINE	:= aarch64
>  endif
>  
> -- 
> 2.15.0.448.gf294e3d99a-goog
