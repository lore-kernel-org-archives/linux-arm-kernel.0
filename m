From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 12 Feb 2016 13:44:31 -0700
Subject: [PATCH] coresight: etb: Remove simple announcement message
In-Reply-To: <1455195004-30214-1-git-send-email-broonie@kernel.org>
References: <1455195004-30214-1-git-send-email-broonie@kernel.org>
Message-ID: <CANLsYkwVn4FgBST-0MeOa38qCkH78-z32_CXewcCF78CnvbxeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 February 2016 at 05:50, Mark Brown <broonie@kernel.org> wrote:
> It's generally preferred that drivers not print initialisation messages on
> startup that don't contain information gained at runtime such as specific
> hardware revision information. This provides a small speedup on systems
> with serial consoles and keeps the boot less noisy.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/hwtracing/coresight/coresight-etb10.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index 92969dae739d..18c55d1c428c 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -481,7 +481,6 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
>         if (ret)
>                 goto err_misc_register;
>
> -       dev_info(dev, "ETB initialized\n");
>         return 0;

Didn't we touch base on that topic before?  I'm not against moving
forward with this but it has to be all or nothing - whether we remove
all the CS boot log message or they all stay.  Otherwise people could
mistakenly come to the conclusion that some of the CS components did
not boot properly.

ETB, funnel and TMCs don't output any useful HW related information
but tracers (ETMv3, PTM and ETMv4) actually do.

People concerned about boot time will definitely set their loglevel
accordingly on the kernel cmd line.  Otherwise we are likely talking
about developers interested in knowing what happened when their kernel
booted.

Thanks,
Mathieu

>
>  err_misc_register:
> --
> 2.7.0
>
