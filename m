From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 28 Aug 2017 14:48:50 +0300
Subject: [PATCH v3 2/5] dmaengine: Add STM32 DMAMUX driver
In-Reply-To: <ea66ba14-fe18-cb83-5989-8ae7b3ab50c6@st.com>
References: <1499343623-5964-1-git-send-email-pierre-yves.mordret@st.com>
 <1499343623-5964-3-git-send-email-pierre-yves.mordret@st.com>
 <20170722065133.GT3053@localhost>
 <2b916330-9b65-f4d5-817f-79b66cc236b3@st.com>
 <20170726052930.GF3053@localhost>
 <f2908e38-dc4d-3886-4058-52a7ad845415@st.com>
 <20170731123157.GJ3053@localhost>
 <e3a76a50-4160-d111-cce9-132b46b66c33@st.com>
 <20170802045522.GU3053@localhost>
 <7d2091fe-a2e5-78bb-b63d-9cb66bdb7e84@ti.com>
 <7bcad698-fa1a-3dc2-e918-4400639ca6d7@st.com>
 <47ceba83-1097-072e-bed6-d1964bce7a25@ti.com>
 <0e16a519-3d60-f683-5517-12a520e0e521@st.com>
 <f0db566e-5613-8914-e070-915c8c4d9b9f@ti.com>
 <71b7ef2a-d745-d16b-4538-567c856cce9a@st.com>
 <401305f0-15d8-1996-60d6-69c13cbacc06@ti.com>
 <58bf2f7c-faf1-d1e9-3c87-d7964d1ba3d4@st.com>
 <6e8e19f1-8d0f-183b-e02f-1ec8c4dd57b3@ti.com>
 <f7ddd927-5db3-e1b1-b7f1-94050b508298@st.com>
 <d1cc3cbb-c4aa-2acc-91ff-1d6713cb8867@ti.com>
 <ea66ba14-fe18-cb83-5989-8ae7b3ab50c6@st.com>
Message-ID: <bbfbf048-9d4d-8714-d607-4d02088170d8@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

On 2017-08-24 16:03, Pierre Yves MORDRET wrote:
> Please tell me whether I'm wrong but for am335x/am437x both DMA Channels and
> events are given by DT. I believe IP Spec provides the mapping for the channel
> (this is what you call fixed channel) and DMA router event is selected randomly
> within the DT.

In our eDMA the channel number and the DMA event number is locked
together. Event 17 can only be serviced by eDMA channel 17. The
am335x/am437x DMA crossbar is implemented on every DMA event lane and by
changing it you can select different event to be routed to the given
event number. The eDMA can handle up to 64 unique DMA events, however
for each of this 64 events we have a crossbar which allows to select
from up to 63 other sources. I can not allocate the eDMA channel in the
crossbar as I can not be sure that I will not step on some other
driver's toe and take a channel (event) which someone want to use with
it's default purpose. So the binding includes the channel number and the
crossbar mapped event ID.

Oh, and this eDMA limitation is the main source of my hassle with the
mem-to-mem channel: in DT we must tell what channels can be used for
memcpy - the ones that are not used on the board (usually we pick i2c
since we don't support DMA with that).

> As for dra7 events comes from DT but channel is selected though out local
> algorithm. IP Spec defines DMA event muxer mapping.

Here it is again a different story. The crossbar in dra7 can handle 256
incoming events and it can map any of these events to the 64 eDMA event
number (or channel) or if it is front of the sDMA we can select the sDMA
event number from the 128 it can handle.

Here we only use the event number in the crossbar node as we will pick
the eDMA event, which is going to be correspond to the eDMA channel.

> At my opinion my router is more closed to dra7. IP Spec defines event mapping.
> Nonetheless the DMA has a fixed allocated mapping. Using DMA alone DT has to
> provide channel number. In router mode this number doesn't matter since router
> makes the routing from fixed event to channel. However router needs to know
> which channel will be assign to event: any random channel is allowed.

In dra7 both eDMA and sDMA have pre-allocated channel mapping. Before my
DMA event router support we had no way to use non default mapped events
(we did had DMA support fro HSMMC and probably other stuff with direct
DMA node).
When I had the DMA router, first I added the node for it, then I have
converted all existing nodes to use the DMA event router node for the
DMA binding. After that I could add the nodes for the peripherals
needing non default mapped DMA requests.
We don't allow direct DMA binding for dra7 class of devices at all,
everything needs to go via the xbars.

I would not bother with mixed use case here, I would just make it
mandatory to go via the router.

Again, with the eDMA I needed to 'mask' out the events/channels which we
want to use for memcpy. Define the memcpy channels in the eDMA node and
mask the same events in the crossbar as well.

> I'm pretty sure I can mimic what has been for DRA7 related to DMA Channel
> allocation however it seems to be this is aside DMA engine. This kind of
> implementation forbid the use of DMA and DMA router at the same time : I
> remember you already raise the point. If a DMA channel is requested DMA router
> is not aware of this allocation. This is the idea of my custom API which relies
> on get_any_slave_channel().

I think you must not allow mixed use for the slave channels. The none
slave (memcpy) is still a pain, but you have managed it somehow in the past.

> Using DT to assign channel seems not a good idea either as I lost router's benefice.
> 
> BTW I need the channel ID within router.

Your use case is pretty close to the dra7 one we have.

> Looking at core or of_dma_router_xlate() I don't really know how to do it a
> generic manner.

You construct the dmaspec for the DMA, which will include the channel
number you have mapped the event to. If the DMA driver needs the channel
number _and_ the event number then both, but based on your description
your DMA engine itself is close to the eDMA of ours than the sDMA.

- P?ter
