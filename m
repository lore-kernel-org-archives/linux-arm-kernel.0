From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Tue, 16 Jun 2015 11:01:44 +0530
Subject: [PATCH-V2 03/12] i2c: pxa: Return I2C_RETRY when timeout in pio
 mode
In-Reply-To: <1434383399-2370-4-git-send-email-vaibhav.hiremath@linaro.org>
References: <vaibhav.hiremath@linaro.org>
 <1434383399-2370-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1434383399-2370-4-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <CAM=Q2ct_PPkWkP4x3-YG4akYDw9Wi+HMK=5dJWEL4R8WO28JZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 15, 2015 at 9:19 PM, Vaibhav Hiremath
<vaibhav.hiremath@linaro.org> wrote:
> From: Shouming Wang <wangshm@marvell.com>
>
> In case of timeout in pio mode of operation return I2C_RETRY.
> This behavior will be same as interrupt mode of operation.
>
> Signed-off-by: Shouming Wang <wangshm@marvell.com>
> [vaibhav.hiremath at linaro.org: Updated changelog]
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> ---
>  drivers/i2c/busses/i2c-pxa.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index 023e59f..632008f 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -745,8 +745,10 @@ static int i2c_pxa_do_pio_xfer(struct pxa_i2c *i2c,
>         ret = i2c->msg_idx;
>
>  out:
> -       if (timeout == 0)
> +       if (timeout == 0) {
>                 i2c_pxa_scream_blue_murder(i2c, "timeout");
> +               ret = I2C_RETRY;

Can we use standard  return types.

> +       }
>
>         return ret;
>  }
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
