From: davide.digesualdo@kaskonetworks.it (Davide Di Gesualdo)
Date: Wed, 25 Nov 2009 13:52:21 +0100
Subject: IXP425: help on HSS channelized service
In-Reply-To: <200911241622.43464.schindele@nentec.de>
References: <4B0BDFC1.7010506@kaskonetworks.it>
	<200911241622.43464.schindele@nentec.de>
Message-ID: <4B0D2885.2030103@kaskonetworks.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Juergen,
I'm sure the configuration of PCR for my application is ok (it's ported 
from a kernel module which uses Intel Access Library).. anyway, it looks 
like the following:
		// tx
		msg.data32 = 	PCR_FRM_SYNC_OUTPUT_RISING |
				PCR_MSB_ENDIAN |
				PCR_FRM_SYNC_RISINGEDGE |
				PCR_TX_DATA_ENABLE |
				PCR_DCLK_EDGE_RISING |
				PCR_SYNC_CLK_DIR_OUTPUT |
				PCR_SOF_NO_FBIT;
		// rx
		msg.data32 =    PCR_FRM_SYNC_RISINGEDGE |
                                 PCR_MSB_ENDIAN |
                                 PCR_SOF_NO_FBIT;

Bye!

Juergen Schindele ha scritto:
> Am Dienstag, 24. November 2009 schrieb Davide Di Gesualdo:
>> Hi all,
> Dear Davide,
> i am using ixp4xx-hss for an HDLC.X21 frontend in packetized mode
> with all timeslots from kernel version 2.6.27.36
> To receive correctly i had to modify the parameters 
> in "hss_config_set_pcr" function. I compared to intel software stack
> for IXP425 which was already working for us. 
> 
> in function static void hss_config_set_pcr(struct port *port)
> ....
> -		msg.data32 = PCR_FRM_SYNC_OUTPUT_RISING | PCR_MSB_ENDIAN |
> -			PCR_TX_DATA_ENABLE;
> +		msg.data32 = PCR_FRM_SYNC_ACTIVE_HIGH | PCR_MSB_ENDIAN |
> +			PCR_TX_DATA_ENABLE | PCR_FCLK_EDGE_RISING | PCR_FRM_PULSE_DISABLED;
> ....
> 
> Nevertheless i am receiving correct data but packet len is always zero!
> Have you already encountered this ???
> 
> Bye 
>> I'm writing a kernel module for a HSS channelized service on IXP425 
>> processor, based on ixp4xx_hss. I'm developing on a IXDPG425 Intel 
>> board, and the HSS bus is attached to four Si3210 ProSLIC chips.
>> The purpose of this module is to read/write from/to HSS 8-byte buffers 
>> in raw mode (no particular alignment is required). In write direction, 
>> everything seems ok: if I write a buffer like
>> char buf[] = {0xcb, 0xcb, 0xcb, 0xcb, 0xcb, 0xcb, 0xcb, 0xcb};
>> on a fixed timeslot and then read the TXD pin signal with a scope, I can 
>> see the correct waveform at the correct place; I've also tried to write 
>> a tone with a fixed freqeuncy, and I've listened it correctly.
>> The problem comes with read direction: I've tried to make a loopback by 
>> copying the rxbuffer in the txbuffer, but I can't hear my voice back 
>> (instead I hear something like a continous buzz). I'm quite sure I read 
>> the rxbuffer in the correct way (I do the same when I write txbuffer, 
>> which works properly!). This is the ISR for HSS read-complete interrupt:
> --------------------------------------------------------------
> J?rgen Schindele  
> Software-Entwicklung
> 
> NENTEC Netzwerktechnologie GmbH
> Greschbachstr. 12
> 76229 Karlsruhe
> Deutschland
> Telefon: +49 721 94249-51
> Telefax: +49 721 94249-10
> E-Mail:  schindele at nentec.de
> WEB:     www.nentec.de
>  
> Gesch?ftsf?hrung: Klaus Becker, Roland Knapp
> Sitz der Gesellschaft: Karlsruhe
> Handelsregister: Amtsgericht Mannheim HRB 107658
> 
> --------------------------------------------------------------
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 


-- 
Davide Di Gesualdo
Kasko Networks S.r.l.
P.zza Regina Margherita, 7
L'Aquila (AQ) - CAP 67100 - Italy
Labs: +39 0862200460
Mobile: +39 3206203127
VoIP: +39 0857993233
Skype: davide.digesualdo
