From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 14 Mar 2017 11:37:52 -0600
Subject: [1/2] coresight: Disable the path only when the source is disabled
In-Reply-To: <1489073232-5093-2-git-send-email-suzuki.poulose@arm.com>
References: <1489073232-5093-2-git-send-email-suzuki.poulose@arm.com>
Message-ID: <CANLsYkyymMScBu7EBdndPo1Yk_okCQOGEx_JQyv4VtnsHy_SXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

On 14 March 2017 at 11:31, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> From: "Suzuki K. Poulose" <Suzuki.Poulose@arm.com>
>
> With a coresight tracing session, the components along the path
> from the source to sink are disabled after the source is disabled.
> However, if the source was not actually disabled due to active
> users, we should not disable the components in the path.
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 0c37356..34cd1ed 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -253,7 +253,8 @@ static int coresight_enable_source(struct coresight_device *csdev, u32 mode)
>         return 0;
>  }
>
> -static void coresight_disable_source(struct coresight_device *csdev)
> +/* coresight_disable_source: Returns true if the device has been disabled */

To be coherent with the rest of the file please use:

/*
 * coresight_disable_source: Returns true if the device has been disabled
 */

I would have done the modification myself but 2/2 needs tending as well.

Thanks,
Mathieu

> +static bool coresight_disable_source(struct coresight_device *csdev)
>  {
>         if (atomic_dec_return(csdev->refcnt) == 0) {
>                 if (source_ops(csdev)->disable) {
> @@ -261,6 +262,7 @@ static void coresight_disable_source(struct coresight_device *csdev)
>                         csdev->enable = false;
>                 }
>         }
> +       return !csdev->enable;
>  }
>
>  void coresight_disable_path(struct list_head *path)
> @@ -629,7 +631,7 @@ void coresight_disable(struct coresight_device *csdev)
>         if (ret)
>                 goto out;
>
> -       if (!csdev->enable)
> +       if (!csdev->enable || !coresight_disable_source(csdev))
>                 goto out;
>
>         switch (csdev->subtype.source_subtype) {
> @@ -647,7 +649,6 @@ void coresight_disable(struct coresight_device *csdev)
>                 break;
>         }
>
> -       coresight_disable_source(csdev);
>         coresight_disable_path(path);
>         coresight_release_path(path);
>
