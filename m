From: ajaynumb@gmail.com (Ajay kumar)
Date: Fri, 26 Aug 2011 10:51:50 +0530
Subject: [PATCH 2/2] video: s3c-fb: Modify s3c-fb driver to support window
	positioning
In-Reply-To: <14401983.184721314319448396.JavaMail.weblogic@epv6ml01>
References: <14401983.184721314319448396.JavaMail.weblogic@epv6ml01>
Message-ID: <CAEC9eQMuqEO1uRnQOjZBFAxtH0qRnKu+Jvjo_xo2P5TJK=UpYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jingoo,

2011/8/26 JinGoo Han <jg1.han@samsung.com>:
> Hi, Ajay.
>> -----Original Message-----
>> From: Ajay Kumar [mailto:ajaykumar.rs at samsung.com]
>> Sent: Friday, August 26, 2011 4:52 AM
>> To: linux-samsung-soc at vger.kernel.org; linux-fbdev at vger.kernel.org; linux-
>> arm-kernel at lists.infradead.org
>> Cc: FlorianSchandinat at gmx.de; lethal at linux-sh.org; jg1.han at samsung.com;
>> m.szyprowski at samsung.com; ben-linux at fluff.org; banajit.g at samsung.com
>> Subject: [PATCH 2/2] video: s3c-fb: Modify s3c-fb driver to support window
>> positioning
>>
>> This patch modifies the existing s3c-fb driver to provide
>> flexibility to the user to reposition the framebuffer windows.
>>
>> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
>> Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
>> ---
>> ?drivers/video/s3c-fb.c | ? 37 ++++++++++++++++++++++++++++++++-----
>> ?1 files changed, 32 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
>> index 0fda252..41179d7 100644
>> --- a/drivers/video/s3c-fb.c
>> +++ b/drivers/video/s3c-fb.c
>> @@ -442,6 +442,7 @@ static int s3c_fb_set_par(struct fb_info *info)
>> ? ? ? struct fb_var_screeninfo *var = &info->var;
>> ? ? ? struct s3c_fb_win *win = info->par;
>> ? ? ? struct s3c_fb *sfb = win->parent;
>> + ? ? struct s3cfb_window_pos *winpos = &win->windata->winpos;
>> ? ? ? void __iomem *regs = sfb->regs;
>> ? ? ? void __iomem *buf = regs;
>> ? ? ? int win_no = win->index;
>> @@ -539,12 +540,13 @@ static int s3c_fb_set_par(struct fb_info *info)
>>
>> ? ? ? /* write 'OSD' registers to control position of framebuffer */
>>
>> - ? ? data = VIDOSDxA_TOPLEFT_X(0) | VIDOSDxA_TOPLEFT_Y(0);
>> + ? ? data = VIDOSDxA_TOPLEFT_X(winpos->win_pos_x) |
>> + ? ? ? ? ? ?VIDOSDxA_TOPLEFT_Y(winpos->win_pos_y);
>> ? ? ? writel(data, regs + VIDOSD_A(win_no, sfb->variant));
>>
>> - ? ? data = VIDOSDxB_BOTRIGHT_X(s3c_fb_align_word(var->bits_per_pixel,
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?var->xres - 1)) |
>> - ? ? ? ? ? ?VIDOSDxB_BOTRIGHT_Y(var->yres - 1);
>> + ? ? data = VIDOSDxB_BOTRIGHT_X((s3c_fb_align_word(var->bits_per_pixel,
>> + ? ? ? ? ? ?(winpos->win_pos_x + var->xres - 1)))) |
>> + ? ? ? ? ? ?VIDOSDxB_BOTRIGHT_Y((winpos->win_pos_y + var->yres - 1));
>>
>> ? ? ? writel(data, regs + VIDOSD_B(win_no, sfb->variant));
>>
>> @@ -999,8 +1001,10 @@ static int s3c_fb_ioctl(struct fb_info *info,
>> unsigned int cmd,
>> ?{
>> ? ? ? struct s3c_fb_win *win = info->par;
>> ? ? ? struct s3c_fb *sfb = win->parent;
>> - ? ? int ret;
>> + ? ? struct s3cfb_window_pos *winpos = &win->windata->winpos;
>> + ? ? int ret = 0;
>> ? ? ? u32 crtc;
>> + ? ? u32 data;
>>
>> ? ? ? switch (cmd) {
>> ? ? ? case FBIO_WAITFORVSYNC:
>> @@ -1011,6 +1015,29 @@ static int s3c_fb_ioctl(struct fb_info *info,
>> unsigned int cmd,
>>
>> ? ? ? ? ? ? ? ret = s3c_fb_wait_for_vsync(sfb, crtc);
>> ? ? ? ? ? ? ? break;
>> + ? ? case S3CFB_WIN_POSITION:
>> + ? ? ? ? ? ? if (copy_from_user(winpos, (u32 __user *)arg,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? sizeof(struct s3cfb_window_pos))) {
>> + ? ? ? ? ? ? ? ? ? ? ret = -EFAULT;
>> + ? ? ? ? ? ? ? ? ? ? break;
>> + ? ? ? ? ? ? }
>> +
>> + ? ? ? ? ? ? shadow_protect_win(win, 1);
>> +
>> + ? ? ? ? ? ? /* write 'OSD' registers to set position of the window */
>> + ? ? ? ? ? ? data = VIDOSDxA_TOPLEFT_X(winpos->win_pos_x) |
>> + ? ? ? ? ? ? ? ? ? ?VIDOSDxA_TOPLEFT_Y(winpos->win_pos_y);
>> + ? ? ? ? ? ? writel(data, sfb->regs + VIDOSD_A(win->index, sfb->variant));
>> +
>> + ? ? ? ? ? ? data = VIDOSDxB_BOTRIGHT_X(
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? s3c_fb_align_word(info->var.bits_per_pixel,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? (winpos->win_pos_x + info->var.xres - 1)));
>> + ? ? ? ? ? ? data |= VIDOSDxB_BOTRIGHT_Y(winpos->win_pos_y +
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? info->var.yres - 1);
>> + ? ? ? ? ? ? writel(data, sfb->regs + VIDOSD_B(win->index, sfb->variant));
>> +
>> + ? ? ? ? ? ? shadow_protect_win(win, 0);
>> + ? ? ? ? ? ? break;
> Can you move this to separate function?
> In my opinion, it would be better for readability and consistency.
> Also, FBIO_WAITFORVSYNC has been implemented in this way.
> ? ? ? ? ? ? ? ?ret = s3c_fb_wait_for_vsync(sfb, crtc);
> How about adding a function 's3c_fb_set_window_position' for this as belows?
> +int s3c_fb_set_window_position(struct fb_info *info,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct s3cfb_window_pos winpos)

Thanks for your suggestion.
I have considered it, and now I have written a separate function for this.
I will be sending it in V2 version.
> ? ? ? ? ? ? ? ?........
> + ? ? ? case S3CFB_WIN_POSITION:
> + ? ? ? ? ? ? ? if (copy_from_user(winpos, (u32 __user *)arg,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? sizeof(struct s3cfb_window_pos))) {
> + ? ? ? ? ? ? ? ? ? ? ? ret = -EFAULT;
> + ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? ret = s3c_fb_set_window_position(info, winpos);
> + ? ? ? ? ? ? ? break;
>> ? ? ? default:
>> ? ? ? ? ? ? ? ret = -ENOTTY;
>> ? ? ? }
>> --
>> 1.7.0.4
>
>
>
