From: robdclark@gmail.com (Rob Clark)
Date: Thu, 25 Apr 2013 13:39:32 -0400
Subject: [PATCH 11/21] drm/tilcdc: use only a single module device table
In-Reply-To: <1366734653-488286-12-git-send-email-arnd@arndb.de>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
 <1366734653-488286-12-git-send-email-arnd@arndb.de>
Message-ID: <CAF6AEGvOmQDvD64=WiGjS1SKeSOOf=5rTefn5c=ciBhaxfhntw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 12:30 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The tilcdc driver fails to be built as a module because of extraneous
> MODULE_DEVICE_TABLE entries:
>
> drivers/gpu/drm/tilcdc/tilcdc_slave.o:(.data+0x54): multiple definition of `__mod_of_device_table'
> drivers/gpu/drm/tilcdc/tilcdc_tfp410.o:(.data+0x54): first defined here
> drivers/gpu/drm/tilcdc/tilcdc_panel.o:(.data+0x54): multiple definition of `__mod_of_device_table'
> drivers/gpu/drm/tilcdc/tilcdc_tfp410.o:(.data+0x54): first defined here
> drivers/gpu/drm/tilcdc/tilcdc_drv.o:(.data+0x184): multiple definition of `__mod_of_device_table'
> drivers/gpu/drm/tilcdc/tilcdc_tfp410.o:(.data+0x54): first defined here
>
> Since the entire point of these entries is to make the module autoload
> when one of the devices is present, it's enough to keep the one entry
> for "ti,am33xx-tilcdc", which should always be there if any of the
> others are.

Thanks Arnd

Acked-By: Rob Clark <robdclark@gmail.com>

> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Dave Airlie <airlied@linux.ie>
> Cc: dri-devel at lists.freedesktop.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/tilcdc/tilcdc_panel.c  | 1 -
>  drivers/gpu/drm/tilcdc/tilcdc_slave.c  | 1 -
>  drivers/gpu/drm/tilcdc/tilcdc_tfp410.c | 1 -
>  3 files changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_panel.c b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
> index 580b74e..eb99f42 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_panel.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
> @@ -413,7 +413,6 @@ static struct of_device_id panel_of_match[] = {
>                 { .compatible = "ti,tilcdc,panel", },
>                 { },
>  };
> -MODULE_DEVICE_TABLE(of, panel_of_match);
>
>  struct platform_driver panel_driver = {
>         .probe = panel_probe,
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_slave.c b/drivers/gpu/drm/tilcdc/tilcdc_slave.c
> index 568dc1c..db1d2fc 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_slave.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_slave.c
> @@ -353,7 +353,6 @@ static struct of_device_id slave_of_match[] = {
>                 { .compatible = "ti,tilcdc,slave", },
>                 { },
>  };
> -MODULE_DEVICE_TABLE(of, slave_of_match);
>
>  struct platform_driver slave_driver = {
>         .probe = slave_probe,
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c b/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
> index 58d487b..a36788f 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
> @@ -396,7 +396,6 @@ static struct of_device_id tfp410_of_match[] = {
>                 { .compatible = "ti,tilcdc,tfp410", },
>                 { },
>  };
> -MODULE_DEVICE_TABLE(of, tfp410_of_match);
>
>  struct platform_driver tfp410_driver = {
>         .probe = tfp410_probe,
> --
> 1.8.1.2
>
