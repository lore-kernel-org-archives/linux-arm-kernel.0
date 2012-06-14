From: balbi@ti.com (Felipe Balbi)
Date: Thu, 14 Jun 2012 14:46:39 +0300
Subject: [PATCH 09/17] i2c: omap: ack IRQ in parts
In-Reply-To: <CAMQu2gw4B_5eFSAq_o+MamNDDwoZi2CitmC+dM=+pi3R1Z2QCA@mail.gmail.com>
References: <1339669250-9183-1-git-send-email-balbi@ti.com>
 <1339669250-9183-10-git-send-email-balbi@ti.com>
 <CAMQu2gw4B_5eFSAq_o+MamNDDwoZi2CitmC+dM=+pi3R1Z2QCA@mail.gmail.com>
Message-ID: <20120614114638.GQ13602@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 04:41:45PM +0530, Shilimkar, Santosh wrote:
> On Thu, Jun 14, 2012 at 3:50 PM, Felipe Balbi <balbi@ti.com> wrote:
> > According to flow diagrams on OMAP TRMs,
> > we should ACK the IRQ as they happen.
> >
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> > ?drivers/i2c/busses/i2c-omap.c | ? 29 +++++++++++++++++------------
> > ?1 file changed, 17 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> > index f978b14..c00ba7d 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -894,21 +894,20 @@ omap_i2c_isr(int this_irq, void *dev_id)
> > ? ? ? ? ? ? ? ?}
> >
> > ?complete:
> > - ? ? ? ? ? ? ? /*
> > - ? ? ? ? ? ? ? ?* Ack the stat in one go, but [R/X]DR and [R/X]RDY should be
> > - ? ? ? ? ? ? ? ?* acked after the data operation is complete.
> > - ? ? ? ? ? ? ? ?* Ref: TRM SWPU114Q Figure 18-31
> > - ? ? ? ? ? ? ? ?*/
> > - ? ? ? ? ? ? ? omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat &
> > - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ~(OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR |
> > - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
> > -
> > - ? ? ? ? ? ? ? if (stat & OMAP_I2C_STAT_NACK)
> > + ? ? ? ? ? ? ? if (stat & OMAP_I2C_STAT_NACK) {
> > + ? ? ? ? ? ? ? ? ? ? ? dev_err(dev->dev, "No Acknowledge\n");
> > ? ? ? ? ? ? ? ? ? ? ? ?err |= OMAP_I2C_STAT_NACK;
> > + ? ? ? ? ? ? ? ? ? ? ? omap_i2c_ack_stat(dev, OMAP_I2C_STAT_NACK);
> > + ? ? ? ? ? ? ? ? ? ? ? omap_i2c_complete_cmd(dev, err);
> > + ? ? ? ? ? ? ? ? ? ? ? return IRQ_HANDLED;
> > + ? ? ? ? ? ? ? }
> >
> Do you think making I2C IRQ ack + complete as one small static inline function
> can save clean the code further. I see it has been used in multiple paths.

done in a later patch

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120614/21a64ab8/attachment.sig>
