From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 26 Sep 2018 12:30:10 +0300
Subject: [Intel-gfx] [PATCH 4/5] drm/omapdrm: Substitute format_is_yuv()
 with format->is_yuv
In-Reply-To: <20180718101741.GU5565@intel.com>
References: <1531847626-22248-1-git-send-email-ayan.halder@arm.com>
 <1531847626-22248-4-git-send-email-ayan.halder@arm.com>
 <20180718101741.GU5565@intel.com>
Message-ID: <57ef0cb3-c032-3854-cff5-78fbe2a5ed20@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 18/07/18 13:17, Ville Syrj?l? wrote:
> On Tue, Jul 17, 2018 at 06:13:45PM +0100, Ayan Kumar Halder wrote:
>> drm_format_info table has a field 'is_yuv' to denote if the format
>> is yuv or not. The driver is expected to use this instead of
>> having a function for the same purpose.
>>
>> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
>> ---
>>  drivers/gpu/drm/omapdrm/dss/dispc.c | 26 ++++++++++----------------
>>  1 file changed, 10 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdrm/dss/dispc.c
>> index 84f274c..8d2d7a4 100644
>> --- a/drivers/gpu/drm/omapdrm/dss/dispc.c
>> +++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
>> @@ -1140,18 +1140,6 @@ static void dispc_ovl_set_color_mode(struct dispc_device *dispc,
>>  	REG_FLD_MOD(dispc, DISPC_OVL_ATTRIBUTES(plane), m, 4, 1);
>>  }
>>  
>> -static bool format_is_yuv(u32 fourcc)
>> -{
>> -	switch (fourcc) {
>> -	case DRM_FORMAT_YUYV:
>> -	case DRM_FORMAT_UYVY:
>> -	case DRM_FORMAT_NV12:
>> -		return true;
>> -	default:
>> -		return false;
>> -	}
>> -}
>> -
>>  static void dispc_ovl_configure_burst_type(struct dispc_device *dispc,
>>  					   enum omap_plane_id plane,
>>  					   enum omap_dss_rotation_type rotation)
>> @@ -1910,11 +1898,14 @@ static void dispc_ovl_set_scaling_uv(struct dispc_device *dispc,
>>  	int scale_x = out_width != orig_width;
>>  	int scale_y = out_height != orig_height;
>>  	bool chroma_upscale = plane != OMAP_DSS_WB;
>> +	const struct drm_format_info *info;
>> +
>> +	info = drm_format_info(fourcc);
> 
> Not sure Tomi wants drm usage (apart from the fourccs) inside the
> dss code.

Seems like I have missed this. No, I don't have anything against drm
usage inside dss. That's the way we've been moving after we managed to
get rid of omapfb links.

I'll pick this up.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
