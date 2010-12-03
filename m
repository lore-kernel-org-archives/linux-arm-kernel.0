From: ben@trinity.fluff.org (Ben Dooks)
Date: Fri, 3 Dec 2010 01:44:24 +0000
Subject: [PATCH 1/6] i2c/pxa2xx: Don't touch ISAR on X86
In-Reply-To: <1291320589-31570-2-git-send-email-bigeasy@linutronix.de>
References: <1291320589-31570-1-git-send-email-bigeasy@linutronix.de>
	<1291320589-31570-2-git-send-email-bigeasy@linutronix.de>
Message-ID: <20101203014424.GG24979@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 02, 2010 at 09:09:44PM +0100, Sebastian Andrzej Siewior wrote:
> The reset functions sets writes the slave address even in not slave
> mode. I don't see any reason in writting it if slave mode is not
> enabled.
> Ben Dooks was conserned about making this change make it unavable on X86
> where it is not available.
> 
> Cc: ben-i2c at fluff.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
> ---
>  drivers/i2c/busses/i2c-pxa.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index f4c19a9..aadf9d2 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -418,7 +418,9 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
>  	writel(I2C_ISR_INIT, _ISR(i2c));
>  	writel(readl(_ICR(i2c)) & ~ICR_UR, _ICR(i2c));
>  
> +#ifndef CONFIG_X86
>  	writel(i2c->slave_addr, _ISAR(i2c));
> +#endif

I'd prefer some way of changing based on either the device name (see
some other drivers which bind on multiple names) to define things such
as this, as well as possibly changing the register layout.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
