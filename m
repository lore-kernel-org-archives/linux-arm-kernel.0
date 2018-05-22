From: randy.li@rock-chips.com (Randy Li)
Date: Tue, 22 May 2018 17:49:07 +0800
Subject: [PATCH 1/2] drm/fourcc: add a 10bits fully packed variant of NV12
In-Reply-To: <303c89b8-e24f-cacb-c305-65d17c58c597@linux.intel.com>
References: <20180520171705.29690-1-ayaka@soulik.info>
 <20180520171705.29690-2-ayaka@soulik.info>
 <303c89b8-e24f-cacb-c305-65d17c58c597@linux.intel.com>
Message-ID: <6288544d-32de-b933-d204-b7026012fb82@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/22/2018 05:26 PM, Maarten Lankhorst wrote:
> Op 20-05-18 om 19:17 schreef Randy Li:
>> This pixel format is a fully packed and 10bits variant of NV12.
>> A luma pixel would take 10bits in memory, without any
>> filled bits between pixels in a stride. The color gamut
>> follows the BT.2020 standard.
>>
>> Signed-off-by: Randy Li <ayaka@soulik.info>
>> ---
>>   drivers/gpu/drm/drm_fourcc.c  | 1 +
>>   include/uapi/drm/drm_fourcc.h | 3 +++
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
>> index 5ca6395cd4d3..1f43967c4013 100644
>> --- a/drivers/gpu/drm/drm_fourcc.c
>> +++ b/drivers/gpu/drm/drm_fourcc.c
>> @@ -173,6 +173,7 @@ const struct drm_format_info *__drm_format_info(u32 format)
>>   		{ .format = DRM_FORMAT_UYVY,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1 },
>>   		{ .format = DRM_FORMAT_VYUY,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1 },
>>   		{ .format = DRM_FORMAT_AYUV,		.depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
>> +		{ .format = DRM_FORMAT_NV12_10LE40,	.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 2 },
> Hm, the cpp value might give problems because it rounds down, not sure how we should handle that? Set to zero?
It is default behavior that using the filed "cpp"? to calculate the 
pixel in many drivers. I would suggest use a new filed called bits per 
pixel (bpp) instead of the old cpp.
The one used in the Gstreamer is more complex: 
https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/gst-plugins-base-libs-GstVideoAlignment.html#GstVideoFormatInfo
As the struct drm_format_info only a kernel internal data structure, it 
doesn't need to update the user-space interface like libdrm.
>>   	};
>>   
>>   	unsigned int i;
>> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
>> index e04613d30a13..8eabf01e966f 100644
>> --- a/include/uapi/drm/drm_fourcc.h
>> +++ b/include/uapi/drm/drm_fourcc.h
>> @@ -140,6 +140,9 @@ extern "C" {
>>   #define DRM_FORMAT_NV61		fourcc_code('N', 'V', '6', '1') /* 2x1 subsampled Cb:Cr plane */
>>   #define DRM_FORMAT_NV24		fourcc_code('N', 'V', '2', '4') /* non-subsampled Cr:Cb plane */
>>   #define DRM_FORMAT_NV42		fourcc_code('N', 'V', '4', '2') /* non-subsampled Cb:Cr plane */
>> +/* A fully packed variant of NV12_10LE32 */
>> +#define DRM_FORMAT_NV12_10LE40	fourcc_code('R', 'K', '2', '0') /* 2x2 subsampled Cr:Cb plane */
>> +
>>   
>>   /*
>>    * 3 plane YCbCr
>
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
