From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 5 Aug 2018 02:11:25 +0200
Subject: [RFC net-next 00/15] net: A socket API for LoRa
In-Reply-To: <CAC=mGzgUCopz2xTOA0R-WD8a1DOaOOUn=YpfdMiJ33y3hnh6kg@mail.gmail.com>
References: <20180701110804.32415-1-afaerber@suse.de>
 <CAC=mGzgUCopz2xTOA0R-WD8a1DOaOOUn=YpfdMiJ33y3hnh6kg@mail.gmail.com>
Message-ID: <92ee4016-1da9-826b-3674-b2d604a64848@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jian-Hong,

Am 03.07.2018 um 17:11 schrieb Jian-Hong Pan:
> 2018-07-01 19:07 GMT+08:00 Andreas F?rber <afaerber@suse.de>:
>> 2) PF_LORA is used with SOCK_DGRAM here. The assumption is that RAW mode
>>    would be DGRAM plus preamble plus optional checksum.
> 
> Is the preamble added by the hardware itself here or software here?

That depends on the driver. For SX127x and any SX127x based modules it
is added by hardware and a SOCK_RAW seems impossible. If you were to use
some SDR hardware, it would need to be done by software and might either
be done in the device driver for SOCK_DGRAM or by user with a SOCK_RAW.
Right now I don't see a practical use case for the latter. (CC Pieter)

>> 3) Only the transmit path is partially implemented already. The assumption
>>    is that the devices should go into receive mode by default and only
>>    interrupt that when asked to transmit.
> 
> If it goes with LoRaWAN spec., end devices should be in idle (or
> called standby mode) by default.  Unless the device is asked to be in
> transmitting or receiving timing slot.

Whatever the LoRaWAN spec says, in practice struct net_device_ops has an
ndo_start_xmit hook but no ndo_start_recv. All drivers that I've checked
start receiving via interrupts after ndo_open has set things up.

LoRa radio channels being half-duplex, we'd need to stop receiving in
ndo_start_xmit and re-start receiving in the TX interrupt handler AFAIU.
Yes, it's ugly - one reason I haven't implemented RX in sx1276 yet.

Are you suggesting to have dgram's recvmsg trigger the RX state somehow?
It gets access to the net_device and could access dev.h struct lora_priv
that we might extend to contain a LoRa-specific start_recv callback. And
probably rename it more uniquely to lora_dev_priv while at it.

The only other alternative I can think of would be to require the user
to perform some netlink operation, possibly wrapped in some lora_ API,
to actively put the device into receive mode. Doesn't sound desirable.

>> 4) Some hardware settings need to be supplied externally, such as the radio
>>    frequency for some modules, but many others can be runtime-configured,
>>    such as Spreading Factor, Bandwidth, Sync Word, or which antenna to use.
>>    What settings should be implemented as socket option vs. netlink layer
>>    vs. ioctl vs. sysfs? What are the criteria to apply?
> 
> - We can have a pre-defined table according to LoRaWAN Regional Parameters.
> - Device driver declares the hardware's capability, for example
> frequency, TX power.  And then registers as a LoRaWAN compatible
> device.

That sounds like a layering violation. We rather need to expose all
these tunable parameters individually at the LoRa layer, allowing the
LoRaWAN layer to configure them as it pleases. Not the other direction.
That still leaves my above question 4) open of how to implement each.

The use case I have in mind is this: User A opens a LoRaWAN socket and
using maclorawan sends a packet P1. Here the LoRaWAN Regional Parameters
and LoRaWAN Sync Word need to be applied.
User B then opens a pure LoRa socket and transmits a packet P1' with
different Sync Word, SF, BW, CR, etc.
Afterwards user A wants to send another packet P2 via LoRaWAN - this
needs to use the same LoRaWAN settings as before, not those used for
LoRa in between. Therefore I was thinking about socket-level options, as
netlink operations would be device-wide, with undesired side-effects.

Obviously in that scenario not both users can receive at the same time.

