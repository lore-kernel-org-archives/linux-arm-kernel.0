From: davide.digesualdo@kaskonetworks.it (Davide Di Gesualdo)
Date: Tue, 24 Nov 2009 14:29:37 +0100
Subject: IXP425: help on HSS channelized service
Message-ID: <4B0BDFC1.7010506@kaskonetworks.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
I'm writing a kernel module for a HSS channelized service on IXP425 
processor, based on ixp4xx_hss. I'm developing on a IXDPG425 Intel 
board, and the HSS bus is attached to four Si3210 ProSLIC chips.
The purpose of this module is to read/write from/to HSS 8-byte buffers 
in raw mode (no particular alignment is required). In write direction, 
everything seems ok: if I write a buffer like
char buf[] = {0xcb, 0xcb, 0xcb, 0xcb, 0xcb, 0xcb, 0xcb, 0xcb};
on a fixed timeslot and then read the TXD pin signal with a scope, I can 
see the correct waveform at the correct place; I've also tried to write 
a tone with a fixed freqeuncy, and I've listened it correctly.
The problem comes with read direction: I've tried to make a loopback by 
copying the rxbuffer in the txbuffer, but I can't hear my voice back 
(instead I hear something like a continous buzz). I'm quite sure I read 
the rxbuffer in the correct way (I do the same when I write txbuffer, 
which works properly!). This is the ISR for HSS read-complete interrupt:

static void hss_chan_irq(void *pdev)
{
	struct port *port = pdev;
	int ch, bytes_received;
	unsigned int first, errors, tx_list, rx_offset, v;
	char *rx_buf, *tx_buf;

	spin_lock(&npe_lock);
	while ((v = qmgr_get_entry(queue_ids[port->id].chan))) {
		first = v >> 24;
		errors = (v >> 16) & 0xFF;
		tx_list = (v >> 8) & 0xFF;
		rx_offset = v & 0xFF;

		BUG_ON(rx_offset % CHAN_RX_TRIGGER);
		BUG_ON(rx_offset >= CHAN_RX_FRAMES);
		BUG_ON(tx_list >= CHAN_TX_LISTS);

		bytes_received = rx_offset - port->chan_current_rx;
		if(bytes_received < 0)
			bytes_received += CHAN_RX_FRAMES;

		dma_sync_single(port->dev, port->chan_rx_buf_phys, 
chan_rx_buf_len(port), DMA_FROM_DEVICE);

		while(bytes_received >= CHAN_RX_TRIGGER) {
			if(port->chan_current_rx >= CHAN_RX_FRAMES)
				port->chan_current_rx = 0;
	
			if(port->chan_current_tx >= CHAN_TX_FRAMES)
				port->chan_current_tx = 0;

			for(ch = 0; ch < MAX_CHAN_DEVICES; ch++) {
				if(port->chan_devices[ch]->opened) {
					tx_buf = chan_tx_buf(port) + port->chan_current_tx + 
(CHAN_TX_FRAMES * port->chan_devices[ch]->timeslot);
					rx_buf = chan_rx_buf(port) + port->chan_current_rx + 
(CHAN_RX_FRAMES * port->chan_devices[ch]->timeslot);

					memcpy(tx_buf, rx_buf, CHAN_RX_TRIGGER);
				}
			}
			bytes_received -= CHAN_RX_TRIGGER;
			port->chan_current_rx += CHAN_RX_TRIGGER;
			port->chan_current_tx += CHAN_RX_TRIGGER;
		}
		dma_sync_single(port->dev, port->chan_tx_buf_phys, 
chan_tx_buf_len(port), DMA_TO_DEVICE);
	}
	spin_unlock(&npe_lock);
}

with buffers configuration as follow:

#define MIN_FRAME_SIZE		16
#define MAX_FRAME_SIZE		256
#define MAX_CHANNELS		(MAX_FRAME_SIZE / 8)
#define MAX_CHAN_DEVICES	32

#define CHAN_RX_TRIGGER		8
#define CHAN_RX_FRAMES		128
#define CHAN_TX_LIST_FRAMES	32
#define CHAN_TX_LISTS		4
#define CHAN_TX_FRAMES		(CHAN_TX_LIST_FRAMES * CHAN_TX_LISTS)

port->chan_current_rx is initialized as 0, port->chan_current_tx is 
initialized as 16; all 32 timeslots are configured as VOICE64K; the NPE 
configuration functions are the ones coded by Krzysztof Halasa.

Any suggestion would be really appreciated!
Thanks,

Davide Di Gesualdo

-- 
Davide Di Gesualdo
Kasko Networks S.r.l.
P.zza Regina Margherita, 7
L'Aquila (AQ) - CAP 67100 - Italy
Labs: +39 0862200460
Mobile: +39 3206203127
VoIP: +39 0857993233
Skype: davide.digesualdo
