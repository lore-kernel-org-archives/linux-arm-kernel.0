From: dave.stevenson@raspberrypi.org (Dave Stevenson)
Date: Fri, 28 Sep 2018 10:04:29 +0100
Subject: [PATCH] staging: bcm2835-camera: Avoid unneeded internal
 declaration warning
In-Reply-To: <20180928005038.1697-1-natechancellor@gmail.com>
References: <20180928005038.1697-1-natechancellor@gmail.com>
Message-ID: <CAAoAYcMMiiDXCcnZ=DP9Y9Xs+xdq-jasj8G_W0jrnQV9so79=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nate

Thanks for the patch.

On Fri, 28 Sep 2018 at 01:53, Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/staging/vc04_services/bcm2835-camera/controls.c:59:18: warning:
> variable 'mains_freq_qmenu' is not needed and will not be emitted
> [-Wunneeded-internal-declaration]
> static const s64 mains_freq_qmenu[] = {
>                  ^
> 1 warning generated.
>
> This is because mains_freq_qmenu is currently only used in an ARRAY_SIZE
> macro, which is a compile time evaluation in this case. Avoid this by
> adding mains_freq_qmenu as the imenu member of this structure, which
> matches all other controls that uses the ARRAY_SIZE macro in v4l2_ctrls.
> This turns out to be a no-op because V4L2_CID_MPEG_VIDEO_BITRATE_MODE is
> defined as a MMAL_CONTROL_TYPE_STD_MENU, which does not pass the imenu
> definition along to v4l2_ctrl_new in bm2835_mmal_init_controls.

There's a slight confusion betwen V4L2_CID_MPEG_VIDEO_BITRATE_MODE and
V4L2_CID_POWER_LINE_FREQUENCY in your description.

However you're right that MMAL_CONTROL_TYPE_STD_MENU calls
v4l2_ctrl_new_std_menu which doesn't need a menu array (it's
v4l2_ctrl_new_int_menu that does). That means the correct fix is to
define the max value using the relevant enum (in this case
V4L2_CID_POWER_LINE_FREQUENCY_AUTO) and remove the array.

The same is true for V4L2_CID_MPEG_VIDEO_BITRATE_MODE - max should be
V4L2_MPEG_VIDEO_BITRATE_MODE_CBR, and remove the bitrate_mode_qmenu
array.

Thanks,
  Dave

> Link: https://github.com/ClangBuiltLinux/linux/issues/122
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/staging/vc04_services/bcm2835-camera/controls.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> index cff7b1e07153..a2c55cb2192a 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
> +++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> @@ -1106,7 +1106,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
>         {
>                 V4L2_CID_POWER_LINE_FREQUENCY, MMAL_CONTROL_TYPE_STD_MENU,
>                 0, ARRAY_SIZE(mains_freq_qmenu) - 1,
> -               1, 1, NULL,
> +               1, 1, mains_freq_qmenu,
>                 MMAL_PARAMETER_FLICKER_AVOID,
>                 &ctrl_set_flicker_avoidance,
>                 false
> --
> 2.19.0
>
>
> _______________________________________________
> linux-rpi-kernel mailing list
> linux-rpi-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel
