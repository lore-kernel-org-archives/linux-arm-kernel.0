From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Sep 2016 11:23:53 +0100
Subject: [PATCH] ARM: decompressor: reset ttbcr fields to use TTBR0 on
 ARMv7
In-Reply-To: <1473663420-18629-1-git-send-email-sramana@codeaurora.org>
References: <57D3C06D.4030908@codeaurora.org>
 <1473663420-18629-1-git-send-email-sramana@codeaurora.org>
Message-ID: <20160912102352.GU1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2016 at 12:27:00PM +0530, Srinivas Ramana wrote:
> If the bootloader uses the long descriptor format and jumps to
> kernel decompressor code, TTBCR may not be in a right state.
> Before enabling the MMU, it is required to clear the TTBCR.PD0
> field to use TTBR0 for translation table walks.
> 
> The 'commit dbece45894d3a ("ARM: 7501/1: decompressor:
> reset ttbcr for VMSA ARMv7 cores")' does the reset of TTBCR.N, but

There's no need to single-quote the commit part of this sentence.

> doesn't consider all the bits for the size of TTBCR.N.
> 
> Clear TTBCR.PD0 field and reset all the three bits of TTBCR.N to
> indicate the use of TTBR0 and the correct base address width.
> 

Adding a properly formatted Fixes: line here would be a bonus if we
need to backport it to stable trees.

> Signed-off-by: Srinivas Ramana <sramana@codeaurora.org>
> ---
>  arch/arm/boot/compressed/head.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index af11c2f8f3b7..fc6d541549a2 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -779,7 +779,7 @@ __armv7_mmu_cache_on:
>  		orrne	r0, r0, #1		@ MMU enabled
>  		movne	r1, #0xfffffffd		@ domain 0 = client
>  		bic     r6, r6, #1 << 31        @ 32-bit translation system
> -		bic     r6, r6, #3 << 0         @ use only ttbr0
> +		bic     r6, r6, #(7 << 0) | (1 << 4)	@ use only ttbr0

Provided this is correct (I've not checked, I'd like an ack from one of
the ARM people, and I'd prefer to see a tested-by as well), and the above
points are addressed, it can be dropped into the patch system.  Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently@9.6Mbps down 400kbps up
according to speedtest.net.
