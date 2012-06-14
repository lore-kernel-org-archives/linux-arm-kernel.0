From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 14 Jun 2012 16:41:45 +0530
Subject: [PATCH 09/17] i2c: omap: ack IRQ in parts
In-Reply-To: <1339669250-9183-10-git-send-email-balbi@ti.com>
References: <1339669250-9183-1-git-send-email-balbi@ti.com>
 <1339669250-9183-10-git-send-email-balbi@ti.com>
Message-ID: <CAMQu2gw4B_5eFSAq_o+MamNDDwoZi2CitmC+dM=+pi3R1Z2QCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 3:50 PM, Felipe Balbi <balbi@ti.com> wrote:
> According to flow diagrams on OMAP TRMs,
> we should ACK the IRQ as they happen.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> ?drivers/i2c/busses/i2c-omap.c | ? 29 +++++++++++++++++------------
> ?1 file changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index f978b14..c00ba7d 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -894,21 +894,20 @@ omap_i2c_isr(int this_irq, void *dev_id)
> ? ? ? ? ? ? ? ?}
>
> ?complete:
> - ? ? ? ? ? ? ? /*
> - ? ? ? ? ? ? ? ?* Ack the stat in one go, but [R/X]DR and [R/X]RDY should be
> - ? ? ? ? ? ? ? ?* acked after the data operation is complete.
> - ? ? ? ? ? ? ? ?* Ref: TRM SWPU114Q Figure 18-31
> - ? ? ? ? ? ? ? ?*/
> - ? ? ? ? ? ? ? omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat &
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ~(OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR |
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
> -
> - ? ? ? ? ? ? ? if (stat & OMAP_I2C_STAT_NACK)
> + ? ? ? ? ? ? ? if (stat & OMAP_I2C_STAT_NACK) {
> + ? ? ? ? ? ? ? ? ? ? ? dev_err(dev->dev, "No Acknowledge\n");
> ? ? ? ? ? ? ? ? ? ? ? ?err |= OMAP_I2C_STAT_NACK;
> + ? ? ? ? ? ? ? ? ? ? ? omap_i2c_ack_stat(dev, OMAP_I2C_STAT_NACK);
> + ? ? ? ? ? ? ? ? ? ? ? omap_i2c_complete_cmd(dev, err);
> + ? ? ? ? ? ? ? ? ? ? ? return IRQ_HANDLED;
> + ? ? ? ? ? ? ? }
>
Do you think making I2C IRQ ack + complete as one small static inline function
can save clean the code further. I see it has been used in multiple paths.
