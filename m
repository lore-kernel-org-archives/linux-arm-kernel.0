From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 11 Jun 2015 13:10:52 +0100
Subject: [PATCH] ARM: mm: show prefetch state when either data or instr
 prefect is enabled
In-Reply-To: <1434023531-20052-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1434023531-20052-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20150611121052.GX7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 11, 2015 at 01:52:11PM +0200, Thomas Petazzoni wrote:
> The l2c310_enable() function shows the state of prefetch configuration
> only when both data *and* instruction prefetching is enabled, but the

Completely wrong, sorry.

> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index d6e43d8..6bdf3a5 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -656,7 +656,8 @@ static void __init l2c310_enable(void __iomem *base, u32 aux, unsigned num_lock)
>  	/* Read back resulting AUX_CTRL value as it could have been altered. */
>  	aux = readl_relaxed(base + L2X0_AUX_CTRL);
>  
> -	if (aux & (L310_AUX_CTRL_DATA_PREFETCH | L310_AUX_CTRL_INSTR_PREFETCH)) {

What this says is...
	first, bitwise _OR_ L310_AUX_CTRL_DATA_PREFETCH with
	L310_AUX_CTRL_INSTR_PREFETCH.  This produces a number which has
	_two_ bits set.

	then, bitwise _AND_ that number with the auxiliary control register.

	If the result is non-zero, then execute the code within the if() { }
	block.

So, I'm not going to take this patch.  The code is correct as it stands.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
