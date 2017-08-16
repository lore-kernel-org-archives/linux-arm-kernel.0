From: frowand.list@gmail.com (Frank Rowand)
Date: Wed, 16 Aug 2017 15:33:00 -0700
Subject: [PATCH] ARM: dts: TI: Enable __symbols__ in dtb files for some
 platforms
In-Reply-To: <1502920751-11121-1-git-send-email-trini@konsulko.com>
References: <1502920751-11121-1-git-send-email-trini@konsulko.com>
Message-ID: <5994C81C.609@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/16/17 14:59, Tom Rini wrote:
> Build the dtb file for these platfroms with __symbol__ information
> included.  This will reduce the size of the dtb (and resident memory

typo: reduce the size should be increase the size


> usage) in exchange for allowing more types of overlays to be applied to
> the dtb file prior to passing it to Linux and additional functionality
> within the kernel when OF_OVERLAY is enabled.
> 
> Cc: Jason Kridner <jkridner@beagleboard.org>
> Cc: Drew Fustini <drew@beagleboard.org>
> Cc: Robert Nelson <robertcnelson@gmail.com>
> Cc: Lokesh Vutla <lokeshvutla@ti.com>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> This patch takes the path that Rob encouraged in my previous patch of
> enabling __symbols__ in some platforms now (that can use it) and see if
> a critical mass evolves that pushes towards -@ being default for all
> dtbs.  I would suggest that the dra76 series be respun to include a hunk
> like this at least as well, and if there's another Beagle X15 patch,
> that too.  Russell, per some of our conversations, something like would
> also be needed as part of using overlays to solve some of the problems
> with Hummingboard, etc.
> ---
>  arch/arm/boot/dts/Makefile | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 4b17f35dc9a7..6f98422ca00e 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1063,3 +1063,17 @@ dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dts
>  
>  always		:= $(dtb-y)
>  clean-files	:= *.dtb
> +
> +# enable creation of __symbols__ node
> +DTC_FLAGS_am335x-bone += -@
> +DTC_FLAGS_am335x-boneblack += -@
> +DTC_FLAGS_am335x-boneblack-wireless += -@
> +DTC_FLAGS_am335x-boneblue += -@
> +DTC_FLAGS_am335x-bonegreen += -@
> +DTC_FLAGS_am335x-bonegreen-wireless += -@
> +DTC_FLAGS_am57xx-beagle-x15 += -@
> +DTC_FLAGS_am57xx-beagle-x15-revb1 += -@
> +DTC_FLAGS_dra7-evm += -@
> +DTC_FLAGS_dra72-evm += -@
> +DTC_FLAGS_dra72-evm-revc += -@
> +DTC_FLAGS_dra71-evm += -@
> 

I would prefer that instead of "-@", a configurable value be used.

The current form of the patch imposes the extra overhead even
for those who do not want to use any overlay.

Using a kernel CONFIG_ value for the "configurable value" is not
desired because it adds a kernel configuration dependency to what
is contained in a dtb.  I do not know if we can find another
better way to make this configurable.  AMaybe Rob's suggestion
of a shell variable used in the make command.
