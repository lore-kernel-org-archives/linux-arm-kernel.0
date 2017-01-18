From: mark.yao@rock-chips.com (Mark yao)
Date: Wed, 18 Jan 2017 10:21:48 +0800
Subject: [01/26] drm/rockchip: dw-mipi-dsi: use mode from display state
In-Reply-To: <587DF431.5040003@rock-chips.com>
References: <20160919171747.28512-2-john@metanate.com>
 <587DF431.5040003@rock-chips.com>
Message-ID: <587ED13C.3000301@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017?01?17? 18:38, Chris Zhong wrote:
>> @@ -821,8 +824,6 @@ static void dw_mipi_dsi_encoder_mode_set(struct 
>> drm_encoder *encoder,
>>       struct dw_mipi_dsi *dsi = encoder_to_dsi(encoder);
>>       int ret;
>>   -    dsi->mode = adjusted_mode;
>> -
> I prefer to keep the original method, although this"dsi->mode" pointer 
> is same as "&dsi->connector.state->crtc->state->adjusted_mode; "
> I still think dsi->mode makes the process easier to read
"&dsi->connector.state->crtc->state->adjusted_mode;" is too long, and 
dsi->connector.state->crtc can be NULL, seems not good.

agree with Chris, I think dsi->mode is better.

Bug the origin code "dsi->mode = adjusted_mode; " also has a bug, 
adjusted_mode's lift time is unknown, use a pointer from adjusted_mode 
is dangerous.

I think we can use like that, copy a display mode to dsi->mode:
struct dw_mipi_dsi
{
    -    struct drm_display_mode *mode;
    +    struct drm_display_mode mode;
}
   xxx_encoder_mode_set()
{
    drm_mode_copy(&dsi->mode, adjusted_mode);
}

-- 
?ark Yao
