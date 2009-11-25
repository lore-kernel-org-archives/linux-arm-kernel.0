From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Wed, 25 Nov 2009 01:07:15 +0100
Subject: IXP425: help on HSS channelized service
In-Reply-To: <200911241622.43464.schindele@nentec.de> (Juergen Schindele's
	message of "Tue, 24 Nov 2009 17:22:43 +0200")
References: <4B0BDFC1.7010506@kaskonetworks.it>
	<200911241622.43464.schindele@nentec.de>
Message-ID: <m38wdvbh70.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Juergen Schindele <schindele@nentec.de> writes:

> To receive correctly i had to modify the parameters 
> in "hss_config_set_pcr" function. I compared to intel software stack
> for IXP425 which was already working for us. 
>
> +		msg.data32 = PCR_FRM_SYNC_ACTIVE_HIGH | PCR_MSB_ENDIAN |
> +			PCR_TX_DATA_ENABLE | PCR_FCLK_EDGE_RISING | PCR_FRM_PULSE_DISABLED;
> ....

I'm currently using:

TX:
+       msg.data32 = PCR_DCLK_EDGE_RISING | PCR_FRM_SYNC_OUTPUT_RISING |
+               PCR_MSB_ENDIAN | PCR_TX_DATA_ENABLE | PCR_SOF_NO_FBIT;

RX:
+       msg.data32 &= ~(PCR_TX_DATA_ENABLE | PCR_DCLK_EDGE_RISING);

with possibility to change PCR_DCLK_EDGE_RISING in both directions
(reversing the clock edges used to send/sample data). The driver in the
official kernel has the edges reversed, it may be incompatible with
typical hardware (I'm going to fix it if my "test users" don't have
problems with it).

I don't use FRM sync signals, though. I think we should make it
configurable by the platform code somehow.

I've found that using PCR_FRM_PULSE_DISABLED creates a nasty problem -
packetized TX stops transmitting when it's brought up and down when
configured to use (IIRC) external clock, and without actual clock
available. I don't remember the exact details but it was something like
that. Perhaps I should try with Intel's settings once again to see if
the problems goes away. Theoretically it shouldn't matter since the
FRAME signal isn't used, but reality with HSS is a bit different -
especially when coupled with channelized traffic.

> Nevertheless i am receiving correct data but packet len is always zero!
> Have you already encountered this ???

Doesn't exactly look like using incorrect clock edge (though you may
want to check). Maybe inverted data signal?

You may also want to try the channelized mode and see what you're
getting in the buffers (hexdump /dev/hss*). The HDLC controller is not
used in channelized mode.
-- 
Krzysztof Halasa
