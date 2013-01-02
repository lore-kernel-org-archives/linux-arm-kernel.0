From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 2 Jan 2013 14:55:18 +0100
Subject: [PATCH 1/2] pwm: vt8500: Register write busy test performed
 incorrectly
In-Reply-To: <1356899005-8876-1-git-send-email-linux@prisktech.co.nz>
References: <1356899005-8876-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <20130102135518.GB4414@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 31, 2012 at 09:23:24AM +1300, Tony Prisk wrote:
> Correct operation for register writes is to perform a busy-wait
> after writing the register. Currently the busy wait it performed
> before, meaning subsequent register writes to bitfields may occur
> before the previous field has been updated.
> 
> Also, all registers are defined as 32-bit read/write. Change
> pwm_busy_wait() to use readl rather than readb.
> 
> Improve readability of code with defines for registers and bitfields.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
> Thierry,
> 
> This patch is a fix but it can go to 3.9 rather than 3.8 (if you prefer)
> as the incorrect behaviour doesn't seem to cause a problem on current
> hardware.
> 
>  drivers/pwm/pwm-vt8500.c |   62 +++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 48 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
> index b0ba2d4..27ed0f4 100644
> --- a/drivers/pwm/pwm-vt8500.c
> +++ b/drivers/pwm/pwm-vt8500.c
> @@ -36,6 +36,25 @@
>   */
>  #define VT8500_NR_PWMS	2
>  
> +#define REG_CTRL(pwm)		(pwm << 4) + 0x00
> +#define REG_SCALAR(pwm)		(pwm << 4) + 0x04
> +#define REG_PERIOD(pwm)		(pwm << 4) + 0x08
> +#define REG_DUTY(pwm)		(pwm << 4) + 0x0C

To be on the safe side, I think these should be:

	(((pwm) << 4) + offset)

> -static inline void pwm_busy_wait(void __iomem *reg, u8 bitmask)
> +static inline void pwm_busy_wait(struct vt8500_chip *vt8500, int nr, u8 bitmask)
>  {
>  	int loops = msecs_to_loops(10);
> -	while ((readb(reg) & bitmask) && --loops)
> +	u32 mask = bitmask << (nr << 8);
> +
> +	while ((readl(vt8500->base + REG_STATUS) & mask) && --loops)
>  		cpu_relax();
>  
>  	if (unlikely(!loops))
>  		pr_warn("Waiting for status bits 0x%x to clear timed out\n",
> -			   bitmask);
> +			   mask);
>  }

Now that you're passing a struct vt8500_chip, couldn't you use
dev_warn() instead?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130102/e247497b/attachment.sig>
