From: tfiga@chromium.org (Tomasz Figa)
Date: Fri, 3 Jul 2015 18:58:44 +0900
Subject: [PATCH v2 3/5] drm/rockchip: vop: support plane scale
In-Reply-To: <55965344.5050502@rock-chips.com>
References: <1435313249-4549-1-git-send-email-mark.yao@rock-chips.com>
 <1435313249-4549-4-git-send-email-mark.yao@rock-chips.com>
 <CAAFQd5A2j7MXrzOMVnsJr_WUKAFPaicv+r9LgwHccLim4fRk8g@mail.gmail.com>
 <55965344.5050502@rock-chips.com>
Message-ID: <CAAFQd5B3NnUQRqdaXUz6BGCn-5rh1iXnfZXnQRDK3=nF_Ya7SA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 3, 2015 at 6:17 PM, Mark yao <mark.yao@rock-chips.com> wrote:
>>> +static void _vop_cal_scl_fac(struct vop *vop, const struct vop_win_data
>>> *win,
>>> +                            uint32_t src_w, uint32_t src_h, uint32_t
>>> dst_w,
>>> +                            uint32_t dst_h, uint32_t pixel_format)
>>> +{
>>> +       uint16_t yrgb_hor_scl_mode = SCALE_NONE;
>>> +       uint16_t yrgb_ver_scl_mode = SCALE_NONE;
>>> +       uint16_t cbr_hor_scl_mode = SCALE_NONE;
>>> +       uint16_t cbr_ver_scl_mode = SCALE_NONE;
>>> +       uint16_t yrgb_hsd_mode = SCALE_DOWN_BIL;
>>> +       uint16_t cbr_hsd_mode = SCALE_DOWN_BIL;
>>> +       uint16_t yrgb_vsd_mode = SCALE_DOWN_BIL;
>>> +       uint16_t cbr_vsd_mode = SCALE_DOWN_BIL;
>>
>> No code seems to be assigning the 4 variables above. Is some code
>> missing or they are simply constants and they (and code checking their
>> values) are not necessary?
>
> those value directly write to the vop regs, it's necessary.
>

Couldn't the constants (SCALE_DOWN_BIL) be written directly without
introducing unnecessary variables?

>>> +       uint16_t yrgb_vsu_mode = SCALE_UP_BIL;
>>> +       uint16_t cbr_vsu_mode = SCALE_UP_BIL;
>>> +       uint16_t scale_yrgb_x = 1 << SCL_FT_DEFAULT_FIXPOINT_SHIFT;
>>> +       uint16_t scale_yrgb_y = 1 << SCL_FT_DEFAULT_FIXPOINT_SHIFT;
>>> +       uint16_t scale_cbcr_x = 1 << SCL_FT_DEFAULT_FIXPOINT_SHIFT;
>>> +       uint16_t scale_cbcr_y = 1 << SCL_FT_DEFAULT_FIXPOINT_SHIFT;
>>> +       int hsub = drm_format_horz_chroma_subsampling(pixel_format);
>>> +       int vsub = drm_format_vert_chroma_subsampling(pixel_format);
>>> +       bool is_yuv = is_yuv_support(pixel_format);
>>> +       uint16_t vsd_yrgb_gt4 = 0;
>>> +       uint16_t vsd_yrgb_gt2 = 0;
>>> +       uint16_t vsd_cbr_gt4 = 0;
>>> +       uint16_t vsd_cbr_gt2 = 0;
>>> +       uint16_t yrgb_src_w = src_w;
>>> +       uint16_t yrgb_src_h = src_h;
>>> +       uint16_t yrgb_dst_w = dst_w;
>>> +       uint16_t yrgb_dst_h = dst_h;
>>> +       uint16_t cbcr_src_w;
>>> +       uint16_t cbcr_src_h;
>>> +       uint16_t cbcr_dst_w;
>>> +       uint16_t cbcr_dst_h;
>>> +       uint32_t vdmult;
>>> +       uint16_t lb_mode;
>>
>> The amount of local variables suggests that this function needs to be
>> split into several smaller ones.
>>
>> By the way, do you need to initialize all of them? GCC will at least
>> warn (if not error out) if an unitialized variable is referenced, so
>> it's enough to make sure that the code correctly covers all branch
>> paths, which is actually better for the code than to rely on default
>> value.
>
> Yeah, some value directly write to the vop, some value gcc report the warn,
> so initialize them.

IMHO in many cases it's better to make sure that the code properly
assigns to them, because otherwise the default value might be used
inadvertently.

>>>
>>> +
>>> +       if (((yrgb_dst_w << 3) <= yrgb_src_w) ||
>>> +           ((yrgb_dst_h << 3) <= yrgb_src_h) ||
>>
>> Hmm, if this is enforcing the maximum downscaling factor, then
>> wouldn't it be more readable to write like this:
>>
>> yrgb_src_w >= 8 * yrgb_dst_w
>>
>> Also is >= correct here? Is the maximum factor less than 8?
>
> yrgb_src_w >= 8 * yrgb_dst_w means we can't scale down exceed 8,
> means that (src_w)1920->(dst_w)240 is wrong.

>= means that the factor exceeds _or_equals_ 8, which means that scale factor 8 is not allowed. However the value passed to drm_plane_helper_check_update() as max_scale is 8, which permits 8.

>>> +               if (cbcr_src_w < cbcr_dst_w)
>>> +                       cbr_hor_scl_mode = SCALE_UP;
>>> +               else if (cbcr_src_w > cbcr_dst_w)
>>> +                       cbr_hor_scl_mode = SCALE_DOWN;
>>> +
>>> +               if (cbcr_src_h < cbcr_dst_h)
>>> +                       cbr_ver_scl_mode = SCALE_UP;
>>> +               else if (cbcr_src_h > cbcr_dst_h)
>>> +                       cbr_ver_scl_mode = SCALE_DOWN;
>>
>> Aren't the scl_modes for CbCr planes always the same as for Y plane?
>
>
> No, such as src(1920 x 1080) -> dst(1280x800), yuv format is NV12.
> so Y plane horizontal and vertical is scale down.
>
> but src_w = 1920 / 2 = 960 < 1280
>       src_h = 1080 / 2 = 540 < 800.
>
> So Cbcr horizontal and vertical is scale up.

Sorry, I don't follow.

If we scale down Y plane in NV12 from 1920x1080 to 1280x800, then
original CbCr plane will be 960x540 and destination CbCr plane will be
640x400 (because CbCr plane of NV12 is subsampled 2x2, which is half
the width and half the height of Y plane), so both planes are being
scaled down.

>>> +
>>> +       switch (lb_mode) {
>>> +       case LB_YUV_3840X5:
>>> +       case LB_YUV_2560X8:
>>> +       case LB_RGB_1920X5:
>>> +       case LB_RGB_1280X8:
>>> +               yrgb_vsu_mode = SCALE_UP_BIC;
>>> +               cbr_vsu_mode  = SCALE_UP_BIC;
>>
>> I might be overlooking something, but don't  yrgb_vsu_mode and
>> cbr_vsu_mode always have the same values?
>
>
> Hmm, yrgb_vsu_mode and cbr_vsu_mode mean different vop config, OK, I think
> it can merge
> together.

Even though they are different registers bitfields, if they always
have the same values, there is no need to create variables just
because of that. IMHO the cleanest way would be to just create a
single value called vsu_mode and use it for both planes.

>
>>> +               break;
>>> +       case LB_RGB_2560X4:
>>> +               yrgb_vsu_mode = SCALE_UP_BIL;
>>> +               cbr_vsu_mode  = SCALE_UP_BIL;
>>> +               break;
>>> +       default:
>>> +               DRM_ERROR("unsupport lb_mode:%d\n", lb_mode);
>>> +               break;
>>> +       }
>>
>> Anyway, this whole switch is a candidate for a helper function.
>
>
> This only use one time, it's ok to be a helper function?
>

I think so, because it will make this function stay at reasonable
length. (Please see Chapter 6: Functions of Documentation/CodingStyle
for more details.)

>>> +                       break;
>>> +               }
>>> +               break;
>>> +       case SCALE_DOWN:
>>> +               switch (yrgb_vsd_mode) {
>>> +               case SCALE_DOWN_BIL:
>>> +                       vdmult = _get_vskiplines(yrgb_src_h, yrgb_dst_h);
>>> +                       scale_yrgb_y =
>>> GET_SCL_FT_BILI_DN_VSKIP(yrgb_src_h,
>>> +
>>> yrgb_dst_h,
>>> +                                                               vdmult);
>>> +                       if (vdmult == 4) {
>>> +                               vsd_yrgb_gt4 = 1;
>>> +                               vsd_yrgb_gt2 = 0;
>>> +                       } else if (vdmult == 2) {
>>> +                               vsd_yrgb_gt4 = 0;
>>> +                               vsd_yrgb_gt2 = 1;
>>> +                       }
>>
>> How about something like this:
>>
>> vsd_yrgb_gt4 = (vdmult == 4);
>> vsd_yrgb_gt2 = (vdmult == 2);
>
>
> But I think it's not easy to read.
>

OK. Either is fine for me.

I thought this way of coding would represent more closely what the
hardware seems to expect (gt4 for vdmult == 2 and gt2 for vdmult ==
4).

>>> +       /*
>>> +        * (2.1)CBCR HOR SCALE FACTOR
>>> +        */
>>> +       switch (cbr_hor_scl_mode) {
>>> +       case SCALE_UP:
>>> +               scale_cbcr_x = GET_SCL_FT_BIC(cbcr_src_w, cbcr_dst_w);
>>> +               break;
>>> +       case SCALE_DOWN:
>>> +               switch (cbr_hsd_mode) {
>>> +               case SCALE_DOWN_BIL:
>>> +                       scale_cbcr_x = GET_SCL_FT_BILI_DN(cbcr_src_w,
>>> +                                                         cbcr_dst_w);
>>> +                       break;
>>> +               case SCALE_DOWN_AVG:
>>> +                       scale_cbcr_x = GET_SCL_FT_AVRG(cbcr_src_w,
>>> cbcr_dst_w);
>>> +                       break;
>>> +               default:
>>> +                       DRM_ERROR("unsupport cbr_hsd_mode:%d\n",
>>> cbr_hsd_mode);
>>
>> Error.
>>
>>> +                       break;
>>> +               }
>>> +               break;
>>> +       }
>>
>> Isn't this switch exactly the same as for Y plane just with different
>> widths used? Also, wouldn't the values for CbCr plane be the same as
>> for Y plane?
>
>
> But Cbcr case is not same as Y plane case,  how to merge?
>

Hmm, could you point the differences? I don't see anything else than
simple s/yrgb/cbcr/ in both parts of the code. Please correct me if
I'm missing something.

>
>>> +
>>> +       /*
>>> +        * (2.2)CBCR VER SCALE FACTOR
>>> +        */
>>> +       switch (cbr_ver_scl_mode) {
>>> +       case SCALE_UP:
>>> +               switch (cbr_vsu_mode) {
>>> +               case SCALE_UP_BIL:
>>> +                       scale_cbcr_y = GET_SCL_FT_BILI_UP(cbcr_src_h,
>>> +                                                         cbcr_dst_h);
>>> +                       break;
>>> +               case SCALE_UP_BIC:
>>> +                       if (cbcr_src_h < 3)
>>> +                               DRM_ERROR("cbcr_src_h need greater than 3
>>> !\n");
>>> +                       scale_cbcr_y = GET_SCL_FT_BIC(cbcr_src_h,
>>> cbcr_dst_h);
>>> +                       break;
>>> +               default:
>>> +                       DRM_ERROR("unsupport cbr_vsu_mode:%d\n",
>>> cbr_vsu_mode);
>>
>> Error.
>>
>>> +                       break;
>>> +               }
>>> +               break;
>>> +       case SCALE_DOWN:
>>> +               switch (cbr_vsd_mode) {
>>> +               case SCALE_DOWN_BIL:
>>> +                       vdmult = _get_vskiplines(cbcr_src_h, cbcr_dst_h);
>>> +                       scale_cbcr_y =
>>> GET_SCL_FT_BILI_DN_VSKIP(cbcr_src_h,
>>> +
>>> cbcr_dst_h,
>>> +                                                               vdmult);
>>> +                       if (vdmult == 4) {
>>> +                               vsd_cbr_gt4 = 1;
>>> +                               vsd_cbr_gt2 = 0;
>>> +                       } else if (vdmult == 2) {
>>> +                               vsd_cbr_gt4 = 0;
>>> +                               vsd_cbr_gt2 = 1;
>>> +                       }
>>> +                       break;
>>> +               case SCALE_DOWN_AVG:
>>> +                       scale_cbcr_y = GET_SCL_FT_AVRG(cbcr_src_h,
>>> cbcr_dst_h);
>>> +                       break;
>>> +               default:
>>> +                       DRM_ERROR("unsupport cbr_vsd_mode:%d\n",
>>> cbr_vsd_mode);
>>> +                       break;
>>> +               }
>>> +               break;
>>> +       }
>>
>> Again, this looks like the values for CbCr would be the same as for Y.
>> Are there actually cases when they differ?
>
>
> Hmm, Actually the cbcr calculations have some different with Y.
>

Again I don't see any differences between those two blocks of code
other than simple s/yrgb/cbcr/. Please correct me if I'm missing
something.

>>> +
>>> +#define SCL_OFFSET_FIXPOINT_SHIFT      8
>>> +#define SCL_OFFSET_FIXPOINT(x) \
>>> +               ((INT32)((x) * (1 << SCL_OFFSET_FIXPOINT_SHIFT)))
>>
>> All of the function macros above: static inline. This should also let
>> you remove the casts.
>
> what the "casts" mean? Why do you thinking that "static inline" is better
> than "#define"?

I mean typecasting, such as (INT32).

Static inline provides built in type checking by compiler. So you
specify types of arguments and return values and have this enforced at
compilation time. Moreover, inline functions are just functions so
have all the goodness of C parser, helping to avoid strange mistakes,
such as missing parentheses around macro argument and mixing operator
precedence because of that.

Of course sometimes you just can't get away without using macros (such
as the need of argument concatenation or stringification), but this
case doesn't seem to be such.

Best regards,
Tomasz
