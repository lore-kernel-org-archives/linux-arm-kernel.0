From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 6 May 2016 08:26:38 -0600
Subject: [PATCH] coresight: Handle build path error
In-Reply-To: <1462358484-9342-1-git-send-email-suzuki.poulose@arm.com>
References: <1462358484-9342-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <CANLsYkwEG-4U+hvdVNHQxoH_WuZvD_pYwDC6NSBOok9o5swNoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 May 2016 at 04:41, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> Enabling a component via sysfs (echo 1 > enable_source), would
> trigger building a path from the enabled sources to the sink.
> If there is an error in the process (e.g, sink not enabled or
> the device (CPU corresponding to ETM) is not online), we never report
> failure, except for leaving a message in the dmesg.
>
> Do proper error checking for the build path and return the error.
>
> Before:
>  $ echo 0 > /sys/devices/system/cpu/cpu2/online
>  $ echo 1 > /sys/devices/cs_etm/cpu2/enable_source
>  $ echo $?
>  0
>
> After:
>  $ echo 0 > /sys/devices/system/cpu/cpu2/online
>  $ echo 1 > /sys/devices/cs_etm/cpu2/enable_source
>  -bash: echo: write error: No such device or address
>
> Cc: Mathie Porier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

This patch looks good - thanks for the fix.  Due to how late we are in
the cycle I'd ask Greg to pick it up right away but there is a
(couple) of typos in my name on the CC line.  Either resend another
patch with the correct spelling or remove the CC line altogether.

Thanks,
Mathieu


> ---
>  drivers/hwtracing/coresight/coresight.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 2ea5961..e0c5166 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -393,6 +393,7 @@ out:
>  struct list_head *coresight_build_path(struct coresight_device *csdev)
>  {
>         struct list_head *path;
> +       int rc;
>
>         path = kzalloc(sizeof(struct list_head), GFP_KERNEL);
>         if (!path)
> @@ -400,9 +401,10 @@ struct list_head *coresight_build_path(struct coresight_device *csdev)
>
>         INIT_LIST_HEAD(path);
>
> -       if (_coresight_build_path(csdev, path)) {
> +       rc = _coresight_build_path(csdev, path);
> +       if (rc) {
>                 kfree(path);
> -               path = NULL;
> +               return ERR_PTR(rc);
>         }
>
>         return path;
> @@ -448,8 +450,9 @@ int coresight_enable(struct coresight_device *csdev)
>                 goto out;
>
>         path = coresight_build_path(csdev);
> -       if (!path) {
> +       if (IS_ERR(path)) {
>                 pr_err("building path(s) failed\n");
> +               ret = PTR_ERR(path);
>                 goto out;
>         }
>
> --
> 1.7.9.5
>
