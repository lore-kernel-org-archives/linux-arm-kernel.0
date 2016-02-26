From: dh.herrmann@gmail.com (David Herrmann)
Date: Fri, 26 Feb 2016 15:07:58 +0100
Subject: [PATCH,
 RESEND] drm: avoid uninitialized timestamp use in wait_vblank
In-Reply-To: <1456434600-4185759-1-git-send-email-arnd@arndb.de>
References: <1456434600-4185759-1-git-send-email-arnd@arndb.de>
Message-ID: <CANq1E4SZTL-vZ7T7EjPeQ29W19jd9qXtrb_4paKJRgxGH73+Zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Thu, Feb 25, 2016 at 10:09 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> gcc warns about the timestamp in drm_wait_vblank being possibly
> used without an initialization:
>
> drivers/gpu/drm/drm_irq.c: In function 'drm_wait_vblank':
> drivers/gpu/drm/drm_irq.c:1755:28: warning: 'now.tv_usec' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    vblwait->reply.tval_usec = now.tv_usec;
> drivers/gpu/drm/drm_irq.c:1754:27: warning: 'now.tv_sec' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    vblwait->reply.tval_sec = now.tv_sec;
>
> This can happen if drm_vblank_count_and_time() returns 0 in its
> error path. To sanitize the error case, I'm changing that function
> to return a zero timestamp when it fails.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: e6ae8687a87b ("drm: idiot-proof vblank")
> ---
>  drivers/gpu/drm/drm_irq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> I'm going through the maybe-unused warnings in randconfig builds, this one is
> apparently not a false positive, although it only happens if something
> else has already gone wrong.
>
> Originally sent out on Jan 13, but I received no reply, so resending now.
>
> diff --git a/drivers/gpu/drm/drm_irq.c b/drivers/gpu/drm/drm_irq.c
> index 881c5a6c180c..6f41ddfbe061 100644
> --- a/drivers/gpu/drm/drm_irq.c
> +++ b/drivers/gpu/drm/drm_irq.c
> @@ -997,8 +997,10 @@ u32 drm_vblank_count_and_time(struct drm_device *dev, unsigned int pipe,
>         int count = DRM_TIMESTAMP_MAXRETRIES;
>         u32 cur_vblank;
>
> -       if (WARN_ON(pipe >= dev->num_crtcs))
> +       if (WARN_ON(pipe >= dev->num_crtcs)) {
> +               *vblanktime = (struct timeval) { 0 };

The '0' is redundant. Anyway, this is:

Reviewed-by: David Herrmann <dh.herrmann@gmail.com>

(CC: Daniel, for drm-misc)

Thanks
David

>                 return 0;
> +       }
>
>         /*
>          * Vblank timestamps are read lockless. To ensure consistency the vblank
> --
> 2.7.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
