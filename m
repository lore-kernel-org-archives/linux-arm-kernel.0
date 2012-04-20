From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 21 Apr 2012 00:34:12 +0100
Subject: [PATCH] arm: omap: fix trivial warnings for dspbridge
In-Reply-To: <1334959458-2873-1-git-send-email-felipe.contreras@gmail.com>
References: <1334959458-2873-1-git-send-email-felipe.contreras@gmail.com>
Message-ID: <20120420233412.GD24205@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 21, 2012 at 01:04:18AM +0300, Felipe Contreras wrote:
> arch/arm/plat-omap/devices.c: In function 'omap_dsp_reserve_sdram_memblock':
> arch/arm/plat-omap/devices.c:170: warning: format '%x' expects type 'unsigned int', but argument 3 has type 'phys_addr_t'
> arch/arm/mach-omap2/dsp.c: In function 'omap_dsp_init':
> arch/arm/mach-omap2/dsp.c:60: warning: format '%x' expects type 'unsigned int', but argument 3 has type 'phys_addr_t'
> arch/arm/mach-omap2/dsp.c:60: warning: format '%x' expects type 'unsigned int', but argument 4 has type 'phys_addr_t'
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  arch/arm/mach-omap2/dsp.c    |    5 +++--
>  arch/arm/plat-omap/devices.c |    4 ++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/dsp.c b/arch/arm/mach-omap2/dsp.c
> index 74f18f2..7665c49 100644
> --- a/arch/arm/mach-omap2/dsp.c
> +++ b/arch/arm/mach-omap2/dsp.c
> @@ -57,8 +57,9 @@ static int __init omap_dsp_init(void)
>  
>  	if (pdata->phys_mempool_base) {
>  		pdata->phys_mempool_size = CONFIG_TIDSPBRIDGE_MEMPOOL_SIZE;
> -		pr_info("%s: %x bytes @ %x\n", __func__,
> -			pdata->phys_mempool_size, pdata->phys_mempool_base);
> +		pr_info("%s: %llu bytes @ %llu\n", __func__,

No, don't change a unprefixed hex number to a decimal number.  Keep
the same formatting, just fix the warning.  Changing the base of the
displayed number when there's no hex prefix to it is just plain idiotic
and creates confusion.  Think: is the number 12345678 output by one of
these a hex number or a decimal number?

Besides, base addresses _should_ be hex numbers.  I'd agree that sizes
should probably be decimal, but as none of these locations you're fixing
had 0x prefixes, I'd strongly advise to leave them as-is - esp. for a
patch allegedly just fixing warnings.
