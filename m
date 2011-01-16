From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 16 Jan 2011 20:18:05 +0000
Subject: [PATCH 27/48] ARM: PL08x: avoid duplicating registers in txd
	and phychan structures
In-Reply-To: <4D334F15.3080705@intel.com>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
	<E1PZt3Z-00025W-0c@rmk-PC.arm.linux.org.uk>
	<AANLkTi=GsMaDQDSuR=Z4AT4Vk4GThx6O_0Le=pjsu9gj@mail.gmail.com>
	<20110115092324.GX15996@n2100.arm.linux.org.uk>
	<AANLkTim_1yK_Q7sy4a1iMX2zXG1p3EJ0avGvcYeTP9Us@mail.gmail.com>
	<20110116123615.GC27542@n2100.arm.linux.org.uk>
	<AANLkTi=s-CQVEj4wOZo8cCbzWnj5G0p_COtKoQt7Xzy8@mail.gmail.com>
	<20110116195948.GA4864@n2100.arm.linux.org.uk>
	<4D334F15.3080705@intel.com>
Message-ID: <20110116201805.GB4864@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 16, 2011 at 12:03:33PM -0800, Dan Williams wrote:
> On 1/16/2011 11:59 AM, Russell King - ARM Linux wrote:
>> On Sun, Jan 16, 2011 at 11:56:08AM -0800, Dan Williams wrote:
>>>   On Sun, Jan 16, 2011 at 4:36 AM, Russell King - ARM Linux
>>> <linux@arm.linux.org.uk>  wrote:
>>>>>> That probably means you've got something out of order.  I have them
>>>>>> ordered in my git tree, I'll recheck there.
>>>>>
>>>>> I rechecked here and I think everything is in order.
>>>>
>>>> Okay, something's screwed in the patch set - and I think I see what it is.
>>>> Patch 16 is missing a change.  I'll respin.
>>>
>>>   Can this be incremental to the previous series instead?  I'm looking
>>> to get my 2.6.38 pull request submitted.
>>
>> In which case I don't know what state your tree in, so...
>
> Sorry, should have pointed that out, here it is:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/djbw/async_tx.git next

Hmm, I found the missing part in a follow-on patch.  It should be safe
to apply but wasn't perfect so didn't get sent. (I thought it was a
little too noisy.)

Subject: [PATCH] ARM: PL08x: cleanup comments

Cleanup the formatting of comments, remove some which don't make sense
anymore.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c   |  144 ++++++++++++++++----------------------------
 include/linux/amba/pl08x.h |   45 +++++++-------
 2 files changed, 72 insertions(+), 117 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index bebc678..7b9c1b6 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -19,14 +19,14 @@
  * this program; if not, write to the Free Software Foundation, Inc., 59
  * Temple Place - Suite 330, Boston, MA  02111-1307, USA.
  *
- * The full GNU General Public License is in this distribution in the
- * file called COPYING.
+ * The full GNU General Public License is in this distribution in the file
+ * called COPYING.
  *
  * Documentation: ARM DDI 0196G == PL080
- * Documentation: ARM DDI 0218E	== PL081
+ * Documentation: ARM DDI 0218E == PL081
  *
- * PL080 & PL081 both have 16 sets of DMA signals that can be routed to
- * any channel.
+ * PL080 & PL081 both have 16 sets of DMA signals that can be routed to any
+ * channel.
  *
  * The PL080 has 8 channels available for simultaneous use, and the PL081
  * has only two channels. So on these DMA controllers the number of channels
