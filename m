From: eric@anholt.net (Eric Anholt)
Date: Wed, 28 Oct 2015 12:16:51 -0700
Subject: [PATCH 3/4] i2c: added I2C_AQ_NO_CLK_STRETCH to i2c-bcm2835.c
In-Reply-To: <1445976718-7449-3-git-send-email-nicola@corna.info>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1445976718-7449-3-git-send-email-nicola@corna.info>
Message-ID: <8737wu9524.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicola Corna <nicola@corna.info> writes:
> As reported here
> http://www.advamation.com/knowhow/raspberrypi/rpi-i2c-bug.html
> the BCM2835 has a bug in its i2c implementation which prevents a correct
> clock stretching.
>
> Signed-off-by: Nicola Corna <nicola@corna.info>
> ---
>  drivers/i2c/busses/i2c-bcm2835.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
> index 3032b89..38d7102 100644
> --- a/drivers/i2c/busses/i2c-bcm2835.c
> +++ b/drivers/i2c/busses/i2c-bcm2835.c
> @@ -222,6 +222,10 @@ static const struct i2c_algorithm bcm2835_i2c_algo = {
>  	.functionality	= bcm2835_i2c_func,
>  };
>  
> +static const struct i2c_adapter_quirks bcm2835_i2c_quirks = {
> +	.flags = I2C_AQ_NO_CLK_STRETCH,
> +};
> +
>  static int bcm2835_i2c_probe(struct platform_device *pdev)
>  {
>  	struct bcm2835_i2c_dev *i2c_dev;
> @@ -293,6 +297,7 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
>  	adap->algo = &bcm2835_i2c_algo;
>  	adap->dev.parent = &pdev->dev;
>  	adap->dev.of_node = pdev->dev.of_node;
> +	adap->quirks = &bcm2835_i2c_quirks;
>  
>  	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, 0);

Looking at the driver, we're not setting the REDL/FEDL fields, which are
involved in the delays following clock stretching.  Looks like I2C_DEL's
low 16 bits (rising edge delay) should be I2C_DIV / 4 (wait half the
period for the slave to update its data before we sample it), and the
high 16 bits (falling edge delay) should be I2C_DIV / 16 (put our data
out before we expet the slave to sample the value).

Note: this is not a detailed analysis, nor am I asserting that this is
the bug, just something that we seem to be missing in the Linux driver.

(Added cc to linux-rpi-kernel, in case anyone on that list is interested
in I2C issues on the platform)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151028/675f82b2/attachment.sig>
