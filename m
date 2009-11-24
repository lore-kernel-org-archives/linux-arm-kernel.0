From: schindele@nentec.de (Juergen Schindele)
Date: Tue, 24 Nov 2009 17:22:43 +0200
Subject: IXP425: help on HSS channelized service
In-Reply-To: <4B0BDFC1.7010506@kaskonetworks.it>
References: <4B0BDFC1.7010506@kaskonetworks.it>
Message-ID: <200911241622.43464.schindele@nentec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 24. November 2009 schrieb Davide Di Gesualdo:
> Hi all,
Dear Davide,
i am using ixp4xx-hss for an HDLC.X21 frontend in packetized mode
with all timeslots from kernel version 2.6.27.36
To receive correctly i had to modify the parameters 
in "hss_config_set_pcr" function. I compared to intel software stack
for IXP425 which was already working for us. 

in function static void hss_config_set_pcr(struct port *port)
....
-		msg.data32 = PCR_FRM_SYNC_OUTPUT_RISING | PCR_MSB_ENDIAN |
-			PCR_TX_DATA_ENABLE;
+		msg.data32 = PCR_FRM_SYNC_ACTIVE_HIGH | PCR_MSB_ENDIAN |
+			PCR_TX_DATA_ENABLE | PCR_FCLK_EDGE_RISING | PCR_FRM_PULSE_DISABLED;
....

Nevertheless i am receiving correct data but packet len is always zero!
Have you already encountered this ???

Bye 
> I'm writing a kernel module for a HSS channelized service on IXP425 
> processor, based on ixp4xx_hss. I'm developing on a IXDPG425 Intel 
> board, and the HSS bus is attached to four Si3210 ProSLIC chips.
> The purpose of this module is to read/write from/to HSS 8-byte buffers 
> in raw mode (no particular alignment is required). In write direction, 
> everything seems ok: if I write a buffer like
> char buf[] = {0xcb, 0xcb, 0xcb, 0xcb, 0xcb, 0xcb, 0xcb, 0xcb};
> on a fixed timeslot and then read the TXD pin signal with a scope, I can 
> see the correct waveform at the correct place; I've also tried to write 
> a tone with a fixed freqeuncy, and I've listened it correctly.
> The problem comes with read direction: I've tried to make a loopback by 
> copying the rxbuffer in the txbuffer, but I can't hear my voice back 
> (instead I hear something like a continous buzz). I'm quite sure I read 
> the rxbuffer in the correct way (I do the same when I write txbuffer, 
> which works properly!). This is the ISR for HSS read-complete interrupt:
--------------------------------------------------------------
J?rgen Schindele  
Software-Entwicklung

NENTEC Netzwerktechnologie GmbH
Greschbachstr. 12
76229 Karlsruhe
Deutschland
Telefon: +49 721 94249-51
Telefax: +49 721 94249-10
E-Mail:  schindele at nentec.de
WEB:     www.nentec.de
 
Gesch?ftsf?hrung: Klaus Becker, Roland Knapp
Sitz der Gesellschaft: Karlsruhe
Handelsregister: Amtsgericht Mannheim HRB 107658

--------------------------------------------------------------
