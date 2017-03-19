From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Sun, 19 Mar 2017 15:00:26 -0700
Subject: [PATCH 1/4] media: imx-media-csi: fix v4l2-compliance check
In-Reply-To: <E1cpYOK-0006EZ-No@rmk-PC.armlinux.org.uk>
References: <20170319103801.GQ21222@n2100.armlinux.org.uk>
 <E1cpYOK-0006EZ-No@rmk-PC.armlinux.org.uk>
Message-ID: <0bdcf910-d566-e46f-92e3-4a7380564736@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks good to me.

Steve


On 03/19/2017 03:48 AM, Russell King wrote:
> v4l2-compliance was failing with:
>
>                  fail: v4l2-test-formats.cpp(1076): cap->timeperframe.numerator == 0 || cap->timeperframe.denominator == 0
>                  test VIDIOC_G/S_PARM: FAIL
>
> Fix this.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>   drivers/staging/media/imx/imx-media-csi.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
> index 0336891069dc..65346e789dd6 100644
> --- a/drivers/staging/media/imx/imx-media-csi.c
> +++ b/drivers/staging/media/imx/imx-media-csi.c
> @@ -680,8 +680,10 @@ static const struct csi_skip_desc *csi_find_best_skip(struct v4l2_fract *in,
>   
>   	/* Default to 1:1 ratio */
>   	if (out->numerator == 0 || out->denominator == 0 ||
> -	    in->numerator == 0 || in->denominator == 0)
> +	    in->numerator == 0 || in->denominator == 0) {
> +		*out = *in;
>   		return best_skip;
> +	}
>   
>   	want_us = div_u64((u64)USEC_PER_SEC * out->numerator, out->denominator);
>   
