From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 06 Mar 2012 13:03:38 +0200
Subject: [PATCH 2/3] arm: fix compile error in
 mach-omap2/board-omap4panda.c
In-Reply-To: <1330987310-8108-3-git-send-email-paul.gortmaker@windriver.com>
References: <1330987310-8108-1-git-send-email-paul.gortmaker@windriver.com>
 <1330987310-8108-3-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <4F55EF0A.1070309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/06/2012 12:41 AM, Paul Gortmaker wrote:
> The commit 3c90c98a1ebbb08d95700ce8a3b7bce6286607bd (linux-next)
> 
>     "OMAP4: omap4panda: Enable audio support"
> 
> introduced population of a new struct, but chose the wrong (but
> similarly named) struct that has none of the named fields.
> 
> Change it to the struct with those fields, to fix:
> 
> arch/arm/mach-omap2/board-omap4panda.c:284: error: unknown field 'hs_left_step' specified in initializer
> arch/arm/mach-omap2/board-omap4panda.c:285: error: unknown field 'hs_right_step' specified in initializer
> arch/arm/mach-omap2/board-omap4panda.c:286: error: unknown field 'hf_left_step' specified in initializer
> arch/arm/mach-omap2/board-omap4panda.c:287: error: unknown field 'hf_right_step' specified in initializer
> arch/arm/mach-omap2/board-omap4panda.c:287: warning: large integer implicitly truncated to unsigned type

Yes, I have also noticed it.
This is because part of the twl6040 i2c conversion series has been taken
by Samuel.
He will stop carrying it further (I hope), and we are going to have a
bit different series going via audio.
Samuel did not took the panda part of the patches since it had some
other dependencies coming via audio tree.

The thing is that the panda audio support is coming via ASoC to
linux-next, so Samuel could not take the patch addressing this breakage
(mfd tree does not have the needed patches).

I'm not sure where we could apply this patch in the first place since
mfd does not have the panda audio support patches, and currently the
ASoC does not have the twl6040 i2c conversion patches either...

> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> CC: Peter Ujfalusi <peter.ujfalusi@ti.com>
> CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
> CC: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/board-omap4panda.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> index c1a852d..e919153 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -279,7 +279,7 @@ static int __init omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers)
>  	return 0;
>  }
>  
> -static struct twl4030_codec_data twl6040_codec = {
> +static struct twl6040_codec_data twl6040_codec = {
>  	/* single-step ramp for headset and handsfree */
>  	.hs_left_step	= 0x0f,
>  	.hs_right_step	= 0x0f,


-- 
P?ter
