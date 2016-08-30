From: will.deacon@arm.com (Will Deacon)
Date: Tue, 30 Aug 2016 10:53:23 +0100
Subject: [PATCH] arm64: Set UTS_MACHINE in the Makefile
In-Reply-To: <1472545895-7237-1-git-send-email-mmarek@suse.com>
References: <1472545895-7237-1-git-send-email-mmarek@suse.com>
Message-ID: <20160830095322.GA24906@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 10:31:35AM +0200, Michal Marek wrote:
> The make rpm target depends on proper UTS_MACHINE definition.  Also, use
> the variable in arch/arm64/kernel/setup.c, so that it's not accidentally
> removed in the future.
> 
> Reported-and-tested-by: Fabian Vogt <fvogt@suse.com>
> Signed-off-by: Michal Marek <mmarek@suse.com>
> ---

What exactly do you mean by "proper", here? Is it just the endianness
suffix that you need?

>  arch/arm64/Makefile        | 2 ++
>  arch/arm64/kernel/Makefile | 2 ++
>  arch/arm64/kernel/setup.c  | 2 +-
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 5b54f8c021d8..ab3df36fdfbb 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -38,10 +38,12 @@ ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
>  KBUILD_CPPFLAGS	+= -mbig-endian
>  AS		+= -EB
>  LD		+= -EB
> +UTS_MACHINE	:= aarch64_be
>  else
>  KBUILD_CPPFLAGS	+= -mlittle-endian
>  AS		+= -EL
>  LD		+= -EL
> +UTS_MACHINE	:= aarch64
>  endif

I think we're be better off changing scripts/package/Makefile to map
UTS_MACHINE into whatever rpm requires, just like scripts/package/builddeb
already does this for .deb (which I think ends up broken with your patch
applied).

Will
