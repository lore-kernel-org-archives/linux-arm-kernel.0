From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 29 May 2015 22:46:43 +0200
Subject: [PATCH 06/12] i2c: pxa: Return I2C_RETRY when timeout in pio mode
In-Reply-To: <1432818224-17070-7-git-send-email-vaibhav.hiremath@linaro.org>
 (Vaibhav Hiremath's message of "Thu, 28 May 2015 18:33:38 +0530")
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1432818224-17070-7-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <87vbfbxgb0.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vaibhav Hiremath <vaibhav.hiremath@linaro.org> writes:

> From: Shouming Wang <wangshm@marvell.com>
>
> In case of timeout in pio mode of operation return I2C_RETRY.
> This behavior will be same as interrupt mode of operation.
>
> Signed-off-by: Shouming Wang <wangshm@marvell.com>
> [vaibhav.hiremath at linaro.org: Updated changelog]
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> ---
>  drivers/i2c/busses/i2c-pxa.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index eb09071..2777d5c 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -841,8 +841,10 @@ static int i2c_pxa_do_pio_xfer(struct pxa_i2c *i2c,
>  	ret = i2c->msg_idx;
>  
>  out:
> -	if (timeout == 0)
> +	if (timeout == 0) {
>  		i2c_pxa_scream_blue_murder(i2c, "timeout");
> +		ret = I2C_RETRY;
> +	}
Ok, looks good to me.
As it changes the dynamic behavior of i2c_pxa_pio_xfer(), I'd like to know how
it was tested (on which platform, and what was on the I2C bus).

Cheers.

-- 
Robert
