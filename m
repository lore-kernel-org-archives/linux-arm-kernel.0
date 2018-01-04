From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 4 Jan 2018 20:56:50 +0100
Subject: [PATCH v2 1/3] drm/sun4i: hdmi: Check for unset best_parent in
 sun4i_tmds_determine_rate
In-Reply-To: <20171226111227.4526-2-net147@gmail.com>
References: <20171226111227.4526-1-net147@gmail.com>
 <20171226111227.4526-2-net147@gmail.com>
Message-ID: <20180104195650.vmbooz3pwjy77wt7@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 26, 2017 at 10:12:25PM +1100, Jonathan Liu wrote:
> We should check if the best match has been set before comparing it.
> 
> Fixes: 9c5681011a0c ("drm/sun4i: Add HDMI support")
> Signed-off-by: Jonathan Liu <net147@gmail.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
> index dc332ea56f6c..4d235e5ea31c 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
> @@ -102,7 +102,7 @@ static int sun4i_tmds_determine_rate(struct clk_hw *hw,
>  					goto out;
>  				}
>  
> -				if (abs(rate - rounded / i) <
> +				if (!best_parent || abs(rate - rounded / i) <

Why is that causing any issue?

If best_parent is set to 0...

>  				    abs(rate - best_parent / best_div)) {

... the value returned here is going to be rate, which is going to be
higher than the first part of the comparison meaning ...

>  					best_parent = rounded;

... that best_parent is going to be set there.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180104/5d9007ba/attachment.sig>
