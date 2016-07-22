From: seanpaul@chromium.org (Sean Paul)
Date: Fri, 22 Jul 2016 11:23:21 -0400
Subject: [PATCH 1/1] drm/sti: use new Reset API
In-Reply-To: <20160722072254.20397-1-lee.jones@linaro.org>
References: <20160722072254.20397-1-lee.jones@linaro.org>
Message-ID: <CAOw6vbKKbbZkEeHD5UOOqDAvMAZD8_Zd5i241XhXhfa+VsB+DQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2016 at 3:22 AM, Lee Jones <lee.jones@linaro.org> wrote:
> Since 0b52297f228 ("reset: Add support for shared reset controls") the
> new Reset API now demands consumers choose either an *_exclusive or
> a *_shared line when requesting reset lines.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/sti/sti_compositor.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/sti/sti_compositor.c b/drivers/gpu/drm/sti/sti_compositor.c
> index 3d2fa3a..c2ace02 100644
> --- a/drivers/gpu/drm/sti/sti_compositor.c
> +++ b/drivers/gpu/drm/sti/sti_compositor.c
> @@ -234,12 +234,12 @@ static int sti_compositor_probe(struct platform_device *pdev)
>         }
>
>         /* Get reset resources */
> -       compo->rst_main = devm_reset_control_get(dev, "compo-main");
> +       compo->rst_main = devm_reset_control_get_shared(dev, "compo-main");

Seems like this patch also changes the behavior from being exclusively
managed to shared. Is this intentional? If so, it's probably worth
changing you commit message to be a little less innocuous.

>         /* Take compo main out of reset */
>         if (!IS_ERR(compo->rst_main))
>                 reset_control_deassert(compo->rst_main);
>
> -       compo->rst_aux = devm_reset_control_get(dev, "compo-aux");
> +       compo->rst_aux = devm_reset_control_get_shared(dev, "compo-aux");
>         /* Take compo aux out of reset */
>         if (!IS_ERR(compo->rst_aux))
>                 reset_control_deassert(compo->rst_aux);
> --
> 2.9.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
