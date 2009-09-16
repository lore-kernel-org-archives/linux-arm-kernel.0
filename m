From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 16 Sep 2009 01:14:39 +0100
Subject: [PATCH 05/10] S3C I2S: lrsync function made to work with IRQs
	disabled.
In-Reply-To: <1253008957-10569-1-git-send-email-jassi.brar@samsung.com>
References: <1253008957-10569-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <20090916001439.GD24720@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 07:02:37PM +0900, Jassi wrote:
> s3c2412_snd_lrsync() maybe reached with IRQs disabled and if LRCLK
> is dead due to improper initialization of CPU or CODEC, the system
> gets stuck in the loop because jiffies may never get updated.
> Implemented counter based wait mechanism for atleast the same
> timeout period.
> 
> Signed-Off-by: Jassi <jassi.brar@samsung.com>
> ---
>  sound/soc/s3c24xx/s3c-i2s-v2.c |   16 ++++++++++------
>  1 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
> index aa7af0b..8865bc7 100644
> --- a/sound/soc/s3c24xx/s3c-i2s-v2.c
> +++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
> @@ -230,6 +230,8 @@ static void s3c2412_snd_rxctrl(struct s3c_i2sv2_info *i2s, int on)
>  	pr_debug("%s: IIS: CON=%x MOD=%x FIC=%x\n", __func__, con, mod, fic);
>  }
>  
> +#define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
> +
>  /*
>   * Wait for the LR signal to allow synchronisation to the L/R clock
>   * from the codec. May only be needed for slave mode.
> @@ -237,19 +239,21 @@ static void s3c2412_snd_rxctrl(struct s3c_i2sv2_info *i2s, int on)
>  static int s3c2412_snd_lrsync(struct s3c_i2sv2_info *i2s)
>  {
>  	u32 iiscon;
> -	unsigned long timeout = jiffies + msecs_to_jiffies(5);
> +	unsigned long loops = msecs_to_loops(5);
>  
>  	pr_debug("Entered %s\n", __func__);
>  
> -	while (1) {
> +	while (--loops) {
>  		iiscon = readl(i2s->regs + S3C2412_IISCON);
>  		if (iiscon & S3C2412_IISCON_LRINDEX)
>  			break;
>  
> -		if (timeout < jiffies) {
> -			printk(KERN_ERR "%s: timeout\n", __func__);
> -			return -ETIMEDOUT;
> -		}
> +	   	cpu_relax();

I don't think cpu_relax() gives a defined 'timeout' length, thus this
loop is of a very indeterminate length of timeout.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
