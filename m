From: balbi@ti.com (Felipe Balbi)
Date: Mon, 15 Aug 2011 22:17:46 +0300
Subject: [PATCH] i2c: tegra: Check for overflow errors with BUG_ON.
In-Reply-To: <1313434172-18319-1-git-send-email-dianders@chromium.org>
References: <1313434172-18319-1-git-send-email-dianders@chromium.org>
Message-ID: <20110815191745.GA7178@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 15, 2011 at 11:49:32AM -0700, Doug Anderson wrote:
> This change doesn't fix any known problems but turns
> on the overflow detection feature of the i2c controller
> in the hopes of flushing out any current (or future)
> bugs in the i2c driver.
> 
> Inspired by a change on nvidia's git server:
>   http://nv-tegra.nvidia.com/gitweb/?p=linux-2.6.git;a=commit;h=266d1b7397284505e55d06254b497cb32be07b69
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/i2c/busses/i2c-tegra.c |   11 ++++++++---
>  1 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> index 2440b74..4dbba23 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -367,7 +367,8 @@ static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
>  static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
>  {
>  	u32 status;
> -	const u32 status_err = I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
> +	const u32 status_err = I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST |
> +		I2C_INT_TX_FIFO_OVERFLOW;
>  	struct tegra_i2c_dev *i2c_dev = dev_id;
>  
>  	status = i2c_readl(i2c_dev, I2C_INT_STATUS);
> @@ -389,6 +390,9 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
>  	}
>  
>  	if (unlikely(status & status_err)) {
> +		/* Don't pass this back--it can only happen due to a bug. */
> +		BUG_ON(status & I2C_INT_TX_FIFO_OVERFLOW);

so due to a FIFO overflow you lock up the whole system ? Can't you e.g.
reset the controller and reconfigure it rather than locking up the
system ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110815/34ebb6a6/attachment.sig>
