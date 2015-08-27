From: olof@lixom.net (Olof Johansson)
Date: Thu, 27 Aug 2015 09:08:08 -0700
Subject: [RFC PATCH] arm/arm64: build all dtbs for CONPILE_TEST
In-Reply-To: <1440690994-5978-1-git-send-email-robh@kernel.org>
References: <1440690994-5978-1-git-send-email-robh@kernel.org>
Message-ID: <CAOesGMjzBaobpLsS77UziWeYO9wo21SkdpWT=Pib6AM7DDKTnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 27, 2015 at 8:56 AM, Rob Herring <robh@kernel.org> wrote:
> Enable building all dtb files when COMPILE_TEST is enabled. The dtbs are
> not really dependent on a platform being enabled or any other kernel
> config, so for testing coverage it is convenient to build all of the
> dtbs.
>
> This builds all dts files in the tree, not just targets listed. This
> is simpler for arm64 which has a bunch of sub-dirs.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
> I've had this on my todo list for a while. RFC for now as I want to do
> the rest of the arches as well. I was originally thinking a new target
> for this, but thanks to Olof for the COMPILE_TEST suggestion.
>
> Rob
>
>  arch/arm/boot/dts/Makefile   | 4 ++++
>  arch/arm64/boot/dts/Makefile | 6 ++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 246473a..4968442a 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -712,5 +712,9 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
>  dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
>  endif
>
> +dtstree                := $(srctree)/$(src)
> +
> +dtb-$(CONFIG_COMPILE_TEST) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
> +
>  always         := $(dtb-y)
>  clean-files    := *.dtb
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index 38913be..9f19390 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -11,3 +11,9 @@ dts-dirs += sprd
>  dts-dirs += xilinx
>
>  subdir-y       := $(dts-dirs)
> +
> +dtstree                := $(srctree)/$(src)
> +
> +dtb-$(CONFIG_COMPILE_TEST) := $(patsubst $(dtstree)/%.dts,%.dtb, $(foreach d,$(dts-dirs), $(wildcard $(dtstree)/$(d)/*.dts)))

I think it would be more appropriate to build dtb-n  here instead of
_any_ file ending in dts.

It would be useful to build all files, but it's not the behavior that
COMPILE_TEST usually has.


-Olof
