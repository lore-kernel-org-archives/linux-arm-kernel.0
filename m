From: rmallon@gmail.com (Ryan Mallon)
Date: Thu, 23 Feb 2012 09:33:02 +1100
Subject: [PATCH v2 09/19] ARM: at91: make sdram/ddr register base soc
 independent
In-Reply-To: <0acddc0a57ea5a198f662bf37047ebe95e3eb695.1329903206.git.nicolas.ferre@atmel.com>
References: <1329903585-30738-1-git-send-email-nicolas.ferre@atmel.com>
 <0acddc0a57ea5a198f662bf37047ebe95e3eb695.1329903206.git.nicolas.ferre@atmel.com>
Message-ID: <4F456D1E.8070807@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/02/12 20:39, Nicolas Ferre wrote:

> From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---

<snip>

> +void __init at91_ioremap_ramc(int id, u32 addr, u32 size)
> +{
> +	if (id > 1) {
> +		pr_warn("%s: id > 2\n", __func__);
> +		return;
> +	}
> +	at91_ramc_base[id] = ioremap(addr, size);
> +	if (!at91_ramc_base[id])
> +		pr_warn("Impossible to ioremap ramc.%d 0x%x\n", id, addr);
> +}


If this fails then you will oops if you call either at91_ramc_read or
at91_ramc_write since they don't check if at91_ramc_base[id] is a valid
pointer. Either this function should panic, like the other at91_ioremap
functions, or the at91_ramc_read/write functions should check for a
valid pointer.

Nitpick: The id check should probably also be BUG() or WARN() since it
indicates a bug in the core AT91 code. pr_warn is likely to missed and
not reported by users. Since the value is int, the check should be:

  if (id < 0 || id > 1)

Obviously the chance of this error happening are slim, but if you are
going to check and warn for it, it should be done properly :-).

~Ryan
