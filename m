From: sean@poorly.run (Sean Paul)
Date: Fri, 28 Sep 2018 03:21:29 -0400
Subject: [PATCH v5 3/5] drm/dp: make dp_get_lane_status usable from
 outside of the core
In-Reply-To: <1537866837-4408-4-git-send-email-dkos@cadence.com>
References: <1537866837-4408-1-git-send-email-dkos@cadence.com>
 <1537866837-4408-4-git-send-email-dkos@cadence.com>
Message-ID: <20180928072129.GX72545@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2018 at 10:13:33AM +0100, Damian Kos wrote:
> From: Quentin Schulz <quentin.schulz@free-electrons.com>
> 
> dp_get_lane_status is pretty generic and can be used for other means,
> so let's make it "public".
> 
> This adds drm_dp_get_lane_status to the header file and add the appropriate
> EXPORT_SYMBOL for it so that it can be used by other drivers, be they compiled
> built-in or as modules.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Signed-off-by: Damian Kos <dkos@cadence.com>

Now that you've refactored mhdp_validate_cr(), you no longer need this patch.

Sean

> ---
>  drivers/gpu/drm/drm_dp_helper.c | 9 +++++----
>  include/drm/drm_dp_helper.h     | 2 ++
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> index 735ebde5c2f0..169db52f92f5 100644
> --- a/drivers/gpu/drm/drm_dp_helper.c
> +++ b/drivers/gpu/drm/drm_dp_helper.c
> @@ -48,14 +48,15 @@ static u8 dp_link_status(const u8 link_status[DP_LINK_STATUS_SIZE], int r)
>  	return link_status[r - DP_LANE0_1_STATUS];
>  }
>  
> -static u8 dp_get_lane_status(const u8 link_status[DP_LINK_STATUS_SIZE],
> -			     int lane)
> +u8 drm_dp_get_lane_status(const u8 link_status[DP_LINK_STATUS_SIZE],
> +			  int lane)
>  {
>  	int i = DP_LANE0_1_STATUS + (lane >> 1);
>  	int s = (lane & 1) * 4;
>  	u8 l = dp_link_status(link_status, i);
>  	return (l >> s) & 0xf;
>  }
> +EXPORT_SYMBOL(drm_dp_get_lane_status);
>  
>  bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
>  			  int lane_count)
> @@ -69,7 +70,7 @@ bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
>  	if ((lane_align & DP_INTERLANE_ALIGN_DONE) == 0)
>  		return false;
>  	for (lane = 0; lane < lane_count; lane++) {
> -		lane_status = dp_get_lane_status(link_status, lane);
> +		lane_status = drm_dp_get_lane_status(link_status, lane);
>  		if ((lane_status & DP_CHANNEL_EQ_BITS) != DP_CHANNEL_EQ_BITS)
>  			return false;
>  	}
> @@ -84,7 +85,7 @@ bool drm_dp_clock_recovery_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
>  	u8 lane_status;
>  
>  	for (lane = 0; lane < lane_count; lane++) {
> -		lane_status = dp_get_lane_status(link_status, lane);
> +		lane_status = drm_dp_get_lane_status(link_status, lane);
>  		if ((lane_status & DP_LANE_CR_DONE) == 0)
>  			return false;
>  	}
> diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> index 698082a02b97..973d2fda9654 100644
> --- a/include/drm/drm_dp_helper.h
> +++ b/include/drm/drm_dp_helper.h
> @@ -952,6 +952,8 @@
>  #define DP_MST_LOGICAL_PORT_0 8
>  
>  #define DP_LINK_STATUS_SIZE	   6
> +
> +u8 drm_dp_get_lane_status(const u8 link_status[DP_LINK_STATUS_SIZE], int lane);
>  bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
>  			  int lane_count);
>  bool drm_dp_clock_recovery_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
> -- 
> 2.17.1
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
