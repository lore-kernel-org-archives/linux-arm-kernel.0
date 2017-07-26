From: david@gibson.dropbear.id.au (David Gibson)
Date: Wed, 26 Jul 2017 11:30:04 +1000
Subject: [PATCH] scripts/dtc: fix '%zx' warning
In-Reply-To: <E1da2Z7-0008GG-AV@rmk-PC.armlinux.org.uk>
References: <E1da2Z7-0008GG-AV@rmk-PC.armlinux.org.uk>
Message-ID: <20170726013004.GJ8978@umbus.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 05:20:09PM +0100, Russell King wrote:
> dtc uses an incorrect format specifier for printing a uint64_t value.
> uint64_t may be either 'unsigned long' or 'unsigned long long' depending
> on the host architecture.
> 
> Fix this by using %llx and casting to unsigned long long, which ensures
> that we always have a wide enough variable to print 64 bits of hex.
> 
>   HOSTCC  scripts/dtc/checks.o
> scripts/dtc/checks.c: In function 'check_simple_bus_reg':
> scripts/dtc/checks.c:876:2: warning: format '%zx' expects argument of type 'size_t', but argument 4 has type 'uint64_t' [-Wformat=]
>   snprintf(unit_addr, sizeof(unit_addr), "%zx", reg);
>   ^
> scripts/dtc/checks.c:876:2: warning: format '%zx' expects argument of type 'size_t', but argument 4 has type 'uint64_t' [-Wformat=]
> 
> Fixes: 828d4cdd012c ("dtc: check.c fix compile error")
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

This (embarrassing) error is already fixed in upstream dtc.

> ---
>  scripts/dtc/checks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> I've been carrying this patch for some time, but I guess hardly anyone
> builds DT based kernels on 32-bit x86 boxes anymore as it has remained
> unfixed.
> 
> diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
> index 4b72b530c84f..62ea8f83d4a0 100644
> --- a/scripts/dtc/checks.c
> +++ b/scripts/dtc/checks.c
> @@ -873,7 +873,7 @@ static void check_simple_bus_reg(struct check *c, struct dt_info *dti, struct no
>  	while (size--)
>  		reg = (reg << 32) | fdt32_to_cpu(*(cells++));
>  
> -	snprintf(unit_addr, sizeof(unit_addr), "%zx", reg);
> +	snprintf(unit_addr, sizeof(unit_addr), "%llx", (unsigned long long)reg);
>  	if (!streq(unitname, unit_addr))
>  		FAIL(c, dti, "Node %s simple-bus unit address format error, expected \"%s\"",
>  		     node->fullpath, unit_addr);

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170726/f55751a8/attachment.sig>
