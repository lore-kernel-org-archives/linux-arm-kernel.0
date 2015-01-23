From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 23 Jan 2015 18:01:32 +0100
Subject: [PATCH V4 4/4] mmc: pwrseq_simple: Add support for a reset GPIO
 pin
In-Reply-To: <CABxcv=nGWPnkNz1tXJpaTUkroucDgVYzeCrEmZvA8xfzHzROvg@mail.gmail.com>
References: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
 <1421658784-11980-5-git-send-email-ulf.hansson@linaro.org>
 <CABxcv=nGWPnkNz1tXJpaTUkroucDgVYzeCrEmZvA8xfzHzROvg@mail.gmail.com>
Message-ID: <CAPDyKFqnU3OcyiDYPQ4pLRhOGkiEJ1nuwYSP_+qain63N9CEfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 January 2015 at 16:56, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
> Hello Ulf,
>
> On Mon, Jan 19, 2015 at 10:13 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>>  int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev)
>>  {
>>         struct mmc_pwrseq_simple *pwrseq;
>> +       int ret = 0;
>>
>>         pwrseq = kzalloc(sizeof(struct mmc_pwrseq_simple), GFP_KERNEL);
>>         if (!pwrseq)
>>                 return -ENOMEM;
>>
>> +       pwrseq->reset_gpio = gpiod_get_index(dev, "reset", 0, GPIOD_OUT_HIGH);
>
> Any reason to not use the devm_gpiod_get_index() managed version instead?

This struct device don't have a bound driver to it. Thus this device
won't be freed automagically from the ->remove() or failed ->probe()
path.

>
> AFAICT mmc_free_host() will free the device so in that case you won't
> need to call gpiod_put() in mmc_pwrseq_simple_free().
>
> This will also make easier to extend pwrseq_simple to support multiple
> GPIOs like the DT binding implies.
>

Kind regards
Uffe
