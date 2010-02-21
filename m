From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 21 Feb 2010 21:07:40 +0000
Subject: [PATCH 3/7] ARM: U300: set f_max to 24 MHz for MMCI
In-Reply-To: <1266537931-12560-1-git-send-email-linus.walleij@stericsson.com>
References: <1266537931-12560-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20100221210740.GA3528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2010 at 01:05:31AM +0100, Linus Walleij wrote:
> This employs the frequency setting mechanism introduced to the
> MMCI to specify that this system can actually be clocked at 24 MHz.
> 
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
>  arch/arm/mach-u300/mmc.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-u300/mmc.c b/arch/arm/mach-u300/mmc.c
> index 109f5a6..c1cb977 100644
> --- a/arch/arm/mach-u300/mmc.c
> +++ b/arch/arm/mach-u300/mmc.c
> @@ -101,6 +101,7 @@ int __devinit mmc_init(struct amba_device *adev)
>  	 * we have a regulator we can control instead.
>  	 */
>  	/* Nominally 2.85V on our platform */
> +	mmci_card->mmc0_plat_data.f_max = 24000000;

I bet setting this without DMA support leads to overruns/underruns on
the interface.  That's why MMCI has a low default - to ensure that PIO
mode can keep up with the data transfers; the low maximum isn't because
of something to do with ARM platforms.
