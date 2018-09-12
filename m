From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 12 Sep 2018 16:30:35 -0700
Subject: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined
 irq events properly
In-Reply-To: <6a99dc09-b06d-88ee-2843-3bd88f883dc2@linux.intel.com>
References: <e5135af4-9105-214f-5de2-65cc03804222@linux.intel.com>
 <CACPK8Xdv3aP_zOHAL0WMgwvkpBHAUesU7OdhW==jgvXjRmt-Zw@mail.gmail.com>
 <20180911233302.GA18799@roeck-us.net>
 <5698ca34-14c9-8d05-c4e6-5acf85ff9d14@linux.intel.com>
 <20180912013449.GA12612@roeck-us.net>
 <7fd98646-fb5a-be4d-ce37-84b74e0fa8b3@linux.intel.com>
 <20180912195844.GA6893@roeck-us.net>
 <da7f4691-7428-3114-32bb-e0171f6c7228@linux.intel.com>
 <20180912203059.GA18201@roeck-us.net>
 <6a99dc09-b06d-88ee-2843-3bd88f883dc2@linux.intel.com>
Message-ID: <20180912233035.GA10713@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2018 at 03:31:06PM -0700, Jae Hyun Yoo wrote:
> >
> >I played with the code on both sides. I had to make changes in both
> >the linux kernel and in qemu to get the code to work again.
> >See attached.
> >
> >Guenter
> >
> >---
> >Linux:
> >
> >diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> >index c258c4d9a4c0..3d518e09369f 100644
> >--- a/drivers/i2c/busses/i2c-aspeed.c
> >+++ b/drivers/i2c/busses/i2c-aspeed.c
> >@@ -552,6 +552,9 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
> >  	spin_lock(&bus->lock);
> >  	irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
> >+	/* Ack all interrupts except for Rx done */
> >+	writel(irq_received & ~ASPEED_I2CD_INTR_RX_DONE,
> >+	       bus->base + ASPEED_I2C_INTR_STS_REG);
> >  	irq_remaining = irq_received;
> >  #if IS_ENABLED(CONFIG_I2C_SLAVE)
> >@@ -584,8 +587,10 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
> >  			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
> >  			irq_received, irq_handled);
> >-	/* Ack all interrupt bits. */
> >-	writel(irq_received, bus->base + ASPEED_I2C_INTR_STS_REG);
> >+	/* Ack Rx done */
> >+	if (irq_received & ASPEED_I2CD_INTR_RX_DONE)
> >+		writel(ASPEED_I2CD_INTR_RX_DONE,
> >+		       bus->base + ASPEED_I2C_INTR_STS_REG);
> >  	spin_unlock(&bus->lock);
> >  	return irq_remaining ? IRQ_NONE : IRQ_HANDLED;
> >  }
> >
> >---
> >qemu:
> >
> >diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> >index c762c73..0d4aa08 100644
> >--- a/hw/i2c/aspeed_i2c.c
> >+++ b/hw/i2c/aspeed_i2c.c
> >@@ -180,6 +180,33 @@ static uint8_t aspeed_i2c_get_state(AspeedI2CBus *bus)
> >      return (bus->cmd >> I2CD_TX_STATE_SHIFT) & I2CD_TX_STATE_MASK;
> >  }
> >+static void aspeed_i2c_handle_rx_cmd(AspeedI2CBus *bus)
> >+{
> >+    int ret;
> >+
> >+    if (!(bus->cmd & (I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST))) {
> >+        return;
> >+    }
> >+    if (bus->intr_status & I2CD_INTR_RX_DONE) {
> >+        return;
> >+    }
> >+
> >+    aspeed_i2c_set_state(bus, I2CD_MRXD);
> >+    ret = i2c_recv(bus->bus);
> >+    if (ret < 0) {
> >+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read failed\n", __func__);
> >+        ret = 0xff;
> >+    } else {
> >+        bus->intr_status |= I2CD_INTR_RX_DONE;
> >+    }
> >+    bus->buf = (ret & I2CD_BYTE_BUF_RX_MASK) << I2CD_BYTE_BUF_RX_SHIFT;
> >+    if (bus->cmd & I2CD_M_S_RX_CMD_LAST) {
> >+        i2c_nack(bus->bus);
> >+    }
> >+    bus->cmd &= ~(I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST);
> >+    aspeed_i2c_set_state(bus, I2CD_MACTIVE);
> >+}
> >+
> >  /*
> >   * The state machine needs some refinement. It is only used to track
> >   * invalid STOP commands for the moment.
> >@@ -188,7 +215,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
> >  {
> >      bus->cmd &= ~0xFFFF;
> >      bus->cmd |= value & 0xFFFF;
> >-    bus->intr_status = 0;
> >+    bus->intr_status &= I2CD_INTR_RX_DONE;
> >      if (bus->cmd & I2CD_M_START_CMD) {
> >          uint8_t state = aspeed_i2c_get_state(bus) & I2CD_MACTIVE ?
> >@@ -227,22 +254,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
> >      }
> >      if (bus->cmd & (I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST)) {
> >-        int ret;
> >-
> >-        aspeed_i2c_set_state(bus, I2CD_MRXD);
> >-        ret = i2c_recv(bus->bus);
> >-        if (ret < 0) {
> >-            qemu_log_mask(LOG_GUEST_ERROR, "%s: read failed\n", __func__);
> >-            ret = 0xff;
> >-        } else {
> >-            bus->intr_status |= I2CD_INTR_RX_DONE;
> >-        }
> >-        bus->buf = (ret & I2CD_BYTE_BUF_RX_MASK) << I2CD_BYTE_BUF_RX_SHIFT;
> >-        if (bus->cmd & I2CD_M_S_RX_CMD_LAST) {
> >-            i2c_nack(bus->bus);
> >-        }
> >-        bus->cmd &= ~(I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST);
> >-        aspeed_i2c_set_state(bus, I2CD_MACTIVE);
> >+        aspeed_i2c_handle_rx_cmd(bus);
> >      }
> >      if (bus->cmd & I2CD_M_STOP_CMD) {
> >@@ -263,6 +275,7 @@ static void aspeed_i2c_bus_write(void *opaque, hwaddr offset,
> >                                   uint64_t value, unsigned size)
> >  {
> >      AspeedI2CBus *bus = opaque;
> >+    int status;
> >      switch (offset) {
> >      case I2CD_FUN_CTRL_REG:
> >@@ -283,9 +296,16 @@ static void aspeed_i2c_bus_write(void *opaque, hwaddr offset,
> >          bus->intr_ctrl = value & 0x7FFF;
> >          break;
> >      case I2CD_INTR_STS_REG:
> >+        status = bus->intr_status;
> >          bus->intr_status &= ~(value & 0x7FFF);
> >-        bus->controller->intr_status &= ~(1 << bus->id);
> >-        qemu_irq_lower(bus->controller->irq);
> >+        if (!bus->intr_status) {
> >+            bus->controller->intr_status &= ~(1 << bus->id);
> >+            qemu_irq_lower(bus->controller->irq);
> >+        }
> >+        if ((status & I2CD_INTR_RX_DONE) && !(bus->intr_status & I2CD_INTR_RX_DONE)) {
> >+            aspeed_i2c_handle_rx_cmd(bus);
> >+            aspeed_i2c_bus_raise_interrupt(bus);
> >+        }
> >          break;
> >      case I2CD_DEV_ADDR_REG:
> >          qemu_log_mask(LOG_UNIMP, "%s: slave mode not implemented\n",
> >
> 
> Nice fix! LGTM. I've tested the new patch and checked that it works well
> on both low and high bus speed environments. Thanks a lot!
> 
> Can you please submit this patch?
> 
Assuming you mean both patches, sure, can do. I'll need to clean up
the qemu patch a bit, though; it looks too messy for my liking.

Guenter
