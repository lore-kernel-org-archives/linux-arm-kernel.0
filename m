From: gnomes@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 8 Aug 2018 21:36:40 +0100
Subject: [RFC net-next 00/15] net: A socket API for LoRa
In-Reply-To: <92ee4016-1da9-826b-3674-b2d604a64848@suse.de>
References: <20180701110804.32415-1-afaerber@suse.de>
 <CAC=mGzgUCopz2xTOA0R-WD8a1DOaOOUn=YpfdMiJ33y3hnh6kg@mail.gmail.com>
 <92ee4016-1da9-826b-3674-b2d604a64848@suse.de>
Message-ID: <20180808213640.10a1d76f@alans-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 5 Aug 2018 02:11:25 +0200
Andreas F?rber <afaerber@suse.de> wrote:

> Hi Jian-Hong,
> 
> Am 03.07.2018 um 17:11 schrieb Jian-Hong Pan:
> > 2018-07-01 19:07 GMT+08:00 Andreas F?rber <afaerber@suse.de>:  
> >> 2) PF_LORA is used with SOCK_DGRAM here. The assumption is that RAW mode
> >>    would be DGRAM plus preamble plus optional checksum.  
> > 
> > Is the preamble added by the hardware itself here or software here?  
> 
> That depends on the driver. For SX127x and any SX127x based modules it
> is added by hardware and a SOCK_RAW seems impossible. If you were to use
> some SDR hardware, it would need to be done by software and might either
> be done in the device driver for SOCK_DGRAM or by user with a SOCK_RAW.
> Right now I don't see a practical use case for the latter. (CC Pieter)

For TCP/IP a SOCK_RAW is a socket with raw IP level access. It doesn't
deal in IP headers and unless you ask it also does chunks of IP header
stuff for you.

SOCK_PACKET is the truely raw interface and even then it's rawness is
bounded. You can't for example talk truely raw wifi bit streams, and for
ethernet you get to generate MAC headers but not preambles etc.

> LoRa radio channels being half-duplex, we'd need to stop receiving in
> ndo_start_xmit and re-start receiving in the TX interrupt handler AFAIU.
> Yes, it's ugly - one reason I haven't implemented RX in sx1276 yet.

Why - the signal is still floating around in the air, you can't unhear it
at the antenna. If a given piece of hardware needs to flip between RX
and TX mode then it should be handled by that driver.

(Some ancient ethernet cards do this btw.. they can't listen and transmit
at the same time)

> > - We can have a pre-defined table according to LoRaWAN Regional Parameters.
> > - Device driver declares the hardware's capability, for example
> > frequency, TX power.  And then registers as a LoRaWAN compatible
> > device.  
> 
> That sounds like a layering violation. We rather need to expose all
> these tunable parameters individually at the LoRa layer, allowing the
> LoRaWAN layer to configure them as it pleases. Not the other direction.
> That still leaves my above question 4) open of how to implement each.

Wifi already has the general policy database for the various existing
protocols. Please take a look at the CRDA agent and how it hooks into
wireless.It might need to some tweaking but it would be odd to have
different configuration schemes for different wifi protocols.

> The use case I have in mind is this: User A opens a LoRaWAN socket and
> using maclorawan sends a packet P1. Here the LoRaWAN Regional Parameters
> and LoRaWAN Sync Word need to be applied.
> User B then opens a pure LoRa socket and transmits a packet P1' with
> different Sync Word, SF, BW, CR, etc.
> Afterwards user A wants to send another packet P2 via LoRaWAN - this
> needs to use the same LoRaWAN settings as before, not those used for
> LoRa in between. Therefore I was thinking about socket-level options, as
> netlink operations would be device-wide, with undesired side-effects.

Agreed

> Obviously in that scenario not both users can receive at the same time.

That's a hardware question. Imagine a software defined radio. If your
limitation wouldn't exist in a pure software defined radio then it's
almost certainly a device level detal.

> interface but cleanly distinguished as ETH_P_GFSK or something.
> For example, the Chistera Pi HAT has both an RFM95W and an RFM22 module.

Agreed if you can flip per packet.

> The next question arising is how the user would create such an skb. Just
> like I was hesitant about PF_LORAWAN originally, I'd like to avoid
> polluting the PF_ number space for each of these. Maybe have one PF_FSK
> as equivalent to PF_LORA and then have either a socket option or
> sockaddr field to select the modulation variants? Not sure how exactly
> those others differ from each other, that's why I tried to postpone the
> FSK topic and to focus on LoRa first - b) below.
> 
> At this point we could also argue whether we need a PF_LORA at all or
> rather just some generic PF_RADIO with lots of options stored in its
> sockaddr.

What matters most is mux/demux.

If you've got something listening to data but without the structure
needed to identify multiple listeners and split out the data meaningfully
to those listeners according to parts of the packet then you've got no
reason to make it a protocol just use SOCK_PACKET and if need be BPF.

The reason we have a socket layer not /dev/ethernet0 is that it's
meaningful to divide messages up into flows, and to partition those flows
securely amongst multiple consumers/generators.

Alan
