From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Oct 2012 22:51:36 +0100
Subject: [PATCH] arm: socfpga: fix build break for allyesconfig
In-Reply-To: <1351289861-16297-1-git-send-email-dinguyen@altera.com>
References: <1351289861-16297-1-git-send-email-dinguyen@altera.com>
Message-ID: <20121026215136.GC21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2012 at 04:17:41PM -0600, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add check for armv7 in headsmp.S.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> ---
>  arch/arm/mach-socfpga/headsmp.S |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-socfpga/headsmp.S b/arch/arm/mach-socfpga/headsmp.S
> index 17d6eaf..9031a3c 100644
> --- a/arch/arm/mach-socfpga/headsmp.S
> +++ b/arch/arm/mach-socfpga/headsmp.S
> @@ -15,8 +15,10 @@
>  #define CPU1_START_ADDR 	        0xffd08010
>  
>  ENTRY(secondary_trampoline)
> +#if __LINUX_ARM_ARCH__ >= 7
>  	movw	r0, #:lower16:CPU1_START_ADDR
>  	movt  r0, #:upper16:CPU1_START_ADDR
> +#endif

If you do that, then it effectively means you don't need these instructions
and you might as well just delete them... but looking at the following one:

>  	ldr	r1, [r0]

it's clear that you do need it.  So you need to find a different solution.
If the above assembly file can only run on ARMv7, consider putting

	.march	armv7

or similar before it.