@@ -91,11 +91,9 @@
 #define DRIVER_NAME	"pl08xdmac"
 
 /**
- * struct vendor_data - vendor-specific config parameters
- * for PL08x derivatives
+ * struct vendor_data - vendor-specific config parameters for PL08x derivatives
  * @channels: the number of channels available in this variant
- * @dualmaster: whether this version supports dual AHB masters
- * or not.
+ * @dualmaster: whether this version supports dual AHB masters or not.
  */
 struct vendor_data {
 	u8 channels;
@@ -241,10 +239,8 @@ static void pl08x_start_txd(struct pl08x_dma_chan *plchan,
  *
  * Disabling individual channels could lose data.
  *
- * Disable the peripheral DMA after disabling the DMAC
- * in order to allow the DMAC FIFO to drain, and
- * hence allow the channel to show inactive
- *
+ * Disable the peripheral DMA after disabling the DMAC in order to allow
+ * the DMAC FIFO to drain, and hence allow the channel to show inactive
  */
 static void pl08x_pause_phy_chan(struct pl08x_phy_chan *ch)
 {
@@ -367,6 +363,10 @@ static u32 pl08x_getbytes_chan(struct pl08x_dma_chan *plchan)
 
 /*
  * Allocate a physical channel for a virtual channel
+ *
+ * Try to locate a physical channel to be used for this transfer. If all
+ * are taken return NULL and the requester will have to cope by using
+ * some fallback PIO mode or retrying later.
  */
 static struct pl08x_phy_chan *
 pl08x_get_phy_channel(struct pl08x_driver_data *pl08x,
@@ -376,12 +376,6 @@ pl08x_get_phy_channel(struct pl08x_driver_data *pl08x,
 	unsigned long flags;
 	int i;
 
-	/*
-	 * Try to locate a physical channel to be used for
-	 * this transfer. If all are taken return NULL and
-	 * the requester will have to cope by using some fallback
-	 * PIO mode or retrying later.
-	 */
 	for (i = 0; i < pl08x->vd->channels; i++) {
 		ch = &pl08x->phy_chans[i];
 
@@ -495,9 +489,9 @@ struct pl08x_lli_build_data {
 };
 
 /*
- * Autoselect a master bus to use for the transfer
- * this prefers the destination bus if both available
- * if fixed address on one bus the other will be chosen
+ * Autoselect a master bus to use for the transfer this prefers the
+ * destination bus if both available if fixed address on one bus the
+ * other will be chosen
  */
 static void pl08x_choose_master_bus(struct pl08x_lli_build_data *bd,
 	struct pl08x_bus_data **mbus, struct pl08x_bus_data **sbus, u32 cctl)
@@ -530,8 +524,7 @@ static void pl08x_choose_master_bus(struct pl08x_lli_build_data *bd,
 }
 
 /*
- * Fills in one LLI for a certain transfer descriptor
- * and advance the counter
+ * Fills in one LLI for a certain transfer descriptor and advance the counter
  */
 static void pl08x_fill_lli_for_desc(struct pl08x_lli_build_data *bd,
 	int num_llis, int len, u32 cctl)
@@ -640,15 +633,11 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 	 * Choose bus to align to
 	 * - prefers destination bus if both available
 	 * - if fixed address on one bus chooses other
-	 * - modifies cctl to choose an appropriate master
 	 */
 	pl08x_choose_master_bus(&bd, &mbus, &sbus, cctl);
 
 	if (txd->len < mbus->buswidth) {
-		/*
-		 * Less than a bus width available
-		 * - send as single bytes
-		 */
+		/* Less than a bus width available - send as single bytes */
 		while (bd.remainder) {
 			dev_vdbg(&pl08x->adev->dev,
 				 "%s single byte LLIs for a transfer of "
@@ -659,10 +648,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 			total_bytes++;
 		}
 	} else {
-		/*
-		 *  Make one byte LLIs until master bus is aligned
-		 *  - slave will then be aligned also
-		 */
+		/* Make one byte LLIs until master bus is aligned */
 		while ((mbus->addr) % (mbus->buswidth)) {
 			dev_vdbg(&pl08x->adev->dev,
 				"%s adjustment lli for less than bus width "
@@ -674,7 +660,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 		}
 
 		/*
-		 *  Master now aligned
+		 * Master now aligned
 		 * - if slave is not then we must set its width down
 		 */
 		if (sbus->addr % sbus->buswidth) {
@@ -732,10 +718,8 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 
 			if (lli_len == target_len) {
 				/*
-				 * Can send what we wanted
-				 */
-				/*
-				 *  Maintain alignment
+				 * Can send what we wanted.
+				 * Maintain alignment
 				 */
 				lli_len	= (lli_len/mbus->buswidth) *
 							mbus->buswidth;
@@ -743,17 +727,14 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 			} else {
 				/*
 				 * So now we know how many bytes to transfer
-				 * to get to the nearest boundary
-				 * The next LLI will past the boundary
-				 * - however we may be working to a boundary
-				 *   on the slave bus
-				 *   We need to ensure the master stays aligned
+				 * to get to the nearest boundary.  The next
+				 * LLI will past the boundary.  However, we
+				 * may be working to a boundary on the slave
+				 * bus.  We need to ensure the master stays
+				 * aligned, and that we are working in
+				 * multiples of the bus widths.
 				 */
 				odd_bytes = lli_len % mbus->buswidth;
-				/*
-				 * - and that we are working in multiples
-				 *   of the bus widths
-				 */
 				lli_len -= odd_bytes;
 
 			}
@@ -793,8 +774,8 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 
 			if (odd_bytes) {
 				/*
-				 * Creep past the boundary,
-				 * maintaining master alignment
+				 * Creep past the boundary, maintaining
+				 * master alignment
 				 */
 				int j;
 				for (j = 0; (j < mbus->buswidth)
@@ -837,13 +818,9 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 	}
 
 	llis_va = txd->llis_va;
-	/*
-	 * The final LLI terminates the LLI.
-	 */
+	/* The final LLI terminates the LLI. */
 	llis_va[num_llis - 1].lli = 0;
-	/*
-	 * The final LLI element shall also fire an interrupt
-	 */
+	/* The final LLI element shall also fire an interrupt. */
 	llis_va[num_llis - 1].cctl |= PL080_CONTROL_TC_IRQ_EN;
 
 #ifdef VERBOSE_DEBUG
@@ -891,7 +868,6 @@ static void pl08x_free_txd_list(struct pl08x_driver_data *pl08x,
 			list_del(&txdi->node);
 			pl08x_free_txd(pl08x, txdi);
 		}
-
 	}
 }
 
@@ -1020,10 +996,9 @@ static struct dma_async_tx_descriptor *pl08x_prep_dma_interrupt(
 }
 
 /*
- * Code accessing dma_async_is_complete() in a tight loop
- * may give problems - could schedule where indicated.
- * If slaves are relying on interrupts to signal completion this
- * function must not be called with interrupts disabled
+ * Code accessing dma_async_is_complete() in a tight loop may give problems.
+ * If slaves are relying on interrupts to signal completion this function
+ * must not be called with interrupts disabled.
  */
 static enum dma_status
 pl08x_dma_tx_status(struct dma_chan *chan,
@@ -1046,10 +1021,6 @@ pl08x_dma_tx_status(struct dma_chan *chan,
 	}
 
 	/*
-	 * schedule(); could be inserted here
-	 */
-
-	/*
 	 * This cookie not complete yet
 	 */
 	last_used = plchan->chan.cookie;
@@ -1273,11 +1244,10 @@ static int pl08x_prep_channel_resources(struct pl08x_dma_chan *plchan,
 		}
 	} else
 		/*
-		 * Else we're all set, paused and ready to roll,
-		 * status will switch to PL08X_CHAN_RUNNING when
-		 * we call issue_pending(). If there is something
-		 * running on the channel already we don't change
-		 * its state.
+		 * Else we're all set, paused and ready to roll, status
+		 * will switch to PL08X_CHAN_RUNNING when we call
+		 * issue_pending(). If there is something running on the
+		 * channel already we don't change its state.
 		 */
 		if (plchan->state == PL08X_CHAN_IDLE)
 			plchan->state = PL08X_CHAN_PAUSED;
@@ -1528,10 +1498,9 @@ bool pl08x_filter_id(struct dma_chan *chan, void *chan_id)
 
 /*
  * Just check that the device is there and active
- * TODO: turn this bit on/off depending on the number of
- * physical channels actually used, if it is zero... well
- * shut it off. That will save some power. Cut the clock
- * at the same time.
+ * TODO: turn this bit on/off depending on the number of physical channels
+ * actually used, if it is zero... well shut it off. That will save some
+ * power. Cut the clock at the same time.
  */
 static void pl08x_ensure_on(struct pl08x_driver_data *pl08x)
 {
@@ -1579,16 +1548,11 @@ static void pl08x_tasklet(unsigned long data)
 	plchan->at = NULL;
 
 	if (txd) {
-		/*
-		 * Update last completed
-		 */
+		/* Update last completed */
 		plchan->lc = txd->tx.cookie;
 	}
 
-	/*
-	 * If a new descriptor is queued, set it up
-	 * plchan->at is NULL here
-	 */
+	/* If a new descriptor is queued, set it up plchan->at is NULL here */
 	if (!list_empty(&plchan->pend_list)) {
 		struct pl08x_txd *next;
 
@@ -1615,11 +1579,10 @@ static void pl08x_tasklet(unsigned long data)
 		plchan->state = PL08X_CHAN_IDLE;
 
 		/*
-		 * And NOW before anyone else can grab that free:d
-		 * up physical channel, see if there is some memcpy
-		 * pending that seriously needs to start because of
-		 * being stacked up while we were choking the
-		 * physical channels with data.
+		 * And NOW before anyone else can grab that free:d up
+		 * physical channel, see if there is some memcpy pending
+		 * that seriously needs to start because of being stacked
+		 * up while we were choking the physical channels with data.
 		 */
 		list_for_each_entry(waiting, &pl08x->memcpy.channels,
 				    chan.device_node) {
@@ -1670,9 +1633,7 @@ static irqreturn_t pl08x_irq(int irq, void *dev)
 
 	val = readl(pl08x->base + PL080_ERR_STATUS);
 	if (val) {
-		/*
-		 * An error interrupt (on one or more channels)
-		 */
+		/* An error interrupt (on one or more channels) */
 		dev_err(&pl08x->adev->dev,
 			"%s error interrupt, register value 0x%08x\n",
 				__func__, val);
@@ -1696,9 +1657,7 @@ static irqreturn_t pl08x_irq(int irq, void *dev)
 			mask |= (1 << i);
 		}
 	}
-	/*
-	 * Clear only the terminal interrupts on channels we processed
-	 */
+	/* Clear only the terminal interrupts on channels we processed */
 	writel(mask, pl08x->base + PL080_TC_CLEAR);
 
 	return mask ? IRQ_HANDLED : IRQ_NONE;
@@ -1717,6 +1676,7 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
 	int i;
 
 	INIT_LIST_HEAD(&dmadev->channels);
+
 	/*
 	 * Register as many many memcpy as we have physical channels,
 	 * we won't always be able to use all but the code will have
@@ -1950,9 +1910,7 @@ static int pl08x_probe(struct amba_device *adev, struct amba_id *id)
 	/* Turn on the PL08x */
 	pl08x_ensure_on(pl08x);
 
-	/*
-	 * Attach the interrupt handler
-	 */
+	/* Attach the interrupt handler */
 	writel(0x000000FF, pl08x->base + PL080_ERR_CLEAR);
 	writel(0x000000FF, pl08x->base + PL080_TC_CLEAR);
 
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index 933b4ed..3111385 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -12,7 +12,6 @@
  *
  * Please credit ARM.com
  * Documentation: ARM DDI 0196D
- *
  */
 
 #ifndef AMBA_PL08X_H
@@ -55,8 +54,8 @@ enum {
  * @circular_buffer: whether the buffer passed in is circular and
  * shall simply be looped round round (like a record baby round
  * round round round)
- * @single: the device connected to this channel will request single
- * DMA transfers, not bursts. (Bursts are default.)
+ * @single: the device connected to this channel will request single DMA
+ * transfers, not bursts. (Bursts are default.)
  * @periph_buses: the device connected to this channel is accessible via
  * these buses (use PL08X_AHB1 | PL08X_AHB2).
  */
@@ -78,8 +77,7 @@ struct pl08x_channel_data {
  * @addr: current address
  * @maxwidth: the maximum width of a transfer on this bus
  * @buswidth: the width of this bus in bytes: 1, 2 or 4
- * @fill_bytes: bytes required to fill to the next bus memory
- * boundary
+ * @fill_bytes: bytes required to fill to the next bus memory boundary
  */
 struct pl08x_bus_data {
 	dma_addr_t addr;
@@ -92,10 +90,10 @@ struct pl08x_bus_data {
  * struct pl08x_phy_chan - holder for the physical channels
  * @id: physical index to this channel
  * @lock: a lock to use when altering an instance of this struct
- * @signal: the physical signal (aka channel) serving this
- * physical channel right now
- * @serving: the virtual channel currently being served by this
- * physical channel
+ * @signal: the physical signal (aka channel) serving this physical channel
+ * right now
+ * @serving: the virtual channel currently being served by this physical
+ * channel
  */
 struct pl08x_phy_chan {
 	unsigned int id;
@@ -118,8 +116,7 @@ struct pl08x_txd {
 	dma_addr_t dst_addr;
 	size_t len;
 	dma_addr_t llis_bus;
-	void *llis_va;
-	bool active;
+	struct pl08x_lli *llis_va;
 	/* Default cctl value for LLIs */
 	u32 cctl;
 	/*
@@ -130,8 +127,8 @@ struct pl08x_txd {
 };
 
 /**
- * struct pl08x_dma_chan_state - holds the PL08x specific virtual
- * channel states
+ * struct pl08x_dma_chan_state - holds the PL08x specific virtual channel
+ * states
  * @PL08X_CHAN_IDLE: the channel is idle
  * @PL08X_CHAN_RUNNING: the channel has allocated a physical transport
  * channel and is running a transfer on it
@@ -152,7 +149,7 @@ enum pl08x_dma_chan_state {
  * @chan: wrappped abstract channel
  * @phychan: the physical channel utilized by this channel, if there is one
  * @phychan_hold: if non-zero, hold on to the physical channel even if we
- *  have no pending entries
+ * have no pending entries
  * @tasklet: tasklet scheduled by the IRQ to handle actual work etc
  * @name: name of channel
  * @cd: channel platform data
@@ -166,8 +163,8 @@ enum pl08x_dma_chan_state {
  * @host: a pointer to the host (internal use)
  * @state: whether the channel is idle, paused, running etc
  * @slave: whether this channel is a device (slave) or for memcpy
- * @waiting: a TX descriptor on this channel which is waiting for
- * a physical channel to become available
+ * @waiting: a TX descriptor on this channel which is waiting for a physical
+ * channel to become available
  */
 struct pl08x_dma_chan {
 	struct dma_chan chan;
@@ -189,16 +186,16 @@ struct pl08x_dma_chan {
 };
 
 /**
- * struct pl08x_platform_data - the platform configuration for the
- * PL08x PrimeCells.
+ * struct pl08x_platform_data - the platform configuration for the PL08x
+ * PrimeCells.
  * @slave_channels: the channels defined for the different devices on the
  * platform, all inclusive, including multiplexed channels. The available
- * physical channels will be multiplexed around these signals as they
- * are requested, just enumerate all possible channels.
- * @get_signal: request a physical signal to be used for a DMA
- * transfer immediately: if there is some multiplexing or similar blocking
- * the use of the channel the transfer can be denied by returning
- * less than zero, else it returns the allocated signal number
+ * physical channels will be multiplexed around these signals as they are
+ * requested, just enumerate all possible channels.
+ * @get_signal: request a physical signal to be used for a DMA transfer
+ * immediately: if there is some multiplexing or similar blocking the use
+ * of the channel the transfer can be denied by returning less than zero,
+ * else it returns the allocated signal number
  * @put_signal: indicate to the platform that this physical signal is not
  * running any DMA transfer and multiplexing can be recycled
  * @lli_buses: buses which LLIs can be fetched from: PL08X_AHB1 | PL08X_AHB2
-- 
1.6.2.5
