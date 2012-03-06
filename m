From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 06 Mar 2012 14:27:24 +0200
Subject: [PATCH 3/3] arm: more fallout from i2c conversions in
 board-omap4panda.c
In-Reply-To: <1330987310-8108-4-git-send-email-paul.gortmaker@windriver.com>
References: <1330987310-8108-1-git-send-email-paul.gortmaker@windriver.com>
 <1330987310-8108-4-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <4F5602AC.3060107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/06/2012 12:41 AM, Paul Gortmaker wrote:
> Commit ded0df8510778a03a2f182a0cbfe3c25788e8852 (linux-next)
> 
>    "mfd: Convert twl6040 to an i2c driver, and separate it from twl core"
> 
> appears to have done an incomplete conversion on the board-omap4panda.c
> file, leaving it with more build failures.  Comparing the changes that
> were done for board-4430sdp.c it is possible for me to whack it with a
> stick until it stops twitching, but someone who really understands this
> code needs to take a look at the conversion, and check it is done
> completely and in a way that will actually work on hardware.

This is true.
I'm sending a revert series for the twl6040 patches causing this
breakage for Samuel.
The same feature will go via audio tree because the dependencies are
queued in that feature tree.

-- 
P?ter

PS: this might fix the compile breakage with omap2_defconfig, but the
audio will not work if you enable the support for it on OMAP4.

> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> CC: Peter Ujfalusi <peter.ujfalusi@ti.com>
> CC: Mark Brown <broonie@opensource.wolfsonicro.com>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  arch/arm/mach-omap2/board-omap4panda.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> index e919153..16a1814 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -287,16 +287,15 @@ static struct twl6040_codec_data twl6040_codec = {
>  	.hf_right_step	= 0x1d,
>  };
>  
> -static struct twl4030_audio_data twl6040_audio = {
> +static struct twl6040_platform_data twl6040_data = {
>  	.codec		= &twl6040_codec,
>  	.audpwron_gpio	= 127,
> -	.naudint_irq	= OMAP44XX_IRQ_SYS_2N,
>  	.irq_base	= TWL6040_CODEC_IRQ_BASE,
>  };
>  
>  /* Panda board uses the common PMIC configuration */
>  static struct twl4030_platform_data omap4_panda_twldata = {
> -	.audio		= &twl6040_audio,
> +   /*	.audio		= &twl6040_audio,	*/
>  };
>  
>  /*
