From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 May 2012 15:30:35 +0100
Subject: [RFC] pl08x: don't use dma_slave_config direction argument
In-Reply-To: <20120516110451.GA9571@n2100.arm.linux.org.uk>
References: <20120516110451.GA9571@n2100.arm.linux.org.uk>
Message-ID: <20120517143035.GA19548@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

Is there any reason you can see not to do this?

I ultimately need to kill off the passing of struct pl08x_dma_chan to
these functions, because that's preventing me moving the struct into
drivers/dma - which I need to in order to convert amba-pl08x.c to use
virt-dma.c.

The only use of pl08x_dma_chan in the functions below is for the debug
prints, which I suggest we just kill off - or we could change them to
be cd->bus_id, which is the same thing anyway.

diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 45868bb..30efe77 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
...
+/* State of the big DMA mux */
+static u32 current_mux;
+static u32 mux_users;
+static DEFINE_SPINLOCK(current_mux_lock);
+
+static int pl081_get_signal(struct pl08x_dma_chan *ch, const struct pl08x_channel_data *cd)
+{
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&current_mux_lock, flags);
+	/*
+	 * We're on the same mux so fine, go ahead!
+	 */
+	if (cd->muxval == current_mux) {
+		mux_users ++;
+		spin_unlock_irqrestore(&current_mux_lock, flags);
+		/* We still have to write it since it may be OFF by default */
+		val = readl(__io_address(REALVIEW_SYS_DMAPSR));
+		val &= 0xFFFFFFFCU;
+		val |= current_mux;
+		writel(val, __io_address(REALVIEW_SYS_DMAPSR));
+		return cd->min_signal;
+	}
+	/*
+	 * If we're not on the same mux and there are already
+	 * users on the other mux setting, tough luck, the client
+	 * can come back and retry or give up and fall back to
+	 * PIO mode.
+	 */
+	if (mux_users) {
+		spin_unlock_irqrestore(&current_mux_lock, flags);
+		return -EBUSY;
+	}
+
+	/* Switch mux setting */
+	current_mux = cd->muxval;
+
+	val = readl(__io_address(REALVIEW_SYS_DMAPSR));
+	val &= 0xFFFFFFFCU;
+	val |= cd->muxval;
+	writel(val, __io_address(REALVIEW_SYS_DMAPSR));
+
+	pr_info("%s: muxing in %s in bank %d writing value "
+		"%08x to register %08x\n",
+		__func__, ch->name, cd->muxval,
+		val, REALVIEW_SYS_DMAPSR);
+
+	spin_unlock_irqrestore(&current_mux_lock, flags);
+
+	return cd->min_signal;
+}
+
+static void pl081_put_signal(struct pl08x_dma_chan *ch, int signal)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&current_mux_lock, flags);
+	mux_users--;
+	spin_unlock_irqrestore(&current_mux_lock, flags);
+}
...
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 6bbd74e..5570894 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
...
+/* This is a lock for the above muxing array */
+static DEFINE_SPINLOCK(muxlock);
+
+static int pl080_get_signal(struct pl08x_dma_chan *ch, const struct pl08x_channel_data *cd)
+{
+	pr_debug("requesting DMA signal on channel %s\n", ch->name);
+
+	/*
+	 * The AB926EJ-S is simple - only static assignments
+	 * so the channel is already muxed in and ready to go.
+	 */
+	if (machine_is_versatile_ab())
+		return cd->min_signal;
+
+	/* The PB926EJ-S is hairier */
+	if (machine_is_versatile_pb()) {
+		unsigned long flags;
+		int i;
+
+		if (cd->min_signal > ARRAY_SIZE(pl080_muxtab) ||
+		    cd->max_signal > ARRAY_SIZE(pl080_muxtab) ||
+		    (cd->max_signal < cd->min_signal)) {
+			pr_err("%s: illegal muxing constraints for %s\n",
+			       __func__, ch->name);
+			return -EINVAL;
+		}
+		/* Try to find a signal to use */
+		spin_lock_irqsave(&muxlock, flags);
+		for (i = cd->min_signal; i <= cd->max_signal; i++) {
+			if (!pl080_muxtab[i].user) {
+				u32 val;
+
+				pl080_muxtab[i].user = ch;
+				/* If the channels need to be muxed in, mux them! */
+				if (pl080_muxtab[i].ctrlreg) {
+					val = readl(__io_address(pl080_muxtab[i].ctrlreg));
+					val &= 0xFFFFFF60U;
+					val |= 0x80; /* Turn on muxing */
+					val |= cd->muxval; /* Mux in the right peripheral */
+					writel(val, __io_address(pl080_muxtab[i].ctrlreg));
+					pr_debug("%s: muxing in %s at channel %d writing value "
+						 "%08x to register %08x\n",
+						 __func__, ch->name, i,
+						 val, pl080_muxtab[i].ctrlreg);
+				}
+				spin_unlock_irqrestore(&muxlock, flags);
+				return pl080_muxtab[i].id;
+			}
+		}
+		spin_unlock_irqrestore(&muxlock, flags);
+	}
+
+	return -EBUSY;
+}
+
+static void pl080_put_signal(struct pl08x_dma_chan *ch, int signal)
+{
+	unsigned long flags;
+	int i;
+
+	pr_debug("releasing DMA signal on channel %s\n", ch->name);
+
+	spin_lock_irqsave(&muxlock, flags);
+	for (i = 0; i < ARRAY_SIZE(pl080_muxtab); i++) {
+		if (pl080_muxtab[i].id == signal) {
+			WARN_ON(pl080_muxtab[i].user != ch);
+			pl080_muxtab[i].user = NULL;
+
+			if (pl080_muxtab[i].ctrlreg) {
+				u32 val;
+
+				val = readl(__io_address(pl080_muxtab[i].ctrlreg));
+				val &= 0xFFFFFF60U; /* Disable, select no channel */
+				writel(val, __io_address(pl080_muxtab[i].ctrlreg));
+				pr_debug("%s: muxing out %s@channel %d writing value "
+				       "%08x to register %08x\n",
+				       __func__, ch->name, i,
+				       val, pl080_muxtab[i].ctrlreg);
+			}
+			spin_unlock_irqrestore(&muxlock, flags);
+			return;
+		}
+	}
+	spin_unlock_irqrestore(&muxlock, flags);
+	pr_debug("%s: unable to release muxing on channel %s\n",
+	       __func__, ch->name);
+}
...
diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index e62dd87..afe4640 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -947,7 +947,7 @@ static int prep_phy_channel(struct pl08x_dma_chan *plchan,
 	 * Can the platform allow us to use this channel?
 	 */
 	if (plchan->slave && pl08x->pd->get_signal) {
-		ret = pl08x->pd->get_signal(plchan);
+		ret = pl08x->pd->get_signal(plchan, plchan->cd);
 		if (ret < 0) {
 			dev_dbg(&pl08x->adev->dev,
 				"unable to use physical channel %d for transfer on %s due to platform restrictions\n",
@@ -982,7 +982,7 @@ static void release_phy_channel(struct pl08x_dma_chan *plchan)
 	struct pl08x_driver_data *pl08x = plchan->host;
 
 	if ((plchan->phychan->signal >= 0) && pl08x->pd->put_signal) {
-		pl08x->pd->put_signal(plchan);
+		pl08x->pd->put_signal(plchan, plchan->phychan->signal);
 		plchan->phychan->signal = -1;
 	}
 	pl08x_put_phy_channel(pl08x, plchan->phychan);
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index 9331b68..f7312f8 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -147,8 +147,8 @@ struct pl08x_platform_data {
 	const struct pl08x_channel_data *slave_channels;
 	unsigned int num_slave_channels;
 	struct pl08x_channel_data memcpy_channel;
-	int (*get_signal)(struct pl08x_dma_chan *);
-	void (*put_signal)(struct pl08x_dma_chan *);
+	int (*get_signal)(struct pl08x_dma_chan *, const struct pl08x_channel_data *);
+	void (*put_signal)(struct pl08x_dma_chan *, int);
 	u8 lli_buses;
 	u8 mem_buses;
 };
