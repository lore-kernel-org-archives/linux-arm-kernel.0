From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 9 Jan 2018 10:58:47 +0000
Subject: [PATCH] ARM: imx: Improve the soc revision calculation flow
In-Reply-To: <1515486632-18488-1-git-send-email-ping.bai@nxp.com>
References: <1515486632-18488-1-git-send-email-ping.bai@nxp.com>
Message-ID: <AM3PR04MB30614F10E6938D057D83A8180100@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacky,

> -----Original Message-----
> From: Jacky Bai
> Sent: Tuesday, January 09, 2018 4:31 PM
> To: shawnguo at kernel.org; kernel at pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>;
> A.s. Dong <aisheng.dong@nxp.com>; jacky.baip at gmail.com
> Subject: [PATCH] ARM: imx: Improve the soc revision calculation flow
> 
> On our i.MX6 SOC, the DIGPROG register is used for representing the SOC ID
> and silicon revision. The revision has two part: MAJOR and MINOR. each is
> represented in 8 bits in the register.
> 
> bits [15:8]: reflect the MAJOR part of the revision; bits [7:0]: reflect the MINOR
> part of the revision;
> 
> In our linux kernel, the soc revision is represented in 8 bits.
> MAJOR part and MINOR each occupy 4 bits.
> 
> previous method does NOT take care about the MAJOR part in DIGPROG
> register. So reformat the revision read from the HW to be compatible with the
> revision format used in kernel.
> 

It would be better if there's more clarification on the real effect of this patch in commit
message.
e.g. what real issue it could be if without this patch?

I guess it would show rev over 2.x correctly, right?

BTW, since this patch totally remove the using of already defined rev macros,
I wonder if it's a good idea.

Just a thought, how about do something like mx3 which keeps using the macros?

static struct {
        u8 srev;
        const char *name;
        unsigned int rev;
} mx31_cpu_type[] = {
        { .srev = 0x00, .name = "i.MX31(L)", .rev = IMX_CHIP_REVISION_1_0 },
        { .srev = 0x10, .name = "i.MX31",    .rev = IMX_CHIP_REVISION_1_1 },
        { .srev = 0x11, .name = "i.MX31L",   .rev = IMX_CHIP_REVISION_1_1 },
        { .srev = 0x12, .name = "i.MX31",    .rev = IMX_CHIP_REVISION_1_1 },
        { .srev = 0x13, .name = "i.MX31L",   .rev = IMX_CHIP_REVISION_1_1 },
        { .srev = 0x14, .name = "i.MX31",    .rev = IMX_CHIP_REVISION_1_2 },
        { .srev = 0x15, .name = "i.MX31L",   .rev = IMX_CHIP_REVISION_1_2 },
        { .srev = 0x28, .name = "i.MX31",    .rev = IMX_CHIP_REVISION_2_0 },
        { .srev = 0x29, .name = "i.MX31L",   .rev = IMX_CHIP_REVISION_2_0 },
};
static int mx31_read_cpu_rev(void)

Regards
Dong Aisheng


> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> ---
>  arch/arm/mach-imx/anatop.c | 58 +++++++++++++++++--------------------------
> ---
>  1 file changed, 21 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c index
> 649a84c..170cb30 100644
> --- a/arch/arm/mach-imx/anatop.c
> +++ b/arch/arm/mach-imx/anatop.c
> @@ -1,5 +1,6 @@
>  /*
>   * Copyright (C) 2013-2015 Freescale Semiconductor, Inc.
> + * Copyright NXP 2017.
>   *
>   * The code contained herein is licensed under the GNU General Public
>   * License. You may obtain a copy of the GNU General Public License @@ -
> 116,6 +117,8 @@ void __init imx_init_revision_from_anatop(void)
>  	unsigned int revision;
>  	u32 digprog;
>  	u16 offset = ANADIG_DIGPROG;
> +	u16 major_part, minor_part;
> +
> 
>  	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-anatop");
>  	anatop_base = of_iomap(np, 0);
> @@ -127,45 +130,26 @@ void __init imx_init_revision_from_anatop(void)
>  	digprog = readl_relaxed(anatop_base + offset);
>  	iounmap(anatop_base);
> 
> -	switch (digprog & 0xff) {
> -	case 0:
> -		/*
> -		 * For i.MX6QP, most of the code for i.MX6Q can be resued,
> -		 * so internally, we identify it as i.MX6Q Rev 2.0
> -		 */
> -		if (digprog >> 8 & 0x01)
> -			revision = IMX_CHIP_REVISION_2_0;
> -		else
> -			revision = IMX_CHIP_REVISION_1_0;
> -		break;
> -	case 1:
> -		revision = IMX_CHIP_REVISION_1_1;
> -		break;
> -	case 2:
> -		revision = IMX_CHIP_REVISION_1_2;
> -		break;
> -	case 3:
> -		revision = IMX_CHIP_REVISION_1_3;
> -		break;
> -	case 4:
> -		revision = IMX_CHIP_REVISION_1_4;
> -		break;
> -	case 5:
> -		/*
> -		 * i.MX6DQ TO1.5 is defined as Rev 1.3 in Data Sheet, marked
> -		 * as 'D' in Part Number last character.
> -		 */
> -		revision = IMX_CHIP_REVISION_1_5;
> -		break;
> -	default:
> -		/*
> -		 * Fail back to return raw register value instead of 0xff.
> -		 * It will be easy to know version information in SOC if it
> -		 * can't be recognized by known version. And some chip's
> (i.MX7D)
> -		 * digprog value match linux version format, so it needn't map
> -		 * again and we can use register value directly.
> +	/*
> +	 * On i.MX7D digprog value match linux version format, so
> +	 * it needn't map again and we can use register value directly.
> +	 */
> +	if (of_device_is_compatible(np, "fsl,imx7d-anatop")) {
> +		revision = digprog & 0xff;
> +	} else {
> +
> +		/* MAJOR: [15:8], the major silicon revison;
> +		 * MINOR: [7: 0], the minor silicon revison;
> +		 *
> +		 * please refer to the i.MX RM for the detailed
> +		 * silicon revison bit define.
> +		 * format the major part and minor part to match the
> +		 * linux kernel soc version format.
>  		 */
>  		revision = digprog & 0xff;
> +		major_part = (digprog >> 8) & 0xf;
> +		minor_part = digprog & 0xf;
> +		revision = ((major_part + 1) << 4) | minor_part;
>  	}
> 
>  	mxc_set_cpu_type(digprog >> 16 & 0xff);
> --
> 1.9.1
