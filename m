From: will.deacon@arm.com (Will Deacon)
Date: Mon, 9 Oct 2017 15:55:59 +0100
Subject: [PATCH] kbuild: fix dependency of dtbs targets
In-Reply-To: <1507091240-12756-1-git-send-email-yamada.masahiro@socionext.com>
References: <1507091240-12756-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20171009145558.GC28164@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 04, 2017 at 01:27:20PM +0900, Masahiro Yamada wrote:
> The target "dtbs" should depend on "scripts" because it needs to
> build dtc.  The "prepare" target is unneeded here.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/arm/Makefile   | 2 +-
>  arch/arm64/Makefile | 2 +-
>  arch/nios2/Makefile | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 47d3a1a..cdb5b55 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -342,7 +342,7 @@ $(INSTALL_TARGETS):
>  
>  PHONY += dtbs dtbs_install
>  
> -dtbs: prepare scripts
> +dtbs: scripts
>  	$(Q)$(MAKE) $(build)=$(boot)/dts
>  
>  dtbs_install:
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 939b310..fd56fbc 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -133,7 +133,7 @@ zinstall install:
>  
>  PHONY += dtbs dtbs_install
>  
> -dtbs: prepare scripts
> +dtbs: scripts
>  	$(Q)$(MAKE) $(build)=$(boot)/dts
>  
>  dtbs_install:

I think this is ok, although I was initially nervous about the possibility
of the archprepare step having interactions with the dt-bindings headers.
That doesn't appear to be the case, so for arm64:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
