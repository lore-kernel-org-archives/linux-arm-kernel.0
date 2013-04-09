From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 9 Apr 2013 15:27:23 +0530
Subject: [PATCH v3 2/3] media: davinci: vpbe: venc: move the enabling
 of vpss clocks to driver
In-Reply-To: <1365423553-12619-3-git-send-email-prabhakar.csengg@gmail.com>
References: <1365423553-12619-1-git-send-email-prabhakar.csengg@gmail.com>
 <1365423553-12619-3-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <5163E603.3030103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 4/8/2013 5:49 PM, Prabhakar lad wrote:
> From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> 
> The vpss clocks were enabled by calling a exported function from a driver
> in a machine code. calling driver code from platform code is incorrect way.
> 
> This patch fixes this issue and calls the function from driver code itself.
> 
> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> ---
>  drivers/media/platform/davinci/vpbe_venc.c |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/media/platform/davinci/vpbe_venc.c b/drivers/media/platform/davinci/vpbe_venc.c
> index f15f211..91d0272 100644
> --- a/drivers/media/platform/davinci/vpbe_venc.c
> +++ b/drivers/media/platform/davinci/vpbe_venc.c
> @@ -202,6 +202,25 @@ static void venc_enabledigitaloutput(struct v4l2_subdev *sd, int benable)
>  	}
>  }
>  
> +static void
> +venc_enable_vpss_clock(int venc_type,
> +		       enum vpbe_enc_timings_type type,
> +		       unsigned int pclock)
> +{
> +	if (venc_type == VPBE_VERSION_1)
> +		return;
> +
> +	if (venc_type == VPBE_VERSION_2 && (type == VPBE_ENC_STD ||
> +	    (type == VPBE_ENC_DV_TIMINGS && pclock <= 27000000))) {

checkpatch --strict will throw a "Alignment should match open
parenthesis" check here. You may want to fix before you send the pull
request. No need to resend the patch just for this.

Thanks,
Sekhar
