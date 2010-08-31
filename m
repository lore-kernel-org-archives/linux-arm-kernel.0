From: antti.p.miettinen@nokia.com (Antti P Miettinen)
Date: Tue, 31 Aug 2010 09:22:40 +0300
Subject: smsc911x.c driver and SMP
References: <4A7AEEB6.5060903@googlemail.com>
	<1249981883.27150.14.camel@pc1117.cambridge.arm.com>
	<4A818CBC.8040000@googlemail.com>
	<1250006770.30628.1.camel@pc1117.cambridge.arm.com>
	<4A819C54.3080606@googlemail.com>
	<1250009043.30628.9.camel@pc1117.cambridge.arm.com>
	<87ab25vazg.fsf@brigitte.kvy.fi>
	<1250080338.20332.32.camel@pc1117.cambridge.arm.com>
	<87k518yc8a.fsf@brigitte.kvy.fi>
	<1252660898.3354.16.camel@pc1117.cambridge.arm.com>
	<4AAA48CA.9040405@billgatliff.com>
	<1252674034.29620.30.camel@pc1117.cambridge.arm.com>
	<4AAA6AB7.60808@billgatliff.com>
	<1252685189.29620.33.camel@pc1117.cambridge.arm.com>
	<87my459hjs.fsf@brigitte.kvy.fi> <4C7C47DF.3030307@renesas.com>
Message-ID: <87k4n7ti6n.fsf@doris.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com> writes:
> Hi Catalin and Antti,
>
> On 10/6/2009 3:12 PM, Antti P Miettinen wrote:
>> Catalin Marinas <catalin.marinas@arm.com> writes:
>>> Fixed it with this new commit (I'm not posting the patch here as it's
>>> not meant for review on this list):
>>>
>>> http://www.linux-arm.org/git?p=linux-2.6.git;a=commitdiff;h=3cc8ee538f6727d1f6773fff6d8e31bc5522bfee
>> 
>> Just a piece of information: with vanilla 2.6.31 boot from NFS root on
>> my PB11MPCore hangs, with this patch applied, boot succeeds.
>
> Now I'm setting up similar dev environment by chance; Cortex-A9 MPcore,
> slightly old kernel (say .31 or .32), and with smsc911x.c Ethernet
> driver required [1].
>
> I'm auditing the required patches right now, and very interested in
> above patch, but it seems that blob got lost these days :-(
>
> Do you still have the patch, and would you mind sharing it with me?
>
> [1] http://www.kmckk.co.jp/eng/kzmca9/index.html
> -- 
> Shinya Kuribayashi
> Renesas Electronics

Hmm.. hard to remember what the patch actually contained - could it be
the one below?  By the way - I have a KZM board so I'd be happy to
test your kernels.

diff --git a/drivers/net/smsc911x.c b/drivers/net/smsc911x.c
index 94b6d26..999e89d 100644
--- a/drivers/net/smsc911x.c
+++ b/drivers/net/smsc911x.c
@@ -84,8 +84,7 @@ struct smsc911x_data {
 	 */
 	spinlock_t mac_lock;
 
-	/* spinlock to ensure 16-bit accesses are serialised.
-	 * unused with a 32-bit bus */
+	/* spinlock to ensure register accesses are serialised */
 	spinlock_t dev_lock;
 
 	struct phy_device *phy_dev;
@@ -118,37 +117,33 @@ struct smsc911x_data {
 	unsigned int hashlo;
 };
 
-/* The 16-bit access functions are significantly slower, due to the locking
- * necessary.  If your bus hardware can be configured to do this for you
- * (in response to a single 32-bit operation from software), you should use
- * the 32-bit access functions instead. */
-
-static inline u32 smsc911x_reg_read(struct smsc911x_data *pdata, u32 reg)
+static inline u32 __smsc911x_reg_read(struct smsc911x_data *pdata, u32 reg)
 {
 	if (pdata->config.flags & SMSC911X_USE_32BIT)
 		return readl(pdata->ioaddr + reg);
 
-	if (pdata->config.flags & SMSC911X_USE_16BIT) {
-		u32 data;
-		unsigned long flags;
-
-		/* these two 16-bit reads must be performed consecutively, so
-		 * must not be interrupted by our own ISR (which would start
-		 * another read operation) */
-		spin_lock_irqsave(&pdata->dev_lock, flags);
-		data = ((readw(pdata->ioaddr + reg) & 0xFFFF) |
+	if (pdata->config.flags & SMSC911X_USE_16BIT)
+		return ((readw(pdata->ioaddr + reg) & 0xFFFF) |
 			((readw(pdata->ioaddr + reg + 2) & 0xFFFF) << 16));
-		spin_unlock_irqrestore(&pdata->dev_lock, flags);
-
-		return data;
-	}
 
 	BUG();
 	return 0;
 }
 
-static inline void smsc911x_reg_write(struct smsc911x_data *pdata, u32 reg,
-				      u32 val)
+static inline u32 smsc911x_reg_read(struct smsc911x_data *pdata, u32 reg)
+{
+	u32 data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pdata->dev_lock, flags);
+	data = __smsc911x_reg_read(pdata, reg);
+	spin_unlock_irqrestore(&pdata->dev_lock, flags);
+
+	return data;
+}
+
+static inline void __smsc911x_reg_write(struct smsc911x_data *pdata, u32 reg,
+					u32 val)
 {
 	if (pdata->config.flags & SMSC911X_USE_32BIT) {
 		writel(val, pdata->ioaddr + reg);
@@ -156,44 +151,54 @@ static inline void smsc911x_reg_write(struct smsc911x_data *pdata, u32 reg,
 	}
 
 	if (pdata->config.flags & SMSC911X_USE_16BIT) {
-		unsigned long flags;
-
-		/* these two 16-bit writes must be performed consecutively, so
-		 * must not be interrupted by our own ISR (which would start
-		 * another read operation) */
-		spin_lock_irqsave(&pdata->dev_lock, flags);
 		writew(val & 0xFFFF, pdata->ioaddr + reg);
 		writew((val >> 16) & 0xFFFF, pdata->ioaddr + reg + 2);
-		spin_unlock_irqrestore(&pdata->dev_lock, flags);
 		return;
 	}
 
 	BUG();
 }
 
+static inline void smsc911x_reg_write(struct smsc911x_data *pdata, u32 reg,
+				      u32 val)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pdata->dev_lock, flags);
+	__smsc911x_reg_write(pdata, reg, val);
+	spin_unlock_irqrestore(&pdata->dev_lock, flags);
+}
+
 /* Writes a packet to the TX_DATA_FIFO */
 static inline void
 smsc911x_tx_writefifo(struct smsc911x_data *pdata, unsigned int *buf,
 		      unsigned int wordcount)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&pdata->dev_lock, flags);
