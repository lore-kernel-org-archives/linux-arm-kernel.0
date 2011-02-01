From: khilman@ti.com (Kevin Hilman)
Date: Tue, 01 Feb 2011 14:22:19 -0800
Subject: [PATCH v2] arm: mach-omap2: potential NULL dereference
In-Reply-To: <20110119125721.GA9203@albatros> (Vasiliy Kulikov's message of
	"Wed, 19 Jan 2011 15:57:22 +0300")
References: <1295258922-31242-1-git-send-email-segoon@openwall.com>
	<4D341C35.80506@bfs.de> <20110119125721.GA9203@albatros>
Message-ID: <87lj1zpf8k.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vasiliy Kulikov <segoon@openwall.com> writes:

> kzalloc() may fail, if so return -ENOMEM.  Also Walter Harms suggested
> to use kasprintf() instead of kzalloc+strcpy+strcat.
>
> Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
> ---
>  Cannot compile this driver, so it is not tested at all.

Boot tested on 3430/n900 and 3630/Zoom3.

Queueing for 2.6.39 (branch: for_2.6.39/pm-misc)

Kevin

>  arch/arm/mach-omap2/smartreflex.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 77ecebf..697d8d4 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -260,9 +260,11 @@ static int sr_late_init(struct omap_sr *sr_info)
>  	if (sr_class->class_type == SR_CLASS2 &&
>  		sr_class->notify_flags && sr_info->irq) {
>  
> -		name = kzalloc(SMARTREFLEX_NAME_LEN + 1, GFP_KERNEL);
> -		strcpy(name, "sr_");
> -		strcat(name, sr_info->voltdm->name);
> +		name = kasprintf(GFP_KERNEL, "sr_%s", sr_info->voltdm->name);
> +		if (name == NULL) {
> +			ret = -ENOMEM;
> +			goto error;
> +		}
>  		ret = request_irq(sr_info->irq, sr_interrupt,
>  				0, name, (void *)sr_info);
>  		if (ret)
