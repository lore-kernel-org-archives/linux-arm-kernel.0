From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 5 Nov 2014 19:26:40 +0800
Subject: [PATCH V2 1/4] can: m_can: update to support CAN FD features
In-Reply-To: <5459F808.3020903@hartkopp.net>
References: <1415174326-6623-1-git-send-email-b29396@freescale.com>
 <5459F808.3020903@hartkopp.net>
Message-ID: <20141105112639.GB4007@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 05, 2014 at 11:12:24AM +0100, Oliver Hartkopp wrote:
> On 05.11.2014 08:58, Dong Aisheng wrote:
> 
> >@@ -327,41 +357,65 @@ static inline void m_can_disable_all_interrupts(const struct m_can_priv *priv)
> >  	m_can_write(priv, M_CAN_ILE, 0x0);
> >  }
> >
> >-static void m_can_read_fifo(const struct net_device *dev, struct can_frame *cf,
> >-			    u32 rxfs)
> >+static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
> >  {
> >+	struct net_device_stats *stats = &dev->stats;
> >  	struct m_can_priv *priv = netdev_priv(dev);
> >-	u32 id, fgi;
> >+	struct canfd_frame *cf;
> >+	struct sk_buff *skb;
> >+	u32 id, fgi, dlc;
> >+	int i;
> >
> >  	/* calculate the fifo get index for where to read data */
> >  	fgi = (rxfs & RXFS_FGI_MASK) >> RXFS_FGI_OFF;
> >+	dlc = m_can_fifo_read(priv, fgi, M_CAN_FIFO_DLC);
> >+	if (dlc & RX_BUF_EDL)
> >+		skb = alloc_canfd_skb(dev, &cf);
> >+	else
> >+		skb = alloc_can_skb(dev, (struct can_frame **)&cf);
> 
> Yes. That's the way it should look like ;-)
> 
> >+	if (!skb) {
> >+		stats->rx_dropped++;
> >+		return;
> >+	}
> >+
> >  	id = m_can_fifo_read(priv, fgi, M_CAN_FIFO_ID);
> >  	if (id & RX_BUF_XTD)
> >  		cf->can_id = (id & CAN_EFF_MASK) | CAN_EFF_FLAG;
> >  	else
> >  		cf->can_id = (id >> 18) & CAN_SFF_MASK;
> >
> >-	if (id & RX_BUF_RTR) {
> >+	if (id & RX_BUF_ESI) {
> >+		cf->flags |= CANFD_ESI;
> >+		netdev_dbg(dev, "ESI Error\n");
> >+	}
> >+
> >+	if (!(dlc & RX_BUF_EDL) && (id & RX_BUF_RTR)) {
> >  		cf->can_id |= CAN_RTR_FLAG;
> >  	} else {
> >  		id = m_can_fifo_read(priv, fgi, M_CAN_FIFO_DLC);
> >-		cf->can_dlc = get_can_dlc((id >> 16) & 0x0F);
> >-		*(u32 *)(cf->data + 0) = m_can_fifo_read(priv, fgi,
> >-							 M_CAN_FIFO_DATA(0));
> >-		*(u32 *)(cf->data + 4) = m_can_fifo_read(priv, fgi,
> >-							 M_CAN_FIFO_DATA(1));
> >+		cf->len = can_dlc2len(get_canfd_dlc((id >> 16) & 0x0F));
> 
> if (dlc & RX_BUF_EDL)
> 	cf->len = can_dlc2len((id >> 16) & 0x0F);
> else
> 	cf->len = get_can_dlc((id >> 16) & 0x0F);
> 
> (..)
> 

Correct.
Will change it.

> >@@ -804,7 +870,8 @@ static void m_can_chip_config(struct net_device *dev)
> >  		    RXFC_FWM_1 | priv->mcfg[MRAM_RXF1].off);
> >
> >  	cccr = m_can_read(priv, M_CAN_CCCR);
> >-	cccr &= ~(CCCR_TEST | CCCR_MON);
> >+	cccr &= ~(CCCR_TEST | CCCR_MON | (CCCR_CMR_MASK << CCCR_CMR_SHIFT) |
> >+		(CCCR_CME_MASK << CCCR_CME_SHIFT));
> >  	test = m_can_read(priv, M_CAN_TEST);
> >  	test &= ~TEST_LBCK;
> >
> >@@ -816,6 +883,9 @@ static void m_can_chip_config(struct net_device *dev)
> >  		test |= TEST_LBCK;
> >  	}
> >
> >+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
> >+		cccr |= CCCR_CME_CANFD_BRS << CCCR_CME_SHIFT;
> >+
> >  	m_can_write(priv, M_CAN_CCCR, cccr);
> >  	m_can_write(priv, M_CAN_TEST, test);
> >
> 
> (..)
> 
> >
> >+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
> >+		cccr = m_can_read(priv, M_CAN_CCCR);
> >+		cccr &= ~(CCCR_CMR_MASK << CCCR_CMR_SHIFT);
> >+		if (cf->flags & CANFD_BRS)
> >+			cccr |= CCCR_CMR_CANFD_BRS << CCCR_CMR_SHIFT;
> >+		else
> >+			cccr |= CCCR_CMR_CANFD << CCCR_CMR_SHIFT;
> >+		m_can_write(priv, M_CAN_CCCR, cccr);
> >+	}
> 
> Unfortunately No. Here it becomes complicated due to the fact that
> the revision 3.0.x does not support per-frame switching for FD/BRS
> ...

