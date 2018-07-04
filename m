From: daniel@ffwll.ch (Daniel Vetter)
Date: Wed, 4 Jul 2018 10:16:49 +0200
Subject: [PATCH 03/12] drm/dp: add helpers for
 drm_dp_set_adjust_request_pre_emphasis and drm_dp_set_adjust_request_voltage
In-Reply-To: <1530612152-27555-4-git-send-email-dkos@cadence.com>
References: <1530612152-27555-1-git-send-email-dkos@cadence.com>
 <1530612152-27555-4-git-send-email-dkos@cadence.com>
Message-ID: <20180704081648.GI3891@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2018 at 11:02:14AM +0100, Damian Kos wrote:
> From: Quentin Schulz <quentin.schulz@free-electrons.com>
> 
> We already have functions to get the adjust request voltage and
> pre-emphasis for a lane so it makes also sense to be able to set them so
> that we can then easily update them via a DPCD write.
> 
> Add helpers for drm_dp_set_adjust_request_pre_emphasis and
> drm_dp_set_adjust_request_voltage that respectively set the
> pre-emphasis and voltage of a lane in the link status array.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Signed-off-by: Damian Kos <dkos@cadence.com>

Hm usually this is source dependent - some sources only have one
adj/pre-emph value for all lanes, some only 2 (for groups of 2), some for
all four. That's kinda why we don't have helpers for this stuff.

An excellent way to show that your new helpers are useful would be to go
through existing drivers and convert them over, where it makes sense. Same
kinda holds for patch 1.

Thanks, Daniel
> ---
>  drivers/gpu/drm/drm_dp_helper.c |   28 ++++++++++++++++++++++++++++
>  include/drm/drm_dp_helper.h     |    4 ++++
>  2 files changed, 32 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> index 3bc2e98..ca2f469 100644
> --- a/drivers/gpu/drm/drm_dp_helper.c
> +++ b/drivers/gpu/drm/drm_dp_helper.c
> @@ -120,6 +120,34 @@ u8 drm_dp_get_adjust_request_pre_emphasis(const u8 link_status[DP_LINK_STATUS_SI
>  }
>  EXPORT_SYMBOL(drm_dp_get_adjust_request_pre_emphasis);
>  
> +void drm_dp_set_adjust_request_voltage(u8 link_status[DP_LINK_STATUS_SIZE],
> +				       int lane, u8 volt)
> +{
> +	int i = DP_ADJUST_REQUEST_LANE0_1 + (lane >> 1);
> +	int s = ((lane & 1) ?
> +		 DP_ADJUST_VOLTAGE_SWING_LANE1_SHIFT :
> +		 DP_ADJUST_VOLTAGE_SWING_LANE0_SHIFT);
> +	int idx = i - DP_LANE0_1_STATUS;
> +
> +	link_status[idx] &= ~(DP_ADJUST_VOLTAGE_SWING_LANE0_MASK << s);
> +	link_status[idx] |= volt << s;
> +}
> +EXPORT_SYMBOL(drm_dp_set_adjust_request_voltage);
> +
> +void drm_dp_set_adjust_request_pre_emphasis(u8 link_status[DP_LINK_STATUS_SIZE],
> +					    int lane, u8 pre_emphasis)
> +{
> +	int i = DP_ADJUST_REQUEST_LANE0_1 + (lane >> 1);
> +	int s = ((lane & 1) ?
> +		 DP_ADJUST_PRE_EMPHASIS_LANE1_SHIFT :
> +		 DP_ADJUST_PRE_EMPHASIS_LANE0_SHIFT);
> +	int idx = i - DP_LANE0_1_STATUS;
> +
> +	link_status[idx] &= ~(DP_ADJUST_PRE_EMPHASIS_LANE0_MASK << s);
> +	link_status[idx] |= pre_emphasis << s;
> +}
> +EXPORT_SYMBOL(drm_dp_set_adjust_request_pre_emphasis);
> +
>  void drm_dp_link_train_clock_recovery_delay(const u8 dpcd[DP_RECEIVER_CAP_SIZE]) {
>  	if (dpcd[DP_TRAINING_AUX_RD_INTERVAL] == 0)
>  		udelay(100);
> diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> index a488af0..6e64b2a 100644
> --- a/include/drm/drm_dp_helper.h
> +++ b/include/drm/drm_dp_helper.h
> @@ -946,6 +946,10 @@ u8 drm_dp_get_adjust_request_voltage(const u8 link_status[DP_LINK_STATUS_SIZE],
>  				     int lane);
>  u8 drm_dp_get_adjust_request_pre_emphasis(const u8 link_status[DP_LINK_STATUS_SIZE],
>  					  int lane);
> +void drm_dp_set_adjust_request_voltage(u8 link_status[DP_LINK_STATUS_SIZE],
> +				       int lane, u8 volt);
> +void drm_dp_set_adjust_request_pre_emphasis(u8 link_status[DP_LINK_STATUS_SIZE],
> +					    int lane, u8 pre_emphasis);
>  
>  #define DP_BRANCH_OUI_HEADER_SIZE	0xc
>  #define DP_RECEIVER_CAP_SIZE		0xf
> -- 
> 1.7.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
