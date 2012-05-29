From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Tue, 29 May 2012 13:23:46 +0800
Subject: [alsa-devel] [PATCH 3/4] ASOC: mmp: add sspa support
In-Reply-To: <20120528145904.GK4032@opensource.wolfsonmicro.com>
References: <1337929863-31885-1-git-send-email-zhangfei.gao@marvell.com>
 <1337929863-31885-4-git-send-email-zhangfei.gao@marvell.com>
 <20120528145904.GK4032@opensource.wolfsonmicro.com>
Message-ID: <CAMj5Bkhm2R+WK=_7eb6Y7h=Dg0-BUKqv3k17wRwow7UJrE_R+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2012 at 10:59 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, May 25, 2012 at 03:11:02PM +0800, Zhangfei Gao wrote:
>> The SSPA is a configurable multi-channel audio serial (TDM) interface.
>> It's configurable at runtime to support up to 128 channels and the
>> number of bits per sample: 8, 12, 16, 20, 24 and 32 bits. It also
>> support stereo format: I2S, left-justified or right-justified.
>
> Mostly looks good. ?A few fairly minor things...
Thanks Mark for kind review.


>> +
>> + ? ? if (!cpu_dai->active) {
>> + ? ? ? ? ? ? clk_enable(sysclk);
>> + ? ? ? ? ? ? clk_enable(sspa->clk);
>> + ? ? }
>
> The clock API is refcounted so you shouldn't need to worry about
> multiple enables, you should just be able to unconditionally enable and
> disable. ?If this is needed we probably have a problem we should fix.
Will update.

>
>> + ? ? switch (pll_id) {
>> + ? ? case MMP_SYSCLK:
>> + ? ? ? ? ? ? clk_set_rate(sysclk, freq_out);
>> + ? ? ? ? ? ? break;
>> + ? ? case MMP_SSPA_CLK:
>> + ? ? ? ? ? ? clk_set_rate(sspa->clk, freq_out);
>> + ? ? ? ? ? ? break;
>
> You're ignoring the return values here.
will update.

>
>> + ? ? priv->sspa->clk = clk_get(&pdev->dev, NULL);
>> + ? ? if (IS_ERR(priv->sspa->clk)) {
>> + ? ? ? ? ? ? ret = PTR_ERR(priv->sspa->clk);
>> + ? ? ? ? ? ? goto err_free_clk;
>> + ? ? }
>
> devm_clk_get().
Unfortunately, not find devm_clk_get.

>
>> + ? ? res = request_mem_region(res->start, resource_size(res),
>> + ? ? ? ? ? ? ? ? ? ? pdev->name);
>> + ? ? if (res == NULL) {
>> + ? ? ? ? ? ? dev_err(&pdev->dev, "failed to request memory resource\n");
>> + ? ? ? ? ? ? ret = -EBUSY;
>> + ? ? ? ? ? ? goto err_get_res;
>> + ? ? }
>> +
>> + ? ? priv->sspa->mmio_base = ioremap(res->start, resource_size(res));
>> + ? ? if (priv->sspa->mmio_base == NULL) {
>> + ? ? ? ? ? ? dev_err(&pdev->dev, "failed to ioremap() registers\n");
>> + ? ? ? ? ? ? ret = -ENODEV;
>> + ? ? ? ? ? ? goto err_free_mem;
>> + ? ? }
>
> devm_request_and_ioremap().
will update.
>
>> +err_free_clk:
>> + ? ? devm_kfree(&pdev->dev, priv->dma_params);
>> +err_priv_dma_params:
>> + ? ? devm_kfree(&pdev->dev, priv->sspa);
>> +err_priv_sspa:
>> + ? ? devm_kfree(&pdev->dev, priv);
>
> The whole point of the devm_ stuff is that you don't need to do stuff
> like this.

Thanks confirmation, not sure before, also find devm_kfree is used.
Will remove the devm_kfree etc in err handle as well as remove function.

>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel at alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
