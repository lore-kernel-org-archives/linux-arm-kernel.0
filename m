From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Thu, 17 Oct 2013 09:29:21 +0200
Subject: [PATCH v2 1/1] ARM: imx: i.mx6d/q: disable the double linefill
 feature of PL310
In-Reply-To: <1379294943-15664-1-git-send-email-r64343@freescale.com>
References: <1379294943-15664-1-git-send-email-r64343@freescale.com>
Message-ID: <525F91D1.5040304@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.09.2013 03:29, Jason Liu wrote:
> The L2 cache controller(PL310) version on the i.MX6D/Q is r3p1-50rel0
> The L2 cache controller(PL310) version on the i.MX6DL/SOLO/SL is r3p2
> But according to ARM PL310 errata: 752271
> ID: 752271: Double linefill feature can cause data corruption
> Fault Status: Present in: r3p0, r3p1, r3p1-50rel0. Fixed in r3p2
> Workaround: The only workaround to this erratum is to disable the
> double linefill feature. This is the default behavior.
>
> without this patch, you will meet the following error when run the
> memtester application at: http://pyropus.ca/software/memtester/
>
> FAILURE: 0x00100000 != 0x00200000 at offset 0x01365664.
> FAILURE: 0x00100000 != 0x00200000 at offset 0x01365668.
> FAILURE: 0x00100000 != 0x00200000 at offset 0x0136566c.
> FAILURE: 0x00100000 != 0x00200000 at offset 0x01365670.
> FAILURE: 0x00100000 != 0x00200000 at offset 0x01365674.
> FAILURE: 0x00100000 != 0x00200000 at offset 0x01365678.
>
> Signed-off-by: Jason Liu <r64343@freescale.com>
>
> ---
> V2:
> - disable the L2 doulbe linefill explicitly on i.MX6Q by using &= mask
> - using the cpu_is_imx6q() instead of checking through DT
> ---
>   arch/arm/mach-imx/system.c |   11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
> index 64ff37e..80c177c 100644
> --- a/arch/arm/mach-imx/system.c
> +++ b/arch/arm/mach-imx/system.c
> @@ -117,6 +117,17 @@ void __init imx_init_l2cache(void)
>   	/* Configure the L2 PREFETCH and POWER registers */
>   	val = readl_relaxed(l2x0_base + L2X0_PREFETCH_CTRL);
>   	val |= 0x70800000;
> +	/*
> +	 * The L2 cache controller(PL310) version on the i.MX6D/Q is r3p1-50rel0
> +	 * The L2 cache controller(PL310) version on the i.MX6DL/SOLO/SL is r3p2
> +	 * But according to ARM PL310 errata: 752271
> +	 * ID: 752271: Double linefill feature can cause data corruption
> +	 * Fault Status: Present in: r3p0, r3p1, r3p1-50rel0. Fixed in r3p2
> +	 * Workaround: The only workaround to this erratum is to disable the
> +	 * double linefill feature. This is the default behavior.
> +	 */
> +	if (cpu_is_imx6q())
> +		val &= ~(1 << 30 | 1 << 23);

Since you sent this patch I was wondering why you touch Bit 23, too.

Having access to the manual, now (CoreLink? Level 2 Cache Controller
L2C-310 Revision: r3p3 ARM DDI 0246H (ID080112)) it states on page 2-39 
(section Double linefill issuing):

"You can control this feature (the double linefill) using Bits 30, 27, 
and 23 of the Prefetch Control Register. Bit 23, and Bit 27 are only 
used if you set Bit 30 HIGH."

I.e. to my understanding

val &= ~(1 << 30);

should be sufficient here?

Best regards

Dirk
