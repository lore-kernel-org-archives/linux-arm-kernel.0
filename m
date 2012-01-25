From: sbabic@denx.de (Stefano Babic)
Date: Wed, 25 Jan 2012 15:49:25 +0100
Subject: [PATCH] ARM: mxs: read correct values when setting up MAC
In-Reply-To: <1327431447-5031-1-git-send-email-w.sang@pengutronix.de>
References: <1327431447-5031-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <4F201675.6050308@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/01/2012 19:57, Wolfram Sang wrote:
> Currently, the MAC address from the second ethernet is generated from the
> crypto-key (and not a customer reg) because of a wrong index to the ocotp
> array.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Stefano Babic <sbabic@denx.de>
> ---
> 

Hi Wolfram,

> This looks clearly wrong to me; probably ocotp was a u8 somewhen in the
> process? I wonder how it works for these boards. Am I missing something?

Maybe you're right, but let's check with the manual:

> 
>  arch/arm/mach-mxs/mach-m28evk.c  |    2 +-
>  arch/arm/mach-mxs/mach-mx28evk.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/mach-m28evk.c b/arch/arm/mach-mxs/mach-m28evk.c
> index 2f27582..8d1459d 100644
> --- a/arch/arm/mach-mxs/mach-m28evk.c
> +++ b/arch/arm/mach-mxs/mach-m28evk.c
> @@ -258,7 +258,7 @@ static int __init m28evk_fec_get_mac(void)
>  	 * so hard-code DENX OUI (C0:E5:4E) here.
>  	 */
>  	for (i = 0; i < 2; i++) {
> -		val = ocotp[i * 4];
> +		val = ocotp[i];

I can read that HW_OCOTP_CUST0 has the phisycal address 0x8002_C020h,
and HW_OCOTP_CUST1 ist at 8002_C030h. So the two registers are not
consecutive and there are some reserved fields between the two registers
- this is the reason for the i * 4.

HW_OCOTP_CRYPTO0 is at 8002_C060h, so it is not true that the address is
currently read from the crypto-key. At least, this is my interpretation...

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
=====================================================================
