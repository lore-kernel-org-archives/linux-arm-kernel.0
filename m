From: robherring2@gmail.com (Rob Herring)
Date: Mon, 03 Dec 2012 10:15:44 -0600
Subject: [PATCH V7 2/7] ARM: dt: change .dtb build rules to build in dts
 directory
In-Reply-To: <1354058956-7199-2-git-send-email-swarren@wwwdotorg.org>
References: <1354058956-7199-1-git-send-email-swarren@wwwdotorg.org>
 <1354058956-7199-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <50BCD030.7020908@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/2012 05:29 PM, Stephen Warren wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> The current rules have the .dtb files build in a different directory
> from the .dts files. The only reason for this is that it was what
> PowerPC has done historically. This patch changes ARM to use the generic
> dtb rule which builds .dtb files in the same directory as the source .dts.

[snip]

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index a17d5ab..cb217f8 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -136,4 +136,12 @@ dtb-$(CONFIG_ARCH_VT8500) += vt8500-bv07.dtb \
>  	wm8650-mid.dtb
>  dtb-$(CONFIG_ARCH_ZYNQ) += zynq-zc702.dtb
>  
> +targets += dtbs
>  endif
> +
> +dtbs: $(addprefix $(obj)/, $(dtb-y))
> +	# *.dtb used to be generated in the directory above. Clean out the
> +	# old build results so people don't accidentally use them.
> +	rm -f $(obj)/../*.dtb

Do you intend for this to print out? Seems a little noisy to me for a
one-time problem. Are you trying to tell users the dtb files moved or
just prevent them from using the old ones? Quietly removing them would
still accomplish the latter.

Rob

> +
> +clean-files := *.dtb
> 
