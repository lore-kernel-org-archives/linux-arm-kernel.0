From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 Feb 2011 09:59:43 +0000
Subject: [PATCH v4 03/19] ARM: LPAE: use long long format when printing
	physical addresses and ptes
In-Reply-To: <1295891761-18366-4-git-send-email-catalin.marinas@arm.com>
References: <1295891761-18366-1-git-send-email-catalin.marinas@arm.com>
	<1295891761-18366-4-git-send-email-catalin.marinas@arm.com>
Message-ID: <20110212095943.GB15616@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 05:55:45PM +0000, Catalin Marinas wrote:
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 5ea4fb7..3d23f0f 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -449,7 +449,7 @@ static int __init arm_add_memory(unsigned long start, unsigned long size)
>  
>  	if (meminfo.nr_banks >= NR_BANKS) {
>  		printk(KERN_CRIT "NR_BANKS too low, "
> -			"ignoring memory at %#lx\n", start);
> +			"ignoring memory at %#08llx\n", (long long)start);

This is not equivalent.  %#lx produces '0x0'.  %#08llx produces '0x000000'
not '0x00000000' - the '0x' is included in the field width.  So you want
'%#010llx' or '0x%08llx' - there's no real advantage to either.  Or just
convert '%#lx' to '%#llx'.
