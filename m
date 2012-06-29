From: shijie.zhang@intel.com (Zhang, Shijie)
Date: Fri, 29 Jun 2012 01:34:43 +0000
Subject: [PATCHv11 3/6] i2c: omap: Do not initialise the completion
 everytime
In-Reply-To: <CAAe_U6Jtoj3mixvp+vqNmkr-RC28AfNqZ0syEE5voEr+Odv3zg@mail.gmail.com>
References: <1340896292-12112-1-git-send-email-shubhrajyoti@ti.com>
 <1340896292-12112-4-git-send-email-shubhrajyoti@ti.com>
 <CAAe_U6Jtoj3mixvp+vqNmkr-RC28AfNqZ0syEE5voEr+Odv3zg@mail.gmail.com>
Message-ID: <F432D66873BF804996E7E830C3B891790FD37C8E@SHSMSX102.ccr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No, it should be init_completion(&dev->cmd_complete); in probe, we need to initialize the wait queue, which will be used when using "complete(......)"


-----Original Message-----
From: linux-i2c-owner@vger.kernel.org [mailto:linux-i2c-owner at vger.kernel.org] On Behalf Of ABRAHAM, KISHON VIJAY
Sent: Friday, June 29, 2012 12:03 AM
To: Shubhrajyoti D
Cc: linux-omap at vger.kernel.org; linux-i2c at vger.kernel.org; linux-arm-kernel at lists.infradead.org; ben-linux at fluff.org; tony at atomide.com; w.sang at pengutronix.de
Subject: Re: [PATCHv11 3/6] i2c: omap: Do not initialise the completion everytime

Hi,

On Thu, Jun 28, 2012 at 8:41 PM, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
> Use INIT_COMPLETION instead of init_completion in transfer.
>
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> - Add Felipe's reviewed-by tag
>
> ?drivers/i2c/busses/i2c-omap.c | ? ?3 ++-
> ?1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c 
> b/drivers/i2c/busses/i2c-omap.c index b9915bb..6d05f18 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -490,7 +490,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter 
> *adap,
> ? ? ? ?w |= OMAP_I2C_BUF_RXFIF_CLR | OMAP_I2C_BUF_TXFIF_CLR;
> ? ? ? ?omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, w);
>
> - ? ? ? init_completion(&dev->cmd_complete);
> + ? ? ? INIT_COMPLETION(dev->cmd_complete);
> ? ? ? ?dev->cmd_err = 0;
>
> ? ? ? ?w = OMAP_I2C_CON_EN | OMAP_I2C_CON_MST | OMAP_I2C_CON_STT; @@ 
> -999,6 +999,7 @@ omap_i2c_probe(struct platform_device *pdev)
> ? ? ? ?}
>
> ? ? ? ?platform_set_drvdata(pdev, dev);
> + ? ? ? init_completion(&dev->cmd_complete);
It should be INIT_COMPLETION here too.

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in the body of a message to majordomo at vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
