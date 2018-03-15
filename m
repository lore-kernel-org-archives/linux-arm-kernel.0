From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Mar 2018 21:01:46 +0800
Subject: [PATCH 1/2] drm/sun4i: backend: Check that we only have a single
 YUV plane
In-Reply-To: <2f8586493d9139b12efe7e94f65e9a149f818e0e.1519931807.git-series.maxime.ripard@bootlin.com>
References: <cover.f0cb3210f2d878853ef16506da152f38ba2e3286.1519931807.git-series.maxime.ripard@bootlin.com>
 <2f8586493d9139b12efe7e94f65e9a149f818e0e.1519931807.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v65E6k6ExO1uKciYbCVU6Ehqbo-VdcjDfUUTH8HnceTeRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 2, 2018 at 3:18 AM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> Just like for the frontend, a single plane can use a YUV format. Make sure
> we have that constraint covered in our atomic_check.

It might be worth mentioning that this is a precursor patch for YUV support.

> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_backend.c | 49 ++++++++++++++++++++++++++--
>  drivers/gpu/drm/sun4i/sun4i_backend.h | 18 ++++++++++-
>  2 files changed, 65 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
> index 092ade4ff6a5..486dfd357920 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> @@ -42,6 +42,38 @@ static const u32 sunxi_rgb2yuv_coef[12] = {
>         0x000001c1, 0x00003e88, 0x00003fb8, 0x00000808
>  };
>
> +static inline bool sun4i_backend_format_is_planar_yuv(uint32_t format)
> +{
> +       switch (format) {
> +       case DRM_FORMAT_YUV411:
> +       case DRM_FORMAT_YUV422:
> +       case DRM_FORMAT_YUV444:
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
> +static inline bool sun4i_backend_format_is_packed_yuv422(uint32_t format)
> +{
> +       switch (format) {
> +       case DRM_FORMAT_YUYV:
> +       case DRM_FORMAT_YVYU:
> +       case DRM_FORMAT_UYVY:
> +       case DRM_FORMAT_VYUY:
> +               return true;
> +
> +       default:
> +               return false;
> +       }
> +}
> +
> +static inline bool sun4i_backend_format_is_yuv(uint32_t format)
> +{
> +       return sun4i_backend_format_is_planar_yuv(format) ||
> +               sun4i_backend_format_is_packed_yuv422(format);
> +}
> +
>  static void sun4i_backend_apply_color_correction(struct sunxi_engine *engine)
>  {
>         int i;
> @@ -330,6 +362,7 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
>         unsigned int num_planes = 0;
>         unsigned int num_alpha_planes = 0;
>         unsigned int num_frontend_planes = 0;
> +       unsigned int num_yuv_planes = 0;
>         unsigned int current_pipe = 0;
>         unsigned int i;
>
> @@ -362,6 +395,11 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
>                 if (fb->format->has_alpha)
>                         num_alpha_planes++;
>
> +               if (sun4i_backend_format_is_yuv(fb->format->format)) {
> +                       DRM_DEBUG_DRIVER("Plane FB format is YUV\n");
> +                       num_yuv_planes++;
> +               }
> +
>                 DRM_DEBUG_DRIVER("Plane zpos is %d\n",
>                                  plane_state->normalized_zpos);
>
> @@ -430,13 +468,20 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
>                 s_state->pipe = current_pipe;
>         }
>
> +       /* We can only have a single YUV plane at a time */
> +       if (num_yuv_planes > SUN4I_BACKEND_NUM_YUV_PLANES) {
> +               DRM_DEBUG_DRIVER("Too many planes with YUV, rejecting...\n");
> +               return -EINVAL;
> +       }
> +
>         if (num_frontend_planes > SUN4I_BACKEND_NUM_FRONTEND_LAYERS) {
>                 DRM_DEBUG_DRIVER("Too many planes going through the frontend, rejecting\n");
>                 return -EINVAL;
>         }
>
> -       DRM_DEBUG_DRIVER("State valid with %u planes, %u alpha, %u video\n",
> -                        num_planes, num_alpha_planes, num_frontend_planes);
> +       DRM_DEBUG_DRIVER("State valid with %u planes, %u alpha, %u video, %u YUV\n",
> +                        num_planes, num_alpha_planes, num_frontend_planes,
> +                        num_yuv_planes);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.h b/drivers/gpu/drm/sun4i/sun4i_backend.h
> index 52e77591186a..316f2179e9e1 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_backend.h
> +++ b/drivers/gpu/drm/sun4i/sun4i_backend.h
> @@ -72,6 +72,7 @@
>  #define SUN4I_BACKEND_ATTCTL_REG0_LAY_PIPESEL(x)               ((x) << 15)
>  #define SUN4I_BACKEND_ATTCTL_REG0_LAY_PRISEL_MASK      GENMASK(11, 10)
>  #define SUN4I_BACKEND_ATTCTL_REG0_LAY_PRISEL(x)                        ((x) << 10)
> +#define SUN4I_BACKEND_ATTCTL_REG0_LAY_YUVEN            BIT(2)
>  #define SUN4I_BACKEND_ATTCTL_REG0_LAY_VDOEN            BIT(1)
>
>  #define SUN4I_BACKEND_ATTCTL_REG1(l)           (0x8a0 + (0x4 * (l)))
> @@ -110,7 +111,23 @@
>  #define SUN4I_BACKEND_SPREN_REG                        0x900
>  #define SUN4I_BACKEND_SPRFMTCTL_REG            0x908
>  #define SUN4I_BACKEND_SPRALPHACTL_REG          0x90c
> +
>  #define SUN4I_BACKEND_IYUVCTL_REG              0x920
> +#define SUN4I_BACKEND_IYUVCTL_FBFMT_MASK               GENMASK(14, 12)
> +#define SUN4I_BACKEND_IYUVCTL_FBFMT_PACKED_YUV444              (4 << 12)
> +#define SUN4I_BACKEND_IYUVCTL_FBFMT_PACKED_YUV422              (3 << 12)
> +#define SUN4I_BACKEND_IYUVCTL_FBFMT_PLANAR_YUV444              (2 << 12)
> +#define SUN4I_BACKEND_IYUVCTL_FBFMT_PLANAR_YUV222              (1 << 12)
> +#define SUN4I_BACKEND_IYUVCTL_FBFMT_PLANAR_YUV111              (0 << 12)
> +#define SUN4I_BACKEND_IYUVCTL_FBPS_MASK                        GENMASK(9, 8)
> +#define SUN4I_BACKEND_IYUVCTL_FBPS_YVYU                                (3 << 8)
> +#define SUN4I_BACKEND_IYUVCTL_FBPS_VYUY                                (2 << 8)
> +#define SUN4I_BACKEND_IYUVCTL_FBPS_YUYV                                (1 << 8)
> +#define SUN4I_BACKEND_IYUVCTL_FBPS_UYVY                                (0 << 8)
> +#define SUN4I_BACKEND_IYUVCTL_FBPS_VUYA                                (1 << 8)
> +#define SUN4I_BACKEND_IYUVCTL_FBPS_AYUV                                (0 << 8)
> +#define SUN4I_BACKEND_IYUVCTL_EN                       BIT(0)
> +

Wrong patch for the above 2 hunks.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

>  #define SUN4I_BACKEND_IYUVADD_REG(c)           (0x930 + (0x4 * (c)))
>
>  #define SUN4I_BACKEND_IYUVLINEWIDTH_REG(c)     (0x940 + (0x4 * (c)))
> @@ -149,6 +166,7 @@
>  #define SUN4I_BACKEND_NUM_LAYERS               4
>  #define SUN4I_BACKEND_NUM_ALPHA_LAYERS         1
>  #define SUN4I_BACKEND_NUM_FRONTEND_LAYERS      1
> +#define SUN4I_BACKEND_NUM_YUV_PLANES           1
>
>  struct sun4i_backend {
>         struct sunxi_engine     engine;
> --
> git-series 0.9.1