If there was a way to start receiving only when a user performs such a
socket operations, even this could be implemented - if incompatible
reception can get detected and if the packet gets delivered to both,
LoRa being broadcast.

> - LoRaWAN module handle the requests from upper layer or MAC commands
> from a gateway (netlink layer), than uses the pre-defined interface
> functions to set the parameters.
> 
> LoRaWAN module will export the operation functions interface.
> 
>> 5) Many of the modules support multiple modes, such as LoRa, LoRaWAN and FSK.
>>    Lacking a LoRaWAN implementation, I am currently switching them into LoRa
>>    mode at probe time wherever possible. How do we deal with that properly?
> 
> - There are data rate tables defined in LoRaWAN Regional Parameters.
> Those contain which data rate uses LoRa mode or FSK mode.

That's missing my point, I fear. Independently of what LoRaWAN does, the
user needs to be able to send on the physical layer from a selection of
LoRa, GFSK, FSK, OOK, GMSK and MSK.
Supposedly Wireless M-Bus and IEEE 802.15.4 can be implemented via those
according to the SX1276 datasheet.

This opens a can of worms...

SX127x has a single channel, so I don't think there should be six
network interfaces lora0, gfsk0, fsk0, ook0, gmsk0 and msk0 exposed to
the user.
Having a lora0 interface speak non-LoRa modulations may be confusing,
but since the chip is sold as LoRa transceiver it might be acceptable.

SX130x has 8+2 channels, with IF9 dedicated to GFSK/FSK. It appears to
use one FIFO for receiving (up to 16 packets) and can only transmit one
packet at a time. So I think this should be one lora0 interface, too.

With a view to supporting non-LoRa RF chipsets such as Si4xxx (GFSK,
FSK, OOK) or nRF905 and nRF24L01+ (both GFSK) at a later date, I don't
think those modulations should be some netlink option on a PF_LORA
interface but cleanly distinguished as ETH_P_GFSK or something.
For example, the Chistera Pi HAT has both an RFM95W and an RFM22 module.

The next question arising is how the user would create such an skb. Just
like I was hesitant about PF_LORAWAN originally, I'd like to avoid
polluting the PF_ number space for each of these. Maybe have one PF_FSK
as equivalent to PF_LORA and then have either a socket option or
sockaddr field to select the modulation variants? Not sure how exactly
those others differ from each other, that's why I tried to postpone the
FSK topic and to focus on LoRa first - b) below.

At this point we could also argue whether we need a PF_LORA at all or
rather just some generic PF_RADIO with lots of options stored in its
sockaddr.
One criteria will be whether we need multiple protocol options per
modulation type or just one. For LoRa that was the dgram vs. raw
discussion; for FSK/OOK I read packet mode vs. continuous mode in SX127x
but not obvious if that affects the protocol or just the device driver.

Getting back to your point, the data rate selection at LoRaWAN layer
needs to determine how an skb gets passed between device driver and MAC.


Another aspect FSK touches on is interactions with other subsystems. For
example, how an sx1276 802.15.4 implementation for FSK/OOK (or LoRa, as
you mentioned in your slides) would best interact with ieee802154 and
mac802154 code when not done as standalone implementation. Or how to
deal with SigFox on the same module as LoRaWAN - not aware of any kernel
subsystem for SigFox. By comparison, on-module BLE sounds slightly
easier, since it uses a separate antenna.
(Haven't seen LoRa plus NB-IoT yet, to name the other LPWAN technology.)

> - LoRaWAN should handle the data rate changing requests and then calls
> the corresponding operation functions.  Of course, the hardware's
> capability registered before should also be under consideration at the
> same time.
> 
>>   a) Is there any precedence from the Wifi world for dynamically selecting
>>      between our own trusted Open Source implementation vs. hardware/firmware
>>      accelerated and/or certified implementations?
>>
>>   b) Would a proof of concept for FSK (non-LoRa) modes be required for
>>      merging any LoRa driver for chipsets that support both? Or is there any
>>      facility or design guidelines that would allow us to focus on LoRa and
>>      LoRaWAN and leave non-LoRa radio modes to later contributors?

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
