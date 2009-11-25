From: davide.digesualdo@kaskonetworks.it (Davide Di Gesualdo)
Date: Wed, 25 Nov 2009 14:34:31 +0100
Subject: IXP425: help on HSS channelized service
Message-ID: <4B0D3267.2000509@kaskonetworks.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,
thanks for your answer..

 > The buffers have different structures for RX and TX.
Do you refer to the tx_pointer_lists (which is not present for rx 
buffer)? The organization of rx and tx buffers isn't the same? If I want 
to read bytes of timeslot "ts" at offset "off", is it correct to read at 
position "chan_rx_buf(port) + CHAN_RX_FRAMES * ts + off"?

 > Looks like a modified code from one of my ixp4xx-[0-9][0-9] branch.
It IS a modified code from your ixp4xx_hss.

 > Have you tried using the original code in e.g. ixp4xx-31?
I cannot use right the original code because I need transfer callback in 
kernel space, not in user space..

 > You may need to make some trivial changes related to "MVIP".
Sorry, what changes do you mean? Keep in mind I have one channel per 
timeslot (maybe you refer to the possibility to have more channels?)

Thank you!

Davide



Krzysztof Halasa ha scritto:
 > Davide Di Gesualdo <davide.digesualdo@kaskonetworks.it> writes:
 >
 >> I'm writing a kernel module for a HSS channelized service on IXP425
 >> processor, based on ixp4xx_hss. I'm developing on a IXDPG425 Intel
 >> board, and the HSS bus is attached to four Si3210 ProSLIC chips.
 >> The purpose of this module is to read/write from/to HSS 8-byte buffers
 >> in raw mode (no particular alignment is required). In write direction,
 >> everything seems ok: if I write a buffer like
 >> char buf[] = {0xcb, 0xcb, 0xcb, 0xcb, 0xcb, 0xcb, 0xcb, 0xcb};
 >> on a fixed timeslot and then read the TXD pin signal with a scope, I
 >> can see the correct waveform at the correct place; I've also tried to
 >> write a tone with a fixed freqeuncy, and I've listened it correctly.
 >> The problem comes with read direction: I've tried to make a loopback
 >> by copying the rxbuffer in the txbuffer, but I can't hear my voice
 >> back (instead I hear something like a continous buzz). I'm quite sure
 >> I read the rxbuffer in the correct way (I do the same when I write
 >> txbuffer, which works properly!).
 >
 > The buffers have different structures for RX and TX.
 >
 >> This is the ISR for HSS
 >> read-complete interrupt:
 >
 > Looks like a modified code from one of my ixp4xx-[0-9][0-9] branch. Have
 > you tried using the original code in e.g. ixp4xx-31? You may need to
 > make some trivial changes related to "MVIP".
 >
 > Not that my channelized HSS code is flawless or something, far from it,
 > but it works, both directions.


-- 
Davide Di Gesualdo
Kasko Networks S.r.l.
P.zza Regina Margherita, 7
L'Aquila (AQ) - CAP 67100 - Italy
Labs: +39 0862200460
Mobile: +39 3206203127
VoIP: +39 0857993233
Skype: davide.digesualdo
