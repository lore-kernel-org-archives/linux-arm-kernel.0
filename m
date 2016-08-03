From: ray.jui@broadcom.com (Ray Jui)
Date: Wed, 3 Aug 2016 09:36:10 -0700
Subject: [PATCH v0 1/4] i2c: bcm-iproc: Use complete() instead of
 complete_all()
In-Reply-To: <1470225791-16613-2-git-send-email-wagi@monom.org>
References: <1470225791-16613-1-git-send-email-wagi@monom.org>
 <1470225791-16613-2-git-send-email-wagi@monom.org>
Message-ID: <32341d5e-a3a1-368e-8319-67b95bb7ade8@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 8/3/2016 5:03 AM, Daniel Wagner wrote:
> From: Daniel Wagner <daniel.wagner@bmw-carit.de>
>
> There is only one waiter for the completion, therefore there
> is no need to use complete_all(). Let's make that clear by
> using complete() instead of complete_all().
>
> The usage pattern of the completion is:
>
> bcm_iproc_i2c_xfer_single_msg()
>   reinit_completion()
>   ...
>   (activate the transfer)
>   ...
>   wait_for_completion_timeout()
>
> Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
> ---
>  drivers/i2c/busses/i2c-bcm-iproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
> index 19c8438..95f7cac 100644
> --- a/drivers/i2c/busses/i2c-bcm-iproc.c
> +++ b/drivers/i2c/busses/i2c-bcm-iproc.c
> @@ -158,7 +158,7 @@ static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
>
>  	if (status & BIT(IS_M_START_BUSY_SHIFT)) {
>  		iproc_i2c->xfer_is_done = 1;
> -		complete_all(&iproc_i2c->done);
> +		complete(&iproc_i2c->done);
>  	}
>
>  	writel(status, iproc_i2c->base + IS_OFFSET);
>

Yes each time there's only one waiter invoked from the main transfer 
routine 'bcm_iproc_i2c_xfer_single_msg'.

This change looks good to me, thanks!

Acked-by: Ray Jui <ray.jui@broadcom.com>
