From: tony@atomide.com (Tony Lindgren)
Date: Mon, 21 Jan 2013 11:03:03 -0800
Subject: [PATCH 02/15] ARM: mvebu: build coherency_ll.S for arch=armv7-a
In-Reply-To: <1358788568-11137-3-git-send-email-arnd@arndb.de>
References: <1358788568-11137-1-git-send-email-arnd@arndb.de>
 <1358788568-11137-3-git-send-email-arnd@arndb.de>
Message-ID: <20130121190302.GN22517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [130121 09:23]:
> In a multiplatform kernel, one can enable mach-mvebu
> together with one or more ARMv6 platforms, which leads
> to all files being built for v6. The coherency_ll.S
> uses the "dsb" instruction that is only available for
> v7, causing a build error in this case. Since the
> file is only used on v7 based machines, it is safe
> to build it using an ".arch armv7-a" statement.
> 
> Without this patch, building allyesconfig results in:
> 
> arch/arm/mach-mvebu/coherency_ll.S: Assembler messages:
> arch/arm/mach-mvebu/coherency_ll.S:45: Error: selected processor does not support ARM mode `dsb'

This should be already fixed by 72533b (arm: mvebu: Fix compile for
multiplatform when ARMv6 is selected) in arm-soc fixes branch.

Regards,

Tony
 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/coherency_ll.S |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-mvebu/coherency_ll.S b/arch/arm/mach-mvebu/coherency_ll.S
> index 53e8391..7648bda 100644
> --- a/arch/arm/mach-mvebu/coherency_ll.S
> +++ b/arch/arm/mach-mvebu/coherency_ll.S
> @@ -25,6 +25,7 @@
>   * r0: Coherency fabric base register address
>   * r1: HW CPU id
>   */
> +	.arch armv7-a
>  ENTRY(ll_set_cpu_coherent)
>  	/* Create bit by cpu index */
>  	mov	r3, #(1 << 24)
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
