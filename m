From: srinidhi.kasagar@stericsson.com (Srinidhi Kasagar)
Date: Thu, 15 Nov 2012 14:19:00 +0530
Subject: Fwd: [PATCH 1/7] I2c-nomadik: Fix the usage of
 wait_for_completion_timeout
In-Reply-To: <CACRpkdYekQF5111NSNSPeaHdxgS_gpXkCjqT1n-n1_iAdDXbSg@mail.gmail.com>
References: <1352222317.15558.1584.camel@cliu38-desktop-build>
 <CACRpkdYekQF5111NSNSPeaHdxgS_gpXkCjqT1n-n1_iAdDXbSg@mail.gmail.com>
Message-ID: <20121115084858.GA29668@bnru10>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> From: Chuansheng Liu <chuansheng.liu@intel.com>
> Date: Tue, Nov 6, 2012 at 6:18 PM
> Subject: [PATCH 1/7] I2c-nomadik: Fix the usage of wait_for_completion_timeout
> To: linus.walleij at linaro.org, w.sang at pengutronix.de
> Cc: linux-arm-kernel at lists.infradead.org,
> linux-kernel at vger.kernel.org, chuansheng.liu at intel.com
> 
> 
> 
> The return value of wait_for_completion_timeout() is always
> >= 0 with unsigned int type.
> 
> So the condition "ret < 0" or "ret >= 0" is pointless.
> 
> Signed-off-by: liu chuansheng <chuansheng.liu@intel.com>
> ---
>  drivers/i2c/busses/i2c-nomadik.c |   14 --------------
>  1 files changed, 0 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
> index 02c3115..8b2ffcf 100644
> --- a/drivers/i2c/busses/i2c-nomadik.c
> +++ b/drivers/i2c/busses/i2c-nomadik.c
> @@ -435,13 +435,6 @@ static int read_i2c(struct nmk_i2c_dev *dev, u16 flags)
>         timeout = wait_for_completion_timeout(
>                 &dev->xfer_complete, dev->adap.timeout);
> 
> -       if (timeout < 0) {
> -               dev_err(&dev->adev->dev,
> -                       "wait_for_completion_timeout "
> -                       "returned %d waiting for event\n", timeout);
> -               status = timeout;
> -       }
> -
No, it is wrong. You need to update the status variable in the case of timeout.
It is used further in nmk_i2c_xfer_one. You could perhaps use

if (timeout == 0) {
 ...and the rest of the code as is
}

regards/srinidhi
