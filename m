From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 9 Apr 2015 08:46:55 -0600
Subject: [PATCH] coresight: etb10: Print size of buffer we fail to allocate
In-Reply-To: <1428531327-16902-1-git-send-email-broonie@kernel.org>
References: <1428531327-16902-1-git-send-email-broonie@kernel.org>
Message-ID: <CANLsYkzoj5nPs2dnejOsDgEHZXArbXq5s6B7Cp3P1siu0Vv8YA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 April 2015 at 16:15, Mark Brown <broonie@kernel.org> wrote:
> When we initialise the ETB driver we attempt to allocate a buffer suitable
> for storing the data buffered in the hardware based on sizing information
> reported by the hardware. Unfortunately if the hardware is not properly
> configured (for example if power domains are not set up correctly) then we
> may read back a nonsensically large value and therefore the allocation will
> be too big to succeed. Print an error message showing the amount of memory
> we tried to allocate if the buffer allocation fails to help users diagnose
> such problems.
>
> Normally it is bad practice to print an error message on memory allocation
> failures since there are verbose core messages reported for this but in
> this case where the allocation size might be incorrect it is a useful hint.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/hwtracing/coresight/coresight-etb10.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index 40049869aecd..46eb9f88a29f 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -462,8 +462,11 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
>
>         drvdata->buf = devm_kzalloc(dev,
>                                     drvdata->buffer_depth * 4, GFP_KERNEL);
> -       if (!drvdata->buf)
> +       if (!drvdata->buf) {
> +               dev_err(dev, "Failed to allocate %u bytes for buffer data\n",
> +                       drvdata->buffer_depth * 4);
>                 return -ENOMEM;
> +       }
>
>         desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
>         if (!desc)
> --
> 2.1.4
>

This could be helpful during the bringup phase of the device when the
HW implementation isn't showing what's expected/intended.  On the
flips side such a problem would show up pretty quickly, specifically
with the -ENOMEM guarding against future damage.

I'll take this patch but will rework the commit message a little.  If
the power domains are not setup properly the device won't show up on
AMBA and as such won't get probed.

Thanks,
Mathieu
