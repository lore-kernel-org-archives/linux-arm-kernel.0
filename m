From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 3 Aug 2017 09:42:04 +0300
Subject: [PATCH v3 2/5] dmaengine: Add STM32 DMAMUX driver
In-Reply-To: <0e16a519-3d60-f683-5517-12a520e0e521@st.com>
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
Message-ID: <f0db566e-5613-8914-e070-915c8c4d9b9f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?our mail server started to mangle outgoing mails, sorry for that, we are 
trying to resolve that...


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

On 2017-08-02 17:28, Pierre Yves MORDRET wrote:
> Correct router needs 3 parameters and among those 2 are forwarded though out
> dma_spec. But when you say "ChannelID is dynamically allocated" you mean
> dma_get_any_slave_channel ? If yes I can use the already existing bindings to
> carry the channelID to DMA. No changes need to peripheral...

What I actually mean is that you should not need to modify the DMA 
driver at all.
According to stm32-dma.txt:
#dma-cells = <4>;
1. channelID
2. request line number
3. - 4. some parameters

I believe if you don't have the event router (directly using the DMA 
node) you always need to provide these, right?
If I'm not mistaken, when you use the event router you want to omit the 
ChannelID and get a random channel via dma_get_any_slave_channel in the 
DMA driver and feed back the channelID to the event router driver?
I believe the reason for this is that you want to keep mixed binding 
use, to have direct DMA bindings and bindings via event router.

Now what happens if you have direct binding:
device1 {
	dmas = <&dma2 1 4 0x10400 0x3>;
};

and via event router:
device2 {
	dmas =	<&dma_router 10 0x10400 0x3>,
		<&dma_router 11 0x10400 0x3>;
};

device2 probes first, will get channelID 0 and 1 via 
dma_get_any_slave_channel.

When device1 tries to probe, the channelID 1 is already taken..

You need to convert all peripherals to use the event router to avoid 
such a races. I have done the same for the dra7.
Add the event router driver,
add the event router node and convert existing users to use that
when adding new devices, use the event router node.

The event router's binding would have 3 parameters, it manages the 
available channelIDs, like the ti-dma-crossbar does for dra7. At 
allocate time it would pick an unused channelID and craft the dma-spec 
with the four parameters as documented.
The main DMA driver will not need any modification as everything will be 
taken care of by the event router.

The only gotcha is with memcpy type of transfers as they might also need 
unique channelID, but not requested via the slave binding. For that I 
have added properties to the event router to mask out certain channels 
(and I needed to do the same for the eDMA, but it is unrelated to the 
router itself).


- P?ter
