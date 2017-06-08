From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Jun 2017 17:29:39 +0100
Subject: [PATCH] arm: boot/compressed: fix inappropriate Thumb2 mnemonic
 for __nop
In-Reply-To: <20170608125847.2611-1-ard.biesheuvel@linaro.org>
References: <20170608125847.2611-1-ard.biesheuvel@linaro.org>
Message-ID: <20170608162939.GQ4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gah, it's rather unfortunate that this has been discovered only a
few days after the other decompressor fix was merged and hit Linus'
tree...

On Thu, Jun 08, 2017 at 12:58:47PM +0000, Ard Biesheuvel wrote:
> Commit 06a4b6d009a1 ("ARM: 8677/1: boot/compressed: fix decompressor
> header layout for v7-M") fixed an issue in the layout of the header
> of the compressed kernel image that was caused by the assembler
> emitting narrow opcodes for 'mov r0, r0', and for this reason, the
> mnemonic was updated to use the W() macro, which will append the .w
> suffix (which forces a wide encoding) if required, i.e., when building
> the kernel in Thumb2 mode.
> 
> However, this failed to take into account that on Thumb2 kernels built
> for CPUs that are also ARM capable, the entry point is entered in ARM
> mode, and so the instructions emitted here will be ARM instructions
> that only exist in a wide encoding to begin with, which is why the
> assembler rejects the .w suffix here and aborts the build with the
> following message:
> 
>   head.S: Assembler messages:
>   head.S:132: Error: width suffixes are invalid in ARM mode -- `mov.w r0,r0'
> 
> So replace the W(mov) with separate ARM and Thumb2 instructions, where
> the latter will only be used for CPU_THUMBONLY builds.
> 
> Fixes: 06a4b6d009a1 ("ARM: 8677/1: boot/compressed: fix decompressor ...")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> 
> Apologies for the breakage: apparently, the combination CONFIG_THUMB2_KERNEL=y,
> CONFIG_CPU_THUMBONLY=n and CONFIG_EFI_STUB=y was not among the configurations
> I tested before sending out the original patch.
> 
>  arch/arm/boot/compressed/efi-header.S | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/compressed/efi-header.S b/arch/arm/boot/compressed/efi-header.S
> index 3f7d1b74c5e0..a17ca8d78656 100644
> --- a/arch/arm/boot/compressed/efi-header.S
> +++ b/arch/arm/boot/compressed/efi-header.S
> @@ -17,7 +17,8 @@
>  		@ there.
>  		.inst	'M' | ('Z' << 8) | (0x1310 << 16)   @ tstne r0, #0x4d000
>  #else
> -		W(mov)	r0, r0
> + AR_CLASS(	mov	r0, r0		)
> +  M_CLASS(	nop.w			)
>  #endif
>  		.endm
>  
> -- 
> 2.9.3
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
