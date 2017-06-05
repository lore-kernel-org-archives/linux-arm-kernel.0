From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Jun 2017 10:34:29 +0100
Subject: [PATCH] arm: LPAE: kexec: clear TTBCR.T1SZ explicitly when
 PHYS_OFFSET > PAGE_OFFSET
In-Reply-To: <1496654569-4749-1-git-send-email-hoeun.ryu@gmail.com>
References: <1496654569-4749-1-git-send-email-hoeun.ryu@gmail.com>
Message-ID: <20170605093429.GE4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 05, 2017 at 06:22:20PM +0900, Hoeun Ryu wrote:
> diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
> index 5e5720e..9ac2bec 100644
> --- a/arch/arm/mm/proc-v7-3level.S
> +++ b/arch/arm/mm/proc-v7-3level.S
> @@ -140,6 +140,7 @@ ENDPROC(cpu_v7_set_pte_ext)
>  	 * otherwise booting secondary CPUs would end up using TTBR1 for the
>  	 * identity mapping set up in TTBR0.
>  	 */
> +	bichi	\tmp, \tmp, #(1 << 16)				@ clear TTBCR.T1SZ

This looks insufficient.  There's two bits here:

 * TTBR0/TTBR1 split (PAGE_OFFSET):
 *   0x40000000: T0SZ = 2, T1SZ = 0 (not used)
 *   0x80000000: T0SZ = 0, T1SZ = 1
 *   0xc0000000: T0SZ = 0, T1SZ = 2

but you seem to only be clearing one bit.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently@9.6Mbps down 400kbps up
according to speedtest.net.
