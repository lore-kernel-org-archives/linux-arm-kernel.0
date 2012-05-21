From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 21 May 2012 23:08:37 +0530
Subject: [PATCH] ARM: davinci: turn off DDR PHY when entering deep sleep
In-Reply-To: <1336672352-23191-1-git-send-email-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <1336672352-23191-1-git-send-email-marcus.folkesson@gmail.com>
Message-ID: <4FBA7D9D.6060202@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcus,

Thanks for the patch.

On 5/10/2012 11:22 PM, Marcus Folkesson wrote:
> Deepsleep is the most power saving state on the davinci-platform.
> The DDR PHY consumes about 25mW and should be turned off in this low
> power state.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  arch/arm/mach-davinci/include/mach/memory.h |    2 ++
>  arch/arm/mach-davinci/sleep.S               |   10 ++++++++++
>  2 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/include/mach/memory.h b/arch/arm/mach-davinci/include/mach/memory.h
> index 7873194..1b1b8ac 100644
> --- a/arch/arm/mach-davinci/include/mach/memory.h
> +++ b/arch/arm/mach-davinci/include/mach/memory.h

This is moved to arch/arm/mach-davinci/include/mach/ddr2.h in current
kernel.

> @@ -36,6 +36,8 @@
>  #define DDR2_MCLKSTOPEN_BIT	BIT(30)
>  #define DDR2_LPMODEN_BIT	BIT(31)
>  
> +#define DDR2_DRPHYC1R_OFFSET 	0xe4
> +#define DDR_PWRDNEN_BIT 		BIT(6)
>  /*
>   * Increase size of DMA-consistent memory region
>   */
> diff --git a/arch/arm/mach-davinci/sleep.S b/arch/arm/mach-davinci/sleep.S
> index 5f1e045..30713b2 100644
> --- a/arch/arm/mach-davinci/sleep.S
> +++ b/arch/arm/mach-davinci/sleep.S
> @@ -57,6 +57,11 @@ ENTRY(davinci_cpu_suspend)
>  
>  	ldmia	r0, {r0-r4}
>  
> +	/* Turn PHY off */
> +	ldr	ip, [r0, #DDR2_DRPHYC1R_OFFSET]
> +	orr	ip, ip, #DDR_PWRDNEN_BIT 	
> +	str	ip, [r0, #DDR2_DRPHYC1R_OFFSET]

Current TRM (section 14.2.13.1) specifies that this bit be set during
DDR initialization sequence itself (done in UBL or U-Boot/SPL). I am
checking with folks from the TI design team on whether it can be done
later on as part of the DeepSleep sequence.

It looks like IOPWRDN bit in VTPIO_CTL also needs to be set for this
configuration take effect. You probably did not have to do it because
the bootloader you are using already has this set?

How much testing has this patch undergone? Have you tested it across
multiple suspend-resume cycles? How much does the power consumed by DDR
PHY go down by (and which type of DDR)?

Thanks,
Sekhar
