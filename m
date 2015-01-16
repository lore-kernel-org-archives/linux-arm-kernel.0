From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Fri, 16 Jan 2015 12:34:41 +0100
Subject: [PATCH V3 4/4] mmc: pwrseq_simple: Add support for a reset GPIO
 pin
In-Reply-To: <1421405273-19117-5-git-send-email-ulf.hansson@linaro.org>
References: <1421405273-19117-1-git-send-email-ulf.hansson@linaro.org>
 <1421405273-19117-5-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAAObsKDm1iPAWgJpQwed8KufkxKwqTAFa5espfqq+jY13r+Ymw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 January 2015 at 11:47, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>  int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev)
>  {
>         struct mmc_pwrseq_simple *pwrseq;
> +       int ret = 0;
>
>         pwrseq = kzalloc(sizeof(struct mmc_pwrseq_simple), GFP_KERNEL);
>         if (!pwrseq)
>                 return -ENOMEM;
>
> +       pwrseq->reset_gpio = gpiod_get_index(dev, "reset", 0, GPIOD_OUT_HIGH);
> +       if (IS_ERR(pwrseq->reset_gpio) &&
> +               PTR_ERR(pwrseq->reset_gpio) != -ENOENT &&
> +               PTR_ERR(pwrseq->reset_gpio) != -ENOSYS) {
> +               ret = PTR_ERR(pwrseq->reset_gpio);
> +               goto free;
> +       }
> +
>         pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
>         host->pwrseq = &pwrseq->pwrseq;
>
>         return 0;
> +free:
> +       kfree(&pwrseq);

Hi Ulf,

this kfree looks a bit fishy (there's one more instance of it in
mmc_pwrseq_simple_free).

Cheers,

Tomeu
