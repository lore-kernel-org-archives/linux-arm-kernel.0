From: frowand.list@gmail.com (Frank Rowand)
Date: Wed, 5 Sep 2018 13:52:50 -0700
Subject: [RESEND PATCHv2 1/2] ARM: dts: ti: add support for building Texas
 Instruments specific overlays
In-Reply-To: <1536049651-10206-2-git-send-email-t-kristo@ti.com>
References: <1535722107-13767-1-git-send-email-t-kristo@ti.com>
 <1536049651-10206-1-git-send-email-t-kristo@ti.com>
 <1536049651-10206-2-git-send-email-t-kristo@ti.com>
Message-ID: <ac8227f4-4be3-df90-e2b9-6994b8b62592@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/18 01:27, Tero Kristo wrote:
> Add support for TI specific DT subdir, along with support for building
> DT overlays. Right now, no DT files are specified in this directory,
> those are to be added later.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  arch/arm/boot/dts/Makefile    | 1 +
>  arch/arm/boot/dts/ti/Makefile | 9 +++++++++
>  2 files changed, 10 insertions(+)
>  create mode 100644 arch/arm/boot/dts/ti/Makefile
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b5bd3de..59a4b63 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -755,6 +755,7 @@ dtb-$(CONFIG_SOC_DRA7XX) += \
>  	dra72-evm-revc.dtb \
>  	dra71-evm.dtb \
>  	dra76-evm.dtb
> +subdir-$(CONFIG_SOC_DRA7XX) += ti
>  dtb-$(CONFIG_ARCH_ORION5X) += \
>  	orion5x-kuroboxpro.dtb \
>  	orion5x-lacie-d2-network.dtb \

My memory of previous discussion of creating subdirectories beneath
arch/arm/boot/dts/ has faded.  Or maybe such discussion never occurred.

Maybe Rob or someone else has a memory of such discussion.  If they don't
chime in with a pointer, can you search for that discussion?  And if it
occurred, what the general consensus was, and why it never was implemented?


> diff --git a/arch/arm/boot/dts/ti/Makefile b/arch/arm/boot/dts/ti/Makefile
> new file mode 100644
> index 0000000..e0203ba
> --- /dev/null
> +++ b/arch/arm/boot/dts/ti/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Make file to build device tree binaries for boards based on
> +# Texas Instruments Inc processors
> +#
> +# Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
> +#
> +
> +DTC_FLAGS += -@
> 

I will nack any attempt to unconditionally compile a devicetree file with the
-@ flag (which adds symbols to the resulting .dtb).  The resulting overhead
is not acceptable.

Adding the symbols must be under the control of the person either creating
or using the .dtb.  The way to provide that control is the challenging part.

One way would be to configure the compile option via kbuild configuration.
There is opposition to this approach because it makes the .dtb dependent
on the Linux kernel configuration.  So suggestions of an alternative
mechanism would be welcome.

Another _possible_ solution would be to add a dtc_strip tool to the dtc
project.  dtc_strip would remove the symbol information from a .dtb,
in a manner that is analogous to strip removing debug information from
a program file.

One aspect of unconditionally building a .dtb with symbols, then
optionally removing the symbols with dtc_strip is that it seems
like a backwards process.  For example, we don't build the kernel
with debug symbols then strip the symbols out when we don't want
them.  I'll have to mull this over if the dtc_strip method sounds
like a good approach to other people.
