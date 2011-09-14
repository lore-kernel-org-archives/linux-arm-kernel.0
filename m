From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 14 Sep 2011 14:32:44 +0100
Subject: [PATCH 2/6] ARM: zImage: Allow the appending of a device tree
	binary
In-Reply-To: <1315978906-15829-3-git-send-email-nico@fluxnic.net>
References: <1315978906-15829-1-git-send-email-nico@fluxnic.net>
	<1315978906-15829-3-git-send-email-nico@fluxnic.net>
Message-ID: <20110914133244.GE2104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2011 at 01:41:42AM -0400, Nicolas Pitre wrote:
> From: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> This patch provides the ability to boot using a device tree that is appended
> to the raw binary zImage (e.g. cat zImage <filename>.dtb > zImage_w_dtb).
> 
> Signed-off-by: John Bonesio <bones@secretlab.ca>
> [nico: adjusted to latest zImage changes plus additional cleanups]
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/Kconfig                |    8 ++++
>  arch/arm/boot/compressed/head.S |   70 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 75 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5ebc5d922e..83323c2b1f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1781,6 +1781,14 @@ config ZBOOT_ROM_SH_MOBILE_SDHI
>  
>  endchoice
>  
> +config ARM_APPENDED_DTB
> +	bool "Use appended device tree blob to zImage"
> +	depends on OF && !ZBOOT_ROM
> +	help
> +	  With this option, the boot code will look for a device tree binary
> +	  (dtb) appended to zImage
> +	  (e.g. cat zImage <filename>.dtb > zImage_w_dtb).
> +
>  config CMDLINE
>  	string "Default kernel command string"
>  	default ""
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index e95a598960..3ce5738ddb 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -216,6 +216,59 @@ restart:	adr	r0, LC0
>  		mov	r10, r6
>  #endif
>  
> +		mov	r5, #0			@ init dtb size to 0
> +#ifdef CONFIG_ARM_APPENDED_DTB
> +/*
> + *   r0  = delta
> + *   r2  = BSS start
> + *   r3  = BSS end
> + *   r4  = final kernel address
> + *   r5  = appended dtb size (still unknown)
> + *   r6  = _edata
> + *   r7  = architecture ID
> + *   r8  = atags/device tree pointer
> + *   r9  = size of decompressed image
> + *   r10 = end of this image, including  bss/stack/malloc space if non XIP
> + *   r11 = GOT start
> + *   r12 = GOT end
> + *   sp  = stack pointer
> + *
> + * if there are device trees (dtb) appended to zImage, advance r10 so that the
> + * dtb data will get relocated along with the kernel if necessary.
> + */
> +
> +		ldr	lr, [r6, #0]
> +#ifndef __ARMEB__
> +		ldr	r1, =0xedfe0dd0		@ sig is 0xd00dfeed big endian
> +#else
> +		ldr	r1, =0xd00dfeed
> +#endif

Do we worry that garbage in memory after the zImage might match this
magic number?

For example, if an ordinary userspace program allocates a huge number
of pages and fills them with bogus device tree headers, is there a chance
that the those headers could remain in memory across a reboot?

In principle this could lead to a security hole on platforms where the
boot images don't append a device tree, by allowing an attacker to
override the bootargs etc.

I don't know whether this is exploitable in practice, but it's worth
thinking about (apologies if it's already been discussed)


A possible workaround is to put a relative pointer or a flag at the
start of the zImage, which we can poke with a non-zero value when
the device tree is appended.

This makes appending the device tree non-trivial, but it's still pretty
simple to do; something like:

$ echo 'boo' | dd bs=4 count=1 seek=4 conv=notrunc of=zImage
$ cat dtb >>zImage

(Where I assume that the affected word in the zImage is initially not
'boo').

Cheers
---Dave