I'm not sure i got your point.
>From m_can spec, it allows switch CAN mode by setting CMR bit.

Bits 11:10 CMR[1:0]: CAN Mode Request
A change of the CAN operation mode is requested by writing to this bit field. After change to the
requested operation mode the bit field is reset to ?00? and the status flags FDBS and FDO are set
accordingly. In case the requested CAN operation mode is not enabled, the value written to CMR is
retained until it is overwritten by the next mode change request. In case CME = ?01?/?10?/?11? a
change to CAN operation according to ISO 11898-1 is always possible. Default is CAN operation
according to ISO11898-1.
00 unchanged
01 Request CAN FD operation
10 Request CAN FD operation with bit rate switching
11 Request CAN operation according ISO11898-1

So what's the difference between this function and the per-frame switching
you mentioned?

> 
> When (priv->can.ctrlmode & CAN_CTRLMODE_FD) is true this *only*
> tells us, that the controller is _capable_ to send either CAN or CAN
> FD frames.
> 
> It does not configure the controller into one of these specific settings!
> 
> Additionally: AFAIK when writing to the CCCR you have to make sure
> that there's currently no ongoing transfer.
> 

I don't know about it before.
By searching m_can user manual v302 again, i still did not find this
limitation. Can you point me if you know where it is?

BTW, since we only use one Tx Buffer for transmission currently, so we
should not meet that case that CAN mode is switched during transfer.
So the issue you concern may not happen.

Additionally it looks to me like m_can does allow set CMR bit at runtime
since the mode change will take affect when controller becomes idle.
See below:

"A mode change requested by writing to CCCR.CMR will be executed next
time the CAN protocol controller FSM reaches idle phase between CAN frames.
Upon this event CCCR.CMR is reset to ?00? and the status flags CCCR.FDBS
and CCCR.FDO are set accordingly. In case the requested
CAN operation mode is not enabled, the value written to CCCR.CMR is
retained until it is overwritten by the next mode change request.
Default is CAN operation according to ISO11898-1."

> I would suggest the following approach to make the revision 3.0.x
> act like a correct CAN FD capable controller:
> 
> - create a helper function to switch FD and BRS while taking care of
> ongoing transmissions
> 
> - create a variable that knows the current tx_mode for FD and BRS
> 
> When we need to send a CAN frame which doesn't fit the settings in
> the tx_mode we need to switch the CCCR and update the tx_mode
> variable.
> 
> This at least reduces the needed CCCR operations.
> 

Yes, i can do like that.
But what i see by doing that is only reduces the needed CCCR operations?
Any other benefits i missed?

And the test for current code showed it seemed work well on the Mode
switch among std frame/fd frame/brs frame.

Regards
Dong Aisheng

> And it also addresses the intention of your patch
> [PATCH V1 4/4] can: m_can: allow to send std frame on CAN FD mode
> 
> Regards,
> Oliver
> 
