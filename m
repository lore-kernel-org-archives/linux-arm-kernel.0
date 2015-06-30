From: gnurou@gmail.com (Alexandre Courbot)
Date: Tue, 30 Jun 2015 22:58:43 +0900
Subject: [PATCH v2] gpio/xilinx: Use correct address when setting initial
 values.
In-Reply-To: <1435130385.30543.3.camel@localhost>
References: <1435130385.30543.3.camel@localhost>
Message-ID: <CAAVeFuLEUECgFeHr4q-N=7omSAL8+hPHoNponUWpkFGCxVYybw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 24, 2015 at 4:19 PM, Rapha?l Teysseyre <rteysseyre@gmail.com> wrote:
> xgpio_save_regs() is used in this driver to setup the initial
> values of the registers in the hardware.
>
> The relevant registers at that time are:
> 0x0 -> channel 0 data (32 bits, one for each GPIO on this channel).
> 0x4 -> channel 0 tri, controls in/out status for each GPIO of this channel.
> 0x8 -> channel 1 data
> 0xC -> channel 1 tri
>
> gpio-xilinx.c defines these:
> XGPIO_DATA_OFFSET   (0x0)
> XGPIO_TRI_OFFSET    (0x4)
> XGPIO_CHANNEL_OFFSET    0x8
>
> Before this patch, the "data" register value of channel 1 was written
> at 0x4 intead of 0x8 (overwriting the channel 0 "tri" register),
> and the "tri" register value for channel 1 was written at 0x8 instead of 0xC.

Nice, descriptive commit log. ;)

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

>
> Signed-off-by: Rapha?l Teysseyre <rteysseyre@gmail.com>
> ---
>  drivers/gpio/gpio-xilinx.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
> index 61243d1..e544b7a 100644
> --- a/drivers/gpio/gpio-xilinx.c
> +++ b/drivers/gpio/gpio-xilinx.c
> @@ -220,9 +220,9 @@ static void xgpio_save_regs(struct of_mm_gpio_chip *mm_gc)
>         if (!chip->gpio_width[1])
>                 return;
>
> -       xgpio_writereg(mm_gc->regs + XGPIO_DATA_OFFSET + XGPIO_TRI_OFFSET,
> +       xgpio_writereg(mm_gc->regs + XGPIO_DATA_OFFSET + XGPIO_CHANNEL_OFFSET,
>                        chip->gpio_state[1]);
> -       xgpio_writereg(mm_gc->regs + XGPIO_TRI_OFFSET + XGPIO_TRI_OFFSET,
> +       xgpio_writereg(mm_gc->regs + XGPIO_TRI_OFFSET + XGPIO_CHANNEL_OFFSET,
>                        chip->gpio_dir[1]);

Nit: Maybe XGPIO_CHANNEL_OFFSET should have come before the other
offset for clarity, but that's no big deal.
