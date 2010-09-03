From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 04 Sep 2010 07:43:57 +0900
Subject: [PATCH] ARM: PL330: Accept revisions of the dmac
In-Reply-To: <1283502656-15445-1-git-send-email-jassisinghbrar@gmail.com>
References: <1283502656-15445-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <01e401cb4bb9$812723d0$83756b70$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jassi Brar wrote:
> 
> From: Jassi Brar <jassi.brar@samsung.com>
> 
> The driver can handle different revisions of the core which
> vary only minorly. So check for only the necessary part of
> the IDs.
> 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
> ---
>  arch/arm/common/pl330.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/common/pl330.c b/arch/arm/common/pl330.c
> index 5ebbab6..8f0f86d 100644
> --- a/arch/arm/common/pl330.c
> +++ b/arch/arm/common/pl330.c
> @@ -146,8 +146,7 @@
>  #define DESIGNER	0x41
>  #define REVISION	0x0
>  #define INTEG_CFG	0x0
> -#define PERIPH_ID_VAL	((PART << 0) | (DESIGNER << 12) \
> -			  | (REVISION << 20) | (INTEG_CFG << 24))
> +#define PERIPH_ID_VAL	((PART << 0) | (DESIGNER << 12))
> 
>  #define PCELL_ID_VAL	0xb105f00d
> 
> @@ -1859,10 +1858,10 @@ int pl330_add(struct pl330_info *pi)
>  	regs = pi->base;
> 
>  	/* Check if we can handle this DMAC */
> -	if (get_id(pi, PERIPH_ID) != PERIPH_ID_VAL
> +	if ((get_id(pi, PERIPH_ID) & 0xfffff) != PERIPH_ID_VAL
>  	   || get_id(pi, PCELL_ID) != PCELL_ID_VAL) {
>  		dev_err(pi->dev, "PERIPH_ID 0x%x, PCELL_ID 0x%x !\n",
> -			readl(regs + PERIPH_ID), readl(regs + PCELL_ID));
> +			get_id(pi, PERIPH_ID), get_id(pi, PCELL_ID));

mm...really needed to change readl to get_id?

According to PL330 TRM 3-48, seems that PERIPH_ID includes all of other
PERIPH_ID_X's information.
And PCELL_ID is same...

But I'm not sure whether there is any update...

>  		return -EINVAL;
>  	}
> 
> --
> 1.6.2.5


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