+
 	if (pdata->config.flags & SMSC911X_SWAP_FIFO) {
 		while (wordcount--)
-			smsc911x_reg_write(pdata, TX_DATA_FIFO, swab32(*buf++));
-		return;
+			__smsc911x_reg_write(pdata, TX_DATA_FIFO,
+					     swab32(*buf++));
+		goto out;
 	}
 
 	if (pdata->config.flags & SMSC911X_USE_32BIT) {
 		writesl(pdata->ioaddr + TX_DATA_FIFO, buf, wordcount);
-		return;
+		goto out;
 	}
 
 	if (pdata->config.flags & SMSC911X_USE_16BIT) {
 		while (wordcount--)
-			smsc911x_reg_write(pdata, TX_DATA_FIFO, *buf++);
-		return;
+			__smsc911x_reg_write(pdata, TX_DATA_FIFO, *buf++);
+		goto out;
 	}
 
 	BUG();
+out:
+	spin_unlock_irqrestore(&pdata->dev_lock, flags);
 }
 
 /* Reads a packet out of the RX_DATA_FIFO */
@@ -201,24 +206,31 @@ static inline void
 smsc911x_rx_readfifo(struct smsc911x_data *pdata, unsigned int *buf,
 		     unsigned int wordcount)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&pdata->dev_lock, flags);
+
 	if (pdata->config.flags & SMSC911X_SWAP_FIFO) {
 		while (wordcount--)
-			*buf++ = swab32(smsc911x_reg_read(pdata, RX_DATA_FIFO));
-		return;
+			*buf++ = swab32(__smsc911x_reg_read(pdata,
+							    RX_DATA_FIFO));
+		goto out;
 	}
 
 	if (pdata->config.flags & SMSC911X_USE_32BIT) {
 		readsl(pdata->ioaddr + RX_DATA_FIFO, buf, wordcount);
-		return;
+		goto out;
 	}
 
 	if (pdata->config.flags & SMSC911X_USE_16BIT) {
 		while (wordcount--)
-			*buf++ = smsc911x_reg_read(pdata, RX_DATA_FIFO);
-		return;
+			*buf++ = __smsc911x_reg_read(pdata, RX_DATA_FIFO);
+		goto out;
 	}
 
 	BUG();
+out:
+	spin_unlock_irqrestore(&pdata->dev_lock, flags);
 }
 
 /* waits for MAC not busy, with timeout.  Only called by smsc911x_mac_read

-- 
http://www.iki.fi/~ananaza/
