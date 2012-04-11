From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 Apr 2012 10:19:56 +0200
Subject: questions about drivers/dma/amba-pl08x.c
In-Reply-To: <CAKwPUoy6ooNbKDb=gbS_jAZuaA7SteGP+RVEhoeCK-eLKoqamw@mail.gmail.com>
References: <CAKwPUozgACvV-TZdn92f1O2shSEvFBfbN-hrS=FNQ5O+DEEY5g@mail.gmail.com>
 <CACRpkdaC3=vSGF6XH=7Oiqsdg0RVDfbv-M5NZDY5psF96BssHQ@mail.gmail.com>
 <CAKwPUoy6ooNbKDb=gbS_jAZuaA7SteGP+RVEhoeCK-eLKoqamw@mail.gmail.com>
Message-ID: <CACRpkdZTeEsZ4+czpmchZJczuS5b3=H4wFPUPb+d7c0=+f4hdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2012 at 12:42 PM, Kassey Lee <kassey1216@gmail.com> wrote:

> hi, Linus, Walleij:
> ? ? ? ?thanks for your answer! is this you meaning?

Sort of...

> Subject: [PATCH] dmaengine/amba-pl08x: check slave_channels to avoid kernel
> ?panic
>
> slave_channels is platform dependent, it should
> be initialized by board.c, and here we need to check it
> to avoid a NULL panic.
>
> Signed-off-by: Kassey,Lee <kassey1216@gmail.com>
> ---
> ?drivers/dma/amba-pl08x.c | ? ?7 +++++++
> ?1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> index c301a8e..b558ea6 100644
> --- a/drivers/dma/amba-pl08x.c
> +++ b/drivers/dma/amba-pl08x.c
> @@ -1687,6 +1687,13 @@ static int
> pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
> ? ? ? ? ? ? ? ?chan->state = PL08X_CHAN_IDLE;
>
> ? ? ? ? ? ? ? ?if (slave) {
> + ? ? ? ? ? ? ? ? ? ? ? if (!pl08x->pd->slave_channels) {
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? dev_err(&pl08x->adev->dev,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "%s slave_channels is
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?not initialized\n", __func__);

Do not split messages for 80 col compliance. Ignore checkpatch warning in this
case.

> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? kfree(chan);
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? return -EFAULT;

Use -EINVAL;

> + ? ? ? ? ? ? ? ? ? ? ? }

Thanks,
Linus Walleij
